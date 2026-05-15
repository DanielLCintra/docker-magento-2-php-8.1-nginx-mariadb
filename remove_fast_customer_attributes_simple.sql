-- Script para remover todos os atributos do Fast_Customer do banco de dados
-- Versão sem variáveis para compatibilidade com MariaDB
-- Atributos a remover: person_type, contact_name, contact_email, contact_phone, state_registration, municipal_registration

-- PASSO 1: Verificar quais atributos existem
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

-- PASSO 2: Remover valores dos atributos de customer_entity_int (person_type)
DELETE FROM customer_entity_int
WHERE attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code = 'person_type' AND entity_type_id = 1
);

-- PASSO 3: Remover valores dos atributos de customer_entity_varchar
DELETE FROM customer_entity_varchar
WHERE attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN (
        'contact_name',
        'contact_email',
        'contact_phone',
        'state_registration',
        'municipal_registration'
    ) AND entity_type_id = 1
);

-- PASSO 4: Remover valores de customer_entity_text (caso existam)
DELETE FROM customer_entity_text
WHERE attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN (
        'person_type',
        'contact_name',
        'contact_email',
        'contact_phone',
        'state_registration',
        'municipal_registration'
    ) AND entity_type_id = 1
);

-- PASSO 5: Remover valores de customer_entity_decimal (caso existam)
DELETE FROM customer_entity_decimal
WHERE attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN (
        'person_type',
        'contact_name',
        'contact_email',
        'contact_phone',
        'state_registration',
        'municipal_registration'
    ) AND entity_type_id = 1
);

-- PASSO 6: Remover opções do person_type
DELETE FROM eav_attribute_option_value
WHERE option_id IN (
    SELECT eao.option_id
    FROM eav_attribute_option eao
    INNER JOIN eav_attribute ea ON eao.attribute_id = ea.attribute_id
    WHERE ea.attribute_code = 'person_type' AND ea.entity_type_id = 1
);

DELETE FROM eav_attribute_option
WHERE attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code = 'person_type' AND entity_type_id = 1
);

-- PASSO 7: Remover dos forms
DELETE FROM customer_form_attribute
WHERE attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN (
        'person_type',
        'contact_name',
        'contact_email',
        'contact_phone',
        'state_registration',
        'municipal_registration'
    ) AND entity_type_id = 1
);

-- PASSO 8: Remover labels
DELETE FROM eav_attribute_label
WHERE attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN (
        'person_type',
        'contact_name',
        'contact_email',
        'contact_phone',
        'state_registration',
        'municipal_registration'
    ) AND entity_type_id = 1
);

-- PASSO 9: Remover de customer_eav_attribute (caso existam)
DELETE FROM customer_eav_attribute
WHERE attribute_id IN (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code IN (
        'person_type',
        'contact_name',
        'contact_email',
        'contact_phone',
        'state_registration',
        'municipal_registration'
    ) AND entity_type_id = 1
);

-- PASSO 10: Remover os atributos da tabela principal
DELETE FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;

-- PASSO 11: Verificar se foram removidos
SELECT
    'APÓS REMOÇÃO - Deve retornar 0 registros' as status,
    COUNT(*) as atributos_restantes
FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;
