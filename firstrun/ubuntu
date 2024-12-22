#!/bin/bash

# Atualizar o sistema
sudo apt update && sudo apt upgrade -y

# Instalar pacotes essenciais para desenvolvimento com Arduino e web
sudo apt install -y arduino arduino-mk arduino-core git curl build-essential \
                    gnome-tweaks gnome-shell-extension-dash-to-panel \
                    libssl-dev nodejs npm python3 python3-pip python3-venv

# Instalar VS Code (via repositório oficial da Microsoft)
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
rm -f packages.microsoft.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code

# Configurar barra de ferramentas na parte inferior (com tamanho médio)
gnome-extensions enable dash-to-panel@jderose9.github.com
gsettings set org.gnome.shell.extensions.dash-to-panel position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 36

# Adicionar suporte a Flatpak
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Adicionar suporte a codecs proprietários
sudo apt install -y ubuntu-restricted-extras libavcodec-extra libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg

# Instalar aplicativos
APPS_APT=(
  "darktable" "solaar" "retroarch" "rawtherapee" "gcolor3"
)
sudo apt install -y "${APPS_APT[@]}"

APPS_FLATPAK=(
  "com.github.johnfactotum.Fotema" "com.makemkv.MakeMKV" "com.boxy_svg.BoxySVG"
  "com.github.tchx84.Rnote" "com.github.rafostar.Gapless" "io.github.tchx84.Flatseal"
  "com.github.unrud.VideoDownloader" "de.haeckerfelix.Podcasts" "org.gnome.Contrast"
  "io.gitlab.zehkira.tuba" "io.gitlab.cubic-print.Colorway" "net.shakthi.solaar"
  "com.github.alainm23.tdesktop.Sly" "io.gitlab.zehkira.Zen" "org.gnome.Fragments"
  "org.openrgb.OpenRGB" "com.github.hugolabe.impressao"
)
flatpak install -y flathub "${APPS_FLATPAK[@]}"

# Melhorar a aparência do terminal
PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${PROFILE}/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${PROFILE}/ background-transparency-percent 10
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${PROFILE}/ palette "['#073642', '#dc322f', '#859900', '#b58900', '#268bd2', '#d33682', '#2aa198', '#eee8d5']"

# Configurar transparência nas janelas (Área de arquivos)
EXTENSION_URL="https://extensions.gnome.org/extension-data/blur-my-shellaunetx.v41.shell-extension.zip"
TEMP_DIR=$(mktemp -d)
wget -O "$TEMP_DIR/blur.zip" "$EXTENSION_URL"
gnome-extensions install "$TEMP_DIR/blur.zip"
gnome-extensions enable blur-my-shell@aunetx
rm -r "$TEMP_DIR"

gsettings set org.gnome.shell.extensions.blur-my-shell strength 10
gsettings set org.gnome.shell.extensions.blur-my-shell brightness -0.2

# Configurar Nautilus (Gerenciador de arquivos)
gsettings set org.gnome.nautilus.preferences always-use-location-entry true # Mostrar caminho completo
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences show-hidden-files true
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
gsettings set org.gnome.nautilus.preferences show-directory-item-counts 'always'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' # Ativar tema escuro

# Configurar Google Drive no GNOME
sudo apt install -y gnome-online-accounts
echo "Abra 'Configurações' -> 'Contas Online' para conectar ao Google Drive."

# Configurações finais
sudo apt autoremove -y
sudo apt clean

echo "Configuração inicial concluída! Reinicie o sistema para aplicar todas as mudanças."
