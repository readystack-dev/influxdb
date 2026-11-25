# Provenance — InfluxDB (`v3.12.3-CE-ubuntu24.04-r1`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/influxdata/influxdb
- Revision built: `v3.12.3` (commit `51f4ac865b8670e0d3555ae992639ec05ecc334e`)
- Source tree: `88eb9ac86d13b38db10cc49087d3b65c14f5019d477a1747a9ab3a40f6f8cb87` over 1857 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-rust`; base image `ubuntu:24.04`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- Not compiled here, shipped as upstream's prebuilt files: the Python UDF runtime (datafusion_udf_wasm_python, an x86_64 ELF) is InfluxData's prebuilt release from github.com/influxdata/datafusion-udf-wasm, downloaded by the vendor stage and checked against the sha256 upstream pins in core/iox_query_udf/build.rs, as upstream's own build does
- SOURCE_DATE_EPOCH: `1795446682` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1` — index digest `sha256:aaf369ea1128e503b80f156fb59ab8f3e6906b978fe679eaefcbbde9c5f802db` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:b9060f068c5457c3ab547795bf3f6819405f8bece7c777924c7d02d97950018f` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/influxdb:v3.12.3-CE-ubuntu24.04-r1`

## Pinned inputs, and why

- 17 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 4, image digests 2, language runtimes and toolchains 1, dependency versions readystack sets 1, pins in the kit's dockerfiles 4, readystack's build engine 1, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-influxdb-v3.12.3-CE-ubuntu24.04-r1.trail.json`, published beside this archive and signed with the release key (`ReadyStack-influxdb-v3.12.3-CE-ubuntu24.04-r1.trail.json.sigstore`), and readable at https://readystack.dev/products/influxdb/trail/v3.12.3-CE-ubuntu24.04-r1.

