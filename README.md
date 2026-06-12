# Nametag Control

A simple Lua script for UIF Zone & Gang wars that hides teammate nametags and health bars, helping you focus on enemy players without unnecessary visual clutter.

When enabled, the script disables the server's default nametags and replaces them with custom enemy-only nametags. The displayed information can be customized to show the player's name, ID, or both. Enemy health, armor, and AFK indicators remain visible while teammates are completely hidden.

## Usage

Use the following commands in-game, preferably during a zone or gang war:

### Toggle Custom Nametags

```text
/toggletags
```

* **Enabled** — teammate nametags are hidden and custom enemy-only nametags are rendered.
* **Disabled** — original server nametag settings are restored.

### Change Tag Display Mode

```text
/tagmode full
/tagmode name
/tagmode id
```

Available modes:

* **full** — displays the player's name and ID (`PlayerName (123)`).
* **name** — displays only the player's name (`PlayerName`).
* **id** — displays only the player's ID (`(123)`).

> [!NOTE]
> Tag mode only affects custom enemy nametags rendered by this script.
>
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
