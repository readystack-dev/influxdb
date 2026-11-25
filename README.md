# InfluxDB: ReadyStack build kit

The offline build kit for the Docker image `readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v3.12.3-CE-ubuntu24.04-r1](https://github.com/readystack-dev/influxdb/releases/tag/v3.12.3-CE-ubuntu24.04-r1)
- Image: [`docker.io/readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1`](https://hub.docker.com/r/readystack/influxdb/tags), manifest digest `sha256:b9060f068c5457c3ab547795bf3f6819405f8bece7c777924c7d02d97950018f`
- Product page: https://readystack.dev/products/influxdb
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=influxdb

InfluxDB is distributed under its upstream licence (MIT OR Apache-2.0); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v3.12.3-CE-ubuntu24.04-r1 release](https://github.com/readystack-dev/influxdb/releases/tag/v3.12.3-CE-ubuntu24.04-r1): `ReadyStack-influxdb-v3.12.3-CE-ubuntu24.04-r1.tar.gz` (918.1 MB), SHA-256 `ab579388a7745dc2fb523d704b1ecfae3dccda245af332d609a5767846a220ad`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-influxdb-v3.12.3-CE-ubuntu24.04-r1.rebuild.json.sigstore ReadyStack-influxdb-v3.12.3-CE-ubuntu24.04-r1.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-influxdb-v3.12.3-CE-ubuntu24.04-r1.tar.gz
cd v3.12.3-CE-ubuntu24.04-r1
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-influxdb-v3.12.3-CE-ubuntu24.04-r1.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/influxdb/recipe. The complete kit is the release download. Each release is a tag here.
