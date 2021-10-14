FROM debian:bullseye-20210902-slim

COPY --from=cloudflare/cloudflared:2021.10.2 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=cloudflare/cloudflared:2021.10.2 /usr/local/bin/cloudflared /usr/local/bin
COPY Dockerfile.entrypoint /usr/local/bin

WORKDIR /app/

ENTRYPOINT ["Dockerfile.entrypoint"]

CMD ["cloudflared", "tunnel"]
