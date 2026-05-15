-- Script PRONTO para remover atributos do Fast_Customer
-- IDs identificados:
-- person_type = 188 (int)
-- contact_name = 189 (varchar)
-- contact_email = 190 (varchar)
-- contact_phone = 187 (varchar)
-- state_registration = 191 (varchar)
-- municipal_registration = 192 (varchar)

-- ========================================
-- EXECUTE CADA BLOCO SEQUENCIALMENTE
-- ========================================

-- BLOCO 1: Remover dados de customer_entity_int (person_type)
DELETE FROM customer_entity_int WHERE attribute_id = 188;

-- BLOCO 2: Remover dados de customer_entity_varchar (os outros 5 atributos)
DELETE FROM customer_entity_varchar WHERE attribute_id IN (187, 189, 190, 191, 192);

-- BLOCO 3: Remover opções do person_type (valores)
DELETE eaov FROM eav_attribute_option_value eaov
INNER JOIN eav_attribute_option eao ON eaov.option_id = eao.option_id
WHERE eao.attribute_id = 188;

-- BLOCO 4: Remover opções do person_type
DELETE FROM eav_attribute_option WHERE attribute_id = 188;

-- BLOCO 5: Remover dos formulários
DELETE FROM customer_form_attribute WHERE attribute_id IN (187, 188, 189, 190, 191, 192);

-- BLOCO 6: Remover labels
DELETE FROM eav_attribute_label WHERE attribute_id IN (187, 188, 189, 190, 191, 192);

-- BLOCO 7: Remover de customer_eav_attribute
DELETE FROM customer_eav_attribute WHERE attribute_id IN (187, 188, 189, 190, 191, 192);

-- BLOCO 8: Remover de customer_entity_text (caso existam)
DELETE FROM customer_entity_text WHERE attribute_id IN (187, 188, 189, 190, 191, 192);

-- BLOCO 9: Remover de customer_entity_decimal (caso existam)
DELETE FROM customer_entity_decimal WHERE attribute_id IN (187, 188, 189, 190, 191, 192);

-- BLOCO 10: REMOÇÃO FINAL - Deletar os atributos
DELETE FROM eav_attribute WHERE attribute_id IN (187, 188, 189, 190, 191, 192);

-- ========================================
-- VERIFICAÇÃO FINAL (deve retornar 0)
-- ========================================
SELECT COUNT(*) as atributos_restantes
FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;
