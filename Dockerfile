FROM caddy:2-builder AS builder

RUN xcaddy build \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
    --with github.com/caddy-dns/netcup

FROM caddy:2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# Verify the build
RUN caddy version

# Optional: Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD caddy version || exit 1
