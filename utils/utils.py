import logging, time
from flask import session, request
from dbutil.dbutil import db





def getTimestamp():
    return time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

def getIp():
    ip = request.remote_addr
    return ip
#用nginx反向代理获取IP
#def getIp(request):
#    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
#    if x_forwarded_for:
#        ip = x_forwarded_for.split(',')[0]#所以这里是真实的ip
#    else:
#        ip = request.META.get('REMOTE_ADDR')#这里获得代理ip
#    return ip

def opLogging(msg, level="INFO", username="anonymous"):
    Timestamp = getTimestamp()
    Entryip = getIp()
    if "username" in session:
        username = session['username']
    # 插入数据库
    sql = 'insert into OperationLog (Timestamp,User,Entryip,Level,Messages) values ("%s","%s","%s","%s","%s")' % (
    Timestamp, username, Entryip, level, msg)
    db.execute(sql)

def loggingToFile(msg,level="debug"):
    logging.debug(msg)
    if level == "warning":
        logging.warning(msg)

