#!/bin/bash
set -e

# 如果在环境变量中定义了 UUID，则替换配置文件中的 UUID
if [ -n "$UUID" ]; then
  echo "[Info] Setting UUID to: $UUID"
  sed -i "s|\"uuid\": \".*\"|\"uuid\": \"$UUID\"|g" /etc/sing-box/config.json
fi

# 如果在环境变量中定义了 WS_PATH，则同步替换 sing-box 与 Caddy 的路径
if [ -n "$WS_PATH" ]; then
  echo "[Info] Setting WS Path to: $WS_PATH"
  sed -i "s|\"path\": \".*\"|\"path\": \"$WS_PATH\"|g" /etc/sing-box/config.json
  sed -i "s|path /.*|path $WS_PATH|g" /etc/caddy/Caddyfile
fi

# 启动 Sing-box 服务端（后台常驻）
echo "[Info] Starting Sing-box core..."
/usr/local/bin/sing-box run -c /etc/sing-box/config.json &

# 启动 Caddy（前台运行，负责 3000 端口流量监听与分流）
echo "[Info] Starting Caddy web server..."
exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
