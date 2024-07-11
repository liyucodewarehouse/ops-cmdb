#!/usr/bin/env python
#encoding:utf8
import logging
import time
import MySQLdb
import MySQLdb.cursors
from config import db_config


class DB: 
    conn = None
    db = None
    host = None

    def __init__(self, host, mysql_user, mysql_pass, mysql_db):
        self.host = host
        self.mysql_user = mysql_user
        self.mysql_pass = mysql_pass
        self.mysql_db = mysql_db
    def connect(self):
        self.conn = MySQLdb.connect(host=self.host, user=self.mysql_user, passwd=self.mysql_pass, db=self.mysql_db, charset="utf8", connect_timeout=600, compress=True,cursorclass = MySQLdb.cursors.DictCursor)
        self.conn.autocommit(True)
    def execute(self, sql):
        logging.info("[mysql] - "+sql)
        try:
            cursor = self.conn.cursor()
            cursor.execute(sql)
        except (AttributeError, MySQLdb.OperationalError):
            try:
                cursor.close()
                self.conn.close()
            except:
                pass
            time.sleep(1)
            try:
                self.connect()
                print ("reconnect DB")
                cursor = self.conn.cursor()
                cursor.execute(sql)
            except (AttributeError, MySQLdb.OperationalError):
                time.sleep(2)
                self.connect()
                print ("reconnect DB")
                cursor = self.conn.cursor()
                cursor.execute(sql)
    
        return cursor

db = DB(host=db_config['host'], mysql_user=db_config['user'], mysql_pass=db_config['passwd'], mysql_db=db_config['db'])
