# Cloudflared

[![build](https://img.shields.io/github/actions/workflow/status/firecow/cloudflared/qa.yml?branch=main)](https://github.com/firecow/cloudflared/actions)
[![Renovate](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com)

Cloudflared "legacy" tunnels have been deprecated. A switch to named tunnels is needed.

This image mimics the "niceness" of legacy tunnels, but uses named tunnels internally.

All that is needed is a cert.pem, `TUNNEL_HOSTNAME` and `TUNNEL_URL` or `TUNNEL_UNIX_SOCKET`

```yml
services:
  cloudflared:
    image: firecow/cloudflared:${FCF_IMAGE_VERSION}
    environment:
      TUNNEL_HOSTNAME: https://somesub.example.com
      TUNNEL_URL: http://webserver:8080
    volumes:
      - ./example.com.cert.pem:/etc/cloudflared/cert.pem
``` 

These environment variables have other defaults than original.
```shell
TUNNEL_TRANSPORT_LOGLEVEL="error"
TUNNEL_METRICS="localhost:2000" # See Dockerfile healthcheck
```

Dockerfile CMD is set to `firecow_cloudflared`, overriding this in `docker-compose.yml` or `docker run` will bypass the DNS and named tunnel auto process. 


`TUNNEL_URL: http://webserver:8080` can be replaced with `TUNNEL_UNIX_SOCKET: unix://var/run/origin.sock`
