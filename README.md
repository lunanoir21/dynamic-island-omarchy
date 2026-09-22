# Dynamic Island for Omarchy

> **This repo is only packaging.** The project itself lives at
> **[lunanoir21/quickshell-dynamic-island](https://github.com/lunanoir21/quickshell-dynamic-island)**
> — source, [changelog](https://github.com/lunanoir21/quickshell-dynamic-island/blob/main/CHANGELOG.md),
> docs, demo video and issue tracker are all there. Please open bugs and
> feature requests upstream; issues here are limited to the Omarchy wrapper
> itself (manifest, `Service.qml`, vendoring).

[Dynamic Island](https://github.com/lunanoir21/quickshell-dynamic-island)
packaged as an Omarchy shell plugin: a Hyprland-native "dynamic island" —
media playback (with lyrics and queue), calls, notifications, a pixel-matrix
clock, timers/alarms/stopwatch, and a per-app volume mixer, all in one pill
that expands from the top of the screen.

This repo is a thin wrapper. All of the island's actual behavior lives in
[`quickshell-dynamic-island`](https://github.com/lunanoir21/quickshell-dynamic-island);
the `dynamic-island/` directory here is a vendored, pinned copy of it
(currently `2026.09.23`), and `Service.qml` is the one line Omarchy's plugin
loader needs to start it. Nothing is developed here — to follow the project,
read the release notes, or see what changed between vendored pins, go to the
upstream repo.

`manifest.json` declares `kinds: ["service"]` with `keepLoaded: true` — the
same shape as Omarchy's own built-in `background`, `lock` and
`notifications` plugins. The island owns its own per-screen `PanelWindow`
and layer-shell surface, so like those three it doesn't need omarchy-shell
to summon or position anything; it just needs to be instantiated once per
screen and stay loaded.

## Install

```bash
omarchy plugin add https://github.com/lunanoir21/dynamic-island-omarchy.git --enable
```

## Configure

Right-click the island (or open its settings chip) for its own settings
window — theme, hover/trigger mode, which panels are enabled, chime sounds,
and more. Settings are the island's own
(`~/.config/quickshell/dynamic-island/settings.json`), independent of
`~/.config/omarchy/shell.json`.

## Uninstall

```bash
omarchy plugin remove io.github.lunanoir21.dynamic-island
```

## Requirements

- Hyprland (fullscreen suppression and some window-state reads use its IPC;
  the panel itself works on any wlr-layer-shell compositor)
- A Nerd Font, for the interface icons
- `playerctl`, `pactl`/PipeWire-Pulse (media + mixer)
- `jq`, `curl` (backend state + lyrics/thumbnail lookups)
- Optional: `bluetoothctl`, `nmcli`, `upower`, `brightnessctl`, `busctl`,
  `cava` (bluetooth/wifi/battery/brightness tiles, track queue, visualizer —
  each degrades quietly if its command is missing)

## Updating the vendored copy

`dynamic-island/` is a plain copy, not a git submodule — Omarchy's
marketplace clones a single ref of this repo, and a submodule would need an
extra `--recurse-submodules` step outside the plugin loader's control. To
pick up a new quickshell-dynamic-island release, copy its files over
`dynamic-island/`, bump `version` in `manifest.json`, and commit.

Watch the [upstream releases](https://github.com/lunanoir21/quickshell-dynamic-island/releases)
(or its changelog) to know when a new pin is worth taking.

## License

MIT, same as upstream — see [LICENSE](LICENSE).

---

<sub>Maintainer note — marketplace submission: category `Widgets`, tags
`Quickshell`, `Hyprland`, `Media`. `preview.png` is the project's front-page
cover image (1280×660).</sub>
