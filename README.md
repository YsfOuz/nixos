<div align="center">

![Verdigris](verdigris.png)
https://github.com/user-attachments/assets/455ce3d4-a937-497a-8c73-cb349be3b06f

# ❧ verdigris

*A NixOS flake for the Lenovo ThinkPad E16 Gen 2*

</div>

---

## Overview

A fully declarative NixOS configuration built around the **Verdigris** colorscheme — deep teal backgrounds, warm copper-rust accents, and muted earth tones. Themed end-to-end via Stylix with a Hyprland desktop.

## Structure

```
.
├── flake.nix              # Inputs & system definition
├── hardware-configuration.nix
├── configuration.nix      # Boot, hardware, networking, audio, Nix settings
├── user.nix               # User account, shell (fish), gaming, greeter
├── home.nix               # Home Manager — editors, packages, fastfetch
├── hyprland.nix           # Hyprland WM + Waybar + Rofi + Kitty + Mako
├── firefox.nix            # Firefox with hardened policies
├── stylix.nix             # Theming (colors, fonts, cursor, icons, opacity)
├── fix.nix                # ThinkPad E16 Gen 2 RAPL power-limit workaround
├── verdigris.yaml         # Base16 colorscheme definition
└── verdigris.png          # Wallpaper
```

## Flake Inputs

| Input | Purpose |
|---|---|
| `nixpkgs/nixos-unstable` | Rolling package set |
| `home-manager` | Declarative user environment |
| `stylix` | System-wide theming from a Base16 scheme |
| `spicetify-nix` | Spotify client theming |
| `firefox-addons` (rycee) | Declarative Firefox extensions |

## Desktop

| Component | Choice |
|---|---|
| Window manager | Hyprland |
| Bar | Waybar (left sidebar + bottom media bar) |
| Launcher | Rofi (drun, clipboard, power menu) |
| Terminal | Kitty |
| Notifications | Mako |
| File manager | Thunar |
| Lock screen | Hyprlock (blurred screenshot + clock) |
| Idle daemon | Hypridle |

### Keybindings

| Key | Action |
|---|---|
| `Super + Return` | Terminal (Kitty) |
| `Super + Space` | App launcher (Rofi) |
| `Super + B` | Browser (Firefox) |
| `Super + E` | File manager (Thunar) |
| `Super + Q` | Close window |
| `Super + T` | Toggle floating |
| `Super + F` | Fullscreen |
| `Super + L` | Lock screen |
| `Super + C` | Clipboard history (cliphist → Rofi) |
| `Super + Escape` | Power menu |
| `Print` | Region screenshot (Hyprshot) |
| `Super + 1–0` | Switch workspace |
| `Super + Shift + 1–0` | Move window to workspace |
| `Alt + Tab` | Cycle windows |
| Media keys | Volume / brightness with OSD notifications |

## Theme — Verdigris

A custom Base16 scheme with a dark teal foundation and warm metallic accents.

| Role | Hex | Swatch |
|---|---|---|
| Background | `#0C2323` | ![](https://placehold.co/18x18/0C2323/0C2323) |
| Foreground | `#C0B5AB` | ![](https://placehold.co/18x18/C0B5AB/C0B5AB) |
| Red / Variables | `#B3653C` | ![](https://placehold.co/18x18/B3653C/B3653C) |
| Orange / Constants | `#A08E50` | ![](https://placehold.co/18x18/A08E50/A08E50) |
| Yellow / Classes | `#8DA363` | ![](https://placehold.co/18x18/8DA363/8DA363) |
| Green / Strings | `#48B777` | ![](https://placehold.co/18x18/48B777/48B777) |
| Cyan / Support | `#43B3AE` | ![](https://placehold.co/18x18/43B3AE/43B3AE) |
| Blue / Functions | `#2A91A2` | ![](https://placehold.co/18x18/2A91A2/2A91A2) |
| Purple / Keywords | `#3E5586` | ![](https://placehold.co/18x18/3E5586/3E5586) |
| Brown / Deprecated | `#B87333` | ![](https://placehold.co/18x18/B87333/B87333) |

**Fonts:** Recursive Sans Casual Static (UI) · RecMonoCasual Nerd Font (mono)  
**Cursor:** Bibata Modern Ice @ 24px  
**Icons:** Papirus Dark  
**Opacity:** 75% across applications, terminal, popups, and desktop

## Editors

- **Helix** — default editor with auto-format
- **Zed** — GUI editor with custom keybinds (`Ctrl+T` terminal, `Ctrl+E` file tree)

Both editors share the same LSP setup:

| LSP | Language |
|---|---|
| `jdt-language-server` | Java |
| `clang-tools` (clangd) | C / C++ |
| `nixd` + `nixfmt` | Nix |

## Shell

Fish shell with Starship prompt and the following aliases:

| Alias | Command |
|---|---|
| `ls` | `eza --icons` |
| `tree` | `eza --tree --icons` |
| `cat` | `bat` |
| `cd` | `z` (zoxide) |

Fastfetch runs on every interactive shell start.

## Hardware

**Lenovo ThinkPad E16 Gen 2** · Intel Core Ultra 7 155H · Intel Arc integrated graphics

Notable configuration:

- Intel Arc GPU forced via the `xe` driver (`xe.force_probe=7d55`)
- Hardware-accelerated video decode via `iHD` / VAAPI
- `scx_bpfland` scheduler for improved responsiveness
- zram swap (50%, zstd) + tmpfs `/tmp`
- Fingerprint reader (`fprintd`), Thunderbolt (`bolt`), firmware updates (`fwupd`)
- BBR TCP congestion control

### Power Fix (`fix.nix`)

Lenovo ships the E16 Gen 2 with conservative RAPL limits (PL1 40W / PL2 55W). This config raises them to **PL1 45W / PL2 115W** via a oneshot systemd service and resume hook. Firmware currently clamps sustained power to 28W regardless; the higher values will take full effect automatically if a future BIOS update raises the ceiling.

> Upgrade note: if you move to a 96W/100W charger, raise `constraint_0` to `65000000`.

## Firefox

Policies enforced declaratively — no telemetry, no Pocket, no Firefox Accounts, no saved logins. Strict content blocking and HTTPS-only mode enabled. Hardware video decode via VAAPI. Extension: **uBlock Origin**.

## Deployment

```sh
# First-time
nixos-install --flake .#nixos

# Rebuild
nh os switch /etc/nixos
```

The flake is pinned at `/etc/nixos`. `nh` handles builds and automatically cleans old generations.
