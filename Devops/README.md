# Projeto SafeAlert - CRUD Java + PostgreSQL com Docker

Este projeto implementa uma aplicação Java Spring Boot com um CRUD completo, persistindo os dados em um banco PostgreSQL. Ambos os containers (aplicação e banco) são executados via Docker em segundo plano, conforme os requisitos da disciplina **DevOps Tools & Cloud Computing**.

---

## 📦 Estrutura do Projeto

```
.
├── db/
|    ├── Dockerfile  # Arquivo Docker File do BANCO DE DADOS POSTGRE                         
├── src/                        
│   └── main/
│       ├── java/
│       └── resources/
│           └── application.properties  # Configurado para o Banco de Dados
├── target/                    
├── Dockerfile # Arquivo Dockerfile da API JAVA                 
├── docker-compose.yml #Arquivo docker-compose para integrar o banco de dados a API         
├── pom.xml                     
├── SWAGGER-POST.txt           

````

---

## 🚀 Como Executar

### 1. Clone o repositório
```bash
git clone https://github.com/thejaobiell/GS-Devops.git
cd GS-Devops/safealert
````

### 2. Suba os containers em segundo plano

```bash
docker-compose up -d --build
```

### 3. Verifique se os containers estão rodando

```bash
docker ps
```

### 4. Exiba os logs

```bash
docker logs -f safealert_app
docker logs -f postgres_db
```

---

## 🔧 Configurações Importantes

* A aplicação lê as variáveis de ambiente no `application.properties`, como `SPRING_DATASOURCE_URL`, `USERNAME`, e `PASSWORD`.
* O banco de dados utiliza uma **imagem personalizada via Dockerfile**, com **usuário não-root**, **diretório de trabalho**, e **variável de ambiente** definida.

---

## 📁 Volume de Persistência

O banco PostgreSQL utiliza um **volume nomeado** para garantir persistência dos dados mesmo após reinício dos containers.

```yaml
volumes:
  pgdata:
```

---

## 🔄 Testes do CRUD
Você pode testar usando:

* [ ] Postman (IMPORTE O ARQUIVO `Global Solution - SafeAlert.postman_collection.json` PARA O POSTMAN )
* [ ] Swagger (http://localhost:8080/swagger-ui/index.html)

---

## 🎥 Vídeo da Entrega

[Link do VÍDEO](https://youtu.be/O9FonBimsoc?si=S1-9gWYEJO3zZwjK)

---

## 👨‍💻 Membros do Grupo

* **João Gabriel Boaventura Marques e Silva** — RM554874
* **Léo Mota Lima** — RM557851
* **Lucas Leal das Chagas** — RM551124

> Turma: 2TDSB – 2025
