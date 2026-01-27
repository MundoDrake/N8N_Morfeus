/**
 * Exemplo de script JavaScript para uso no nó "Code" do n8n
 *
 * No n8n, você pode usar este código diretamente no nó "Code"
 * ou salvar como arquivo e importar
 */

// Exemplo 1: Processar itens de entrada
function processarItens(items) {
  return items.map(item => {
    return {
      json: {
        ...item.json,
        processado: true,
        timestamp: new Date().toISOString()
      }
    };
  });
}

// Exemplo 2: Fazer requisição HTTP usando axios (disponível globalmente)
async function buscarDados(url) {
  const axios = require('axios');
  const response = await axios.get(url);
  return response.data;
}

// Exemplo 3: Manipular datas com moment
function formatarData(data) {
  const moment = require('moment');
  return moment(data).format('DD/MM/YYYY HH:mm:ss');
}

// Exemplo 4: Gerar UUID
function gerarId() {
  const { v4: uuidv4 } = require('uuid');
  return uuidv4();
}

// Exemplo 5: Criptografia simples
function criptografar(texto, chave) {
  const CryptoJS = require('crypto-js');
  return CryptoJS.AES.encrypt(texto, chave).toString();
}

function descriptografar(textoCriptografado, chave) {
  const CryptoJS = require('crypto-js');
  const bytes = CryptoJS.AES.decrypt(textoCriptografado, chave);
  return bytes.toString(CryptoJS.enc.Utf8);
}

// Exportar funções para uso
module.exports = {
  processarItens,
  buscarDados,
  formatarData,
  gerarId,
  criptografar,
  descriptografar
};
