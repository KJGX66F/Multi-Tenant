# Multi-Tenant Edge Relay

Single-container deployment of Sing-box with Caddy for PaaS environments (such as Staxa.dev).

### Environment Variables (Optional)

| Variable | Default Value | Description |
| :--- | :--- | :--- |
| `UUID` | `23d24263-5e96-48c0-827c-9bfa00947f6d` | VLESS User UUID |
| `WS_PATH` | `/api/v1/stream` | WebSocket Transport Path |

### Port & Health Check
- **Port**: `3000`
- **Health Check Path**: `/` (Returns HTTP 200 OK)
