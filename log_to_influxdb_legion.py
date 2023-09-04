#!/usr/bin/env python3
import sys, smtplib, os
from datetime import datetime
import psutil
import shutil

import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS


total, usage, free, percent = psutil.disk_usage("/home")


bucket = "srv"
org = "1blu"
token = "TwqMZ7kYn2bIio7Ax7V8XQ5o-GZEe8M-CBG2OoS23-HVEblhN7VoqpIfrQEQVJiVqpGtiv-iZHrgEmJ4P2MjEQ=="
# Store the URL of your InfluxDB instance
url="192.168.1.1:8086"


client = influxdb_client.InfluxDBClient(
    url=url,
    token=token,
    org=org
)
# Write script
write_api = client.write_api(write_options=SYNCHRONOUS)
p = influxdb_client.Point(os.uname()[1]).field("diskspace_used_percent_home", percent)
write_api.write(bucket=bucket, org=org, record=p)

