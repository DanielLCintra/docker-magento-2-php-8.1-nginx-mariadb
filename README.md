# Docker Magento (stack local)

Este repositório usa principalmente [`docker-compose.yaml`](docker-compose.yaml): Nginx custom (`server`), PHP-FPM 8.2 (`phpfpm`), **MariaDB 10.6** (`db`), **OpenSearch** (`opensearch`) e Mailcatcher (`mailcatcher`).

Quando migrares para um compose com dois FPM em TCP (`php82` e `php83`, conforme o plano interno), os comandos CLI passam a ser executados explicitamente no serviço desejado.

## CLI com `php82` / `php83` (`docker compose run`)

Imagens **FPM** arrancam `php-fpm` por defeito. Para Magento na linha de comandos, usa `docker compose run` com `--workdir` no código e invoca o PHP em modo CLI:

```bash
# Exemplos (ajusta o nome do ficheiro compose se usares outro)
docker compose run --rm --workdir /var/www/html php82 php bin/magento cache:flush
docker compose run --rm --workdir /var/www/html php83 php bin/magento setup:upgrade
docker compose run --rm --workdir /var/www/html php83 php bin/magento setup:di:compile
```

**Porquê `php bin/magento`:** garante execução mesmo que permissões de execução no volume falhem. Os wrappers em [`bin/magento`](bin/magento) do host costumam delegar para [`bin/cli`](bin/cli) e **não** devem ser assumidos como existentes dentro do container; no container usa `php bin/magento` ou o caminho absoluto para o script.

**Volumes:** o serviço no `run` deve montar o mesmo código que o Nginx (ex.: `./src:/var/www/html`, ou o caminho que o teu compose definir). Opcionalmente monta credenciais Composer, por exemplo `~/.composer:/var/www/.composer`.

**Base de dados:** para comandos que acedem à BD, o container PHP precisa das mesmas variáveis que no compose (ex.: `env_file: env/db.env` ou `environment` alinhado com `env/db.env`). Mantém o host `db` coerente com o nome do serviço MySQL/MariaDB no compose.

## Migração face ao `docker-compose.yaml` actual

### Base de dados (MariaDB 10.6 → MySQL 8.0)

O compose actual usa **`mariadb:10.6.8`** e volume `dbdata`. Se migrares a imagem para **MySQL 8.0**:

- Não contes com trocar só a imagem sobre o mesmo volume sem risco: o formato de dados pode não ser compatível.
- Abordagem segura: **dump** a partir do stack actual (por exemplo `mysqldump` com o serviço `db` a correr), subir o novo MySQL 8 com volume limpo e **reimportar** o SQL.
- Depois do restore, pode ser necessário **`mysql_upgrade`** ou equivalente e rever **charset/collation** e modo SQL do Magento.
- Actualiza `env/db.env` e `app/etc/env.php` do Magento para credenciais e host alinhados ao novo serviço.

### OpenSearch

O compose actual inclui **`opensearch`** (`markoshust/magento-opensearch`). O Magento 2.4.x depende de motor de pesquisa (OpenSearch/Elasticsearch) para indexação e vários fluxos admin/frontend.

- Se o novo ficheiro compose **não** incluir OpenSearch (ou equivalente), comandos como instalação, reindexação ou funcionalidades de catálogo podem falhar até readicionares o serviço e configurares o Magento (`bin/magento config:set` / `env.php`).
- Mantém portas, URL do motor de pesquisa e credenciais coerentes com `env/opensearch.env` (ou o que usares na nova stack).

### Outros serviços e nomes de serviço

- **Mailcatcher:** o compose actual expõe SMTP/UI para desenvolvimento; se o novo compose o omitir, configura o Magento para outro MTA ou readiciona o serviço.
- **Rede Docker:** garante que o hostname da BD no `env.php` corresponde ao `service` name no Compose (hoje `MYSQL_HOST=db` em [`env/db.env`](env/db.env)).

## Stack actual (referência rápida)

Até existirem `php82`/`php83`, o PHP corre no serviço **`phpfpm`**. Para comandos ad-hoc nesse container (se tiveres shell/CLI disponível), o padrão continua a ser trabalhar **dentro** do container com o mesmo volume `/var/www/html` que no compose.
