# Source and distribution

The canonical Nyx palette, semantic roles, generator, and validation checks live
in the private `stfolder/nyx` repository under `themes/nyx/jetbrains`.

This public bundle contains the generated, self-contained distribution:

- `themes/nyx.theme.json` — IntelliJ application UI theme.
- `themes/nyx.xml` — editor color and syntax scheme.
- `META-INF/plugin.xml` and `pluginIcon.svg` — plugin metadata and identity.
- `nyx-intellij-theme.jar` — installable theme plugin.

The IntelliJ theme and scheme structures begin with the Catppuccin JetBrains
3.5.3 Frappé UI theme and Mocha editor scheme as compatibility references.
Their colors, identity, UI roles, and syntax semantics are replaced by the
canonical Nyx system. See [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md).

Do not edit the generated files independently. Change the canonical palette or
generator, run its full check and package workflow, and then refresh this copy.
