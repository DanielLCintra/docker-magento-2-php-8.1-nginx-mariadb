-- Verificar attribute_id do person_type
SELECT attribute_id, attribute_code, backend_type, frontend_input, default_value
FROM eav_attribute
WHERE attribute_code = 'person_type' AND entity_type_id = 1;

-- Verificar opções disponíveis
SELECT eao.option_id, eao.attribute_id, eaov.value
FROM eav_attribute_option eao
JOIN eav_attribute_option_value eaov ON eao.option_id = eaov.option_id
JOIN eav_attribute ea ON eao.attribute_id = ea.attribute_id
WHERE ea.attribute_code = 'person_type'
ORDER BY eao.option_id;

-- Verificar valor atual dos clientes
SELECT
    ce.entity_id,
    ce.email,
    cev.value as person_type_option_id,
    eaov.value as person_type_label
FROM customer_entity ce
LEFT JOIN customer_entity_varchar cev ON ce.entity_id = cev.entity_id
LEFT JOIN eav_attribute ea ON cev.attribute_id = ea.attribute_id AND ea.attribute_code = 'person_type'
LEFT JOIN eav_attribute_option_value eaov ON cev.value = eaov.option_id
WHERE ce.entity_id = 1;
