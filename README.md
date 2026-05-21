# Docker Magento (stack local)

Este repositório usa [`docker-compose.yaml`](docker-compose.yaml): Nginx custom (`server`), **PHP-FPM 8.3** (`phpfpm`), **MariaDB 10.6** (`db`), **OpenSearch** (`opensearch`) e Mailcatcher (`mailcatcher`).

A versão de PHP activa é definida por **swap** no Compose (como na migração 8.1→8.2): o serviço `phpfpm` faz build de [`dockerfiles/php/8.3/`](dockerfiles/php/8.3/) e monta [`dockerfiles/php/8.3/conf/php.ini`](dockerfiles/php/8.3/conf/php.ini). A pasta [`dockerfiles/php/8.2/`](dockerfiles/php/8.2/) permanece no repo para **rollback** manual (reapontar `build.context` e o volume do `php.ini` para 8.2, depois `docker compose build phpfpm`).

## CLI Magento (`bin/cli` / `phpfpm`)

HTTP e CLI usam o **mesmo** container `phpfpm` (hoje PHP 8.3):

```bash
bin/cli php -v
bin/cli php bin/magento cache:flush
bin/cli php bin/magento setup:upgrade
```

**Porquê `php bin/magento`:** garante execução mesmo que permissões de execução no volume falhem. Os wrappers [`bin/magento`](bin/magento) no host delegam para [`bin/cli`](bin/cli), que executa `docker compose exec phpfpm`.

**Volumes:** código em `./src:/var/www/html`; Composer opcional em `~/.composer:/var/www/.composer`.

**Base de dados:** credenciais em [`env/db.env`](env/db.env); host `db` no Compose.

## Rollback para PHP 8.2

1. Em `docker-compose.yaml`, alterar `phpfpm.build.context` para `./dockerfiles/php/8.2/` e o volume do `php.ini` para `./dockerfiles/php/8.2/conf/php.ini`.
2. `docker compose build phpfpm && docker compose up -d phpfpm server`

## Migração de infraestrutura (referência)

### Base de dados (MariaDB 10.6 → MySQL 8.0)

Não trocar só a imagem sobre o mesmo volume sem risco. Abordagem segura: dump, volume limpo, reimport; rever charset e `app/etc/env.php`.

### OpenSearch

O Magento 2.4.x depende de motor de pesquisa. O compose inclui `opensearch`; sem ele, indexação e vários fluxos falham até reconfigurar.

### Outros

- **Mailcatcher:** SMTP/UI em desenvolvimento (portas 1025/1080).
- **Rede:** hostname da BD no `env.php` deve coincidir com o serviço `db` no Compose.
