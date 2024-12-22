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

# Configurar Flatpak e corrigir XDG_DATA_DIRS
STEP=$((STEP + 1))
if ! step_completed "flatpak_config"; then
  show_progress $STEP $STEPS
  sudo apt install -y flatpak gnome-software-plugin-flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  if ! grep -q "/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share" <<< "$XDG_DATA_DIRS"; then
    echo "export XDG_DATA_DIRS=\$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share" >> ~/.profile
    source ~/.profile
  fi
  mark_step_done "flatpak_config"
fi

# Instalar pacotes essenciais
STEP=$((STEP + 1))
if ! step_completed "essential_packages"; then
  show_progress $STEP $STEPS
  sudo apt update && sudo apt install -y arduino arduino-mk arduino-core git curl build-essential \
                      gnome-tweaks gnome-shell-extension-dash-to-panel \
                      libssl-dev nodejs npm python3 python3-pip python3-venv
  mark_step_done "essential_packages"
fi

# Configurar barra de ferramentas na parte inferior
STEP=$((STEP + 1))
if ! step_completed "bottom_toolbar"; then
  show_progress $STEP $STEPS
  gnome-extensions enable dash-to-panel@jderose9.github.com
  gsettings set org.gnome.shell.extensions.dash-to-panel position 'BOTTOM'
  gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 36
  mark_step_done "bottom_toolbar"
fi

# Instalar aplicativos via apt e Flatpak
STEP=$((STEP + 1))
if ! step_completed "install_
