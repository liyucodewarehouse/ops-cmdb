
```
### 使用指南

1. 下载该项目到本地
2. config.py是我们唯一要修改的文件
2. 修改config.py里的db_config变量，配置数据库的host，用户名，密码和要操作的数据库

```python
db_config = {
    'host':'localhost',
    'user':'root',
    'passwd':"",
    'db':'cmdb'
}

```


3. 修改config.py的page_config变量，此变量是设置具体的页面变量，先做一个简单的配置

```

page_config = {
    # menu是一个list，包含所有的页面信息
    "menu":[{
        //页面的名字，和数据库表一致
        "name": 'user',
        // 显示的页面标题
        "title": '用户管理',

        # 页面里具体的字段，如果有两个字段，配置两个即可，包含name和title
        "data": [{
            "name": 'username',
            "title": '用户名'
        },{
            "name":'password',
            "title":'密码'
        }]
    }}]
}

```

4. start.py，浏览器访问http://localhost:8080/



### 字段详解

1. page_config配置

```
    menu:下面具体介绍，页面具体的字段
    favicon:页面标签的小logo 默认用reboot的
    title：页面标签的标题，默认是warehouse-cmdb
    brand_name：项目左上角显示文字，默认是warehouse-cmdb

```

2. menu配置详解
```

{
    name:名字和数据库表名一直
    titile:中文
    modal_detail:是否用模态窗展示详情（有隐藏字段没展示）
    具体字段数据
    data：[
        {
            name:
            title:
            type:类型，默认input text
            value：select直接从value里渲染，不发ajax和preload，如果没有type，就是input里的value属性

            select_type：获取数据的action_type的值,和对应的name字段一致
            toname:preload数据里，完成id到name得转换显示，select默认true
             hide:默认false，true的话隐藏此字段
             
            option_val list的显示字段 默认id
            option_name list的显示字段 默认name

        }
    ]
}
```


### 依赖

本项目python依赖flask和mysqldb模块，直接pip安装一下即可


