FROM cloudflare/cloudflared:2022.5.1 as cloudflared
FROM alpine:3.16.0

RUN apk add jq=1.6-r1 --no-cache

COPY --from=cloudflared /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=cloudflared /usr/local/bin/cloudflared /usr/local/bin

COPY Dockerfile.entrypoint /usr/local/bin

WORKDIR /app/

ENV NO_AUTOUPDATE="true"
ENV TUNNEL_TRANSPORT_LOGLEVEL="error"
ENV TUNNEL_LOGLEVEL="info"
ENV TUNNEL_METRICS="localhost:2000"

HEALTHCHECK --interval=5s --retries=6 --timeout=3s CMD wget -q ${TUNNEL_METRICS}/ready -O -

ENTRYPOINT ["Dockerfile.entrypoint"]
