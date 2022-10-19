FROM cloudflare/cloudflared:latest@sha256:db58bb38c3cd1c206999c2133d1355d86a0be40510685b9d21d87b0c0a8662e3 as cloudflared
FROM alpine:3.16.2

RUN apk add jq=1.6-r1 --no-cache

COPY --from=cloudflared /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=cloudflared /usr/local/bin/cloudflared /usr/local/bin

COPY firecow_cloudflared /usr/local/bin

WORKDIR /app/

ENV NO_AUTOUPDATE="true"
ENV TUNNEL_TRANSPORT_LOGLEVEL="error"
ENV TUNNEL_LOGLEVEL="info"
ENV TUNNEL_METRICS="localhost:2000"

HEALTHCHECK --interval=5s --retries=6 --timeout=3s CMD wget -q ${TUNNEL_METRICS}/ready -O -

CMD ["firecow_cloudflared"]
