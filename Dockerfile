FROM cloudflare/cloudflared:2022.2.1 as cloudflared
FROM alpine:3.15.0

COPY --from=cloudflared /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=cloudflared /usr/local/bin/cloudflared /usr/local/bin
COPY Dockerfile.entrypoint /usr/local/bin

RUN apk add jq --no-cache

WORKDIR /app/

ENV NO_AUTOUPDATE="true"
ENV TUNNEL_TRANSPORT_LOGLEVEL="error"
ENV TUNNEL_LOGLEVEL="error"
ENV TUNNEL_METRICS="localhost:2000"

HEALTHCHECK --interval=5s --retries=6 --timeout=3s CMD wget -q ${TUNNEL_METRICS}/ready -O -

ENTRYPOINT ["Dockerfile.entrypoint"]

CMD ["cloudflared", "tunnel"]
