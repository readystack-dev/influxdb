# GENERATED L-009 hermetic Rust build (--network=none, SBOM+SLSA-attestation-producing).
# Pinned bases from BASE_IMAGE_DIGESTS.lock; vendored Cargo tree + web-vault + debs from Dockerfile.vendor.
# The upstream Rust toolchain (rustup's portable x86_64-unknown-linux-gnu dist) from the pinned official
# image; the build stage below is ubuntu:24.04 and links against that distro's own libraries.
FROM rust:1.98.1-bookworm@sha256:93ce27a88655056a51dbdd8f5f2d7ddc071c7b0070fb288a37b5a285fc83971e AS rusttoolchain
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289 AS build_influxdb3
# build-stage tools (strategy.build_packages) installed offline from the
# vendored deb closure — build.rs helpers like protoc live here.
RUN --mount=type=bind,source=vendored/build-debs,target=/tmp/bdebs \
    set --; for f in /tmp/bdebs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; }
COPY --from=rusttoolchain /usr/local/rustup /usr/local/rustup
COPY --from=rusttoolchain /usr/local/cargo /usr/local/cargo
WORKDIR /src
COPY vendored/influxdb-src/ .
ENV CARGO_NET_OFFLINE=true CARGO_HOME=/usr/local/cargo RUSTUP_TOOLCHAIN=1.98.1 RUSTUP_HOME=/usr/local/rustup PATH=/usr/local/cargo/bin:${PATH}
ENV GIT_HASH=51f4ac865b8670e0d3555ae992639ec05ecc334e GIT_HASH_SHORT=51f4ac8 RUSTFLAGS="--cfg tokio_unstable" PYO3_PYTHON=/usr/bin/python3.12
ARG SOURCE_DATE_EPOCH=1795446682
ENV SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH}
RUN cargo build --release --offline --locked --bin influxdb3 && \
    cp target/release/influxdb3 /influxdb3 && /influxdb3 --version
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289
ENV DEBIAN_FRONTEND=noninteractive INFLUXDB3_NODE_ID=node0 INFLUXDB3_OBJECT_STORE=file INFLUXDB3_DATA_DIR=/var/lib/influxdb3/data INFLUXDB3_HTTP_BIND_ADDR=0.0.0.0:8181 INFLUXDB3_DISABLE_AUTHZ=health INFLUXDB3_DISABLE_TELEMETRY_UPLOAD=true INFLUXDB3_PLUGIN_DIR=/var/lib/influxdb3/plugins INFLUXDB3_DISABLE_PACKAGE_MANAGEMENT=true INFLUXDB3_LOG_FILTER=info
RUN --mount=type=bind,source=vendored/debs,target=/tmp/debs \
    set --; for f in /tmp/debs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; } && \
    rm -rf /var/lib/apt/lists/* \
           /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /var/cache/ldconfig/aux-cache /var/cache/fontconfig
ARG SOURCE_DATE_EPOCH=1795446682
RUN groupadd -r -g 1500 influxdb3 && useradd -r -u 1500 -g influxdb3 -d /var/lib/influxdb3 -m influxdb3 && \
    mkdir -p /var/lib/influxdb3 /var/lib/influxdb3/data /var/lib/influxdb3/plugins && chown -R influxdb3:influxdb3 /var/lib/influxdb3 /var/lib/influxdb3/data /var/lib/influxdb3/plugins && \
    : "${SOURCE_DATE_EPOCH:?SOURCE_DATE_EPOCH must be set for a reproducible build}" && \
    sed -ri "s/^([^:]*:[^:]*):[0-9]*:/\1:$((SOURCE_DATE_EPOCH/86400)):/" /etc/shadow && \
    rm -f /etc/passwd- /etc/shadow- /etc/group- /etc/gshadow-
COPY --from=build_influxdb3 /influxdb3 /usr/bin/influxdb3
COPY readystack-entrypoint.sh /usr/local/bin/readystack-entrypoint.sh
COPY readystack-admin-token /usr/local/bin/readystack-admin-token
RUN chmod 755 /usr/bin/influxdb3; chown influxdb3:influxdb3 /usr/local/bin/readystack-entrypoint.sh; chown influxdb3:influxdb3 /usr/local/bin/readystack-admin-token; chmod 0755 /usr/local/bin/readystack-entrypoint.sh; chmod 0755 /usr/local/bin/readystack-admin-token; if ldd /usr/bin/influxdb3 | grep -F 'not found'; then exit 1; fi
LABEL org.opencontainers.image.licenses="MIT OR Apache-2.0"
LABEL org.opencontainers.image.title="InfluxDB"
LABEL org.opencontainers.image.source="https://github.com/influxdata/influxdb"
LABEL org.opencontainers.image.description="InfluxDB 3 Core 3.12.3 time-series database (MIT/Apache-2.0), compiled from source"
LABEL org.opencontainers.image.version="v3.12.3-CE-ubuntu24.04-r1"
LABEL org.opencontainers.image.vendor="ReadyStack.dev"
LABEL readystack.product="influxdb"
LABEL readystack.edition="CE"
LABEL readystack.build_method="source-rebuild-rust"
LABEL org.opencontainers.image.revision="51f4ac865b8670e0d3555ae992639ec05ecc334e"
HEALTHCHECK --interval=5s --timeout=180s --start-period=30s \
  CMD bash -c 'exec 3<>/dev/tcp/127.0.0.1/8181 && printf "GET /health HTTP/1.1\r\nHost: 127.0.0.1\r\nConnection: close\r\n\r\n" >&3 && head -n1 <&3 | grep -q " 200 "' || exit 1
WORKDIR /var/lib/influxdb3
USER influxdb3
EXPOSE 8181
ENTRYPOINT ["/usr/local/bin/readystack-entrypoint.sh"]
CMD ["serve"]
