#!/usr/bin/env python3
"""
Exemplo de script Python para uso no n8n
Este script pode ser chamado usando o nó "Execute Command"
"""

import json
import sys
from datetime import datetime

def processar_dados(dados):
    """
    Função de exemplo que processa dados recebidos
    """
    resultado = {
        "timestamp": datetime.now().isoformat(),
        "dados_processados": dados,
        "status": "sucesso"
    }
    return resultado

if __name__ == "__main__":
    # Recebe dados via argumento ou stdin
    if len(sys.argv) > 1:
        entrada = sys.argv[1]
    else:
        entrada = sys.stdin.read()

    try:
        dados = json.loads(entrada) if entrada else {}
    except json.JSONDecodeError:
        dados = {"raw": entrada}

    resultado = processar_dados(dados)
    print(json.dumps(resultado, ensure_ascii=False, indent=2))
