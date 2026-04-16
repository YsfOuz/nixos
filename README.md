# Yusuf's NixOS Flake

A fully declarative NixOS configuration for the Lenovo ThinkPad E16 Gen 2, built on Hyprland with the custom **Verdigris** colorscheme.

---

## Overview

This flake provides a complete, reproducible system setup with:
- **Hyprland** wayland compositor with custom keybindings
- **Verdigris** dark teal theme with warm metallic accents (Base16 scheme)
- Development tools: Helix, Zed, Java, Rust, C/C++, Nix
- Gaming: Steam + Proton, Prismlauncher
- Privacy-focused Firefox with hardened policies
- Local services: Searx, Ollama, KDE Connect
- Power management optimized for ThinkPad

---

## File Structure

```
.
├── flake.nix                  # Flake inputs & system configuration
├── hardware-configuration.nix # Hardware-specific settings
├── configuration.nix          # Boot, hardware, networking, audio, Nix settings
├── user.nix                   # User account, shell, services, gaming
├── home.nix                   # Home Manager — editors, packages, dev tools
├── hyprland.nix               # Hyprland WM + Waybar + Fuzzel + Hyprlock + Hypridle
├── firefox.nix                # Firefox with privacy policies & hardening
├── stylix.nix                 # System-wide theming via Stylix
├── verdigris.yaml             # Custom Base16 colorscheme
└── verdigrisMinimal.png       # Wallpaper
```

---

## Flake Inputs

| Input | Purpose |
|---|---|
| `nixpkgs/nixos-unstable` | Bleeding-edge package set |
| `home-manager` | Declarative user environment |
| `stylix` | System-wide theming from Base16 scheme |

---

## Hardware

**Device:** Lenovo ThinkPad E16 Gen 2  
**CPU:** Intel Core Ultra 7 155H  
**GPU:** Intel Arc (Xe) integrated graphics

### Hardware Features
- Intel Arc GPU: forced via `xe.force_probe=7d55` (disables i915)
- Hardware video decode: iHD / VAAPI
- Fingerprint reader (`fprintd`), Thunderbolt (`bolt`), firmware updates (`fwupd`)
- Bluetooth + Network Manager
- BBR TCP congestion control

### Power & Thermal
- `thermald` for thermal management
- TLP for battery conservation:
  - Charge: 75–80% threshold
  - Enable power delivery
- zram swap (50%, zstd compression)
- tmpfs `/tmp` for speed

---

## Boot & System

**Bootloader:** Limine (max 10 generations)  
**Kernel:** Latest stable + custom kernel parameters:
- `xe.force_probe=7d55` — Intel Arc
- `i915.force_probe=!7d55` — Disable i915
- `nowatchdog`, `quiet`

**Networking:**
- NetworkManager
- Firewall ports:
  - TCP: 25565 (Minecraft), 1716 (KDE Connect), 8080
  - UDP: 19132 (Bedrock), 1714–1715 (KDE Connect)

**Audio:** PipeWire + ALSA + Pulse (32-bit support)  
**Display:** Wayland, NIXOS_OZONE_WL=1  
**Locale:** Turkish keyboard layout (tr), Istanbul timezone

---

## Hyprland Desktop Environment

### Components

| Component | Choice |
|---|---|
| Window manager | Hyprland |
| Launcher | Fuzzel |
| Top bar | Waybar (left sidebar + bottom media) |
| Notifications | Mako |
| Lock screen | Hyprlock (blurred screenshot + clock) |
| Idle daemon | Hypridle |
| Terminal | Alacritty |
| File manager | Thunar |
| Screenshots | Hyprshot |
| Clipboard history | Cliphist |

### Keybindings

#### Window & App Management
| Binding | Action |
|---|---|
| `Super` + `Return` | Launch terminal (Alacritty) |
| `Super` + `Space` | App launcher (Fuzzel) |
| `Super` + `B` | Firefox |
| `Super` + `E` | File manager (Thunar) |
| `Super` + `Q` | Close window |
| `Super` + `T` | Toggle floating |
| `Super` + `F` | Fullscreen |
| `Alt` + `Tab` | Cycle windows |
| `Super` + `U` | Special workspace (scratchpad) |

#### System Actions
| Binding | Action |
|---|---|
| `Super` + `L` | Lock screen |
| `Super` + `Escape` | Power menu (rofi) |
| `Super` + `C` | Clipboard history (cliphist → Fuzzel) |
| `Print` | Full screenshot |
| `Super` + `Print` | Window screenshot |
| `Ctrl` + `Print` | Region screenshot |

#### Workspaces
| Binding | Action |
|---|---|
| `Super` + `[1–0]` | Switch workspace |
| `Super` + `Shift` + `[1–0]` | Move window to workspace |

