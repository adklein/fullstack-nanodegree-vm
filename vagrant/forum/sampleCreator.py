#
# Database sample creator
#

import time
import psycopg2

conn = psycopg2.connect("dbname=forum")
cur = conn.cursor()

sql_command= """SET AUTOCOMMIT = ON;"""

cur.execute(sql_command)

sql_command = """CREATE DATABASE fishies;"""

cur.execute(sql_command)

sql_command = """ CREATE TABLE info (text STRING num SERIAL);"""

cur.execute(sql_command)

conn.commit()
conn.close()