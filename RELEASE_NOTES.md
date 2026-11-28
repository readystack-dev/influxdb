# InfluxDB v3.12.3 — ReadyStack release `v3.12.3-CE-ubuntu24.04-r2`

Generated 2026-11-28 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/influxdb:v3.12.3-CE-ubuntu24.04-r2` (linux/amd64). Index digest `sha256:b5d2c015b28ddad81b20a8fbd47672b07866b27d0bb0af278ebe6b6241472d36` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:094911cbf3589f6a804c6dad91c52bed1270b569b77e1fa0e700fcf93765f31d` [`TARGET_DIGEST.txt`].
- **Upstream:** InfluxDB v3.12.3 built from source at `v3.12.3` of https://github.com/influxdata/influxdb (the Python UDF runtime (datafusion_udf_wasm_python, an x86_64 ELF) is InfluxData's prebuilt release from github.com/influxdata/datafusion-udf-wasm, downloaded by the vendor stage and checked against the sha256 upstream pins in core/iox_query_udf/build.rs, as upstream's own build does) — upstream notes: https://github.com/influxdata/influxdb/releases/tag/v3.12.3 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `influxdb3`.
- **Build:** `source-rebuild-rust`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `v3.12.3-CE-ubuntu24.04-r1`.

## What changed in this release

- Upstream version unchanged (v3.12.3); ReadyStack rebuild.
- InfluxDB v3.12.3 is unchanged from the release this supersedes (v3.12.3-CE-ubuntu24.04-r1); this release rebuilds it. Changes: libexpat1 moves from 2.6.1-2ubuntu0.6 to 2.6.1-2ubuntu0.7 (USN-9196-1). Settings, ports and data volumes are those of v3.12.3-CE-ubuntu24.04-r1: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-27)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `influxdb3` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/influxdb:v3.12.3-CE-ubuntu24.04-r2` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** Every request except /health and /api/v1/health needs a token. The operator token is created on first start and stored in plain text in /var/lib/influxdb3/admin-token.json inside the data volume, so anyone who can read the volume or its backups, or run docker exec, can read it: treat the volume and its backups as secrets.
- **Before exposing this service:** Traffic is plain HTTP unless you set INFLUXDB3_TLS_CERT and INFLUXDB3_TLS_KEY; a token crosses the network in clear text without TLS.
- **Before exposing this service:** INFLUXDB3_WITHOUT_AUTH=true removes authentication entirely; do not use it on a reachable port.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:094911cbf3589f6a804c6dad91c52bed1270b569b77e1fa0e700fcf93765f31d`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 1 of 1 use cases passed (2 authored, 1 kept in the suite; 1 not exercised, see below) against the running image [`docs/validation/test-results.json`].
- The only case is `GET /health` (200); the suite checks nothing else.
- 1 further authored check was not exercised and is not counted above: it needed credentials the build's check does not have (listed under Not exercised in `docs/validation/FAILED_TESTS.md`).

## Known issues

- **medium** (upstream): Secret written in plain text or to the log by default [`RSD-influxdb-265c893027`]
- **low** (ReadyStack package): API guide: Route table omits the route the guide's own intro says v3.12.3 adds. [`RSD-influxdb-08c2dd2933`] (carried from `v3.12.3-CE-ubuntu24.04-r1`, recorded there as `RSD-influxdb-5164c8426b`)

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/influxdb:v3.12.3-CE-ubuntu24.04-r2
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