#### Media Controls
| Binding | Action |
|---|---|
| `XF86AudioRaiseVolume` | +5% volume w/ notification |
| `XF86AudioLowerVolume` | −5% volume w/ notification |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioMicMute` | Toggle mic |
| `XF86MonBrightnessUp` | +5% brightness w/ notification |
| `XF86MonBrightnessDown` | −5% brightness w/ notification |

### Hyprland Settings
- **Gaps:** 8px in/out
- **Border:** None
- **Rounding:** 8px
- **Animations:** Custom bezier curve (`verdigris`) for fade, windows, layers, workspaces
- **Cursor acceleration:** Flat
- **Touchpad:** Natural scroll enabled
- **Wallpaper:** `verdigrisMinimal.png`

### Waybar

**Left sidebar** (fixed width 48px):
- Workspaces with icons
- Clock (vertical format: HH / MM)
- System tray
- Idle inhibitor
- Pulseaudio with volume %
- Backlight with brightness %
- Power profiles (performance / balanced / power-saver)
- Battery with capacity % and time remaining

**Bottom media bar** (height 48px):
- Cava audio visualizer (64 bars)
- MPRIS player controls w/ title/artist info
- Player: Spotify integration (Firefox ignored)

### Hypridle & Lock Screen
- **150s:** Dim display to 10% brightness
- **300s:** Lock screen
- **330s:** DPMS off (display standby)
- **1800s:** Suspend

**Hyprlock:** Blurred screenshot background + large centered time + date below

---

## Theming: Verdigris

A custom dark teal Base16 scheme with warm metallic accents.

### Color Palette

| Role | Hex | Use |
|---|---|---|
| **Background** | `#0C2323` | Windows, editor background |
| **Foreground** | `#C0B5AB` | Default text |
| **Red** | `#B3653C` | Variables, errors |
| **Orange** | `#A08E50` | Numbers, constants |
| **Yellow** | `#8DA363` | Classes, search highlights |
| **Green** | `#48B777` | Strings |
| **Cyan** | `#43B3AE` | Support, regex |
| **Blue** | `#2A91A2` | Functions, headings |
| **Purple** | `#3E5586` | Keywords, storage |
| **Brown** | `#B87333` | Deprecated, tags |

### Extended Palette
- **base10–base17:** Muted variants for UI elements
  - Muted rust, gold, olive, teal, cyan, slate-blue, bronze

### Typography
- **UI Font:** Iosevka (sans-serif)
- **Monospace:** Iosevka Nerd Font
- **Cursor:** Bibata Modern Ice @ 24px
- **Icons:** Papirus Dark

### Opacity
All set to 100% (1.0):
- Applications
- Desktop
- Popups
- Terminal

---

## Development

### Editors

**Helix** (default):
- Auto-format on save
- LSP setup (see below)

**Zed:**
- AI disabled, telemetry off
- Custom keybinds:
  - `Ctrl` + `T` → Toggle terminal
  - `Ctrl` + `E` → Toggle file tree
- LSP setup (see below)

### Language Servers

| Language | Server |
|---|---|
| Nix | `nixd` + `nixfmt` |
| Java | `jdt-language-server` |
| C / C++ | `clang-tools` (clangd) |
| Rust | `rust-analyzer` |

### Available Tools
- GCC, Clang
- Cargo (Rust)
- Maven
- Make, CMake
- Graphviz

---

## Shell & CLI

**Shell:** Fish with Starship prompt

### Aliases
| Alias | Command |
|---|---|
| `ls` | `eza --icons` |
| `tree` | `eza --tree --icons` |
| `cat` | `bat` |

**Auto-run:** `fastfetch` on every interactive shell start

### System Monitor
`btop` for real-time process & resource monitoring

---

## Applications

### Development
- **Claude Code** (CLI)
- Lynx (terminal web browser)
- Graphviz

### Media
- Spotify
- GIMP
- FFmpeg
- VLC

### Productivity
- LibreOffice

### Gaming
- Steam + Proton (GE builds)
- Prism Launcher (Minecraft)
- Mindustry

### Utils
- Unzip / Zip
- Intel GPU monitor (nvtop)
- Alacritty (terminal)
- Thunar (file manager)

---

## Services

### Searx (Meta Search)
- Local privacy-respecting search engine
- Redis backend
- JSON + HTML formats
- Accessible locally

### Ollama
- Local LLM inference
- Available for local AI tasks

### Gaming & Connectivity
- **Steam:** With Proton + GE compatibility layer
- **KDE Connect:** Phone integration
- **Blueman:** Bluetooth management

### Desktop Services
- **GVFS:** Virtual filesystem abstraction
- **UDisks2:** Storage management
- **D-Bus Broker:** IPC
- **Systemd:** Integration with Hyprland

---

## Firefox

### Policies
- **No telemetry** (health reporting, usage tracking disabled)
- **No AI**: default blocked
- **No saved logins** (password generation disabled)
- **No Pocket** (implied by search defaults)
- **No Firefox Accounts**

### Privacy
- Sanitize data on shutdown (except cookies/storage)
- History disabled
- Form autofill disabled
- Credit card autofill disabled
- Firefox Relay disabled

### Search
- **Default engines:** DuckDuckGo (private + normal)
- Enforce user choice
- No search suggestions in URL bar

### UI
- **Vertical sidebar** with tab groups disabled
- Collapse-on-hover sidebar visibility
- Hide search suggestion prefilling

### Extensions
- **uBlock Origin** (force-installed)

### Hardware
- VAAPI video decode enabled

---

## Deployment

### First-time Installation
```bash
nixos-install --flake .#nixos
```

### System Rebuild
```bash
nh os switch /etc/nixos
```

The flake is pinned at `/etc/nixos`. The `nh` tool handles builds and automatically manages old generations.

---

## System Details

- **NixOS State Version:** 26.05
- **Boot Loader:** Limine (10 generation max)
- **Unfree Packages:** Enabled
- **Cachix:** nix-community (faster builds)
- **Nix Features:** flakes, nix-command

---

## Notes

- **Git user:** Yusuf Oğuz (ysfouz2007@gmail.com)
- **Timezone:** Europe/Istanbul (UTC+03:00)
- **Keyboard layout:** Turkish (tr)
- This config assumes a fresh NixOS install on the ThinkPad E16 Gen 2. Other hardware may require adjustments to `hardware-configuration.nix`.
