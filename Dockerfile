FROM alpine:latest

# 定义 Sing-box 基础版本
ARG SING_BOX_VERSION=1.11.0

# 安装基础依赖与 Caddy
RUN apk add --no-cache curl ca-certificates caddy bash sed \
    && ARCH=$(uname -m) \
    && if [ "$ARCH" = "x86_64" ]; then SB_ARCH="amd64"; elif [ "$ARCH" = "aarch64" ]; then SB_ARCH="arm64"; else SB_ARCH="amd64"; fi \
    && curl -fsSL -o /tmp/sing-box.tar.gz "https://github.com/SagerNet/sing-box/releases/download/v${SING_BOX_VERSION}/sing-box-${SING_BOX_VERSION}-linux-${SB_ARCH}.tar.gz" \
    && tar -xzf /tmp/sing-box.tar.gz -C /tmp \
    && mv /tmp/sing-box-*/sing-box /usr/local/bin/sing-box \
    && chmod +x /usr/local/bin/sing-box \
    && rm -rf /tmp/*

WORKDIR /app

# 复制配置文件和伪装静态文件
COPY config.json /etc/sing-box/config.json
COPY Caddyfile /etc/caddy/Caddyfile
COPY html/ /var/www/html/
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# 暴露 Staxa 默认健康检查与服务端口
EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
