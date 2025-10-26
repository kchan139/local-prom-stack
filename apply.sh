#!/bin/bash
set -e

kubectl apply -f namespace.yml

kubectl apply -Rf . 
