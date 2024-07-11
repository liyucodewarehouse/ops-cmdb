from flask import request, render_template, redirect, url_for, session, abort
from dbutil.dbutil import db
from config import secret_key, page_config
from utils.utils import opLogging
from functools import wraps
from utils.dashboard import getProductInfo
import base64, hashlib,json





############################################
#                登录/登出模块             #
############################################
def hash_pass(password):
    """ 密码加密（本地进行） """
    salted_password = password + base64.b64encode(secret_key.encode('utf-8')).decode('utf-8')

    return hashlib.sha256(salted_password.encode('utf-8')).hexdigest()



def checkUserCountInDB(name=None):
    """ 统计数据库中用户数量 """
    if name == None:
        sql = 'select count(*) as count from user'
    else:
        sql = 'select count(*) as count from user where username="%s"' % name
    cur = db.execute(sql)
    count = cur.fetchone()["count"]
    return int(count)


def writeSession(name, role_id):
    ''' 登录时写session信息 '''
    session['username'] = name
    # 把授权规则变成规则名列表
    if role_id is not None and len(role_id) > 0:
        role_id = role_id.split(',')
        roleNameList = []
        whereStatement = ''
        for id in role_id:
            whereStatement += " id=%s or" % id
        whereStatement = whereStatement[:-2]
        sql = "select name from AuthorizeRole where " + whereStatement
        cur = db.execute(sql)
        for roleName in cur.fetchall():
            roleNameList.append(roleName["name"])
        session['role_name'] = roleNameList
    else:
        session['role_name'] = ''


def removeSession():
    username = "nobody"
    if 'username' in session:
        username = session.pop('username')
    if 'role_id' in session:
        session.pop('role_id')
    return username


def login(app):
    @app.route('/login', methods=['GET', 'POST'])
    def login():
        if 'username' in session:
            return redirect('/')
        if request.method == "POST":
            name = request.form.get('username')
            passwd = request.form.get('password')
            passwd = "$chiper$" + hash_pass(passwd)
            redirectURL = request.form.get('redirectURL')
            obj = {"result": 1}
            obj['redirectURL'] = redirectURL
            if name and passwd:
                sql = 'select * from `user` where `username`="%s" and `password`="%s"' % (name, passwd)
                cur = db.execute(sql)
                res = cur.fetchone()
                if res:
                    if res["status"] == "0":
                        obj["result"] = 0
                        writeSession(name, res["role_id"])
                        opLogging("用户 %s 登录成功！" % name)
                    else:
                        obj["result"] = 2
                        opLogging("用户 %s 登录失败！已禁用" % name, username=name)
                else:
                    obj["result"] = 1
                    opLogging("用户 %s 登录失败！用户名或密码不正确" % name, username=name)
            return json.dumps(obj)
        else:
            return render_template('login.html')


def logout(app):
    @app.route('/logout')
    def logout():
        username = removeSession()
        opLogging("用户 %s 退出系统！" % username)
        return redirect('/login')


def login_required(func):
    @wraps(func)
    def wp(*args, **kw):
        
        if 'username' in session:
            if check_Authorize():
                return func(*args, **kw)
            else:
                # return json.dumps(u"{'error':'Permition'}")
                # removeSession()
                abort(403)
        else:
            return redirect(url_for('login', redirectURL=request.url))

    return wp

def index(app):
    @app.route('/')
    @login_required
    def index():
        """ Dashboard """
        return render_template('dashboard.html', data=page_config, updateData=getProductInfo())
    

def check_Authorize():
    ''' 授权检查 '''
    urlPath = request.path
    # 默认允许所有登录用户访问首页
    if urlPath == "/":
        return True
    urlPathList = urlPath.split('/')
    if str(urlPathList[-1]).isdigit():
        roleName = urlPathList[-2]
    else:
        roleName = urlPathList[-1]
    universalRole = ['addapi', 'delapi', 'updateapi']
    # 如果是超级权限
    if "all" in session["role_name"]:
        return True
    else:
        # 非超级权限
        # 查看记录/列表的权限与模块权限一样
        if roleName == "listapi":
            action_type = request.args.get('action_type')
            if action_type in session["role_name"]:
                return True
        # 更新、删除、添加功能需要授权，且对应的模块也要授权
        elif roleName in universalRole:
            # 获取登录用户的用户名
            username = session["username"]
            
            # 查询用户权限
            sql = """
                SELECT GROUP_CONCAT(ar.name) AS names
                FROM AuthorizeRole AS ar
                JOIN user AS u ON FIND_IN_SET(ar.id, u.role_id)
                WHERE u.username = '%s'

            """ % username
            print("SQL query:", sql)
            cur = db.execute(sql)
            row = cur.fetchone()
            names = row["names"]
            name_list = names.split(",")
            print(name_list)
            if roleName in name_list:
                return True
        else:
            if roleName in session["role_name"]:
                return True
            else:
                return False







            
def AuthorizationForUser(app):
    @app.route('/AuthorizationForUser/<id>')
    @login_required
    def AuthorizationForUser(id):
        ''' 打开用户授权页 '''
        userInfo = db.execute('select id,real_name,username,role_id from user where id="%s"' % id).fetchone()
        roleInfo = {}
        roleInfo = db.execute('select * from AuthorizeRole').fetchall()
        roleGroupInfo = {}
        roleGroupInfo = db.execute('select * from AuthorizeRoleGroup').fetchall()
        str_roleChecked = []
        if userInfo["role_id"]:
            str_roleChecked = userInfo["role_id"].split(',')
        int_roleChecked = []
        for i in str_roleChecked:
            if i.isdigit():
                int_roleChecked.append(int(i))
        return render_template('authorizationForUser.html', userInfo=userInfo, roleInfo=roleInfo,
                            roleChecked=int_roleChecked, roleGroupInfo=roleGroupInfo)

def apiAuthorizationForUser(app):
    @app.route('/api/AuthorizationForUser')
    @login_required
    def apiAuthorizationForUser():
        """ 给用户授权的API """
        id = request.args.get('id')  # 用户ID
        role_id = request.args.get('role_id')  # 逗号分隔开的一系列权限ID
        username = db.execute('select username from user where id="%s"' % id).fetchone()["username"]
        sql = """ update user set role_id="%s" where id="%s" """ % (role_id, id)
        if db.execute(sql):
            # return json.dumps(u"{'result':'success！'}")
            opLogging("给用户 %s 授权成功！" % username)
            opLogging("管理员更新了您的权限！请重新登录", username=username)
            return "Success!"
        else:
            # return json.dumps(u"{'error':'faile！'}")
            opLogging("给用户 %s 授权失败！" % username)
            return "Failed!"