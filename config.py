# coding=utf-8

secret_key = '\xca\x0c\x86\x04\x98@\x02b\x1b7\x8c\x88]\x1b\xd7"+\xe6px@\xc3#\\'

# warehousecmdb的全局配置
global_config = {
    # 访问地址
    'public_url': "http://192.168.1.1:36180",
    # 日志文件存放位置
    "logfile":"D:\\script\\warehouse-cmdb\\log"
}

# 数据库配置
db_config = {
    'host': 'localhost',
    'user': 'root',
    'passwd': "9@XLRW8g%4WxZdxp",
    'db': 'warehousecmdb'
}


# 页面配置：包含数据库表结构定义，WEB界面定义，功能模块定义
page_config = {
    "brand_name": '博瀚CMDB',
    'title': '博瀚CMDB',
    "favicon": 'https://pic1.zhimg.com/6d660dd4156c64bfad13ff97d79c2f98_l.jpg',
    "menu": [
        {
            "title": "用户及权限管理",
            "sub": [{
                # user配置最好不要修改，是和登陆认证相关的，直接在下面加配置即可
                "name": 'user',
                "title": '用户管理',
                "data": [{
                    "name": 'username',
                    "title": '用户名'
                }, {
                    "name": 'real_name',
                    "title": '实名'
                }, {
                    "name": 'password',
                    "title": '密码',
                }, {
                    "name": 'mobile',
                    "title": '手机号码',
                }, {
                    "name": 'role_id',
                    "title": '已授权模块',
                    "empty": "yes",
                    "manualChage": "no"
                }, {
                    "name": 'status',
                    "title": '状态',
                    "type": 'select',
                    "value": {0: '启用', 1: '禁用'}
                }],
                "customizedButton": [{
                    "name": "AuthorizationForUser",
                    "title": "给用户授权",
                    "text": "授权",
                    "url": "/AuthorizationForUser/"
                }]
            }, {
                "name": "AuthorizeRoleGroup",
                "title": "授权规则组",
                "auto_increment": 5000,
                "data": [{
                    "name": 'group_ame',
                    "title": '组名'
                }, {
                    "name": 'include_role',
                    "title": '包含模块',
                    "empty": "yes",
                    "manualChage": "no"
                }]
            }, {
                "name": "AuthorizeRole",
                "title": "授权规则",
                "data": [{
                    "name": 'group',
                    "title": '属组',
                    "type": 'select',
                    "select_type": 'AuthorizeRoleGroup',
                    "option_val": 'id',
                    "option_name": 'group_ame'
                }, {
                    "name": 'name',
                    "title": '规则名'
                }, {
                    "name": 'title',
                    "title": '标题'
                }, {
                    "name": 'authorized',
                    "title": '已授权用户',
                    "empty": "yes",
                    "manualChage": "no"
                }]
            }
            ]
        },
        {
            "title": "资产管理",
            "sub": [
                {
                    "name": 'caninet',
                    "title": '机柜管理',
                    "data": [{
                        "name": "name",
                        "title": '机柜名'
                    }, {
                        "name": "address",
                        "title": '地址',
                        "empty": "yes"
                    }]
                },
                {
                    "name": 'supplier',
                    "title": '供应商管理',
                    "data": [{
                        "name": "supplier_name",
                        "title": '公司名称',
                        "empty": "yes"
                    }, {
                        "name": "staff_name",
                        "title": '联系人'
                    }, {
                        "name": "duties",
                        "title": '职务',
                        "empty": "yes"
                    }, {
                        "name": "phone",
                        "title": '固话',
                        "empty": "yes"
                    }, {
                        "name": "mobile",
                        "title": '手机',
                        "empty": "yes"
                    }, {
                        "name": "qq",
                        "title": 'QQ',
                        "empty": "yes"
                    }, {
                        "name": "email",
                        "title": 'EMAIL',
                        "empty": "yes"
                    }]
                },
                {
                    "name": "device",
                    "title": "设备管理",
                    "data": [{
                        "name": "caninet",
                        "title": '机柜',
                        "type": 'select',
                        "select_type": 'caninet'
                    }, {
                        "name": "name",
                        "title": '设备名称'
                    }, {
                        'name': 'model_no',
                        'title': '型号',
                        "empty": "yes"
                    }, {
                        'name': 'serial_no',
                        'title': '序列号',
                        "empty": "yes"
                    }, {
                        'name': 'express_service_code',
                        'title': '快速服务代码',
                        "empty": "yes"
                    }, {
                        'name': 'cpu',
                        'title': 'CPU',
                        "empty": "yes"
                    }, {
                        'name': 'memory',
                        'title': '内存',
                        "empty": "yes"
                    }, {
                        'name': 'hard_disk',
                        'title': '硬盘',
                        "empty": "yes"
                    }, {
                        'name': 'raid',
                        'title': 'RAID卡',
                        "empty": "yes"
                    }, {
                        'name': 'other_control_card',
                        'title': '其他控制卡',
                        "empty": "yes"
                    }, {
                        'name': 'power',
                        'title': '电源',
                        "empty": "yes"
                    }, {
                        'name': 'management_ip',
                        'title': '管理IP',
                        "empty": "yes"
                    }, {
                        "name": 'purchase_date',
                        "title": "采购日期",
                        "type": 'date',
                        "empty": "yes"
                    }, {
                        "name": 'supplier',
                        "title": "供货商",
                        "empty": "yes"
                    }, {
                        "name": 'ups',
                        "title": '是否开启',
                        "type": 'select',
                        "value": {0: '开启', 1: '关闭'}
                    }]
                }]
        },
        {"title": "系统每日巡检",
         "sub": [{
             "name": 'HostDailyCheck',
             "title": '查看巡检结果',
             "showUpdateBtn": "no",
             "showDeleteBtn": "no",
             "showAddBtn": "no",
             "data": [{
                 "name": "Hostname",
                 "title": '主机名'
             }, {
                 "name": "LastCheck",
                 "title": '最近一次检查'
             }, {
                 "name": "FilePath",
                 "title": '文件路径'
             }],
             "customizedButton": [{
                 "name": "view",
                 "title": "查看最新巡检结果",
                 "text": "查看",
                 "url": "/viewHostDailyCheck/"
             }],
             "customizedButtonAtHeader": [{
                 "name": "downloadHostDailyCheck",
                 "title": "打包下载",
                 "text": "打包下载",
                 "url": "/downloadHostDailyCheck"
             }]
         },
             {
                 "name": 'HostDailyCheckReport',
                 "title": '查看巡检报表',
                 "showUpdateBtn": "no",
                 "showDeleteBtn": "no",
                 "showAddBtn": "no",
                 "data": [{
                     "name": "DateTime",
                     "title": '时间戳'
                 }, {
                     "name": "Hostname",
                     "title": '主机名'
                 }, {
                     "name": "OSRelease",
                     "title": '发行版本'
                 }, {
                     "name": "Kernel",
                     "title": '内核'
                 }, {
                     "name": "Language",
                     "title": '语言/编码'
                 }, {
                     "name": "LastReboot",
                     "title": '最近启动时间'
                 }, {
                     "name": "Uptime",
                     "title": '运行时间'
                 }, {
                     "name": "CPUs",
                     "title": 'CPU数量'
                 }, {
                     "name": "CPUType",
                     "title": 'CPU类型'
                 }, {
                     "name": "Arch",
                     "title": 'CPU架构'
                 }, {
                     "name": "MemTotal",
                     "title": '内存总容量'
                 }, {
                     "name": "MemFree",
                     "title": '内存剩余'
                 }, {
                     "name": "MemUsedPercent",
                     "title": '内存使用率'
                 }, {
                     "name": "DiskTotal",
                     "title": '硬盘总容量'
                 }, {
                     "name": "DiskFree",
                     "title": '硬盘剩余'
                 }, {
                     "name": "DiskUsedPercent",
                     "title": '硬盘使用率'
                 }, {
                     "name": "InodeTotal",
                     "title": 'Inode总量'
                 }, {
                     "name": "InodeFree",
                     "title": 'Inode剩余'
                 }, {
                     "name": "InodeUsedPercent",
                     "title": 'Inode使用率'
                 }, {
                     "name": "IP",
                     "title": 'IP地址'
                 }, {
                     "name": "MAC",
                     "title": 'MAC地址'
                 }, {
                     "name": "Gateway",
                     "title": '默认网关'
                 }, {
                     "name": "DNS",
                     "title": 'DNS'
                 }, {
                     "name": "Listen",
                     "title": '监听'
                 }, {
                     "name": "Selinux",
                     "title": 'Selinux'
                 }, {
                     "name": "Firewall",
                     "title": '防火墙'
                 }, {
                     "name": "USERs",
                     "title": '用户数'
                 }, {
                     "name": "USEREmptyPassword",
                     "title": '含空密码用户'
                 }, {
                     "name": "USERTheSameUID",
                     "title": '含相同UID用户'
                 }, {
                     "name": "PasswordExpiry",
                     "title": '密码过期（天）'
                 }, {
                     "name": "RootUser",
                     "title": '特权用户数量'
                 }, {
                     "name": "Sudoers",
                     "title": 'sudo授权'
                 }, {
                     "name": "SSHAuthorized",
                     "title": 'SSH信任主机'
                 }, {
                     "name": "SSHDProtocolVersion",
                     "title": 'SSH协议版本'
                 }, {
                     "name": "SSHDPermitRootLogin",
                     "title": '允许root远程登录'
                 }, {
                     "name": "DefunctProsess",
                     "title": '僵尸进程数量'
                 }, {
                     "name": "SelfInitiatedService",
                     "title": '自启动服务数量'
                 }, {
                     "name": "SelfInitiatedProgram",
                     "title": '自启动程序数量'
                 }, {
                     "name": "RuningService",
                     "title": '运行中服务数'
                 }, {
                     "name": "Crontab",
                     "title": '计划任务数'
                 }, {
                     "name": "Syslog",
                     "title": '日志服务'
                 }, {
                     "name": "SNMP",
                     "title": 'SNMP'
                 }, {
                     "name": "NTP",
                     "title": 'NTP'
                 }, {
                     "name": "JDK",
                     "title": 'JDK版本'
                 }]
             }]
         },
        {"title": "网络配置管理",
         "sub": [{
             "name": 'NetworkDevice',
             "title": '查看设备信息',
             "data": [{
                 "name": "DeviceName",
                 "title": '设备名'
             }, {

                 "name": "IPAddr",
                 "title": '管理IP'
             }, {

                 "name": "Username",
                 "title": '用户名'
             }, {
                 "name": "Passwd",
                 "title": '密码'
             }],
             "customizedButton": [{
                 "name": "fetchOneNetworkConfig",
                 "title": "点击备份",
                 "text": "备份",
                 "url": "/fetchOneNetworkConfig/"
             }],
             "customizedButtonAtHeader": [{
                 "name": "backupAllNetworkConfig",
                 "title": "点击一键备份",
                 "text": "一键备份",
                 "url": "/backupAllNetworkConfig"
             }]
         },
             {
                 "name": 'NetworkConfigManagement',
                 "title": '查看最新配置',
                 "showUpdateBtn": "no",
                 "showDeleteBtn": "no",
                 "showAddBtn": "no",
                 "data": [{
                     "name": "DeviceName",
                     "title": '设备名'
                 }, {

                     "name": "LastCheckTime",
                     "title": '时间戳'
                 }, {
                     "name": "ConfigFilePath",
                     "title": '配置文件路径'
                 }],
                 "customizedButton": [{
                     "name": "viewLatestConfig",
                     "title": "查看最新备份",
                     "text": "查看",
                     "url": "/viewNetworkConfig/"
                 }, {
                     "name": "viewNetworkConfigDiff",
                     "title": "查看配置对比",
                     "text": "比较",
                     "url": "/viewNetworkConfigDiff/"
                 }],
                 "customizedButtonAtHeader": [{
                     "name": "downloadNetworkConfig",
                     "title": "打包下载最新配置",
                     "text": "打包下载",
                     "url": "/downloadNetworkConfig"
                 }]
             },
             {
                 "name": 'NetworkConfigManagementReport',
                 "title": '查看变更报表',
                 "showUpdateBtn": "no",
                 "showDeleteBtn": "no",
                 "data": [{
                     "name": "DeviceName",
                     "title": '设备名'
                 }, {
                     "name": "LastCheckTime",
                     "title": '最后检查时间'
                 }, {
                     "name": "LastChageTime",
                     "title": '最后变更时间'
                 }, {
                     "name": "ChageDetail",
                     "title": '变更内容'
                 }]
             }]
         },
        {
            "title": '短信平台',
            "sub": [{
                "name": "SMSUsers",
                "title": "短信接收用户",
                "data": [{
                    "name": "UserName",
                    "title": "用户名"
                }, {
                    "name": "Mobile",
                    "title": "手机号码"
                }]
            }, {
                "name": "SMSHistory",
                "title": "短信发送记录",
                "showUpdateBtn": "no",
                "showDeleteBtn": "no",
                "showAddBtn": "no",
                "data": [{
                    "name": "MSG_TIM",
                    "title": "时间戳"
                }, {
                    "name": "UserName",
                    "title": "短信接收人"
                }, {
                    "name": "USRMP",
                    "title": "手机号码"
                }, {
                    "name": "SMSCONTENT",
                    "title": "短信内容"
                }, {
                    "name": "RETURNMESSAGE",
                    "title": "返回信息"
                }, {
                    "name": "ERRORCODE",
                    "title": "状态码"
                }, {
                    "name": "RSPCOD",
                    "title": "RSPCOD"
                }]
            },  {
                "name": "Email_Notice",
                "title": "邮件通知",
                "showUpdateBtn": "no",
                "showDeleteBtn": "no",
                "showAddBtn": "no",
                "data": [{
                    "name": "project",
                    "title": "项目名"
                }, {
                    "name": "content",
                    "title": "内容"
                }, {
                    "name": "enclosure",
                    "title": "附件"
                }, {
                    "name": "Timestamp",
                    "title": "时间戳"
                }]
            }
            ]
        },
        {

            "title": '变更管理',
            "sub": [{
                "name": "ProductUpdateDiff",
                "title": "生产更新",
                "showUpdateBtn": "yes",
                "showDeleteBtn": "no",
                "showAddBtn": "no",
                "data": [{
                    "name": "UUID",
                    "title": "UUID",
                    "manualChage": "no",
                    "hide": "true"
                }, {
                    "name": "Timestamp",
                    "title": "时间戳",
                    "manualChage": "no"
                }, {
                    "name": "HostName",
                    "title": "主机名",
                    "manualChage": "no"
                }, {
                    "name": "PackageLocation",
                    "title": "更新包位置",
                    "manualChage": "no"
                }, {
                    "name": "DiffFileLocation",
                    "title": "Diff文件位置",
                    "manualChage": "no",
                    "hide": "true"
                }, {
                    "name": "Title",
                    "title": "更新主题"
                }, {
                    "name": "ProjectLeader",
                    "title": "更新申请人",
                    "type": 'select',
                    "value": {"李毓": "李毓"}
                }, {
                    "name": "Executor",
                    "title": "执行人",
                    "type": 'select',
                    "value": {"李毓": "李毓"}
                }, {
                    "name": "Status",
                    "title": "更新状态",
                    "manualChage": "no"
                }, {
                    "name": "restart_times",
                    "title": "重启次数",
                    "default": "0"
                }],
                "customizedButton": [{
                    "name": "viewProductUpdateDiff",
                    "title": "代码审核",
                    "text": "代码审核",
                    "url": "/viewProductUpdateDiff/"
                }]
            },
            {
                "name": "service_boot_info",
                "title": "生产系统启动信息",
                "showUpdateBtn": "yes",
                "showDeleteBtn": "no",
                "data": [{
                    "name": "timestamp",
                    "title": "时间戳"
                }, {
                    "name": "hostname",
                    "title": "主机名"
                }, {
                    "name": "action",
                    "title": "执行操作"
                }, {
                    "name": "app",
                    "title": "产品线"
                }]
            }]
        },
        {
            "title": '日志记录',
            "sub": [{
                "name": "OperationLog",
                "title": "操作日志记录",
                "showUpdateBtn": "no",
                "showDeleteBtn": "no",
                "showAddBtn": "no",
                "data": [{
                    "name": "Timestamp",
                    "title": "时间戳",
                }, {
                    "name": "User",
                    "title": "用户",
                }, {
                    "name": "Level",
                    "title": "日志等级",
                }, {
                    "name": "Messages",
                    "title": "日志信息",
                }]
            }
            ]
        },
        {
            "title": '冠捷现场',
            "sub": [{
                "name": "fov_report",
                "title": "全量FOV",
                "showUpdateBtn": "no",
                "showDeleteBtn": "no",
                "showAddBtn": "no",
                "data": [{
                    "name": "Timestamp",
                    "title": "时间戳",
                }, {
                    "name": "line",
                    "title": "线体",
                }, {
                    "name": "model",
                    "title": "机种名",
                }, {
                    "name": "path",
                    "title": "存放路径",
                }, {
                    "name": "notes",
                    "title": "备注",
                }]
            }
            ]
        }
    ]
}

# 网络配置管理模块，NCM_Agent定义
# Agent主机提供密码加密、解密服务。并且是实际登录网络设备的主机
NCM_Agent = {
    "domain":"http://127.0.0.1:8080",
}



# 短信通道配置
SMS_Config = {
    "url":"http://192.168.1.2/user/yunweisms.tran"
}

product_series = {

    "netapp-m-a":"netapp",
    "netapp-m-b":"netapp",
    "netapp-s-a":"netapp",

    "posapp-m-a":"posapp",
    "posapp-m-b":"posapp",
    "posapp-s-a":"posapp",

    "mposapp-m-a":"mposapp",
    "mposapp-m-b":"mposapp",
    "mposapp-s-a":"mposapp",
}