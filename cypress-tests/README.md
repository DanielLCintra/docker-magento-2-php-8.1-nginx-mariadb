# Testes Automatizados Frontend - BrazilCustomerAttributes

Este diretório contém testes automatizados para o módulo SystemCode_BrazilCustomerAttributes.

## 🚀 Setup

```bash
# 1. Instalar Cypress
npm install --save-dev cypress

# 2. Abrir Cypress pela primeira vez (cria estrutura)
npx cypress open

# 3. Rodar testes em modo headless
npx cypress run

# 4. Rodar teste específico
npx cypress run --spec "cypress/e2e/customer-registration-cpf.cy.js"
```

## 📁 Estrutura

```
cypress-tests/
├── cypress/
│   ├── e2e/                          # Testes E2E
│   │   ├── customer-registration-cpf.cy.js
│   │   ├── customer-registration-cnpj.cy.js
│   │   ├── customer-validation.cy.js
│   │   └── customer-edit.cy.js
│   ├── fixtures/                     # Dados de teste
│   │   └── customers.json
│   ├── support/
│   │   ├── commands.js               # Comandos customizados
│   │   └── e2e.js
│   └── screenshots/                  # Screenshots de falhas
├── cypress.config.js                 # Configuração
└── package.json
```

## 🎯 Casos de Teste Cobertos

### ✅ Pessoa Física (CPF)
- [x] Cadastro com CPF válido
- [x] Cadastro com CPF inválido
- [x] Cadastro com CPF duplicado
- [x] Cadastro sem CPF (campo obrigatório)
- [x] Edição mantendo mesmo CPF
- [x] Edição alterando para CPF existente

### ✅ Pessoa Jurídica (CNPJ)
- [x] Cadastro com CNPJ válido
- [x] Cadastro com CNPJ inválido
- [x] Cadastro com CNPJ duplicado
- [x] Validação de campos obrigatórios (IE, Razão Social)

### ✅ Validações
- [x] Máscaras aplicadas corretamente
- [x] Toggle entre PF e PJ funciona
- [x] Campos mostrados/escondidos conforme tipo
- [x] Mensagens de erro corretas

## 🔧 Configuração do Ambiente

Antes de rodar os testes, configure as variáveis de ambiente:

```bash
# cypress.env.json (não commitar - adicionar ao .gitignore)
{
  "baseUrl": "http://localhost",
  "adminUsername": "admin",
  "adminPassword": "senha123"
}
```

## 📊 Relatórios

Os relatórios são gerados automaticamente em:
- Screenshots: `cypress/screenshots/`
- Vídeos: `cypress/videos/`
- HTML Report: `cypress/reports/`

## ⚡ Comandos Úteis

```bash
# Rodar todos os testes
npm run test:e2e

# Rodar testes específicos
npm run test:cpf
npm run test:cnpj

# Abrir Cypress UI
npm run cypress:open

# Rodar no modo CI
npm run test:ci
```

## 🐛 Debug

Para debugar testes:

```javascript
// No teste, adicione:
cy.pause()           // Pausa execução
cy.debug()          // Debug no DevTools
cy.screenshot()     // Tira screenshot
```

## 📚 Documentação

- [Cypress Docs](https://docs.cypress.io/)
- [Best Practices](https://docs.cypress.io/guides/references/best-practices)
- [Magento Testing](https://devdocs.magento.com/guides/v2.4/test/testing.html)
