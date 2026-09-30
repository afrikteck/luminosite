# Luminosité

Petit outil pour régler la **luminosité des écrans** sous Linux/X11, en
ajustement logiciel via `xrandr`. Utile quand le rétroéclairage matériel n'est
pas exposé (écrans externes HDMI/DisplayPort, station d'accueil, etc.).

Deux composants :

- **`brightness`** — ligne de commande
- **`brightness-gui`** — petite interface GTK3 (Python)

## Aperçu

L'interface propose :

- une jauge **« Les deux écrans »** qui règle tous les écrans connectés ensemble,
- une jauge **par écran** pour le réglage individuel,
- un bouton **« Défaut (90%) »** et un bouton **« Appliquer »**.

## Prérequis

- Linux/X11 avec `xrandr` (`x11-xserver-utils`)
- Python 3 + GTK 3 (`python3-gi`, `gir1.2-gtk-3.0`)

## Installation

```bash
git clone https://github.com/afrikteck/luminosite.git
cd luminosite
sudo ./install.sh
```

## Utilisation

Interface :

```bash
brightness-gui
```

Ligne de commande :

```bash
brightness 0.8            # les deux écrans à 80 %
brightness 0.7 HDMI-1     # un seul écran
brightness                # 80 % par défaut
```

La valeur va de `0.2` (sombre) à `1.0` (pleine luminosité).

## Autostart (optionnel)

Pour appliquer une luminosité à l'ouverture de session, copie l'exemple :

```bash
mkdir -p ~/.config/autostart
cp examples/luminosite.desktop ~/.config/autostart/
```

Puis adapte `Exec=` (par défaut `brightness 0.8`).

## Désinstallation

```bash
sudo ./uninstall.sh
```

## Notes

- Il s'agit d'un **assombrissement logiciel** : l'image est atténuée, le
  rétroéclairage physique reste allumé.
- Les noms d'écrans (`HDMI-1`, `DP-3`…) dépendent de la machine ; utilise
  `xrandr --current` pour les lister.

## Licence

MIT — voir [LICENSE](LICENSE).

## Auteur

AfriTeck
