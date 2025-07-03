FROM ubuntu:22.04

# تثبيت المتطلبات
RUN apt update && \
    apt install -y git build-essential cmake libmicrohttpd-dev libssl-dev libhwloc-dev libuv1-dev

# تحميل XMRig وتجهيزه
RUN git clone https://github.com/xmrig/xmrig.git && \
    mkdir xmrig/build && cd xmrig/scripts && ./build_deps.sh && \
    cd ../build && cmake .. && make -j$(nproc) && \
    mv xmrig /usr/local/bin/xmrig

# عنوان المحفظة Kaspa بصيغة unMineable
ENV WALLET=KAS:kaspa:qp2kr66xgw2aaukrtfzktmz045cmh6vdvpk0lqh4t8d707py9kysxdywnr7nc.unmineable_worker_zsutaep#9orn-qafv

# أمر التشغيل الأساسي
CMD xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u $WALLET -p x

