from flask import request
from flask_mail import Message, Mail
from config import SMS_Config
from dbutil.dbutil import db
import requests
import re
from utils.utils import loggingToFile, getTimestamp



def mail(app):
    def mail():
        mail=Mail(app)
        return mail

############################################
#             通知平台管理模块             #
############################################
def sendSMS(app):
    @app.route('/sendSMS', methods=['POST', 'GET'])
    def sendSMS():
        # 短信发送程序
        # 短信通道：
        #   http://119.147.208.220/user/yunweisms.tran?USRMP=15986807009&SMSCONTENT=test
        #   限制：60秒内，不能给同一个手机发送内容相同的短信
        #
        # 设计要求：
        #   1.如果没有设置手机号码则默认发送给运维组所有成员
        #   2.多个手机号码之间用逗号隔开
        #   3.返回结果记录数据库
        URL = SMS_Config["url"]
        # URL参数验证
        if request.method == 'GET':
            content = request.args.get('content')
        # 短信内容验证
        if content == None:
            msg = '无短信内容！'
            loggingToFile(msg)
            return msg
        # 收信人列表
        sql = """ select * from SMSUsers """
        cur = db.execute(sql)
        res = cur.fetchall()
        # 开始发短信
        for user in res:
            url = URL + "?USRMP=" + user["Mobile"] + "&SMSCONTENT=" + content
            r = requests.get(url)
            j = r.json()
            # 时间戳格式转换
            # 原格式：20160414095517
            timeStr = re.match("(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})", j["MSG_TIM"])
            # 新格式：2016-04-14 09:55:17
            j["MSG_TIM"] = timeStr.group(1) + "-" + timeStr.group(2) + "-" + timeStr.group(3) + " " + timeStr.group(
                4) + ":" + timeStr.group(5) + ":" + timeStr.group(6)
            # 更新数据库
            keys = j.keys()
            values = j.values()
            sql = """ insert into `SMSHistory` (MSG_TIM,USRMP,SMSCONTENT,RETURNMESSAGE,ERRORCODE,RSPCOD,UserName) values ("%s","%s","%s","%s","%s","%s","%s") """ % (
            j["MSG_TIM"], j["USRMP"], j["SMSCONTENT"], j["RETURNMESSAGE"], j["ERRORCODE"], j["RSPCOD"], user["UserName"])
            db.execute(sql)
            SMSResult = j["RETURNMESSAGE"]
        return SMSResult



def send_notice(app):
    @app.route('/send_email',methods=['POST', 'GET'])
    def send_notice():
    # sender 发送方，recipients 接收方列表
        # URL参数验证
        Timestamp = getTimestamp()
        if request.method == 'GET':
            project = request.args.get('project')
            content = request.args.get('content')
            enclosure = request.args.get('enclosure')
            #return jsonify({'t': [content]})
        # 收信人列表
        email_sql = """ select * from user """
        cur = db.execute(email_sql)
        res = cur.fetchall()
        for user in res:
            receive_user=user["email"]
            msg = Message("运维通知",sender='yu.li@warehouse.com',recipients=[receive_user])
            sql = 'insert into Email_Notice (project,content,enclosure,Timestamp) values ("%s","%s","%s","%s")' % (
            project, content, enclosure,Timestamp)
            db.execute(sql)
            #邮件内容
            msg.body = project+content+enclosure
            #发送邮件
        mail.send(msg)
        return "succeed"


def pack(app):
    @app.route('/pack',methods=['POST', 'GET'])
    def pack():
    # sender 发送方，recipients 接收方列表
        # URL参数验证
        if request.method == 'GET':
            project = request.args.get('project')
            packcontent = request.args.get('packcontent')
            statuscode = request.args.get('statuscode')
            sql = 'insert into packinfo (project,packcontent,statuscode) values ("%s","%s","%s")' % (
            project, packcontent, statuscode)
            db.execute(sql)
        return "succeed"