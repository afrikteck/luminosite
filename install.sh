#!/usr/bin/env bash
# Luminosite - installation (Debian/Ubuntu)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PREFIX="${PREFIX:-/usr/local}"
TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"

log() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
die() { printf '\033[1;31mErreur:\033[0m %s\n' "$*" >&2; exit 1; }

[ "$(id -u)" -eq 0 ] || die "Lance ce script avec sudo."
command -v apt-get >/dev/null || die "Ce script cible Debian/Ubuntu."

log "Installation des dépendances (xrandr, GTK)"
apt-get update -qq
apt-get install -y --no-install-recommends \
    x11-xserver-utils python3-gi gir1.2-gtk-3.0

log "Installation des commandes dans $PREFIX/bin"
install -Dm755 "$REPO_DIR/bin/brightness" "$PREFIX/bin/brightness"
install -Dm755 "$REPO_DIR/bin/brightness-gui" "$PREFIX/bin/brightness-gui"

log "Création du raccourci applicatif pour $TARGET_USER"
app_dir="$TARGET_HOME/.local/share/applications"
install -d -o "$TARGET_USER" -g "$TARGET_USER" "$app_dir"
cat > "$app_dir/luminosite.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=Luminosité
Comment=Régler la luminosité des écrans (xrandr)
Exec=brightness-gui
Icon=video-display
Terminal=false
Categories=Settings;HardwareSettings;
EOF
chown "$TARGET_USER":"$TARGET_USER" "$app_dir/luminosite.desktop"

log "Terminé."
log "Interface : lance « Luminosité » depuis le menu, ou la commande brightness-gui."
log "Ligne de commande : brightness 0.8   (ou  brightness 0.7 HDMI-1)"
log "Autostart (optionnel) : copie examples/luminosite.desktop dans ~/.config/autostart/"
