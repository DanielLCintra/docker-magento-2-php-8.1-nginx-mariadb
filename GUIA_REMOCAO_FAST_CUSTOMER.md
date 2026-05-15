# Guia de Remoção dos Atributos Fast_Customer

## Atributos a serem removidos

O módulo `Fast_Customer` criou os seguintes 6 atributos:

1. **person_type** (int) - Tipo de pessoa (PF/PJ)
2. **contact_name** (varchar) - Nome do contato
3. **contact_email** (varchar) - Email do contato
4. **contact_phone** (varchar) - Telefone do contato
5. **state_registration** (varchar) - Inscrição Estadual
6. **municipal_registration** (varchar) - Inscrição Municipal

## Scripts Disponíveis

### 1. `remove_fast_customer_auto.sql` ⭐ **RECOMENDADO**

Script totalmente automatizado usando tabelas temporárias. Compatível com MariaDB.

**Como usar:**
```bash
# Para ambiente staging (substitua pelas credenciais corretas)
mysql -h [HOST] -u [USER] -p[PASSWORD] [DATABASE] < remove_fast_customer_auto.sql
```

**Vantagens:**
- ✅ Totalmente automatizado
- ✅ Compatível com MariaDB
- ✅ Mostra quais atributos serão removidos antes de deletar
- ✅ Verifica ao final se todos foram removidos

---

### 2. `remove_fast_customer_attributes_simple.sql`

Script com subqueries diretas no DELETE.

**Atenção:** Pode dar erro em algumas versões do MariaDB com subqueries em DELETE.

---

### 3. `remove_fast_customer_step_by_step.sql`

Script manual onde você precisa preencher os IDs dos atributos.

**Use este se:**
- Quer controle total sobre cada etapa
- Os outros scripts não funcionarem
- Quiser entender melhor o processo

**Como usar:**
1. Execute a ETAPA 1 para ver os attribute_ids
2. Anote os IDs
3. Substitua XXX pelos IDs nas próximas etapas
4. Execute cada etapa manualmente

---

### 4. `remove_fast_customer_attributes_complete.sql`

Script com variáveis SET.

**Atenção:** Pode dar erro no MariaDB com múltiplos SET statements.

---

## Processo Recomendado

### ANTES DE EXECUTAR:

#### 1. **BACKUP DO BANCO DE DADOS** ⚠️
```bash
# Fazer backup completo
mysqldump -h [HOST] -u [USER] -p[PASSWORD] [DATABASE] > backup_before_removal_$(date +%Y%m%d_%H%M%S).sql

# Ou apenas das tabelas relevantes
mysqldump -h [HOST] -u [USER] -p[PASSWORD] [DATABASE] \
  eav_attribute \
  eav_attribute_option \
  eav_attribute_option_value \
  customer_entity_int \
  customer_entity_varchar \
  customer_form_attribute \
  eav_attribute_label \
  customer_eav_attribute \
  > backup_eav_tables_$(date +%Y%m%d_%H%M%S).sql
```

#### 2. **Verificar atributos existentes**
```sql
SELECT attribute_id, attribute_code, backend_type, is_required
FROM eav_attribute
WHERE attribute_code IN (
    'person_type',
    'contact_name',
    'contact_email',
    'contact_phone',
    'state_registration',
    'municipal_registration'
) AND entity_type_id = 1;
```

#### 3. **Contar quantos clientes têm dados nesses atributos**
```sql
-- person_type (int)
SELECT COUNT(DISTINCT entity_id) as customers_with_person_type
FROM customer_entity_int
WHERE attribute_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'person_type' AND entity_type_id = 1);

-- contact_name (varchar)
SELECT COUNT(DISTINCT entity_id) as customers_with_contact_name
FROM customer_entity_varchar
WHERE attribute_id = (SELECT attribute_id FROM eav_attribute WHERE attribute_code = 'contact_name' AND entity_type_id = 1);
```

### EXECUÇÃO:

```bash
# Executar o script automatizado
mysql -h [HOST] -u [USER] -p[PASSWORD] [DATABASE] < remove_fast_customer_auto.sql
```

### APÓS EXECUÇÃO:

#### 1. **Verificar se foram removidos**
```sql
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
-- Deve retornar 0
```

#### 2. **Limpar cache do Magento**
```bash
bin/magento cache:flush
bin/magento cache:clean
```

#### 3. **Verificar no admin**
- Acessar um cliente no admin
- Verificar se os campos do Fast_Customer não aparecem mais

---

## Rollback (Em caso de erro)

Se algo der errado, restaurar o backup:

```bash
mysql -h [HOST] -u [USER] -p[PASSWORD] [DATABASE] < backup_before_removal_[DATA].sql
```

---

## Observações Importantes

1. **NÃO execute esses scripts no ambiente de produção sem testar em staging primeiro!**

2. **person_type do SystemCode**: O atributo `person_type` do módulo `SystemCode_BrazilCustomerAttributes` **NÃO será afetado** porque:
   - Foi criado depois (attribute_id diferente)
   - Tem backend_type diferente (int vs varchar)
   - Tem opções diferentes ("Pessoa Física", "Pessoa Jurídica", "Produtor Rural")

3. **Clientes existentes**: Os clientes que tinham dados nesses campos perderão essas informações. Certifique-se de que isso é aceitável.

4. **Módulo desabilitado**: Mesmo com o módulo Fast_Customer desabilitado, os atributos permanecem no banco. Por isso precisamos removê-los manualmente.

---

## Checklist de Segurança

- [ ] Backup do banco de dados feito
- [ ] Script testado em ambiente de desenvolvimento/staging
- [ ] Verificado que não há dependências de outros módulos nesses campos
- [ ] Cache limpo após a remoção
- [ ] Verificado no admin que os campos não aparecem mais
- [ ] Documentado o que foi removido e quando

---

## Suporte

Se encontrar algum erro durante a execução:

1. **Não entre em pânico** - você tem o backup!
2. Anote a mensagem de erro completa
3. Restaure o backup se necessário
4. Use o script `remove_fast_customer_step_by_step.sql` para controle manual
