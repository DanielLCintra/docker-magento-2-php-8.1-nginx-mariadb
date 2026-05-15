-- Script para tornar os atributos do Fast_Customer opcionais
-- Execute este script quando houver conflito com outros módulos de atributos de cliente

-- Tornar person_type não obrigatório e remover dos formulários frontend
SET @person_type_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'person_type' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

UPDATE customer_eav_attribute 
SET is_required = 0 
WHERE attribute_id = @person_type_id;

UPDATE eav_attribute 
SET is_required = 0 
WHERE attribute_id = @person_type_id;

-- Remover person_type dos formulários frontend (manter apenas admin)
DELETE FROM customer_form_attribute 
WHERE attribute_id = @person_type_id 
AND form_code IN ('customer_account_create', 'customer_account_edit');

-- Tornar contact_name não obrigatório
SET @contact_name_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_name' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

UPDATE customer_eav_attribute 
SET is_required = 0 
WHERE attribute_id = @contact_name_id;

UPDATE eav_attribute 
SET is_required = 0 
WHERE attribute_id = @contact_name_id;

DELETE FROM customer_form_attribute 
WHERE attribute_id = @contact_name_id 
AND form_code IN ('customer_account_create', 'customer_account_edit');

-- Tornar contact_email não obrigatório
SET @contact_email_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_email' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

UPDATE customer_eav_attribute 
SET is_required = 0 
WHERE attribute_id = @contact_email_id;

UPDATE eav_attribute 
SET is_required = 0 
WHERE attribute_id = @contact_email_id;

DELETE FROM customer_form_attribute 
WHERE attribute_id = @contact_email_id 
AND form_code IN ('customer_account_create', 'customer_account_edit');

-- Tornar contact_phone não obrigatório
SET @contact_phone_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_phone' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

UPDATE customer_eav_attribute 
SET is_required = 0 
WHERE attribute_id = @contact_phone_id;

UPDATE eav_attribute 
SET is_required = 0 
WHERE attribute_id = @contact_phone_id;

DELETE FROM customer_form_attribute 
WHERE attribute_id = @contact_phone_id 
AND form_code IN ('customer_account_create', 'customer_account_edit');

SELECT 'Atributos do Fast_Customer tornados opcionais com sucesso!' AS Resultado;




















