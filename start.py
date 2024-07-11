#!/usr/bin/env python
# _*_ coding=utf8 _*_
from flask import Flask, request, render_template, session
from flask import g
from flask_mail import Mail
from config import page_config, NCM_Agent, global_config, secret_key
import json,logging
from dbutil.dbutil import db
from utils.utils import opLogging, loggingToFile
from utils.auth import login_required, login, logout, index, AuthorizationForUser, apiAuthorizationForUser, checkUserCountInDB, hash_pass
from utils.excel import exportExcel
from utils.networkconfig import backupAllNetworkConfig, fetchOneNetworkConfig, viewNetworkConfig, viewNetworkConfigDiff,downloadNetworkConfig
from utils.hostdailycheck import uploadHostDailyCheck, uploadHostDailyCheckReport, viewHostDailyCheck, downloadHostDailyCheck
from utils.notice import pack, sendSMS, send_notice, mail
from utils.deploy import viewProductUpdateDiff, uploadProductUpdateDatabase, uploadProductUpdateDiffApi, uploadProductUpdateRestartTimes
from utils.aoc import fov_report

app = Flask(__name__)

login(app)
logout(app)
index(app)
exportExcel(app)
AuthorizationForUser(app)
apiAuthorizationForUser(app)
backupAllNetworkConfig(app)
fetchOneNetworkConfig(app)
viewNetworkConfig(app)
viewNetworkConfigDiff(app)
downloadNetworkConfig(app)
uploadHostDailyCheckReport(app)
uploadHostDailyCheck(app)
viewHostDailyCheck(app)
downloadHostDailyCheck(app)
pack(app)
sendSMS(app)
send_notice(app)
viewProductUpdateDiff(app)
uploadProductUpdateDatabase(app)
uploadProductUpdateDiffApi(app)
uploadProductUpdateRestartTimes(app)
fov_report(app)
mail(app)

app.secret_key = secret_key

page_config.setdefault('favicon', '/static/img/favicon.ico')
page_config.setdefault('title', 'warehousecmdb')
page_config.setdefault('brand_name', 'warehousecmdb')

DOWNLOAD_FONDER = 'static/download'
logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s - [%(levelname)s] - %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    filename=global_config["logfile"],
                    filemode='a')
app.config.update(
    DEBUG = True,
    MAIL_SERVER='smtp.warehouse.com',
    MAIL_USERNAME = 'deploy@warehouse.com',
    MAIL_PASSWORD = 'warehouse@123',
)

#mail = Mail(app)




@app.before_request
def set_global_variables():
    g.config = NCM_Agent


############################################
#                 通用功能模块             #
############################################
@app.route('/page/<template>')
@login_required
def render(template):
    return render_template('page/' + template + '.html', data=page_config)


# def encrypto(clearText):
#     """ 通用功能模块:文本信息加密 """
#     encryptUrl = NCM_Agent["domain"] + "/encrypto/"
#     result = {}  # 返回信息
#     chiperText = ""  # 加密后的密文
#     status = 0  # 状态
#     message = "ok"  # 文本信息
#     try:
#         r = requests.get(encryptUrl + clearText)
#         if r.status_code >= 200 and r.status_code < 300:
#             chiperText = r.text
#         else:
#             #message = str(a)
#             message = str(r.status_code)
#             status = 1
#     except Exception as e:
#         message = str(e)
#         status = 2
#     result["status"] = status
#     result["chiperText"] = chiperText
#     result["message"] = message
#     return result


@app.route('/addapi', methods=['POST'])
@login_required
def addapi():
    """ 通用功能模块:添加表记录的API """
    obj = request.form.to_dict()
    table = obj.pop('action_type')
    # 网络配置管理模块中的密码字段进行加密(加密机加密)
    # if table == "NetworkDevice":
    #     r = encrypto(obj["Passwd"])
    #     if r["status"] == 0:
    #         obj["Passwd"] = r["chiperText"]
    #     else:
    #         loggingToFile(r["message"])
    #         return json.dumps({'error': '%s' % r["message"]})
    # 用户管理模块
    if table == "user":
        # 密码字段进行加密(hash加密)
        obj["password"] = "$chiper$" + hash_pass(obj["password"])
        if checkUserCountInDB(obj["username"]) > 0:
            return json.dumps({'error': '用户有重名！'})
    keys = obj.keys()
    values = obj.values()
    sql = 'insert into `%s` (`%s`) values ("%s")' % (table, '`,`'.join(keys), '","'.join(values))
    db.execute(sql)
    res = {'result': 'ok'}
    table_id = db.execute('select max(id) as id from %s' % table).fetchone()["id"]
    if table == "user":
        logMSG = "添加新用户 %s" % db.execute('select id,username from user order by id desc;').fetchone()["username"]
    elif table == "AuthorizeRole":
        logMSG = "添加授权规则 %s" % db.execute('select id,title from AuthorizeRole order by id desc;').fetchone()["title"]
    else:
        logMSG = "为数据表 %s 添加一条记录,id=%s" % (table, table_id)
    opLogging(logMSG)
    return json.dumps(res)


