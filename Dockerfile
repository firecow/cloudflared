FROM cloudflare/cloudflared:2024.12.2 as cloudflared
FROM alpine:3.21.2

RUN apk add jq~=1.7 --no-cache

COPY --from=cloudflared /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=cloudflared /usr/local/bin/cloudflared /usr/local/bin

COPY firecow_cloudflared /usr/local/bin

WORKDIR /app/

ENV NO_AUTOUPDATE="true"
ENV TUNNEL_TRANSPORT_LOGLEVEL="error"
ENV TUNNEL_LOGLEVEL="info"
ENV TUNNEL_METRICS="0.0.0.0:2000"

HEALTHCHECK --interval=5s --retries=6 --timeout=3s CMD wget -q ${TUNNEL_METRICS}/ready -O -

CMD ["firecow_cloudflared"]
