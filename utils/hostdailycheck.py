from flask import request, render_template, redirect, abort
from dbutil.dbutil import db
from werkzeug.utils import secure_filename
import os, time, zipfile
from utils.utils import opLogging
from utils.auth import login_required

UPLOAD_FOLDER = 'upload'

############################################
#             系统每日巡检模块             #
############################################
def uploadHostDailyCheck(app):
    @app.route('/api/uploadHostDailyCheck', methods=['POST'])
    def uploadHostDailyCheck():
        """ 系统每日巡检：接受上传的检查结果文件；更新检查结果的数据库 """
        assert request.method == 'POST'
        ##保存上传文件
        file = request.files['filename']
        filename = secure_filename(file.filename)
        file.save(os.path.join("%s/HostDailyCheck" % UPLOAD_FOLDER, filename))
        ##更新数据库
        FilePath = "%s/HostDailyCheck/%s" % (UPLOAD_FOLDER, filename)
        # 文件名格式：HostDailyCheck-MPOSAPP-M-A-20160315.txt
        Hostname = filename[15:-13]
        LastCheck = time.strftime('%Y-%m-%d %X', time.localtime())
        insert_sql = """ insert into `HostDailyCheck` (Hostname,LastCheck,FilePath) values ("%s","%s","%s"); """ % (
        Hostname, LastCheck, FilePath)
        db.execute(insert_sql)
        # opLogging(msg = "主机 %s 上传系统巡检结果" % Hostname,level = "debug")
        return '检查结果上传成功'

def uploadHostDailyCheckReport(app):
    @app.route('/api/uploadHostDailyCheckReport', methods=['POST'])
    def uploadHostDailyCheckReport():
        """ 系统每日巡检：更新检查结果报表数据库 """
        assert request.method == 'POST'
        result = request.get_json()
        keys = result.keys()
        values = result.values()
        new_values = []
        for v in values:
            new_values.append(v.replace(',', '\n'))
        sql = """ insert into `HostDailyCheckReport` (%s) values ("%s");""" % (','.join(keys), '","'.join(new_values))
        db.execute(sql)
        return "报表信息更新成功"

def viewHostDailyCheck(app):
    @app.route('/viewHostDailyCheck/<id>')
    @login_required
    def viewHostDailyCheck(id):
        """ 系统每日巡检：查看系统的检查结果 """
        sql = """ select FilePath from HostDailyCheck where id=""" + id
        cur = db.execute(sql)
        filename = cur.fetchone()
        filename = filename["FilePath"]
        if os.path.exists(filename):
            #with open(filename, 'r') as fp:
            with open(filename, 'r', encoding='utf-8') as fp:
                lines = fp.readlines()
                fp.close()
            check_result = ''.join(lines)
            return render_template('viewHostDailyCheck.html', data=check_result)
        else:
            abort(404)

def downloadHostDailyCheck(app):
    @app.route('/downloadHostDailyCheck')
    @login_required
    def downloadHostDailyCheck():
        """ 系统每日巡检：打包下载最新的检查结果 """
        sql = """ select id,Hostname,LastCheck,FilePath from HostDailyCheck as hc,(select max(id) 'cid'  from HostDailyCheck group by Hostname) as cc where hc.id=cc.cid; """
        cur = db.execute(sql)
        res = cur.fetchall()
        timestampDate = time.strftime("%Y.%m.%d", time.localtime())
        zipfilename = u'%s/系统每日巡检结果_%s.zip' % (DOWNLOAD_FONDER, timestampDate)
        z = zipfile.ZipFile(zipfilename, mode='w', compression=zipfile.ZIP_DEFLATED)
        for item in res:
            z.write(item["FilePath"], item["FilePath"].split("/")[-1])
        z.close()
        opLogging("打包下载系统巡检结果")
        return redirect(zipfilename)