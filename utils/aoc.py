from flask import request
from dbutil.dbutil import db
import datetime

def fov_report(app):
    @app.route('/fov_report', methods=['GET', 'POST'])
    def fov_report():
        if request.method == 'POST':
            line = request.form['line']
            model = request.form['model']
            path = request.form['path']
            notes = request.form['notes']

            timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            

            sql = f'INSERT INTO fov_report (line, model, path, notes, Timestamp) VALUES ("{line}", "{model}", "{path}", "{notes}", "{timestamp}")'
            db.execute(sql)
        return "FOV报表更新成功"
