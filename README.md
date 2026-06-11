# Nametag Control

A simple Lua script for UIF Zone & Gang wars that hides teammate nametags and health bars, helping you focus on enemy players without unnecessary visual clutter.

When enabled, the script disables the server's default nametags and replaces them with custom nametags that are only rendered for enemy players. Enemy health, armor, and AFK indicators remain visible while teammates are completely hidden.

## Usage

Use the following command in-game, preferably during a zone or gang war:

```text
/toggletags
```

* **Enabled** — teammate nametags are hidden.
* **Disabled** — original server nametag settings are restored.

> [!NOTE]
> The script saves the original nametag settings and restores them automatically when disabled.

> [!WARNING]
> This script is intended specifically for UIF Zone & Gang Wars.

## Requirements

* [MoonLoader](https://www.blast.hk/threads/13305/)
* [SAMPFUNCS](https://www.blast.hk/threads/17/)
* [SA-MP](https://www.sa-mp.mp/downloads/)

## Installation

1. Download `nametag_control.lua`.
2. Place it inside your MoonLoader directory.
3. Launch the game and connect to UIF Server.
4. Use `/toggletags` to enable or disable the feature.

## Screenshot

The screenshot below demonstrates the custom enemy-only nametag rendering.

![Screenshot](https://images.fsc-clan.eu/i/vnjyq.png)
![Screenshot](https://images.fsc-clan.eu/i/b0dxi.png)
