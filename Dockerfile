FROM cloudflare/cloudflared:2021.10.5 as cloudflared
FROM debian:bullseye-20210902-slim

COPY --from=cloudflared /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=cloudflared /usr/local/bin/cloudflared /usr/local/bin
COPY Dockerfile.entrypoint /usr/local/bin

WORKDIR /app/

ENTRYPOINT ["Dockerfile.entrypoint"]

CMD ["cloudflared", "tunnel"]
