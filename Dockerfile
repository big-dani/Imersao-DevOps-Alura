# 1. Usar uma imagem base oficial do Python. `slim` é uma boa opção para produção.
FROM python:3.10-slim

# 2. Definir o diretório de trabalho no contêiner para /app
WORKDIR /app

# 3. Copiar o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# 4. Instalar as dependências
#    --no-cache-dir: Desabilita o cache do pip para manter a imagem menor.
#    --upgrade pip: Garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho
COPY . .

# 6. Expor a porta 8000 para que ela possa ser mapeada pelo Docker host
EXPOSE 8000

# 7. Comando para executar a aplicação quando o contêiner for iniciado.
#    Usamos --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

