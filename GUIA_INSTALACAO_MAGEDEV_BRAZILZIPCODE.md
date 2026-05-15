# Guia de Instalação do Módulo MageDev_BrazilZipCode no Staging

## Problema
O módulo `MageDev_BrazilZipCode` não está sendo reconhecido/instalado no ambiente staging, enquanto funciona corretamente no ambiente local.

## Diagnóstico Passo a Passo

### Passo 1: Verificar se o módulo está presente no código
```bash
# Verificar se o diretório do módulo existe
ls -la src/app/code/MageDev/BrazilZipCode/

# Verificar se os arquivos essenciais existem
ls -la src/app/code/MageDev/BrazilZipCode/etc/module.xml
ls -la src/app/code/MageDev/BrazilZipCode/registration.php
```

### Passo 2: Verificar se o módulo está registrado no config.php
```bash
# Verificar se o módulo está no config.php
grep -i "MageDev_BrazilZipCode" src/app/etc/config.php
```

**Resultado esperado:** `'MageDev_BrazilZipCode' => 1,` (habilitado) ou `'MageDev_BrazilZipCode' => 0,` (desabilitado)

### Passo 3: Verificar permissões dos arquivos
```bash
# Verificar permissões do diretório do módulo
ls -la src/app/code/MageDev/
ls -la src/app/code/MageDev/BrazilZipCode/
```

### Passo 4: Verificar se o módulo está sendo reconhecido pelo Magento
```bash
# Listar módulos instalados
bin/clinotty bin/magento module:status | grep -i BrazilZipCode
```

## Soluções Passo a Passo

### Solução 1: Forçar Reconhecimento do Módulo (Recomendado)

Execute os seguintes comandos na ordem:

```bash
# 1. Limpar cache
bin/clinotty bin/magento cache:clean
bin/clinotty bin/magento cache:flush

# 2. Limpar generated e di
rm -rf src/generated/*
rm -rf src/var/di/*
rm -rf src/var/generation/*

# 3. Executar setup:upgrade para registrar o módulo
bin/clinotty bin/magento setup:upgrade

# 4. Verificar se o módulo foi reconhecido
bin/clinotty bin/magento module:status MageDev_BrazilZipCode

# 5. Habilitar o módulo (se estiver desabilitado)
bin/clinotty bin/magento module:enable MageDev_BrazilZipCode

# 6. Executar setup:upgrade novamente após habilitar
bin/clinotty bin/magento setup:upgrade

# 7. Compilar o código (se necessário)
bin/clinotty bin/magento setup:di:compile

# 8. Limpar cache novamente
bin/clinotty bin/magento cache:flush

# 9. Verificar status final
bin/clinotty bin/magento module:status MageDev_BrazilZipCode
```

### Solução 2: Verificar e Corrigir config.php Manualmente

Se o módulo não estiver no `config.php`:

```bash
# 1. Editar o config.php e adicionar manualmente
# Adicione a linha: 'MageDev_BrazilZipCode' => 1,
# Na seção 'modules' do array

# 2. Executar setup:upgrade
bin/clinotty bin/magento setup:upgrade

# 3. Limpar cache
bin/clinotty bin/magento cache:flush
```

### Solução 3: Verificar Permissões

```bash
# Corrigir permissões do módulo
bin/fixperms

# Ou manualmente:
chmod -R 755 src/app/code/MageDev/BrazilZipCode/
chown -R $(whoami):$(whoami) src/app/code/MageDev/BrazilZipCode/
```

### Solução 4: Verificar se o Módulo Está Presente no Staging

Se o módulo não estiver presente fisicamente no staging:

```bash
# 1. Verificar se o diretório existe
test -d src/app/code/MageDev/BrazilZipCode && echo "Módulo existe" || echo "Módulo NÃO existe"

# 2. Se não existir, copiar do ambiente local ou do repositório
# (ajuste o caminho conforme necessário)
rsync -av /caminho/local/app/code/MageDev/BrazilZipCode/ src/app/code/MageDev/BrazilZipCode/

# 3. Executar os passos da Solução 1
```

### Solução 5: Verificar Logs de Erro

```bash
# Verificar logs do Magento
tail -f src/var/log/system.log
tail -f src/var/log/exception.log

# Verificar erros do PHP
bin/clinotty tail -f /var/log/php_errors.log
```

## Comandos Rápidos (Script Automatizado)

Use o script `bin/install-magedev-brazilzipcode` que foi criado para automatizar o processo:

```bash
bin/install-magedev-brazilzipcode
```

## Verificação Final

Após executar as soluções, verifique:

```bash
# 1. Status do módulo
bin/clinotty bin/magento module:status MageDev_BrazilZipCode

# 2. Verificar no config.php
grep "MageDev_BrazilZipCode" src/app/etc/config.php

# 3. Verificar se não há erros
bin/clinotty bin/magento setup:upgrade 2>&1 | grep -i error

# 4. Testar funcionalidade do módulo (se aplicável)
# Acesse o admin do Magento e verifique se o módulo aparece
```

## Possíveis Causas do Problema no Staging

1. **Módulo não presente fisicamente** - O código não foi deployado no staging
2. **Permissões incorretas** - Arquivos sem permissão de leitura
3. **Cache desatualizado** - Cache do Magento com informações antigas
4. **config.php diferente** - O módulo não está registrado no config.php do staging
5. **Generated/DI desatualizado** - Código gerado não inclui o módulo
6. **Modo de produção** - Alguns comandos podem se comportar diferente em produção
7. **Composer autoload** - Problemas com o autoload do Composer

## Dicas Importantes

- ⚠️ **Sempre faça backup** antes de executar comandos no staging
- ⚠️ **Verifique o modo do Magento** (`bin/clinotty bin/magento deploy:mode:show`)
- ⚠️ **Em modo produção**, pode ser necessário executar `setup:di:compile` e `setup:static-content:deploy`
- ⚠️ **Verifique logs** se algo der errado








