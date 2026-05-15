# Solução para Conflito de Atributos de Cliente

## Problema Identificado

Você está tendo conflito entre dois módulos que criam atributos de cliente:

1. **Fast_Customer** - Criou atributos obrigatórios:
   - `person_type` (select com valores 0 e 1)
   - `contact_name` (obrigatório)
   - `contact_email` (obrigatório)
   - `contact_phone` (obrigatório)

2. **SystemCode_BrazilCustomerAttributes** - Cria atributos brasileiros:
   - `cpf`, `cnpj`, `rg`, `ie`, `socialname`, `tradename`
   - Usa `person_type` como string ("cpf" ou "cnpj")

## Erros Encontrados

- "CPF" é um valor necessário
- "CNPJ" é um valor necessário  
- "Contact Phone" é um valor necessário
- "Nome do contato" é um valor necessário
- "Contact Email" é um valor necessário
- Attribute person_type does not contain option with Id cpf

## Solução

### Opção 1: Executar Script SQL (Recomendado - Mais Rápido)

Execute o script que torna os atributos do Fast_Customer opcionais:

```bash
bin/fix-fast-customer-attributes
```

Este script:
- Torna `person_type`, `contact_name`, `contact_email` e `contact_phone` não obrigatórios
- Remove esses atributos dos formulários frontend (mantém apenas no admin)
- Limpa o cache automaticamente

### Opção 2: Usar Patch do Módulo

O patch `MakeAttributesOptional.php` foi criado e será executado automaticamente quando você rodar:

```bash
bin/clinotty bin/magento setup:upgrade
bin/clinotty bin/magento cache:flush
```

### Opção 3: Desabilitar Fast_Customer Temporariamente

Se você não precisa dos atributos do Fast_Customer, pode desabilitar o módulo:

```bash
bin/clinotty bin/magento module:disable Fast_Customer
bin/clinotty bin/magento setup:upgrade
bin/clinotty bin/magento cache:flush
```

## Recomendação

**Use a Opção 1** (script SQL) porque:
- ✅ É mais rápido
- ✅ Resolve o problema imediatamente
- ✅ Mantém os atributos disponíveis no admin (caso precise)
- ✅ Remove dos formulários frontend (evita conflito)

## Após Executar a Solução

1. Limpe o cache:
   ```bash
   bin/clinotty bin/magento cache:flush
   ```

2. Teste o cadastro de cliente no frontend

3. Verifique se os campos do BrazilCustomerAttributes aparecem corretamente

## Nota sobre person_type

O erro "Attribute person_type does not contain option with Id cpf" ocorre porque:
- Fast_Customer criou `person_type` como select com opções 0 e 1
- BrazilCustomerAttributes espera `person_type` como string ("cpf" ou "cnpj")

Ao tornar o atributo `person_type` do Fast_Customer não obrigatório e removê-lo dos formulários frontend, o BrazilCustomerAttributes poderá usar seu próprio sistema de person_type sem conflito.


