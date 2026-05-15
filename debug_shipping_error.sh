#!/bin/bash

# Script para debugar o erro 500 no endpoint estimate-shipping-methods

echo "=== Iniciando monitoramento de logs ==="
echo "Por favor, faça a requisição do carrinho agora..."
echo ""

# Limpar logs anteriores
docker-compose exec -T phpfpm bash -c "echo '' > /var/www/html/var/log/exception.log"
docker-compose exec -T phpfpm bash -c "echo '' > /var/www/html/var/log/system.log"

# Monitorar logs em tempo real
docker-compose exec -T phpfpm tail -f /var/www/html/var/log/exception.log /var/www/html/var/log/system.log &

TAIL_PID=$!

echo "Aguardando por 30 segundos..."
echo "Faça a requisição no navegador AGORA!"
sleep 30

# Parar monitoramento
kill $TAIL_PID 2>/dev/null

echo ""
echo "=== Últimos erros capturados ==="
docker-compose exec -T phpfpm tail -n 50 /var/www/html/var/log/exception.log | grep -A 20 "CRITICAL\|ERROR" | tail -50

echo ""
echo "=== Verificando logs do PHP-FPM ==="
docker-compose logs --tail=20 phpfpm | grep -i "error\|fatal\|exception"

echo ""
echo "=== Verificando logs do Nginx ==="
docker-compose logs --tail=10 server | grep "500"
