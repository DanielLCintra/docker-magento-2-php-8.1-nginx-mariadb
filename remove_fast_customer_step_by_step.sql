-- Script passo a passo para remover atributos do Fast_Customer
-- Execute cada bloco separadamente para evitar erros

-- ========================================
-- ETAPA 1: VERIFICAR ATRIBUTOS EXISTENTES
-- ========================================
SELECT
    attribute_id,
    attribute_code,
    backend_type,
    is_required
FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;

-- ========================================
-- ETAPA 2: REMOVER DADOS - person_type (INT)
-- ========================================
-- Anote o attribute_id do person_type da query acima e substitua aqui
-- DELETE FROM customer_entity_int WHERE attribute_id = XXX;

-- ========================================
-- ETAPA 3: REMOVER DADOS - contact_name (VARCHAR)
-- ========================================
-- Anote o attribute_id do contact_name e substitua aqui
-- DELETE FROM customer_entity_varchar WHERE attribute_id = XXX;

-- ========================================
-- ETAPA 4: REMOVER DADOS - contact_email (VARCHAR)
-- ========================================
-- DELETE FROM customer_entity_varchar WHERE attribute_id = XXX;

-- ========================================
-- ETAPA 5: REMOVER DADOS - contact_phone (VARCHAR)
-- ========================================
-- DELETE FROM customer_entity_varchar WHERE attribute_id = XXX;

-- ========================================
-- ETAPA 6: REMOVER DADOS - state_registration (VARCHAR)
-- ========================================
-- DELETE FROM customer_entity_varchar WHERE attribute_id = XXX;

-- ========================================
-- ETAPA 7: REMOVER DADOS - municipal_registration (VARCHAR)
-- ========================================
-- DELETE FROM customer_entity_varchar WHERE attribute_id = XXX;

-- ========================================
-- ETAPA 8: REMOVER OPÇÕES DO person_type
-- ========================================
-- Anote o attribute_id do person_type
-- DELETE FROM eav_attribute_option_value WHERE option_id IN (SELECT option_id FROM eav_attribute_option WHERE attribute_id = XXX);
-- DELETE FROM eav_attribute_option WHERE attribute_id = XXX;

-- ========================================
-- ETAPA 9: REMOVER DOS FORMULÁRIOS
-- ========================================
-- DELETE FROM customer_form_attribute WHERE attribute_id IN (XXX, XXX, XXX, XXX, XXX, XXX);

-- ========================================
-- ETAPA 10: REMOVER LABELS
-- ========================================
-- DELETE FROM eav_attribute_label WHERE attribute_id IN (XXX, XXX, XXX, XXX, XXX, XXX);

-- ========================================
-- ETAPA 11: REMOVER DE customer_eav_attribute
-- ========================================
-- DELETE FROM customer_eav_attribute WHERE attribute_id IN (XXX, XXX, XXX, XXX, XXX, XXX);

-- ========================================
-- ETAPA 12: REMOVER ATRIBUTOS
-- ========================================
-- DELETE FROM eav_attribute WHERE attribute_id IN (XXX, XXX, XXX, XXX, XXX, XXX);

-- ========================================
-- ETAPA 13: VERIFICAR REMOÇÃO
-- ========================================
-- SELECT COUNT(*) FROM eav_attribute WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration') AND entity_type_id = 1;
