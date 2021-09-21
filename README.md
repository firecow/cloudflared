# Cloudflared

Cloudflared "legacy" tunnels have been deprecated. A switch to named tunnels is needed.

This image mimics the "niceness" of "legacy" tunnels, but uses named tunnels internally.

All that is needed is a cert.pem, TUNNEL_HOSTNAME and TUNNEL_URL

```yml
services:
  cloudflared:
    image: firecow/cloudflared:${FCF_IMAGE_VERSION}
    stop_grace_period: 1m
    environment:
      TUNNEL_HOSTNAME: https://somesub.example.com
      TUNNEL_URL: http://webserver:8080
   volumes:
     - ./example.com.cert.pem:/etc/cloudflared/cert.pem
``` 
