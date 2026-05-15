-- Script para remover o atributo person_type do banco de dados
-- Execute este script no banco de dados do Magento

-- Primeiro, vamos obter o attribute_id para usar nas queries
SET @attribute_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'person_type' AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer'));

-- Verificar se o atributo existe antes de remover
-- Se @attribute_id for NULL, o atributo não existe e nada será removido

-- Remover labels das opções primeiro (dependência)
DELETE FROM eav_attribute_option_value 
WHERE option_id IN (
    SELECT option_id FROM eav_attribute_option 
    WHERE attribute_id = @attribute_id
);

-- Remover opções do atributo (se for select)
DELETE FROM eav_attribute_option 
WHERE attribute_id = @attribute_id;

-- Remover valores do atributo da tabela customer_entity_int (se existir)
DELETE FROM customer_entity_int 
WHERE attribute_id = @attribute_id;

-- Remover o atributo da tabela customer_eav_attribute (se existir)
DELETE FROM customer_eav_attribute 
WHERE attribute_id = @attribute_id;

-- Remover o atributo person_type da tabela eav_attribute
DELETE FROM eav_attribute 
WHERE attribute_code = 'person_type' 
AND entity_type_id = (SELECT entity_type_id FROM eav_entity_type WHERE entity_type_code = 'customer');
