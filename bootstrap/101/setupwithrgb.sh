#!/bin/bash

# Função para exibir a barra de progresso com gradiente colorido
show_progress() {
  local current=$1
  local total=$2
  local width=50
  local progress=$((current * width / total))
  local empty=$((width - progress))

  local colors=(31 33 32 36 34 35) # Cores em sequência para gradiente
  local gradient=""
  
  for i in $(seq 0 $((progress - 1))); do
    color=${colors[$((i % ${#colors[@]}))]}
    gradient+="\e[1;${color}m#\e[0m"
  done

  printf "\r["
  printf "%b" "$gradient"
  printf "%0.s-" $(seq 1 $empty)
  printf "] %d/%d" "$current" "$total"
}

# Lista de etapas (número total)
STEPS=12 # Atualize conforme o número de etapas no script
STEP=0

# Atualizar o sistema
STEP=$((STEP + 1))
show_progress $STEP $STEPS
sudo apt update && sudo apt upgrade -y

# Instalar pacotes essenciais para desenvolvimento com Arduino e web
STEP=$((STEP + 1))
show_progress $STEP $STEPS
sudo apt install -y arduino arduino-mk arduino-core git curl build-essential \
                    gnome-tweaks gnome-shell-extension-dash-to-panel \
                    libssl-dev nodejs npm python3 python3-pip python3-venv

# Instalar VS Code
STEP=$((STEP + 1))
show_progress $STEP $STEPS
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
rm -f packages.microsoft.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install -y code

# Configurar barra de ferramentas na parte inferior
STEP=$((STEP + 1))
show_progress $STEP $STEPS
gnome-extensions enable dash-to-panel@jderose9.github.com
gsettings set org.gnome.shell.extensions.dash-to-panel position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 36

# Adicionar suporte a Flatpak
STEP=$((STEP + 1))
show_progress $STEP $STEPS
sudo apt install -y flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Adicionar suporte a codecs proprietários
STEP=$((STEP + 1))
show_progress $STEP $STEPS
sudo apt install -y ubuntu-restricted-extras libavcodec-extra libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg

# Instalar aplicativos
STEP=$((STEP + 1))
show_progress $STEP $STEPS
APPS_APT=("darktable" "solaar" "retroarch" "rawtherapee" "gcolor3")
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

# Configurar transparência nas janelas
STEP=$((STEP + 1))
show_progress $STEP $STEPS
EXTENSION_URL="https://extensions.gnome.org/extension-data/blur-my-shellaunetx.v41.shell-extension.zip"
TEMP_DIR=$(mktemp -d)
wget -O "$TEMP_DIR/blur.zip" "$EXTENSION_URL"
gnome-extensions install "$TEMP_DIR/blur.zip"
gnome-extensions enable blur-my-shell@aunetx
rm -r "$TEMP_DIR"

# Configurar Google Drive no GNOME
STEP=$((STEP + 1))
show_progress $STEP $STEPS
sudo apt install -y gnome-online-accounts

# Configurações finais
STEP=$((STEP + 1))
show_progress $STEP $STEPS
sudo apt autoremove -y
sudo apt clean

# Concluir
echo -e "\nConfiguração inicial concluída!"
