from flask import request, render_template, abort
from config import global_config,product_series
#from functools import wraps
from dbutil.dbutil import db
from werkzeug.utils import secure_filename
from utils.auth import login_required
import os
############################################
#                生产更新模块              #
############################################
def uploadProductUpdateDiffApi(app):
    @app.route('/api/ProductUpdate/uploadDiffFile', methods=['POST'])
    def uploadProductUpdateDiffApi():
        """ 生产更新模块：接受上传的diff文件；更新数据库 """
        assert request.method == 'POST'
        ##保存上传文件
        file = request.files['filename']
        filename = secure_filename(file.filename)
        file.save(os.path.join("%s/ProductUpdateDiff" % UPLOAD_FOLDER, filename))
        return "ok"

def uploadProductUpdateRestartTimes(app):
    @app.route('/api/ProductUpdate/updateRestartTimes', methods=['POST'])
    def uploadProductUpdateRestartTimes():
        """ 生产更新模块：更新重启次数 """
        # 上传方式:
        # curl -H "Content-type: application/json" -X POST -d "{\"HostName\":\"`hostname`\"}" http://172.23.20.201:8080/api/ProductUpdate/updateRestartTimes
        # 将这条SHELL命令嵌入到TDS启动脚本中，该命令每执行一次表示TDS重启过一次
        assert request.method == 'POST'
        result = request.get_json()
        HostName = result["HostName"]
        # 把重启次数算在最近一次更新的头上
        sql = """
        -- 更新该主机的最近一次更新记录，重启次数+1
        update ProductUpdateDiff A
            join (select max(id) as id from ProductUpdateDiff where HostName="%s" and Status!="Checked") as A2
            on A2.id=A.id
        set A.restart_times=A.restart_times+1;
        """ % HostName
        db.execute(sql)
        # 如果是生产系统，则记录重启时间等信息。供查询和计算可用性
        if HostName in product_series:
            sql2 = """ insert into service_boot_info (timestamp,hostname,action,app) values ("%s","%s","start","%s"); """ % (getTimestamp(),HostName,product_series[HostName])
            db.execute(sql2)

        return "ok"

def uploadProductUpdateDatabase(app):
    @app.route('/api/ProductUpdate/updateInfo', methods=['POST'])
    def uploadProductUpdateDatabase():
        """ 生产更新模块：更新数据库 """
        assert request.method == 'POST'
        result = request.get_json()
        result["DiffFileLocation"] = "%s/ProductUpdateDiff/%s" % (UPLOAD_FOLDER, result["DiffFileLocation"])
        keys = result.keys()
        values = result.values()
        query_sql = """ select UUID from ProductUpdateDiff where UUID="%s" """ % result["UUID"]
        cur = db.execute(query_sql)
        # 状态有三种：
        #  checked: 当生产更新脚本执行"检查"时产生此状态
        #  updated: 当生产更新脚本执行"更新"时产生此状态
        #  rollbak: 当生产更新脚本执行"回退"时产生此状态
        #
        # 状态的更新设计：
        #  如果数据库记录的状态是checked，则当此状态发生改变时会被另外两种替换
        #  如果数据库记录的状态是updated或rollbak，则此状态不会被checked覆盖，只会被updated或rollbak替换
        if cur.fetchone():
            # 如果已有记录则更新
            if result["Status"] == "checked":
                # 如果状态是checked,则不更新状态字段
                sql = """ update ProductUpdateDiff set Timestamp="%s",HostName="%s",PackageLocation="%s",DiffFileLocation="%s"
                """ % (result["Timestamp"], result["HostName"], result["PackageLocation"], result["DiffFileLocation"],
                    result["UUID"])
            else:
                # 如果状态是updated或rollbak等，则状态字段也要更新
                sql = """ update ProductUpdateDiff set Timestamp="%s",HostName="%s",PackageLocation="%s",Status="%s",DiffFileLocation="%s" where UUID="%s"
                """ % (result["Timestamp"], result["HostName"], result["PackageLocation"], result["Status"],
                    result["DiffFileLocation"], result["UUID"])
        else:
            # 全新记录则新增
            sql = """ insert into `ProductUpdateDiff` (`%s`) values ("%s");""" % ('`,`'.join(keys), '","'.join(values))
        db.execute(sql)
        # 下面代码获取ID
        query_sql = """ select id from ProductUpdateDiff where UUID="%s" """ % result["UUID"]
        cur = db.execute(query_sql)
        id = cur.fetchone()["id"]
        return "代码审计：%s/viewProductUpdateDiff/%s\n" % (global_config["public_url"], id)

def viewProductUpdateDiff(app):
    @app.route('/viewProductUpdateDiff/<id>')
    @login_required
    def viewProductUpdateDiff(id):
        """ 生产更新模块：代码审核/差异对比 """
        sql = """ select Title,UUID,DiffFileLocation from ProductUpdateDiff where id=""" + id
        cur = db.execute(sql)
        res = cur.fetchone()
        if os.path.exists(res["DiffFileLocation"]):
            with open(res["DiffFileLocation"], "r") as diffFile:
                result = "".join(diffFile.readlines())
            opLogging("审核了代码：UUID=%s,Title=%s" % (res["UUID"], res["Title"]))
            return render_template('viewProductUpdateDiff.html', data=result)
        else:
            abort(404)