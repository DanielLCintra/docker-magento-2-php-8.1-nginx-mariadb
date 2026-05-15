-- Script direto para remover atributos do Fast_Customer
-- Versão otimizada para MariaDB sem tabelas temporárias

-- ETAPA 1: Verificar quais atributos existem
SELECT
    attribute_id,
    attribute_code,
    backend_type,
    is_required,
    'ANTES DA REMOÇÃO' as status
FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;

-- ETAPA 2: Remover de customer_entity_int (person_type)
DELETE cei FROM customer_entity_int cei
WHERE cei.attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
    AND entity_type_id = 1
);

-- ETAPA 3: Remover de customer_entity_varchar
DELETE cev FROM customer_entity_varchar cev
WHERE cev.attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
    AND entity_type_id = 1
);

-- ETAPA 4: Remover de customer_entity_text
DELETE cet FROM customer_entity_text cet
WHERE cet.attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
    AND entity_type_id = 1
);

-- ETAPA 5: Remover de customer_entity_decimal
DELETE ced FROM customer_entity_decimal ced
WHERE ced.attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
    AND entity_type_id = 1
);

-- ETAPA 6: Remover valores das opções
DELETE eaov FROM eav_attribute_option_value eaov
WHERE eaov.option_id IN (
    SELECT eao.option_id FROM eav_attribute_option eao
    WHERE eao.attribute_id IN (
        SELECT attribute_id FROM eav_attribute
        WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
        AND entity_type_id = 1
    )
);

-- ETAPA 7: Remover opções
DELETE eao FROM eav_attribute_option eao
WHERE eao.attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
    AND entity_type_id = 1
);

-- ETAPA 8: Remover dos formulários
DELETE cfa FROM customer_form_attribute cfa
WHERE cfa.attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
    AND entity_type_id = 1
);

-- ETAPA 9: Remover labels
DELETE eal FROM eav_attribute_label eal
WHERE eal.attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
    AND entity_type_id = 1
);

-- ETAPA 10: Remover de customer_eav_attribute
DELETE cea FROM customer_eav_attribute cea
WHERE cea.attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN ('person_type', 'contact_name', 'contact_email', 'contact_phone', 'state_registration', 'municipal_registration')
    AND entity_type_id = 1
);

-- ETAPA 11: Remover os atributos da tabela principal
DELETE FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;

-- ETAPA 12: Verificação final
SELECT
    'APÓS REMOÇÃO' as status,
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
