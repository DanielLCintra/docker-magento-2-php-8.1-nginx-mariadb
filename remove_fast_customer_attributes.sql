-- Script para REMOVER os atributos do Fast_Customer do banco de dados
-- Use apenas para testes! Isso remove os atributos permanentemente.

-- ============================================
-- REMOVER person_type
-- ============================================
SET @person_type_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'person_type' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

-- Remover valores do atributo
DELETE FROM customer_entity_int WHERE attribute_id = @person_type_id;

-- Remover labels das opções
DELETE FROM eav_attribute_option_value 
WHERE option_id IN (
    SELECT option_id FROM eav_attribute_option 
    WHERE attribute_id = @person_type_id
);

-- Remover opções do atributo
DELETE FROM eav_attribute_option WHERE attribute_id = @person_type_id;

-- Remover do customer_eav_attribute
DELETE FROM customer_eav_attribute WHERE attribute_id = @person_type_id;

-- Remover dos formulários
DELETE FROM customer_form_attribute WHERE attribute_id = @person_type_id;

-- Remover o atributo
DELETE FROM eav_attribute WHERE attribute_id = @person_type_id;

-- ============================================
-- REMOVER contact_name
-- ============================================
SET @contact_name_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_name' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

DELETE FROM customer_entity_varchar WHERE attribute_id = @contact_name_id;
DELETE FROM customer_eav_attribute WHERE attribute_id = @contact_name_id;
DELETE FROM customer_form_attribute WHERE attribute_id = @contact_name_id;
DELETE FROM eav_attribute WHERE attribute_id = @contact_name_id;

-- ============================================
-- REMOVER contact_email
-- ============================================
SET @contact_email_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_email' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

DELETE FROM customer_entity_varchar WHERE attribute_id = @contact_email_id;
DELETE FROM customer_eav_attribute WHERE attribute_id = @contact_email_id;
DELETE FROM customer_form_attribute WHERE attribute_id = @contact_email_id;
DELETE FROM eav_attribute WHERE attribute_id = @contact_email_id;

-- ============================================
-- REMOVER contact_phone
-- ============================================
SET @contact_phone_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_phone' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

DELETE FROM customer_entity_varchar WHERE attribute_id = @contact_phone_id;
DELETE FROM customer_eav_attribute WHERE attribute_id = @contact_phone_id;
DELETE FROM customer_form_attribute WHERE attribute_id = @contact_phone_id;
DELETE FROM eav_attribute WHERE attribute_id = @contact_phone_id;

-- ============================================
-- REMOVER state_registration (opcional, se quiser)
-- ============================================
SET @state_registration_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'state_registration' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

DELETE FROM customer_entity_varchar WHERE attribute_id = @state_registration_id;
DELETE FROM customer_eav_attribute WHERE attribute_id = @state_registration_id;
DELETE FROM customer_form_attribute WHERE attribute_id = @state_registration_id;
DELETE FROM eav_attribute WHERE attribute_id = @state_registration_id;

-- ============================================
-- REMOVER municipal_registration (opcional, se quiser)
-- ============================================
SET @municipal_registration_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'municipal_registration' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

DELETE FROM customer_entity_varchar WHERE attribute_id = @municipal_registration_id;
DELETE FROM customer_eav_attribute WHERE attribute_id = @municipal_registration_id;
DELETE FROM customer_form_attribute WHERE attribute_id = @municipal_registration_id;
DELETE FROM eav_attribute WHERE attribute_id = @municipal_registration_id;

SELECT 'Atributos do Fast_Customer removidos com sucesso!' AS Resultado;




















