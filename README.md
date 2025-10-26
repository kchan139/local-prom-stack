# Monitoring Stack

Kubernetes-based monitoring setup with Prometheus, Grafana, and Loki for k3s.

## Services

- **Prometheus**: Metrics collection
- **Grafana**: Visualization dashboard
- **Loki**: Log aggregation
- **Promtail**: Systemd journal log collector
- **Node Exporter**: System metrics collector

## Prerequisites

- k3s cluster
- `kubectl` configured

## Deployment

Deploy the entire stack:
```bash
./apply.sh
```

## Accessing Grafana

**Local access via port-forward:**
```bash
./port-forward.sh
```
Access at [http://localhost:3000](http://localhost:3000) (admin/admin)

Stop port-forward:
```bash
./stop-port-forward.sh
```

**Or expose via NodePort:**
Uncomment `type: NodePort` and `nodePort: 30000` in `grafana/service.yml`, then access at `http://<node-ip>:30000`

> **Warning**: This setup uses default credentials (admin/admin) and no TLS. Do not expose NodePort or Ingress to the public internet without proper hardening.

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

## Management

Check status:
```bash
kubectl get pods -n monitoring
```

View logs:
```bash
kubectl logs -n monitoring <pod-name>
```

Restart a service:
```bash
kubectl rollout restart deployment/grafana -n monitoring
```

Remove everything:
```bash
./cleanup.sh
```

## Structure

```
 monitoring
├── grafana
│   ├── deployment.yml
│   ├── pvc.yml
│   └── service.yml
├── loki
│   ├── configmap.yml
│   ├── deployment.yml
│   ├── pvc.yml
│   └── service.yml
├── node-exporter
│   ├── daemonset.yml
│   └── service.yml
├── prometheus
│   ├── configmap.yml
│   ├── deployment.yml
│   ├── pvc.yml
│   └── service.yml
├── promtail
│   ├── configmap.yml
│   ├── daemonset.yml
│   ├── rbac.yml
│   └── service.yml
├── apply.sh
├── cleanup.sh
├── namespace.yml
├── port-forward.sh
└── stop-port-forward.sh
```
