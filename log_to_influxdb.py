#!/usr/bin/env python3
import sys, smtplib, os
from datetime import datetime
import psutil
import shutil

import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS


total, usage, free, percent = psutil.disk_usage("/")


bucket = "srv"
org = "1blu"
token = "TwqMZ7kYn2bIio7Ax7V8XQ5o-GZEe8M-CBG2OoS23-HVEblhN7VoqpIfrQEQVJiVqpGtiv-iZHrgEmJ4P2MjEQ=="
# Store the URL of your InfluxDB instance
url="192.168.1.1:8086"


# Calling psutil.cpu_precent() for 4 seconds
cpu = psutil.cpu_percent(4)
ram = psutil.virtual_memory()[2]
ram_gb = (psutil.virtual_memory()[3]/1000000000)

client = influxdb_client.InfluxDBClient(
    url=url,
    token=token,
    org=org
)
# Write script
write_api = client.write_api(write_options=SYNCHRONOUS)
p = influxdb_client.Point(os.uname()[1]).field("diskspace_total", total).field("diskspace_used", usage).field("diskspace_free", free).field("diskspace_used_percent", percent).field("cpu", cpu).field("ram", ram)
write_api.write(bucket=bucket, org=org, record=p)

