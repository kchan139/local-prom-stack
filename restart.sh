#!/bin/bash
set -e

if command -v podman &> /dev/null; then
    TOOL=podman
elif command -v docker &> /dev/null; then
    TOOL=docker
else
    echo "Error: podman or docker is not installed." >&2
    exit 1
fi

echo "Stopping all containers..."
RUNNING=$($TOOL ps -q)
if [ -n "$RUNNING" ]; then
    $TOOL stop $RUNNING
fi

$TOOL container prune -f

$TOOL compose down
$TOOL compose up -d

echo "Restart complete"
