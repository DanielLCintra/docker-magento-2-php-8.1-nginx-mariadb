#!/bin/bash

# Script para testar a API de estimate-shipping-methods diretamente

echo "=== Teste da API de Estimate Shipping Methods ==="
echo ""

# Primeiro, vamos obter o token do cliente
echo "1. Obtendo token de cliente..."

# Substitua com suas credenciais de teste
CUSTOMER_EMAIL="seu-email@exemplo.com"
CUSTOMER_PASSWORD="sua-senha"

# Ou use guest cart token
echo "2. Criando carrinho guest..."
GUEST_CART_ID=$(docker-compose exec -T phpfpm curl -X POST "http://magento.local/rest/default/V1/guest-carts" 2>/dev/null | jq -r '.')

echo "Guest Cart ID: $GUEST_CART_ID"
echo ""

# Adicionar produto ao carrinho
echo "3. Testando endpoint estimate-shipping-methods..."
echo ""

# Teste com CEP
RESPONSE=$(docker-compose exec -T phpfpm curl -X POST \
  "http://magento.local/rest/default/V1/carts/mine/estimate-shipping-methods" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SEU_TOKEN_AQUI" \
  -d '{
    "address": {
      "region": "MG",
      "region_id": 0,
      "country_id": "BR",
      "street": ["Rua Teste"],
      "postcode": "30720-030",
      "city": "Belo Horizonte",
      "firstname": "Test",
      "lastname": "User",
      "email": "test@example.com",
      "telephone": "31999999999"
    }
  }' \
  -w "\n\nHTTP Status: %{http_code}\n" \
  2>/dev/null)

echo "$RESPONSE"
