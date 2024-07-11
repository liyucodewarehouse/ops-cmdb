import time
import xlwt
from flask import request, redirect, url_for
from dbutil.dbutil import db
from config import page_config
from utils.utils import opLogging, loggingToFile
from utils.auth import login_required

############################################
#                Excel导出模块             #
############################################
def getExportSql(field, action_type):
    """获取Excel导出时的SQL语句 """
    # 情况一：外键引用
    #if field.has_key('select_type'):
    if 'select_type' in field:
        foreign_table = field['select_type']
        foreign_primary_key = 'id'  # 默认值
        foreign_field = 'name'  # 默认值
        if field.has_key('option_val'):
            foreign_primary_key = field['option_val']
        if field.has_key('option_name'):
            foreign_field = field['option_name']
        query_list = "(select %s from %s where %s=%s.%s) as %s," % (
        foreign_field, foreign_table, foreign_primary_key, action_type, field['name'], field['name'])
    # 情况二：配置文件里预定义值
    # elif field.has_key('value'):
    #    pass
    # 情况三：一般情况
    else:
        query_list = "%s," % field['name']
    return query_list


def getExportMaxFieldLenght(data):
    """获取Excel每一列对应的宽度 """
    # 初始化
    maxLen = []
    i = 0
    while (i < len(data[0])):
        maxLen.append(0)
        i = i + 1
    # 获取每个字段对应的最大长度
    for item in data:
        i = 0
        while (i < len(item)):
            if item[i] == None:
                maxLen[i] = 0
            elif maxLen[i] < len(item[i]):
                maxLen[i] = len(item[i])
            else:
                pass
            i = i + 1
    # 调剂
    minWidth = 15  # 没办法，只能用了魔幻数字了。表示15个英文字母的宽度
    maxWidth = 35
    i = 0
    while (i < len(maxLen)):
        if maxLen[i] < minWidth:
            maxLen[i] = minWidth
        elif maxLen[i] > maxWidth:
            maxLen[i] = maxWidth
        else:
            pass
        i = i + 1
    return maxLen

def exportExcel(app):
    @app.route('/export/excel')
    @login_required
    def exportExcel():
        action_type = request.args.get('action_type')
        query_string = ""
        fields_title = []
        fields = []
        data = []
        timestamp = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        timestampDate = time.strftime("%Y.%m.%d", time.localtime())
        # 按照配置文件的字段顺序输出
        for main_config in page_config['menu']:
            #if main_config.has_key('sub'):
            if 'sub' in main_config:
                for sub_config in main_config['sub']:
                    if sub_config['name'] == action_type:
                        filename = u"%s" % sub_config['title']
                        for field in sub_config['data']:
                            query_string += getExportSql(field, action_type)
                            fields_title.append(field['title'])
                            fields.append(field['name'])
                        break
            else:
                if main_config['name'] == action_type:
                    filename = u"%s" % main_config['title']
                    for field in main_config['data']:
                        query_string += getExportSql(field, action_type)
                        fields_title.append(field['title'])
                        fields.append(field['name'])
                    break
        query_string = query_string[:-1]  # 去掉最后一个逗号
        sql = "select %s from %s" % (query_string, action_type)
        # 如果是导出每日巡检报表，则只导出每台服务器最新的一次检查结果
        if action_type == "HostDailyCheckReport":
            sql = "select %s from HostDailyCheckReport as hc,(select max(id) 'cid'  from HostDailyCheckReport group by Hostname) as cc where hc.id=cc.cid;" % query_string
        # 如果是导出每日巡检结果，则只导出每台服务器最新的一次检查结果
        elif action_type == "HostDailyCheck":
            sql = """ select %s from HostDailyCheck as hc,(select max(id) 'cid'  from HostDailyCheck group by Hostname) as cc where hc.id=cc.cid; """ % query_string
        else:
            pass
        loggingToFile("export:%s" % sql)
        # 生成excel表格添加标题
        data.append(fields_title)
        # 生成excel表格的具体内容
        cur = db.execute(sql)
        res = cur.fetchall()
        for item in res:
            sorted_item = []
            for f in fields:
                # 查询出来的每一条结果，都按配置文件的字段顺序排序
                sorted_item.append(item[f])
            data.append(sorted_item)
        # 生成excel文件
        file = xlwt.Workbook(encoding='utf-8')
        table = file.add_sheet(u"%s" % filename)
        # 设置显示样式
        style_title = xlwt.easyxf('font: bold 1,height 300;'
                                'borders: left thin, right thin, top thin, bottom thin;'
                                'alignment: horizontal center;'
                                'pattern: pattern solid, fore_colour gray40;')
        style_data = xlwt.easyxf('font: height 256;'
                                'borders: left thin, right thin, top thin, bottom thin;'
                                'alignment: horizontal center, wrap on;')
        style_tip = xlwt.easyxf('font: height 200,colour red;')
        FieldWidth = getExportMaxFieldLenght(data)
        row = 0
        for row_data in data:
            column = 0
            for cell_data in row_data:
                if row == 0:
                    # 写入标题头
                    table.write(row, column, u"%s" % cell_data, style_title)
                else:
                    # 写入数据
                    table.write(row, column, u"%s" % cell_data, style_data)
                # 设置字段宽度--开始
                table.col(column).width = 256 * FieldWidth[column]
                # 设置字段宽度--结束
                column += 1
            row += 1
        table.write(row, 0, "报表生成时间:%s" % timestamp, style_tip)
        filename = "%s_%s.xls" % (filename, timestampDate)
        file.save(u"static/export/%s" % filename)
        opLogging("导出文件 %s" % filename)
        return redirect(url_for('static', filename='export/%s' % filename))