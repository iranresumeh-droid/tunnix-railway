FROM debian:bookworm-slim

# نصب کتابخانه‌های runtime موردنیاز
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# کپی باینری از مخزن
COPY tunnix /usr/local/bin/tunnix

# 🔴 این خط را اضافه کنید تا مجوز اجرا داده شود
RUN chmod +x /usr/local/bin/tunnix

# Railway از متغیر PORT استفاده می‌کند
ENV PORT=8080

# اجرای سرور tunnix
CMD ["sh", "-c", "tunnix server --listen 0.0.0.0:${PORT} --password ${TUNNIX_PASSWORD}"]
