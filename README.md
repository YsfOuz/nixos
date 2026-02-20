<div align="center">

# NixOS

[![Typing SVG](https://readme-typing-svg.herokuapp.com?lines=NixOS+%2B+Hyprland;Flake-based+%26+Reproducible;Themed+with+Verdigris&center=true&width=450&height=50&color=43B3AE&vCenter=true&size=18)](https://git.io/typing-svg)

*A minimal, declarative NixOS config for the ThinkPad E16 Gen 2.*  
*Themed around [Verdigris](verdigris.yaml) — a custom base24 colorscheme.*

![Verdigris](verdigris.png)

https://github.com/user-attachments/assets/455ce3d4-a937-497a-8c73-cb349be3b06f

</div>

---

## System

| | |
|---|---|
| **Machine** | Lenovo ThinkPad E16 Gen 2 |
| **CPU** | Intel Core Ultra 7 155H |
| **GPU** | Intel Arc (Xe driver) |
| **RAM** | 32GB |
| **OS** | NixOS Unstable |

---

## Stack

| Role | Tool |
|---|---|
| Window Manager | Hyprland |
| Bar | Waybar |
| Terminal | Kitty |
| Shell | Fish + Starship |
| Editor | Zed + Neovim |
| Launcher | Rofi |
| Notifications | Mako |
| Lock Screen | Hyprlock |
| Theme Engine | Stylix |
| Colorscheme | Verdigris (custom base24) |
| Browser | Firefox |

---

## Verdigris Palette

### Base

| Label | Hex | Swatch |
|---|---|---|
| base00 | `#0C2323` | ![](https://placehold.co/24x24/0C2323/0C2323) |
| base01 | `#102C2C` | ![](https://placehold.co/24x24/102C2C/102C2C) |
| base02 | `#143837` | ![](https://placehold.co/24x24/143837/143837) |
| base03 | `#1A4745` | ![](https://placehold.co/24x24/1A4745/1A4745) |
| base04 | `#F0E3D6` | ![](https://placehold.co/24x24/F0E3D6/F0E3D6) |
| base05 | `#C0B5AB` | ![](https://placehold.co/24x24/C0B5AB/C0B5AB) |
| base06 | `#999088` | ![](https://placehold.co/24x24/999088/999088) |
| base07 | `#7A736C` | ![](https://placehold.co/24x24/7A736C/7A736C) |

### Accents

| Label | Hex | Swatch | Role |
|---|---|---|---|
| base08 | `#B3653C` | ![](https://placehold.co/24x24/B3653C/B3653C) | Red / Errors |
| base09 | `#A08E50` | ![](https://placehold.co/24x24/A08E50/A08E50) | Orange |
| base0A | `#8DA363` | ![](https://placehold.co/24x24/8DA363/8DA363) | Yellow |
| base0B | `#48B777` | ![](https://placehold.co/24x24/48B777/48B777) | Green / Strings |
| base0C | `#43B3AE` | ![](https://placehold.co/24x24/43B3AE/43B3AE) | Cyan / Regex |
| base0D | `#2A91A2` | ![](https://placehold.co/24x24/2A91A2/2A91A2) | Blue / Functions |
| base0E | `#3E5586` | ![](https://placehold.co/24x24/3E5586/3E5586) | Violet / Keywords |
| base0F | `#B87333` | ![](https://placehold.co/24x24/B87333/B87333) | Copper |

### Extended (base24)

| Label | Hex | Swatch |
|---|---|---|
| base10 | `#956E59` | ![](https://placehold.co/24x24/956E59/956E59) |
| base11 | `#968D6E` | ![](https://placehold.co/24x24/968D6E/968D6E) |
| base12 | `#919C7C` | ![](https://placehold.co/24x24/919C7C/919C7C) |
| base13 | `#6BA282` | ![](https://placehold.co/24x24/6BA282/6BA282) |
| base14 | `#69A19F` | ![](https://placehold.co/24x24/69A19F/69A19F) |
| base15 | `#4F828B` | ![](https://placehold.co/24x24/4F828B/4F828B) |
| base16 | `#48546C` | ![](https://placehold.co/24x24/48546C/48546C) |
| base17 | `#9C7959` | ![](https://placehold.co/24x24/9C7959/9C7959) |

---

## Usage

```bash
git clone https://github.com/YsfOuz/nixos /etc/nixos
nh os switch
```
