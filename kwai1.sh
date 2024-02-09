#!/bin/bash

# Autor do script
autor="Lucas Carvalho"

# Verifica se o Figlet está instalado, se não, instala automaticamente
if ! command -v figlet &> /dev/null; then
    echo "Instalando Figlet..."
    pkg install figlet -y
fi

# Função para enviar um e-mail com mensagem pré-definida
enviar_email() {
    destinatario="$1"
    assunto="$2"
    mensagem="$3"
    echo -e "$mensagem" | am start -a android.intent.action.SENDTO -d "mailto:$destinatario?subject=$assunto&body=$mensagem" 2>/dev/null
}

# Função para enviar uma mensagem para o WhatsApp do criador
enviar_mensagem_whatsapp() {
    mensagem="Gostei muito da sua ferramenta!"
    am start -a android.intent.action.VIEW -d "https://wa.me/14991124440?text=$mensagem" 2>/dev/null
}

# Função para denunciar um ID
denunciar_id() {
    clear
    echo -e "\e[1;34mOpção Denunciar ID\e[0m"
    echo "Digite o ID que deseja denunciar:"
    read id
    mensagem="ID: $id
    Este usuário foi denunciado por ser menor de idade. Por favor, bani-lo imediatamente, Kwai"
    enviar_email "customer-service@kwai.com" "Denúncia de Usuário" "$mensagem"
    echo "ID $id denunciado com sucesso."
}

# Função para desbanir um ID
desbanir_id() {
    clear
    echo -e "\e[1;32mOpção Desbanir ID\e[0m"
    echo "Digite o ID que deseja desbanir:"
    read id
    mensagem="ID: $id
    Este usuário foi denunciado injustamente. Por favor, traga a conta dele imediatamente, Kwai"
    enviar_email "customer-service@kwai.com" "Pedido de Desbanimento de Usuário" "$mensagem"
    echo "ID $id solicitado para desbanimento."
}

# Função para anotar um ID
anotar_id() {
    clear
    echo -e "\e[1;35mOpção Anotar ID\e[0m"
    echo "Digite o ID que deseja anotar:"
    read id
    echo "ID: $id" >> ids.txt
    echo "ID $id anotado com sucesso."
}

# Função para ver as anotações
ver_anotacoes() {
    clear
    echo -e "\e[1;36mOpção Ver Anotações\e[0m"
    echo "Anotações:"
    cat ids.txt
    read -p "Pressione Enter para continuar..."
}

# Função para excluir as anotações
excluir_anotacoes() {
    clear
    echo -e "\e[1;31mOpção Excluir Anotações\e[0m"
    echo -n "Tem certeza que deseja excluir todas as anotações? (s/n): "
    read confirmacao
    if [ "$confirmacao" = "s" ]; then
        > ids.txt
        echo "Anotações excluídas com sucesso."
    else
        echo "Operação cancelada."
    fi
    read -p "Pressione Enter para continuar..."
}

# Função para contar o total de denúncias
contar_denuncias() {
    clear
    echo -e "\e[1;33mOpção Total de Denúncias\e[0m"
    total=$(wc -l < opcoes_utilizadas.txt)
    echo "Total de denúncias feitas: $total"
    read -p "Pressione Enter para continuar..."
}

# Função para abrir o WhatsApp do criador e enviar mensagem
abrir_whatsapp() {
    clear
    echo -e "\e[1;31mOpção Criador\e[0m"
    echo "Abrindo WhatsApp do criador..."
    enviar_mensagem_whatsapp
}

# Função para exibir mensagem de saída personalizada
exibir_mensagem_saida() {
    clear
    echo -e "\e[1;35mVocê saiu da ferramenta poderosa de $autor\e[0m"
}

# Menu principal
while true; do
    clear
    echo -e "           \e[1;34m________\e[0m"
    echo -e "         \e[1;34m/         \ \e[0m"
    echo -e "       \e[1;34m/ ★           ★\ \e[0m"
    echo -e "     \e[1;34m/_________________\ \e[0m"
    echo -e "    \e[1;34m|\e[1;35m🚀\e[1;34m  M E N U  \e[1;35m🚀\e[1;34m   |\e[0m"
    echo -e "    \e[1;34m|-------------------|\e[0m"
    echo -e "    \e[1;34m| \e[1;35m1. Denunciar ID   \e[1;34m|\e[0m"
    echo -e "    \e[1;34m| \e[1;36m2. Desbanir ID    \e[1;34m|\e[0m"
    echo -e "    \e[1;34m| \e[1;32m3. Anotar ID      \e[1;34m|\e[0m"
    echo -e "    \e[1;34m| \e[1;33m4. Ver Anotações  \e[1;34m|\e[0m"
    echo -e "    \e[1;34m| \e[1;33m5. Excluir Anotações\e[1;34m|\e[0m"
    echo -e "    \e[1;34m| \e[1;34m6. Total de Denúncias\e[1;34m|\e[0m"
    echo -e "    \e[1;34m| \e[1;31m7. Criador        \e[1;34m|\e[0m"
    echo -e "    \e[1;34m| \e[1;34m8. Sair           \e[1;34m|\e[0m"
    echo -e "    \e[134m|___________________|\e[0m"
    echo -e "       \e[1;34m\ .:. .:. .:. /\e[0m"
    echo -e "         \e[1;34m\ .:. .:. /\e[0m"
    echo
    echo -e "\e[1;35mLucas Carvalho 2.0\e[0m"
    echo

    # Ler a entrada do usuário
    read -p "Selecione uma opção: " opcao

    # Executar a ação com base na opção selecionada
    case $opcao in
        1)  denunciar_id ;;
        2)  desbanir_id ;;
        3)  anotar_id ;;
        4)  ver_anotacoes ;;
        5)  excluir_anotacoes ;;
        6)  contar_denuncias ;;
        7)  abrir_whatsapp ;;
        8)  exibir_mensagem_saida; exit ;;
        *)  echo "Opção inválida. Por favor, selecione uma opção válida." ;;
    esac
done
