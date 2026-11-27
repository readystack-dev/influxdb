[![ReadyStack](https://readystack.dev/logo.svg)](https://readystack.dev)

**Stable, Open-source Releases, Automated** · [readystack.dev](https://readystack.dev)

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-readystack%2Finfluxdb-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/readystack/influxdb) [![Docker pulls](https://img.shields.io/docker/pulls/readystack/influxdb)](https://hub.docker.com/r/readystack/influxdb) [![Grade at release](https://img.shields.io/badge/grade%20at%20release-A%20%2894%25%29-2ea44f)](https://readystack.dev/products/influxdb) [![Signed: cosign](https://img.shields.io/badge/signed-cosign-2ea44f)](https://readystack.dev/keys/cosign.pub) ![SBOM: SPDX](https://img.shields.io/badge/SBOM-SPDX-2ea44f) ![Provenance: SLSA v1](https://img.shields.io/badge/provenance-SLSA%20v1-2ea44f) ![Offline rebuild: verified](https://img.shields.io/badge/offline%20rebuild-verified-2ea44f)

# InfluxDB: ReadyStack build kit

The offline build kit for the Docker image `readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v3.12.3-CE-ubuntu24.04-r1](https://github.com/readystack-dev/influxdb/releases/tag/v3.12.3-CE-ubuntu24.04-r1)
- Image: [`docker.io/readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1`](https://hub.docker.com/r/readystack/influxdb/tags), manifest digest `sha256:b9060f068c5457c3ab547795bf3f6819405f8bece7c777924c7d02d97950018f`
- Product page: https://readystack.dev/products/influxdb
- Source and build recipe: https://readystack.dev/products/influxdb/recipe
- Build trail: https://readystack.dev/products/influxdb/trail/v3.12.3-CE-ubuntu24.04-r1
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=influxdb

## The image

Single container running one Rust binary, influxdb3 serve, compiled from the upstream source. A single-node time-series database: it accepts writes in line protocol, answers SQL and InfluxQL queries, and stores its catalog, write-ahead log and Parquet files in a local-disk object store under /var/lib/influxdb3/data (INFLUXDB3_OBJECT_STORE=file; the server also accepts the s3, google and azure object stores, which this release's handbooks do not cover). No external database, no web UI. It runs as the non-root user influxdb3.

## Who uses InfluxDB and why

Engineers who collect time-stamped data such as sensor readings, server metrics and network measurements.

InfluxDB is a database built to collect, process and store event and time series data, and to answer queries on recent data quickly for dashboards, monitoring and automation.

A typical use: A factory streams readings from its machine sensors every few seconds. InfluxDB ingests them as they arrive, a dashboard queries the latest values with SQL, and a Python plugin running inside the database reacts when a reading crosses a threshold.

From the upstream project's own description: https://github.com/influxdata/influxdb, https://docs.influxdata.com/influxdb3/core/.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-25 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 90 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`influxdb3`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-23; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/influxdb.

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

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/influxdb/recipe. The complete kit is the release download. Each release is a tag here. How to report a vulnerability: [SECURITY.md](SECURITY.md).

## About ReadyStack

**Stable, Open-source Releases, Automated.** ReadyStack releases popular open-source apps every week with every available critical and high security fix applied, plus full documentation, reference data, tests and a build recipe that recreates each release bit-for-bit. Each release is rebuilt from its pinned inputs with the network off, checked against its published digest, signed, and scanned and graded again every day. The images and build kits are free, and ReadyStack is soon to be a nonprofit.

[readystack.dev](https://readystack.dev) · [All products](https://readystack.dev/products.html) · [Build kits on GitHub](https://github.com/readystack-dev) · [Defect log](https://readystack.dev/defects.html) · contact@readystack.dev

— ReadyStack · https://readystack.dev
