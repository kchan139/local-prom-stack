# Monitoring Stack

Docker-based monitoring setup with Prometheus, Grafana, and Loki.

## Services

- **Prometheus**: Metrics collection (port 9090)
- **Grafana**: Visualization dashboard (port 3000)
- **Loki**: Log aggregation (port 3100)
- **Promtail**: Systemd journal log collector
- **Node Exporter**: System metrics and logs collector

## Usage

Start the stack:
```bash
docker compose up -d
```
> Access Grafana at `http://localhost:3000` (admin/admin)

## Viewing Logs

1. Login to Grafana at `http://localhost:3000`
2. Add Loki data source:
   - Go to Connections → Data sources → Add new data source
   - Select "Loki"
   - URL: `http://loki:3100`
   - Save & test
3. View logs in Explore (compass icon):
   - Select Loki data source
   - Query examples:
     - All logs: `{job="systemd-journal"}`
     - Filter by text: `{job="systemd-journal"} |= "error"`

## Viewing Metrics

1. Add Prometheus data source:
   - Go to Connections → Data sources → Add new data source
   - Select "Prometheus"
   - URL: `http://prometheus:9090`
   - Save & test
2. View metrics in Explore or create dashboards

## Requirements

- Docker or Podman
- SELinux: Promtail runs in privileged mode to access systemd journal
