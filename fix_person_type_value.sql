-- Verificar o backend_type e como está armazenado
SELECT ea.attribute_id, ea.backend_type, ea.frontend_input, ea.default_value
FROM eav_attribute ea
WHERE ea.attribute_code = 'person_type' AND ea.entity_type_id = 1;

-- Ver os option_ids disponíveis
SELECT eao.option_id, eaov.value
FROM eav_attribute ea
JOIN eav_attribute_option eao ON eao.attribute_id = ea.attribute_id
JOIN eav_attribute_option_value eaov ON eaov.option_id = eao.option_id
WHERE ea.attribute_code = 'person_type' AND ea.entity_type_id = 1;

-- Limpar valores antigos do person_type
DELETE FROM customer_entity_varchar
WHERE attribute_id = (
    SELECT attribute_id FROM eav_attribute
    WHERE attribute_code = 'person_type' AND entity_type_id = 1
);

-- Inserir corretamente com option_id como INT
INSERT INTO customer_entity_int (attribute_id, entity_id, value)
SELECT
    ea.attribute_id,
    ce.entity_id,
    eao.option_id
FROM customer_entity ce
CROSS JOIN eav_attribute ea
INNER JOIN eav_attribute_option eao ON eao.attribute_id = ea.attribute_id
INNER JOIN eav_attribute_option_value eaov ON eaov.option_id = eao.option_id
WHERE ea.attribute_code = 'person_type'
    AND ea.entity_type_id = 1
    AND eaov.value = 'Pessoa Física'
ON DUPLICATE KEY UPDATE value = eao.option_id;

-- Verificar resultado
SELECT
    ce.entity_id,
    ce.email,
    cei.value as person_type_option_id,
    eaov.value as person_type_label
FROM customer_entity ce
LEFT JOIN customer_entity_int cei ON ce.entity_id = cei.entity_id
LEFT JOIN eav_attribute ea ON cei.attribute_id = ea.attribute_id AND ea.attribute_code = 'person_type'
LEFT JOIN eav_attribute_option_value eaov ON cei.value = eaov.option_id;