@app.route('/delapi', methods=['POST'])
@login_required
def delapi():
    """ 通用功能模块:删除表记录的API """
    obj = request.form.to_dict()
    table = obj.pop('action_type')
    table_id = obj.pop('id')
    # 用户管理模块
    if table == "user":
        if checkUserCountInDB() == 1:
            return json.dumps({'error': '必须至少保留一个有效用户！'})
    sql = 'delete from `%s` where `id`=%s' % (table, table_id)
    if table == "user":
        logMSG = "删除用户 %s" % db.execute('select username from user where id=%s' % table_id).fetchone()["username"]
    else:
        logMSG = "从数据表 %s 删除一条记录，id=%s" % (table, table_id)
    db.execute(sql)
    res = {'result': 'ok'}
    opLogging(logMSG)
    return json.dumps(res)



@app.route('/listapi')
@login_required
def listapi():
    """ 通用功能模块:显示表记录的API """
    action_type = request.args.get('action_type')
    sql = 'select * from ' + action_type
    if action_type == "HostDailyCheck":
        # 每日巡检只显示最新结果
        sql = """ select id,Hostname,LastCheck,FilePath from HostDailyCheck as hc,(select max(id) 'cid'  from HostDailyCheck group by Hostname) as cc where hc.id=cc.cid; """
    elif action_type == "SMSHistory":
        # 只显示最新的100条结果
        sql = """select * from SMSHistory order by MSG_TIM desc LIMIT 0,100 """
    elif action_type == "HostDailyCheckReport":
        # 每日巡检报表只显示最新结果
        sql = """ select id,DateTime,Hostname,OSRelease,Kernel,Language,LastReboot,Uptime,CPUs,CPUType,Arch,MemTotal,MemFree,MemUsedPercent,DiskTotal,DiskFree,DiskUsedPercent,InodeTotal,InodeFree,InodeUsedPercent,IP,MAC,Gateway,DNS,Listen,Selinux,Firewall,USERs,USEREmptyPassword,USERTheSameUID,PasswordExpiry,RootUser,Sudoers,SSHAuthorized,SSHDProtocolVersion,SSHDPermitRootLogin,DefunctProsess,SelfInitiatedService,SelfInitiatedProgram,RuningService,Crontab,Syslog,SNMP,NTP,JDK from HostDailyCheckReport as hc,(select max(id) 'cid'  from HostDailyCheckReport group by Hostname) as cc where hc.id=cc.cid; """
    # elif action_type =="AuthorizeRole":
    #        sql = """ select AuthorizeRole.id,AuthorizeRole.Name,AuthorizeRole.Title,group_concat(user.username) as Authorized from user,AuthorizeRole where user.role_id=AuthorizeRole.id group by Name; """
    elif action_type == "OperationLog":
        sql = 'select * from OperationLog'
        if 'all' not in session['role_name']:
            sql += """ where User="%s" """ % session["username"]
    else:
        pass
    cur = db.execute(sql)
    res = {"result": cur.fetchall()}
    return json.dumps(res)


@app.route('/updateapi', methods=['POST'])
@login_required
def updateapi():
    """ 通用功能模块:更新表记录的API """
    obj = request.form.to_dict()
    table = obj.pop('action_type')
    # 网络配置管理模块中的密码字段进行加密(通过加密机加密)
    if table == "NetworkDevice":
        r = encrypto(obj["Passwd"])
        if r["status"] == 0:
            obj["Passwd"] = r["chiperText"]
        else:
            loggingToFile(r["message"])
            return json.dumps({'error': '%s' % r["message"]})
    # 用户管理模块中
    if table == "user":
        # 如果密码字段输入的是明文，则进行加密(hash加密)
        if obj["password"][:8] != "$chiper$":
            obj["password"] = "$chiper$" + hash_pass(obj["password"])
        userNameInDB = db.execute('select username from user where id="%s"' % obj["id"]).fetchone()["username"]
        if userNameInDB != obj["username"]:
            return json.dumps({'error': '不允许修改用户名！'})

    table_id = obj.pop('id')
    arr = []
    for key, val in obj.items():
        arr.append('`%s`="%s"' % (key, val))
    keys = obj.keys()
    values = obj.values()
    sql = 'update `%s` set ' % (table)

    sql += ','.join(arr)
    sql += ' where id=' + table_id
    if table == "user":
        logMSG = "修改用户 %s 的信息" % db.execute('select username from user where id=%s' % table_id).fetchone()["username"]
    elif table == "SMSUsers":
        logMSG = "修改短信接收用户 %s 的信息" % db.execute('select UserName from SMSUsers where id=%s' % table_id).fetchone()[
            "UserName"]
    else:
        logMSG = "修改数据表 %s 一条记录,id=%s" % (table, table_id)
    db.execute(sql)
    res = {'result': 'ok'}
    opLogging(logMSG)
    return json.dumps(res)








############################################
#                  监控用                  #
############################################
@app.route('/hello')
def hello():
    return "world!"


############################################
#                  主函数                  #
############################################
if __name__ == '__main__':
    # 启用多线程，防止阻塞
    app.run(debug=True, port=8080, host='0.0.0.0',threaded=True)


