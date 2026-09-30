#!/usr/bin/env bash
# Luminosite - désinstallation
set -euo pipefail

PREFIX="${PREFIX:-/usr/local}"
TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"

[ "$(id -u)" -eq 0 ] || { echo "Lance ce script avec sudo." >&2; exit 1; }

rm -f "$PREFIX/bin/brightness"
rm -f "$PREFIX/bin/brightness-gui"
rm -f "$TARGET_HOME/.local/share/applications/luminosite.desktop"

echo "Luminosite désinstallé."
