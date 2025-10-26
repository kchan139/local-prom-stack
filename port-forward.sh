#!/bin/bash
set -e

nohup kubectl -n monitoring port-forward svc/grafana 3000:3000 > /tmp/grafana-portforward.log 2>&1 &
echo $! > /tmp/grafana-portforward.pid
