FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# کپی فایل با مجوز اجرا (روش مطمئن‌تر)
COPY --chmod=755 tunnix /usr/local/bin/tunnix

ENV PORT=8080

CMD ["sh", "-c", "tunnix server --listen 0.0.0.0:${PORT} --password ${TUNNIX_PASSWORD}"]
