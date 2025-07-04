# 1. Define a imagem base. Usamos a versão 'slim' do Python 3.10,
FROM python:3.13.5-alpine3.22

# 2. Define o diretório de trabalho dentro do contêiner.
# Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# 3. Copia o arquivo de dependências para o diretório de trabalho.
# Fazemos isso antes de copiar o resto do código para aproveitar o cache do Docker.
COPY requirements.txt .

# 4. Instala as dependências do projeto.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o restante dos arquivos da aplicação para o diretório de trabalho.
COPY . .

# 6. Expõe a porta em que a aplicação será executada.
EXPOSE 8000

# 7. Define o comando para executar a aplicação quando o contêiner iniciar.
# Usamos "0.0.0.0" para que a API seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]