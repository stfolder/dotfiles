# Source and refresh contract

The private `stfolder/nyx` repository remains the canonical source for the Nyx
palette, porting rules, generator, validation, and preview fixtures. This public
directory is a generated distribution for machines that cannot access that
repository.

Exported from canonical Nyx commit `7478ad9`.

The public bundle contains:

- the generated, readable `themes/nyx-color-theme.json`;
- the minimal extension metadata and documentation;
- a ready-to-install `nyx-theme.vsix` built from those public files;
- `SHA256SUMS` for detecting a stale or damaged public copy.

Do not edit the generated theme independently. To refresh it, generate and
validate the theme in the canonical repository, copy the generated JSON here,
update the source commit above, rebuild the VSIX from this directory, and verify
that the packaged theme and metadata exactly match the public source files.
