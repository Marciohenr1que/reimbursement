# Sistema de Controle de Reembolsos

## 📌 Introdução

Este projeto é um sistema de controle de reembolsos que permite que usuários registrem seus gastos diretamente pelo smartphone, anexando fotos dos comprovantes fiscais. O objetivo principal é acelerar o processo de solicitação e reembolso, além de proporcionar aos gestores uma visão clara sobre os gastos realizados.

### 🎯 Objetivos

1. **Agilidade** no processo de solicitação e reembolso.
2. **Consulta eficiente** para gestores, permitindo avaliação detalhada dos reembolsos por **quem**, **quando**, **onde** e **quanto**.
3. **Classificação flexível** dos gastos através de rótulos (tags), como "transporte" ou "projeto/x", proporcionando melhor contexto no momento da análise.

## 🚀 Tecnologias Utilizadas

- **Ruby on Rails**
- **PostgreSQL**
- **Docker**

## 🛠 Como Rodar o Projeto

### 🔧 Pré-requisitos

Certifique-se de ter o **Docker** e **Docker Compose** instalados na sua máquina.

### 📦 Rodando a aplicação

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/Marciohenr1que/reimbursement.git
   ```

2. **Crie e suba os containers:**

   ```bash
   docker-compose up --build
   ```

3. **Acesse o container da aplicação:**

   ```bash
   docker exec -it rails_api bash
   ```

4. **Configure o banco de dados:**

   ```bash
   rails db:create db:migrate
   ```

5. **Acesse a aplicação:**
   - Se estiver rodando localmente, a aplicação estará disponível em:
     ```
     http://localhost:3001
     ```

## 📝 Testes

Para rodar os testes dentro do container:

```bash
bundle exec rspec
```
