from dbutil.dbutil import db
import time, datetime


############################################
#                 Dashboard模块            #
############################################
def getProductInfo():
    """ 获取应用更新次数、应用重启次数、开发人员更新次数、可用性等相关信息 """
    result = {}
    #周一
    theFirstDateOfWeek = getTheFirstDateOfWeek()
    #月初第一天
    theFirstDateOfMonth = getTheFirstDateOfMonth()
    #30天前
    theDateOfThirtyDaysAgo = getTheDateOfThirtyDaysAgo()
    #今天
    theDateOfToday = getTheDateOfToday()

    # 更新频率
    # 主机名 	本周更新 	本月更新 	30天更新
    productUpdateFrequencySql = """
        select HostName,
        count(case when Timestamp>='%s' then 1 end) productWeeklyUpdate,
        count(case when Timestamp>='%s' then 1 end) productMonthlyUpdate,
        count(case when Timestamp>='%s' then 1 end) productThirtyDaysUpdate
        from ProductUpdateDiff group by HostName order by productWeeklyUpdate desc;
    """ % (theFirstDateOfWeek,theFirstDateOfMonth,theDateOfThirtyDaysAgo)
    result["productUpdateFrequency"] = db.execute(productUpdateFrequencySql).fetchall()

    # 重启次数
    # 产品线   本周重启 	本月重启 	30天重启
    productRestartTimesSql = """
        select app,
        count(case when timestamp>='%s' then 1 end) productWeeklyRestart,
        count(case when timestamp>='%s' then 1 end) productMonthlyRestart,
        count(case when timestamp>='%s' then 1 end)  productThirtyDaysRestart
        from service_boot_info where action="start" group by app order by productWeeklyRestart desc;
    """ % (theFirstDateOfWeek,theFirstDateOfMonth,theDateOfThirtyDaysAgo)
    result["productRestartTimes"] = db.execute(productRestartTimesSql).fetchall()

    # 开发人员更新次数
    # 开发     本周更新     本月更新    30天更新
    developerUpdateFrequencySql = """
        select ProjectLeader as developer,
        count(case when Timestamp>='%s' then 1 end) developerWeeklyUpdate,
        count(case when Timestamp>='%s' then 1 end) developerMonthlyUpdate,
        count(case when Timestamp>='%s' then 1 end) developerThirtyDaysUpdate
        from ProductUpdateDiff group by ProjectLeader order by developerWeeklyUpdate desc;
    """ % (theFirstDateOfWeek, theFirstDateOfMonth, theDateOfThirtyDaysAgo)
    result["developerUpdateFrequency"] = db.execute(developerUpdateFrequencySql).fetchall()

    #获取生产系统的可用性数据
    availability = []
    for item in result["productRestartTimes"]:
        service = {}
        service["app"] = item["app"]
        service["WeeklyAvailability"] = getServiceAvailability(theFirstDateOfWeek,item["productWeeklyRestart"])
        service["MonthlyAvailability"] = getServiceAvailability(theFirstDateOfMonth,item["productMonthlyRestart"])
        service["ThirtyDaysAvailability"] = getServiceAvailability(theDateOfThirtyDaysAgo,item["productThirtyDaysRestart"])
        availability.append(service)
    result["serviceAvailability"] = availability

    return result


def getTheDateOfToday():
    """获取今天的日期"""
    return time.strftime('%Y-%m-%d', time.localtime())


def getTheFirstDateOfWeek():
    """获取周一的日期"""
    # 由于time.strftime('%w',XXX)取值(0[周日]-6[周六])，要把它换算成周一是第一天
    #
    # 星期几   %w  实际相差天数
    # 周日    0   6
    # 周一    1   0
    # 周二    2   1
    # 周三    3   2
    # 周四    4   3
    # 周五    5   4
    # 周六    6   5
    # 工式是：实际相差天数 = (7 + %w - 1) % 7
    today = datetime.date.today()
    #today = datetime.now()
    differenceInDate = (7 + int(time.strftime('%w', time.localtime())) - 1) % 7
    monday = today - datetime.timedelta(differenceInDate)
    return str(monday)


def getTheFirstDateOfMonth():
    """获取本月第一天的日期"""
    return time.strftime('%Y-%m-01', time.localtime())


def getTheDateOfThirtyDaysAgo():
    """获取30天前的日期"""
    today = datetime.date.today()
    ThirtyDaysAgo = today - datetime.timedelta(30)
    return str(ThirtyDaysAgo)

def getServiceAvailability(startTime,restart_times):
    """	计算可用性 """
    # date必须是 "%Y-%m-%d" 如 2016-06-18
    # 可用性 =（时间跨度 - 故障时间）/时间跨度*100
    # 预设每次重启用时2分钟，即120秒

    if isinstance(restart_times, int) or isinstance(restart_times, long):
        pass
    else:
        return "None"
    startTime = time.mktime(time.strptime(startTime, "%Y-%m-%d"))
    endTime = time.time()
    #时间跨度
    spanning = (endTime - startTime)
    #故障时间
    faultTime = int(restart_times) * 2 * 60
    serviceAvailability = (spanning - faultTime)/spanning * 100
    #保留小数点后两位
    return "%.2f" % serviceAvailability
