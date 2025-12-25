# ❄️ NixOS Dotfiles

My personal declarative NixOS configuration, built with **Flakes** and **Home Manager**.

![NixOS](https://img.shields.io/badge/NixOS-Unstable-blue.svg?style=for-the-badge&logo=nixos&logoColor=white)
![GNOME](https://img.shields.io/badge/GNOME-Wayland-46a2f9.svg?style=for-the-badge&logo=gnome&logoColor=white)
![Stylix](https://img.shields.io/badge/Stylix-Verdigris-purple.svg?style=for-the-badge)

## 💻 System Details

| Component | Description |
| :--- | :--- |
| **Hardware** | Lenovo ThinkPad E14 Gen 6 (Intel Core Ultra / Arc Graphics) |
| **OS** | NixOS Unstable |
| **Desktop** | GNOME (Wayland) |
| **Shell** | Fish + Starship |
| **Editor** | NixVim (NeoVim) |
| **Browser** | Firefox (Hardened + Vertical Tabs) |

## ✨ Highlights

### 🎨 Aesthetics (Stylix)
* **Theme:** Uniform "Verdigris" color scheme (Dark).
* **Font Stack:** FiraCode Nerd Font (Mono) & NotoSans Nerd Font (UI).
* **Cursor:** Bibata Modern Ice.
* **Extras:**
    * **Spicetify:** Themed Spotify client.
    * **Firefox:** Custom GNOME theme integration.

### 🛠️ Development (NixVim)
A full IDE experience powered by `nixvim`:
* **LSP:** Pre-configured for Java (`jdtls`), C++, Rust, and Web Dev.
* **Tools:** `neo-tree` file explorer, `toggleterm`, and `telescope` fuzzy finder.
* **Syntax:** Treesitter highlighting enabled for major languages.

### 🎮 Gaming & AI
* **Gaming:** Steam bundled with `gamescope` and `gamemode` for performance.
* **Local AI:** `ollama` and `open-webui` running via Podman containers.
* **Virtualization:** Podman with Docker compatibility enabled.

## ⌨️ Workflow & Keybindings

I use custom keybindings to mimic a tiling window manager workflow on GNOME:

| Key | Action |
| :--- | :--- |
| `Super` + `Return` | Launch Terminal |
| `Super` + `Q` | Close Window |
| `Super` + `E` | File Manager (Nautilus) |
| `Super` + `B` | Web Browser (Firefox) |
| `Super` + `Space` | App Launcher (ArcMenu) |

## 📂 Structure

* `flake.nix` - Entry point and dependencies.
* `configuration.nix` - System-level settings (Boot, Hardware, Network).
* `user.nix` - User profile, shell configuration, and virtualization.
* `home.nix` - Home Manager packages and dotfile management.
* `gnome.nix` - Desktop environment settings and keybindings.
* `nixvim.nix` - Modular NeoVim configuration.
* `stylix.nix` - System-wide theming engine.

## 🚀 Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/YsfOuz/nixos-config.git](https://github.com/YsfOuz/nixos-config.git)
    cd nixos-config
    ```

2.  **Apply configuration:**
    ```bash
    # Rebuild system
    sudo nixos-rebuild switch --flake .#nixos
    ```
