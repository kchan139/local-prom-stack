#!/bin/bash

set -e

kill $(cat /tmp/grafana-portforward.pid)
rm /tmp/grafana-portforward.pid
