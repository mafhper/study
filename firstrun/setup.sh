#!/bin/bash

# Função para exibir separador visual
show_separator() {
  echo -e "\n\e[1;35m=============================================================\e[0m"
}

# Função para exibir barra de progresso simples
show_progress() {
  local current=$1
  local total=$2
  local width=50
  local progress=$((current * width / total))
  local empty=$((width - progress))

  printf "\r\e[1;36m["
  printf "%0.s#" $(seq 1 $progress)
  printf "%0.s-" $(seq 1 $empty)
  printf "] %d/%d\e[0m" "$current" "$total"
}

# Funções de mensagens coloridas
message_success() {
  echo -e "\e[1;32m✅ $1\e[0m"
}

message_warning() {
  echo -e "\e[1;33m⚠️ $1\e[0m"
}

message_error() {
  echo -e "\e[1;31m❌ $1\e[0m"
}

message_info() {
  echo -e "\e[1;34mℹ️ $1\e[0m"
}

# Etapas do script
STEPS=5
STEP=0

message_info "⚙️ Configuração e atualização do sistema em andamento"
show_separator

# Etapa 1: Atualizar listas de pacotes
STEP=$((STEP + 1))
show_progress $STEP $STEPS
message_warning "[Etapa $STEP/$STEPS] Atualizando listas de pacotes..."
sudo apt update && message_success "Listas de pacotes atualizadas com sucesso!" || message_error "Erro ao atualizar listas de pacotes."
show_separator

# Etapa 2: Atualizar pacotes instalados
STEP=$((STEP + 1))
show_progress $STEP $STEPS
message_warning "[Etapa $STEP/$STEPS] Atualizando pacotes instalados..."
sudo apt upgrade -y && message_success "Pacotes instalados atualizados com sucesso!" || message_error "Erro ao atualizar pacotes instalados."
show_separator

# Etapa 3: Limpar pacotes desnecessários
STEP=$((STEP + 1))
show_progress $STEP $STEPS
message_warning "[Etapa $STEP/$STEPS] Removendo pacotes desnecessários..."
sudo apt autoremove -y && message_success "Pacotes desnecessários removidos com sucesso!" || message_error "Erro ao remover pacotes desnecessários."
show_separator

# Etapa 4: Configurar GitHub como ferramenta padrão de Git
STEP=$((STEP + 1))
show_progress $STEP $STEPS
message_warning "[Etapa $STEP/$STEPS] Configurando GitHub como ferramenta padrão..."

# Verifica se o Git está instalado
if ! command -v git &> /dev/null; then
  message_warning "Git não encontrado. Instalando o Git..."
  sudo apt install git -y && message_success "Git instalado com sucesso!" || { message_error "Erro ao instalar o Git."; show_separator; exit 1; }
fi

# Configura o GitHub no Git
git config --global user.name "SeuNomeAqui" && \
git config --global user.email "SeuEmailAqui" && \
message_success "GitHub configurado como ferramenta padrão!" || message_error "Erro ao configurar o GitHub."
show_separator

# Etapa 5: Configurar terminal
STEP=$((STEP + 1))
show_progress $STEP $STEPS
message_warning "[Etapa $STEP/$STEPS] Configurando o terminal..."

# Identifica o ID do perfil padrão
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
PROFILE_PATH="/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

# Configura o fundo transparente
dconf write ${PROFILE_PATH}use-transparent-background true
dconf write ${PROFILE_PATH}background-transparency-percent 15

# Ativa cores diferenciadas e desativa o uso de temas do sistema
dconf write ${PROFILE_PATH}use-theme-colors false
dconf write ${PROFILE_PATH}foreground-color "'#FFFFFF'"
dconf write ${PROFILE_PATH}background-color "'#000000'"
dconf write ${PROFILE_PATH}cursor-colors-set true
dconf write ${PROFILE_PATH}cursor-background-color "'#FFFFFF'"
dconf write ${PROFILE_PATH}cursor-foreground-color "'#000000'"

message_success "Terminal configurado com fundo transparente e cores aprimoradas!"
show_separator

# Link para o terminal pelo console
echo -e "\n\e[1;36m💻 Acesse o terminal com o comando: \e[1;32mgnome-terminal\e[0m"
show_separator

# Perguntar sobre reinicialização
message_info "✨ Configuração e atualização concluídas!"
while true; do
  read -p $'\e[1;36mDeseja reiniciar o sistema agora? (SIM/NÃO): \e[0m' choice
  case "$choice" in
    [Ss][Ii][Mm]) 
      message_success "Reiniciando o sistema..."
      sudo reboot
      break
      ;;
    [Nn][Ãã][Oo]) 
      message_info "Reinicie o sistema manualmente quando desejar."
      break
      ;;
    *) 
      message_error "Por favor, digite SIM ou NÃO."
      ;;
  esac
done
