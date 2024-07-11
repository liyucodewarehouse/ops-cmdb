#!/bin/bash
PROGPATH=$(echo $0 | sed -e 's,[\\/][^\\/][^\\/]*$,,')
cd "$PROGPATH"
mysqldump -uroot -p12345678 hrcmdb > ../backup/mysql_bak_`date +"%Y-%m-%d"`.sql
