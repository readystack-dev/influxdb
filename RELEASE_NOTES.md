# InfluxDB v3.12.3 — ReadyStack release `v3.12.3-CE-ubuntu24.04-r1`

Generated 2026-11-25 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1` (linux/amd64). Index digest `sha256:aaf369ea1128e503b80f156fb59ab8f3e6906b978fe679eaefcbbde9c5f802db` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:b9060f068c5457c3ab547795bf3f6819405f8bece7c777924c7d02d97950018f` [`TARGET_DIGEST.txt`].
- **Upstream:** InfluxDB v3.12.3 built from source at `v3.12.3` of https://github.com/influxdata/influxdb (the Python UDF runtime (datafusion_udf_wasm_python, an x86_64 ELF) is InfluxData's prebuilt release from github.com/influxdata/datafusion-udf-wasm, downloaded by the vendor stage and checked against the sha256 upstream pins in core/iox_query_udf/build.rs, as upstream's own build does) — upstream notes: https://github.com/influxdata/influxdb/releases/tag/v3.12.3 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `influxdb3`.
- **Build:** `source-rebuild-rust`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `v3.12.2-CE-ubuntu24.04-r1`.

## What changed in this release

- Upstream version v3.12.2 → v3.12.3.
- This release moves InfluxDB from 3.12.2 to 3.12.3, a newer release of upstream's 3.12.x line. Upstream's release notes list what changed: https://github.com/influxdata/influxdb/releases/tag/v3.12.3 Among them: dependency fixes for RUSTSEC-2026-0421 and RUSTSEC-2026-0435, and a new admin-token route, POST /api/v3/configure/processing_engine_trigger/refresh, which re-fetches a trigger's gh: plugin. Settings, ports and data volumes are those of v3.12.2: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-23)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `influxdb3` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** Every request except /health and /api/v1/health needs a token. The operator token is created on first start and stored in plain text in /var/lib/influxdb3/admin-token.json inside the data volume, so anyone who can read the volume or its backups, or run docker exec, can read it: treat the volume and its backups as secrets.
- **Before exposing this service:** Traffic is plain HTTP unless you set INFLUXDB3_TLS_CERT and INFLUXDB3_TLS_KEY; a token crosses the network in clear text without TLS.
- **Before exposing this service:** INFLUXDB3_WITHOUT_AUTH=true removes authentication entirely; do not use it on a reachable port.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:b9060f068c5457c3ab547795bf3f6819405f8bece7c777924c7d02d97950018f`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 1 of 1 use cases passed (2 authored, 1 kept in the suite; 1 not exercised, see below) against the running image [`docs/validation/test-results.json`].
- The only case is `GET /health` (200); the suite checks nothing else.
- 1 further authored check was not exercised and is not counted above: it needed credentials the build's check does not have (listed under Not exercised in `docs/validation/FAILED_TESTS.md`).

## Known issues

- **medium** (upstream): Secret written in plain text or to the log by default [`RSD-influxdb-bc18d1cd78`]

## Defects fixed

- 5 problems found before release and fixed before it shipped (5 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

