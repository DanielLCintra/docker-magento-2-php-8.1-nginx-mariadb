-- Script para definir "Pessoa Física" como padrão para clientes sem person_type

-- Inserir valor padrão para clientes que não têm person_type
INSERT INTO customer_entity_varchar (attribute_id, entity_id, value)
SELECT
    ea.attribute_id,
    ce.entity_id,
    eao.option_id
FROM customer_entity ce
CROSS JOIN eav_attribute ea
INNER JOIN eav_attribute_option eao ON eao.attribute_id = ea.attribute_id
INNER JOIN eav_attribute_option_value eaov ON eaov.option_id = eao.option_id
LEFT JOIN customer_entity_varchar cev ON ce.entity_id = cev.entity_id AND cev.attribute_id = ea.attribute_id
WHERE ea.attribute_code = 'person_type'
    AND ea.entity_type_id = 1
    AND eaov.value = 'Pessoa Física'
    AND (cev.value IS NULL OR cev.value = '')
ON DUPLICATE KEY UPDATE value = eao.option_id;
