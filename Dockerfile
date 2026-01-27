# Dockerfile customizado para n8n com Python 3 e suporte completo a JavaScript
FROM n8nio/n8n:latest

USER root

# Instalar Python 3 e dependências necessárias
RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    python3-dev \
    build-base \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    curl \
    git \
    bash \
    && ln -sf python3 /usr/bin/python

# Criar ambiente virtual Python e instalar bibliotecas úteis
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Instalar bibliotecas Python comuns para automação
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    requests \
    pandas \
    numpy \
    beautifulsoup4 \
    lxml \
    python-dateutil \
    pytz \
    aiohttp \
    httpx \
    pydantic \
    python-dotenv \
    cryptography \
    PyJWT \
    openpyxl \
    xlrd \
    python-docx \
    Pillow \
    selenium \
    playwright

# Instalar bibliotecas npm globais úteis para JavaScript no n8n
RUN npm install -g \
    axios \
    lodash \
    moment \
    uuid \
    crypto-js \
    cheerio \
    xml2js \
    csv-parse \
    xlsx \
    jsonwebtoken \
    node-fetch@2

# Criar diretórios necessários
RUN mkdir -p /home/node/.n8n \
    && mkdir -p /home/node/scripts \
    && mkdir -p /files \
    && chown -R node:node /home/node \
    && chown -R node:node /files

# Voltar para usuário node (padrão do n8n)
USER node

# Diretório de trabalho
WORKDIR /home/node

# Expor porta do n8n
EXPOSE 5678

# Variáveis de ambiente padrão
ENV N8N_PORT=5678
ENV NODE_ENV=production
ENV EXECUTIONS_DATA_SAVE_ON_ERROR=all
ENV EXECUTIONS_DATA_SAVE_ON_SUCCESS=all
ENV EXECUTIONS_DATA_SAVE_ON_PROGRESS=true
ENV EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=true

# Comando de inicialização
CMD ["n8n", "start"]
