# مرحله ۱: ساخت باینری tunnix از سورس
FROM rust:1.75-slim AS builder

WORKDIR /build

# نصب ابزارهای لازم برای کامپایل
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# کلون و کامپایل tunnix
RUN git clone https://github.com/aeroxy/tunnix.git . \
    && cargo build --release \
    && strip target/release/tunnix

# مرحله ۲: ایمیج نهایی سبک
FROM debian:bookworm-slim

# نصب کتابخانه‌های runtime موردنیاز
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# کپی باینری از مرحله ساخت
COPY --from=builder /build/target/release/tunnix /usr/local/bin/tunnix

# Railway از متغیر PORT استفاده می‌کند
ENV PORT=8080

# اجرای سرور tunnix
CMD ["sh", "-c", "tunnix server --listen 0.0.0.0:${PORT} --password ${TUNNIX_PASSWORD}"]
