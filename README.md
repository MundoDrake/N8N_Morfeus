# N8N Morfeus

**Versão n8n: 2.4.6** (Stable - Janeiro 2026)

Instalação Docker do n8n com suporte completo a **Python 3** e **JavaScript**.

## Requisitos

- Docker
- Docker Compose

## Instalação Rápida

```bash
# 1. Clone o repositório
git clone <repo-url>
cd N8N_Morfeus

# 2. Configure as variáveis de ambiente
cp .env.example .env
# Edite o arquivo .env com suas configurações

# 3. Inicie o n8n
docker-compose up -d

# 4. Acesse no navegador
# http://localhost:5678
```

## Credenciais Padrão

- **Usuário:** admin
- **Senha:** admin123

> **Importante:** Altere as credenciais no arquivo `.env` antes de usar em produção!

## Comandos Úteis

```bash
# Iniciar
docker-compose up -d

# Parar
docker-compose down

# Ver logs
docker-compose logs -f n8n

# Reiniciar
docker-compose restart

# Reconstruir imagem (após mudanças no Dockerfile)
docker-compose up -d --build

# Acessar terminal do container
docker exec -it n8n_morfeus /bin/bash
```

## Estrutura de Pastas

```
N8N_Morfeus/
├── docker-compose.yml    # Configuração do Docker
├── Dockerfile            # Imagem customizada com Python
├── .env                  # Variáveis de ambiente (não versionado)
├── .env.example          # Template de configuração
├── files/                # Arquivos compartilhados
├── scripts/              # Scripts customizados
│   └── examples/         # Exemplos de scripts
└── README.md
```

## Bibliotecas Python Incluídas

- `requests` - Requisições HTTP
- `pandas` - Manipulação de dados
- `numpy` - Computação numérica
- `beautifulsoup4` - Web scraping
- `lxml` - Parser XML/HTML
- `python-dateutil` - Manipulação de datas
- `aiohttp` / `httpx` - HTTP assíncrono
- `pydantic` - Validação de dados
- `cryptography` / `PyJWT` - Criptografia
- `openpyxl` / `xlrd` - Arquivos Excel
- `python-docx` - Documentos Word
- `Pillow` - Manipulação de imagens
- `selenium` / `playwright` - Automação web

## Bibliotecas JavaScript/Node.js Incluídas

- `axios` - Requisições HTTP
- `lodash` - Utilitários
- `moment` - Manipulação de datas
- `uuid` - Geração de IDs únicos
- `crypto-js` - Criptografia
- `cheerio` - Web scraping
- `xml2js` - Parser XML
- `csv-parse` - Parser CSV
- `xlsx` - Arquivos Excel
- `jsonwebtoken` - JWT
- `node-fetch` - Fetch API

## Usando Python no n8n

### Opção 1: Nó "Execute Command"

```bash
python3 /home/node/scripts/seu_script.py '{"dados": "exemplo"}'
```

### Opção 2: Nó "Code" com execução de comando

```javascript
const { exec } = require('child_process');
const util = require('util');
const execPromise = util.promisify(exec);

const input = JSON.stringify($input.all());
const { stdout } = await execPromise(`python3 -c "
import json
dados = json.loads('${input}')
print(json.dumps({'resultado': 'processado'}))
"`);

return JSON.parse(stdout);
```

## Usando JavaScript no n8n

No nó "Code", você tem acesso a todas as bibliotecas instaladas:

```javascript
// Exemplo com axios
const axios = require('axios');
const response = await axios.get('https://api.exemplo.com/dados');

// Exemplo com moment
const moment = require('moment');
const dataFormatada = moment().format('DD/MM/YYYY');

// Exemplo com lodash
const _ = require('lodash');
const resultado = _.groupBy(items, 'categoria');

return items;
```

## Variáveis de Ambiente Importantes

| Variável | Descrição | Padrão |
|----------|-----------|--------|
| `N8N_HOST` | Host do n8n | localhost |
| `N8N_PORT` | Porta do n8n | 5678 |
| `N8N_BASIC_AUTH_USER` | Usuário de login | admin |
| `N8N_BASIC_AUTH_PASSWORD` | Senha de login | admin123 |
| `N8N_ENCRYPTION_KEY` | Chave de criptografia | - |
| `GENERIC_TIMEZONE` | Fuso horário | America/Sao_Paulo |
| `WEBHOOK_URL` | URL base para webhooks | http://localhost:5678/ |

## Usando PostgreSQL (Opcional)

Para usar PostgreSQL ao invés de SQLite:

1. Descomente o serviço `postgres` no `docker-compose.yml`
2. Configure as variáveis no `.env`:

```env
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=postgres
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=n8n
DB_POSTGRESDB_USER=n8n
DB_POSTGRESDB_PASSWORD=sua_senha_segura
```

## Backup

### Backup do SQLite

```bash
docker cp n8n_morfeus:/home/node/.n8n/database.sqlite ./backup_$(date +%Y%m%d).sqlite
```

### Backup dos workflows

```bash
docker exec n8n_morfeus n8n export:workflow --all --output=/files/workflows_backup.json
```

## Troubleshooting

### Container não inicia

```bash
docker-compose logs n8n
```

### Erro de permissão

```bash
docker exec -u root n8n_morfeus chown -R node:node /home/node/.n8n
```

### Limpar e reiniciar do zero

```bash
docker-compose down -v
docker-compose up -d --build
```

## Produção

Para uso em produção, recomenda-se:

1. Gerar uma nova `N8N_ENCRYPTION_KEY`:
   ```bash
   openssl rand -hex 32
   ```

2. Usar senhas fortes para autenticação

3. Configurar HTTPS (usar proxy reverso como Nginx ou Traefik)

4. Usar PostgreSQL ao invés de SQLite

5. Configurar backups automáticos

## Atualização

Para atualizar para uma nova versão do n8n:

1. Edite o `Dockerfile` e altere a versão:
   ```dockerfile
   FROM docker.n8n.io/n8nio/n8n:NOVA_VERSAO
   ```

2. Reconstrua e reinicie:
   ```bash
   docker-compose down
   docker-compose up -d --build
   ```

3. Verifique as [Release Notes](https://docs.n8n.io/release-notes/) para breaking changes.

## Licença

MIT
