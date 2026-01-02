# 🌿 Verdigris NixOS Configuration

![Verdigris Theme](verdigris.png)

> A highly customized, performance-oriented **NixOS** configuration featuring **Hyprland**, driven by the custom **Verdigris** color scheme.

## 📖 Overview

This configuration is built on **NixOS Unstable** using **Flakes** for reproducibility. It features a cohesive aesthetic managed by **Stylix**, a fully configured **NixVim** environment, and specific optimizations for modern Intel hardware.

* **User:** Yusuf Oğuz
* **System Architecture:** `x86_64-linux`
* **State Version:** 25.11

## 💻 Hardware: Lenovo ThinkPad E16 Gen 2

This system is specifically tuned for the **Intel Core Ultra** platform (Meteor Lake), utilizing the new Xe kernel driver for improved graphics performance.

| Component | Specification | Config Notes |
| :--- | :--- | :--- |
| **Model** | **Lenovo ThinkPad E16 Gen 2** | |
| **CPU** | **Intel Core Ultra 7 155H** | `auto-cpufreq` & `thermald` active |
| **GPU** | **Intel Arc Graphics** (Integrated) | `xe` driver forced via kernel params |
| **Audio** | PipeWire | PulseAudio/ALSA/Jack support |
| **Security** | Fingerprint Reader | `fprintd` enabled |
| **Thermal** | ThinkFan | Custom curves enabled |

## 🎨 Theming & Visuals

The system's look and feel are centrally managed by **Stylix**, ensuring a uniform appearance across the shell, window manager, and applications.

* **Theme Engine:** Stylix
* **Color Scheme:** **Verdigris** (Custom Base16 by YsfOuz)
* **Wallpaper:** `verdigris.png`
* **Polarity:** Dark
* **Cursor:** Bibata-Modern-Ice (24px)
* **Icons:** Papirus-Dark
* **Fonts:** Recursive (Sans, Serif) & RecMonoCasual Nerd Font
* **Opacity:** 0.5 (Applied to Desktop, Terminal, and Apps)

## 🖥️ Desktop Environment (Hyprland)

The window manager is **Hyprland**, customized for fluid animations and a blur-heavy aesthetic.

* **Bar:** **Waybar** with custom modules for workspaces, idle inhibition, and hardware stats.
* **Launcher:** **Rofi** (Left-aligned, transparent, icon-heavy).
* **Notifications:** **Dunst** (Rounded corners, 5s timeout).
* **Lock Screen:** **Hyprlock** with screenshot-based blurring.
* **Idle Daemon:** **Hypridle** (Locks at 10m, Screen off at 15m).
* **Night Light:** **Hyprsunset** (Warmth 5000k at 20:00).
* **Animations:** Custom "bouncy" Bézier curve configuration.

## 🛠️ Software Stack

### 🐚 Shell & Terminal
* **Shell:** **Fish** with `zoxide`, `fzf`, and `starship` prompt.
* **Terminal:** **Kitty** (Padding: 4px, Size: 960x600).
* **Fetch Utility:** **Fastfetch** with a custom structure displaying CPU P-Cores, GPU, and software breakdown.
* **File Manager:** **Yazi** (with Fish integration).

### 🦊 Browser (Firefox)
A hardened, privacy-focused Firefox configuration:
* **Privacy:** Strict content blocking, HTTPS-only mode, and disabled telemetry.
* **DNS:** DNS over HTTPS (Cloudflare).
* **UI:** **Vertical Tabs** enabled, Sidebar revamped, Bookmarks toolbar hidden.
* **Extensions:** uBlock Origin pre-installed.
* **Search:** DuckDuckGo forced default.

### 📝 Editor (NixVim)
A full IDE-like experience built with **NixVim**:
* **File Tree:** Neo-tree.
* **LSP:** Support for C/C++, Java, TS/JS, HTML/CSS, Nix, Python, and Rust.
* **Completion:** nvim-cmp with LSP, path, and buffer sources.
* **Formatting:** Conform-nvim (Prettier, Black, Alejandra, Clang-format).
* **Visuals:** Lualine, Rainbow Delimiters, Indent-blankline.

### 🎮 Gaming
* **Steam:** Enabled with firewall exceptions for Remote Play/Dedicated Server.
* **Tools:** Gamemode, Gamescope, and Proton-GE.
* **Launcher:** PrismLauncher (Minecraft).

## ⌨️ Keybindings

**Mod Key:** `SUPER`

| Key | Action |
| :--- | :--- |
| `Mod` + `Return` | Open Terminal (Kitty) |
| `Mod` + `Space` | Open App Launcher (Rofi) |
| `Mod` + `B` | Open Firefox |
| `Mod` + `E` | Open File Manager (Thunar) |
| `Mod` + `Q` | Kill Active Window |
| `Mod` + `T` | Toggle Floating |
| `Mod` + `F` | Fullscreen |
| `Mod` + `L` | Lock Screen |
| `Print` | Screenshot (Region) |
| `Mod` + `C` | Clipboard History (Cliphist/Rofi) |
| `Mod` + `N` | Notification History |

## 🚀 Installation

This config uses `nh` (Nix Helper) for management.

1.  **Clone the repository:**
    ```bash
    git clone <repository-url> /etc/nixos
    ```
2.  **Rebuild the system:**
    ```bash
    nh os switch
    ```
    *Note: The config keeps 3 generations and cleans older than 7 days.*
