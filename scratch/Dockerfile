FROM alpine:latest AS builder

# Installs dependencies from alpine's repository
RUN apk --no-cache add tzdata ca-certificates

# Sets default timezone
RUN echo "America/Sao_Paulo" > /etc/timezone

FROM scratch

COPY --from=builder /etc/timezone /etc/timezone
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

EXPOSE 80
ENTRYPOINT ["/app"]

