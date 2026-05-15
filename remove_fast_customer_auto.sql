-- Script automatizado para remover atributos do Fast_Customer
-- Compatível com MariaDB usando tabela temporária

-- Criar tabela temporária com os IDs dos atributos
CREATE TEMPORARY TABLE IF NOT EXISTS temp_attr_ids (attribute_id INT);

-- Inserir os IDs dos atributos a serem removidos
INSERT INTO temp_attr_ids
SELECT attribute_id
FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;

-- Mostrar quais atributos serão removidos
SELECT
    ea.attribute_id,
    ea.attribute_code,
    ea.backend_type,
    ea.is_required,
    'SERÁ REMOVIDO' as status
FROM eav_attribute ea
INNER JOIN temp_attr_ids tai ON ea.attribute_id = tai.attribute_id;

-- Criar tabela temporária para option_ids do person_type
CREATE TEMPORARY TABLE IF NOT EXISTS temp_option_ids (option_id INT);

INSERT INTO temp_option_ids
SELECT eao.option_id
FROM eav_attribute_option eao
INNER JOIN temp_attr_ids tai ON eao.attribute_id = tai.attribute_id;

-- REMOÇÃO DOS DADOS

-- 1. Remover de customer_entity_int
DELETE cei FROM customer_entity_int cei
INNER JOIN temp_attr_ids tai ON cei.attribute_id = tai.attribute_id;

-- 2. Remover de customer_entity_varchar
DELETE cev FROM customer_entity_varchar cev
INNER JOIN temp_attr_ids tai ON cev.attribute_id = tai.attribute_id;

-- 3. Remover de customer_entity_text
DELETE cet FROM customer_entity_text cet
INNER JOIN temp_attr_ids tai ON cet.attribute_id = tai.attribute_id;

-- 4. Remover de customer_entity_decimal
DELETE ced FROM customer_entity_decimal ced
INNER JOIN temp_attr_ids tai ON ced.attribute_id = tai.attribute_id;

-- 5. Remover opções (values)
DELETE eaov FROM eav_attribute_option_value eaov
INNER JOIN temp_option_ids toi ON eaov.option_id = toi.option_id;

-- 6. Remover opções
DELETE eao FROM eav_attribute_option eao
INNER JOIN temp_attr_ids tai ON eao.attribute_id = tai.attribute_id;

-- 7. Remover dos formulários
DELETE cfa FROM customer_form_attribute cfa
INNER JOIN temp_attr_ids tai ON cfa.attribute_id = tai.attribute_id;

-- 8. Remover labels
DELETE eal FROM eav_attribute_label eal
INNER JOIN temp_attr_ids tai ON eal.attribute_id = tai.attribute_id;

-- 9. Remover de customer_eav_attribute
DELETE cea FROM customer_eav_attribute cea
INNER JOIN temp_attr_ids tai ON cea.attribute_id = tai.attribute_id;

-- 10. Remover atributos
DELETE ea FROM eav_attribute ea
INNER JOIN temp_attr_ids tai ON ea.attribute_id = tai.attribute_id;

-- Limpar tabelas temporárias
DROP TEMPORARY TABLE IF EXISTS temp_attr_ids;
DROP TEMPORARY TABLE IF EXISTS temp_option_ids;

-- Verificação final
SELECT
    'VERIFICAÇÃO FINAL' as status,
    COUNT(*) as atributos_restantes,
    'Deve retornar 0' as esperado
FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;
