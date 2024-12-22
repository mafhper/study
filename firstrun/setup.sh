#!/bin/bash

# Função para exibir barra de progresso com gradiente colorido
show_progress() {
  local current=$1
  local total=$2
  local width=50
  local progress=$((current * width / total))
  local empty=$((width - progress))

  local colors=(31 33 32 36 34 35)
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

# Exibir separador bonito
show_separator() {
  echo -e "\n\e[1;34m=============================================================\e[0m"
}

# Lista de etapas
STEPS=12
STEP=0

# Verifica se uma etapa já foi concluída
step_completed() {
  local step_name=$1
  [ -f "$HOME/.config_setup_done/$step_name" ]
}

# Marca uma etapa como concluída
mark_step_done() {
  local step_name=$1
  mkdir -p "$HOME/.config_setup_done"
  touch "$HOME/.config_setup_done/$step_name"
}

# Início do script
echo -e "\n\e[1;32mConfiguração inicial do sistema Ubuntu 24.04.1 LTS\e[0m"
show_separator

# Configurar Flatpak e corrigir XDG_DATA_DIRS
STEP=$((STEP + 1))
if ! step_completed "flatpak_config"; then
  show_progress $STEP $STEPS
  echo -e "\n\e[1;33m[Etapa $STEP/$STEPS] Configurando Flatpak...\e[0m"
  sudo apt install -y flatpak gnome-software-plugin-flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  if ! grep -q "/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share" <<< "$XDG_DATA_DIRS"; then
    echo "export XDG_DATA_DIRS=\$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share" >> ~/.profile
    source ~/.profile
  fi
  mark_step_done "flatpak_config"
fi
show_separator

# Instalar pacotes essenciais
STEP=$((STEP + 1))
if ! step_completed "essential_packages"; then
  show_progress $STEP $STEPS
  echo -e "\n\e[1;33m[Etapa $STEP/$STEPS] Instalando pacotes essenciais...\e[0m"
  sudo apt update && sudo apt install -y arduino arduino-mk arduino-core git curl build-essential \
                      gnome-tweaks gnome-shell-extension-dash-to-panel \
                      libssl-dev nodejs npm python3 python3-pip python3-venv
  mark_step_done "essential_packages"
fi
show_separator

# Configurar barra de ferramentas na parte inferior
STEP=$((STEP + 1))
if ! step_completed "bottom_toolbar"; then
  show_progress $STEP $STEPS
  echo -e "\n\e[1;33m[Etapa $STEP/$STEPS] Configurando barra de ferramentas...\e[0m"
  gnome-extensions enable dash-to-panel@jderose9.github.com
  gsettings set org.gnome.shell.extensions.dash-to-panel position 'BOTTOM'
  gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 36
  mark_step_done "bottom_toolbar"
fi
show_separator

# Instalar aplicativos via apt e Flatpak
STEP=$((STEP + 1))
if ! step_completed "install_apps"; then
  show_progress $STEP $STEPS
  echo -e "\n\e[1;33m[Etapa $STEP/$STEPS] Instalando aplicativos...\e[0m"

  # Atualizar ou instalar pacotes via apt
  APPS_APT=("darktable" "solaar" "retroarch" "rawtherapee" "gcolor3")
  for app in "${APPS_APT[@]}"; do
    if dpkg -l | grep -q "^ii  $app"; then
      echo -e "\e[1;34m- Atualizando $app...\e[0m"
      sudo apt install --only-upgrade -y "$app"
    else
      echo -e "\e[1;34m- Instalando $app...\e[0m"
      sudo apt install -y "$app"
    fi
  done

  # Atualizar ou instalar pacotes via Flatpak
  APPS_FLATPAK=(
    "com.github.tchx84.Rnote" "com.github.rafostar.Gapless" "io.github.tchx84.Flatseal"
    "com.github.unrud.VideoDownloader" "de.haeckerfelix.Podcasts" "org.gnome.Contrast"
    "io.gitlab.zehkira.tuba" "io.gitlab.cubic-print.Colorway" "net.shakthi.solaar"
    "com.github.alainm23.tdesktop.Sly" "io.gitlab.zehkira.Zen" "org.gnome.Fragments"
    "org.openrgb.OpenRGB" "com.github.hugolabe.impressao" "app.fotema.Fotema"
  )
  for app in "${APPS_FLATPAK[@]}"; do
    if flatpak list | grep -q "$app"; then
      echo -e "\e[1;34m- Atualizando $app...\e[0m"
      flatpak update -y "$app"
    else
      echo -e "\e[1;34m- Instalando $app...\e[0m"
      flatpak install -y flathub "$app"
    fi
  done

  mark_step_done "install_apps"
fi
show_separator

# Configurar Google Drive no GNOME
STEP=$((STEP + 1))
if ! step_completed "google_drive"; then
  show_progress $STEP $STEPS
  echo -e "\n\e[1;33m[Etapa $STEP/$STEPS] Configurando Google Drive...\e[0m"
  sudo apt install -y gnome-online-accounts
  mark_step_done "google_drive"
fi
show_separator

# Perguntar sobre reiniciar o sistema
echo -e "\n\e[1;32mConfiguração inicial concluída!\e[0m"
while true; do
  read -p "Deseja reiniciar o sistema agora? (SIM/NÃO): " choice
  case "$choice" in
    [Ss][Ii][Mm]) sudo reboot; break ;;
    [Nn][Ãã][Oo]) echo "Reinicie manualmente para aplicar todas as mudanças."; break ;;
    *) echo -e "\e[1;31mPor favor, digite SIM ou NÃO.\e[0m" ;;
  esac
done
