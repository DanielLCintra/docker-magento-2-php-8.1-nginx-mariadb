-- ========================================
-- SCRIPT MANUAL - EXECUTE BLOCO POR BLOCO
-- ========================================

-- BLOCO 1: Verificar quais atributos existem e anotar os IDs
-- COPIE E EXECUTE ESTE BLOCO PRIMEIRO
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

-- Anote os attribute_id retornados acima!
-- Exemplo: person_type = 100, contact_name = 101, etc.


-- ========================================
-- BLOCO 2: Substituir XXX pelos IDs anotados e executar
-- ========================================

-- Deletar de customer_entity_int (person_type é int)
-- Substitua XXX pelo attribute_id do person_type
DELETE FROM customer_entity_int WHERE attribute_id IN (XXX);

-- Deletar de customer_entity_varchar (os outros são varchar)
-- Substitua XXX, YYY, ZZZ, AAA, BBB pelos attribute_ids de:
-- contact_name, contact_email, contact_phone, state_registration, municipal_registration
DELETE FROM customer_entity_varchar WHERE attribute_id IN (XXX, YYY, ZZZ, AAA, BBB);


-- ========================================
-- BLOCO 3: Remover opções do person_type
-- Substitua XXX pelo attribute_id do person_type
-- ========================================

-- Primeiro deletar os valores das opções
DELETE FROM eav_attribute_option_value
WHERE option_id IN (
    SELECT option_id FROM eav_attribute_option WHERE attribute_id = XXX
);

-- Depois deletar as opções
DELETE FROM eav_attribute_option WHERE attribute_id = XXX;


-- ========================================
-- BLOCO 4: Remover dos formulários
-- Substitua pelos IDs de TODOS os 6 atributos
-- ========================================

DELETE FROM customer_form_attribute
WHERE attribute_id IN (XXX, YYY, ZZZ, AAA, BBB, CCC);


-- ========================================
-- BLOCO 5: Remover labels
-- Substitua pelos IDs de TODOS os 6 atributos
-- ========================================

DELETE FROM eav_attribute_label
WHERE attribute_id IN (XXX, YYY, ZZZ, AAA, BBB, CCC);


-- ========================================
-- BLOCO 6: Remover de customer_eav_attribute
-- Substitua pelos IDs de TODOS os 6 atributos
-- ========================================

DELETE FROM customer_eav_attribute
WHERE attribute_id IN (XXX, YYY, ZZZ, AAA, BBB, CCC);


-- ========================================
-- BLOCO 7: Remover os atributos
-- Esta é a etapa final - NÃO tem volta depois disto!
-- ========================================

DELETE FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;


-- ========================================
-- BLOCO 8: Verificação final (deve retornar 0)
-- ========================================

SELECT COUNT(*) as atributos_restantes
FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;
