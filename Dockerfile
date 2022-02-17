FROM cloudflare/cloudflared:2022.2.0 as cloudflared
FROM alpine:3.15.0

COPY --from=cloudflared /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=cloudflared /usr/local/bin/cloudflared /usr/local/bin
COPY Dockerfile.entrypoint /usr/local/bin

WORKDIR /app/

ENV TUNNEL_METRICS="localhost:2000"

HEALTHCHECK --interval=5s --retries=6 --timeout=3s CMD wget ${TUNNEL_METRICS}/ready

ENTRYPOINT ["Dockerfile.entrypoint"]

CMD ["cloudflared", "tunnel"]
