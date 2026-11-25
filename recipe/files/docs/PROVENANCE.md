# Provenance — InfluxDB (`v3.12.2-CE-ubuntu24.04-r1`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/influxdata/influxdb
- Revision built: `v3.12.2` (commit `cc9769917ab399ed5b48567a92b5d34ed4d918ea`)
- Source tree: `5f6faf6b3ede125087079b9b9490a9745d0055ec385c9c14e9f74cc61364d6f7` over 1855 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-rust`; base image `ubuntu:24.04`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- Not compiled here, shipped as upstream's prebuilt files: the Python UDF runtime (datafusion_udf_wasm_python, an x86_64 ELF) is InfluxData's prebuilt release from github.com/influxdata/datafusion-udf-wasm, downloaded by the vendor stage and checked against the sha256 upstream pins in core/iox_query_udf/build.rs, as upstream's own build does
- SOURCE_DATE_EPOCH: `1793301155` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/influxdb:v3.12.2-CE-ubuntu24.04-r1` — index digest `sha256:e9a43b81a40c95fbbfc4700d784c9408fadf8bf49d489d88520d55d1f211906a` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:968bcc53f2d97e304bacc2cf6cc16dec8a39bb6bc5509bc1fe75c56c4edf2ec0` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/influxdb:v3.12.2-CE-ubuntu24.04-r1`

## Pinned inputs, and why

- 16 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 4, image digests 2, language runtimes and toolchains 1, pins in the kit's dockerfiles 4, readystack's build engine 1, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-influxdb-v3.12.2-CE-ubuntu24.04-r1.trail.json`, published beside this archive and signed with the release key (`ReadyStack-influxdb-v3.12.2-CE-ubuntu24.04-r1.trail.json.sigstore`), and readable at https://readystack.dev/products/influxdb/trail/v3.12.2-CE-ubuntu24.04-r1.

