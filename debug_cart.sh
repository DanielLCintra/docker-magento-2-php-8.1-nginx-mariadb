#!/bin/bash

echo "=== MONITOR DE DEBUG DO CARRINHO ==="
echo "Arquivo de log: /var/log/customer_admin_cart_debug.log"
echo "Pressione Ctrl+C para parar o monitoramento"
echo "====================================="
echo ""

# Verifica se o arquivo existe
if [ ! -f "/var/log/customer_admin_cart_debug.log" ]; then
    echo "Arquivo de log não encontrado. Criando..."
    touch /var/log/customer_admin_cart_debug.log
    chmod 666 /var/log/customer_admin_cart_debug.log
fi

# Monitora o arquivo em tempo real
tail -f /var/log/customer_admin_cart_debug.log



























































