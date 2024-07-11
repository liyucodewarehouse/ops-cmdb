from flask import render_template, redirect, abort
from config import NCM_Agent
from dbutil.dbutil import db
import requests, cgi
import json
import os, time, difflib, zipfile
from utils.utils import opLogging, loggingToFile
from utils.auth import login_required


############################################
#             网络配置管理模块             #
############################################
def backupOneNetworkConfig(dic):
    DeviceName = dic["DeviceName"]
    IPAddr = dic["IPAddr"]
    Username = dic["Username"]
    Passwd = dic["Passwd"]
    u = """%s/fetchNetworkConfig?DeviceName=%s&IPAddr=%s&Username=%s&Passwd=%s""" % (NCM_Agent["domain"],DeviceName, IPAddr, Username, Passwd)
    loggingToFile("HTTP GET Request：%s" % u)
    # 请求NCM-Agent登录网络设备做备份操作
    try:
        r = requests.get(u)
        j = r.json()
    except Exception as e:
        loggingToFile(e)
        j = {}
        j["StatusCode"] = 2
        j["ReturnMSG"] = "%s" % e
    # 如果备份正常则更新数据库
    if j["StatusCode"] == 0:
        FileName = j["targetFileName"]
        ConfigFilePath = "upload/NetworkConfigBackup/%s" % FileName
        sql = """ insert into `NetworkConfigManagement` (DeviceName,LastCheckTime,ConfigFilePath) values ("%s","%s","%s"); """ % (
        j["DeviceName"], j["LastCheckTime"], ConfigFilePath)
        db.execute(sql)
    return j

def backupAllNetworkConfig(app):
    @app.route('/backupAllNetworkConfig')
    @login_required
    def backupAllNetworkConfig():
        """ 网络配置管理：配置一键备份 """
        sql = """ select * from NetworkDevice; """
        cur = db.execute(sql)
        res = cur.fetchall()
        result = []
        oneDeviceResult = {}
        for item in res:
            j = backupOneNetworkConfig(item)
            # 特殊字符转义及中文编码
            j["ReturnMSG"] = cgi.escape(j["ReturnMSG"].encode("utf-8"))
            result.append(j)
        # return json.dumps(result)
        opLogging('执行了网络配置"一键备份"功能')
        return render_template('backupAllNetworkConfig.html', data=result)

def fetchOneNetworkConfig(app):
    @app.route('/fetchOneNetworkConfig/<id>')
    @login_required
    def fetchOneNetworkConfig(id):
        sql = """ select * from NetworkDevice where id=""" + id
        cur = db.execute(sql)
        res = cur.fetchone()
        DeviceName = res["DeviceName"]
        j = backupOneNetworkConfig(res)
        msg = j["ReturnMSG"].encode("utf-8")
        if j["ReturnMSG"] == "ok":
            opLogging("对网络设备 %s 进行了配置备份，成功！" % DeviceName)
            return json.dumps({"result": msg})
        else:
            opLogging("对网络设备 %s 进行了配置备份，失败！" % DeviceName)
            return json.dumps({"error": msg})

def viewNetworkConfig(app):
    @app.route('/viewNetworkConfig/<id>')
    @login_required
    def viewNetworkConfig(id):
        """ 网络配置管理：查看设备配置 """
        sql = """ select * from NetworkConfigManagement where id=""" + id
        cur = db.execute(sql)
        res = cur.fetchone()
        DeviceName = res["DeviceName"]
        filename = res["ConfigFilePath"]
        check_result = "none"
        if os.path.exists(filename):
            with open(filename, 'r') as fp:
                lines = fp.readlines()
                fp.close()
                check_result = ''.join(lines)
                check_result = check_result.decode('gb2312').encode('utf-8')
            opLogging("查看了网络设备 %s 的配置" % DeviceName)
            return render_template('viewNetworkConfig.html', data=check_result)
        else:
            abort(404)


def viewNetworkConfigDiff(app):
    @app.route('/viewNetworkConfigDiff/<id>')
    @login_required
    def viewNetworkConfigDiff(id):
        """ 网络配置管理：设备配置差异对比 """
        sql = """ select ConfigFilePath,DeviceName from NetworkConfigManagement where id=""" + id
        cur = db.execute(sql)
        res = cur.fetchone()
        oldFile = res["ConfigFilePath"]
        devicename = res["DeviceName"]
        latestFileSQL = """select ConfigFilePath from NetworkConfigManagement as ncm,(select max(id) 'cid' from NetworkConfigManagement where DeviceName="%s") as cc where ncm.id=cc.cid;""" % devicename
        res = db.execute(latestFileSQL)
        cur = res.fetchone()
        latestFile = cur["ConfigFilePath"]
        if os.path.exists(oldFile) and os.path.exists(latestFile):
            a = open(oldFile, 'U').readlines()
            b = open(latestFile, 'U').readlines()
            # 必须统一编码才能比较
            # H3C对中文的编码是gb2312
            i = 0
            while (i < len(a)):
                a[i] = a[i].decode('gb2312').encode('utf-8')
                i += 1
            i = 0
            while (i < len(b)):
                b[i] = b[i].decode('gb2312').encode('utf-8')
                i += 1
            # 开始对比
            diff = difflib.ndiff(a, b)
            result = ""
            # 优化视觉效果，排除？开头的行
            for line in diff:
                if line[0] == "?":
                    continue
                result += line
            result += "\n"
            return render_template('viewNetworkConfigDiff.html', data=result)
        else:
            abort(404)

def downloadNetworkConfig(app):
    @app.route('/downloadNetworkConfig')
    @login_required
    def downloadNetworkConfig():
        """ 网络配置管理：打包下载最新的配置文件 """
        sql = """ select id,DeviceName,LastCheckTime,ConfigFilePath from `NetworkConfigManagement` as ncm,(select max(id) 'cid'  from `NetworkConfigManagement` group by DeviceName) as cc where ncm.id=cc.cid """
        cur = db.execute(sql)
        res = cur.fetchall()
        timestampDate = time.strftime("%Y.%m.%d", time.localtime())
        zipfilename = u'%s/网络设备最新配置_%s.zip' % (DOWNLOAD_FONDER, timestampDate)
        z = zipfile.ZipFile(zipfilename, mode='w', compression=zipfile.ZIP_DEFLATED)
        for item in res:
            z.write(item["ConfigFilePath"], item["ConfigFilePath"].split("/")[-1])
        z.close()
        opLogging("打包下载了最新的配置文件")
        return redirect(zipfilename)