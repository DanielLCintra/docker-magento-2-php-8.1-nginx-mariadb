-- Script completo para remover todos os atributos do Fast_Customer do banco de dados
-- Atributos a remover: person_type, contact_name, contact_email, contact_phone, state_registration, municipal_registration

-- PASSO 1: Obter os IDs dos atributos
SET @person_type_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'person_type' AND entity_type_id = 1);
SET @contact_name_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_name' AND entity_type_id = 1);
SET @contact_email_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_email' AND entity_type_id = 1);
SET @contact_phone_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_phone' AND entity_type_id = 1);
SET @state_registration_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'state_registration' AND entity_type_id = 1);
SET @municipal_registration_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'municipal_registration' AND entity_type_id = 1);

-- Exibir IDs encontrados
SELECT
    'Atributos encontrados:' as info,
    @person_type_id as person_type_id,
    @contact_name_id as contact_name_id,
    @contact_email_id as contact_email_id,
    @contact_phone_id as contact_phone_id,
    @state_registration_id as state_registration_id,
    @municipal_registration_id as municipal_registration_id;

-- PASSO 2: Remover valores dos atributos de todas as tabelas EAV

-- Remover de customer_entity_int (person_type é int)
DELETE FROM customer_entity_int WHERE attribute_id IN (@person_type_id);

-- Remover de customer_entity_varchar (os outros são varchar)
DELETE FROM customer_entity_varchar
WHERE attribute_id IN (
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- Remover de customer_entity_text (caso existam)
DELETE FROM customer_entity_text
WHERE attribute_id IN (
    @person_type_id,
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- Remover de customer_entity_decimal (caso existam)
DELETE FROM customer_entity_decimal
WHERE attribute_id IN (
    @person_type_id,
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- Remover de customer_entity_datetime (caso existam)
DELETE FROM customer_entity_datetime
WHERE attribute_id IN (
    @person_type_id,
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- PASSO 3: Remover opções do person_type (é um select)
DELETE FROM eav_attribute_option_value
WHERE option_id IN (
    SELECT option_id FROM eav_attribute_option WHERE attribute_id = @person_type_id
);

DELETE FROM eav_attribute_option WHERE attribute_id = @person_type_id;

-- PASSO 4: Remover dos forms
DELETE FROM customer_form_attribute
WHERE attribute_id IN (
    @person_type_id,
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- PASSO 5: Remover labels dos atributos
DELETE FROM eav_attribute_label
WHERE attribute_id IN (
    @person_type_id,
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- PASSO 6: Remover da tabela catalog_eav_attribute (caso existam)
DELETE FROM catalog_eav_attribute
WHERE attribute_id IN (
    @person_type_id,
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- PASSO 7: Remover da tabela customer_eav_attribute (caso existam)
DELETE FROM customer_eav_attribute
WHERE attribute_id IN (
    @person_type_id,
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- PASSO 8: Finalmente, remover os atributos da tabela principal
DELETE FROM eav_attribute
WHERE attribute_id IN (
    @person_type_id,
    @contact_name_id,
    @contact_email_id,
    @contact_phone_id,
    @state_registration_id,
    @municipal_registration_id
);

-- PASSO 9: Verificar se foram removidos
SELECT
    'Verificação pós-remoção:' as info,
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

-- Se retornar 0, todos os atributos foram removidos com sucesso!
