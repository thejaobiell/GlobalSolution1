# 🚨 SafeAlert
**SafeAlert** é uma plataforma de comunicação desenvolvida para **reportar e monitorar em tempo real eventos extremos** — como desastres naturais, acidentes e situações de emergência — **ocorridos na cidade de São Paulo**. A solução tem como objetivo **auxiliar tanto os cidadãos quanto as autoridades locais** com informações ágeis, precisas e confiáveis, promovendo uma resposta mais rápida e eficaz frente a situações críticas.

---

## 📌 Funcionalidades Principais

* Cadastro e autenticação de usuários
* Criação de alertas com título, descrição, localização e tipo do evento
* Listagem de alertas públicos em tempo real
* Edição e exclusão de alertas por usuários autorizados

---

## 🧪 Tecnologias Utilizadas

* **Backend:** Java 17 + Spring Boot
* **Segurança:** Spring Security + JWT
* **Banco de Dados:** PostgreSQL (Deploy) | Oracle Database (Localhost)
* **Deploy:** Render.com
* **Gerenciamento de Dependências:** Maven
* **Documentação da API:** Swagger

---

## 🚀 Deploy da Aplicação

Acesse a aplicação em produção pelo link abaixo:
🔗 [https://gs-javaadvanced.onrender.com](https://gs-javaadvanced.onrender.com)

---

## 📁 Como Rodar Localmente

### 🔧 Pré-requisitos

* Java 17
* Maven
* Oracle Database
* IDE (Eclipse ou VS Code)

---

## ✅ Execução via Terminal

### 1. [Clone o repositório](https://github.com/thejaobiell/GS-JavaAdvanced)

```bash
git clone https://github.com/thejaobiell/GS-JavaAdvanced.git
```

### 2. Acesse o diretório do projeto

```bash
cd GS-JavaAdvanced/safealert
```
3. **Configure o `application.properties` com os dados do Oracle da FIAP:**

###### 🗂️ **Caminho completo do arquivo:**

```
src/main/resources/application.properties
```

Usando Oracle Database FIAP:

```properties
spring.application.name=safealert

spring.datasource.url=jdbc:oracle:thin:@oracle.fiap.com.br:1521/orcl
spring.datasource.username=<SEU_RM>
spring.datasource.password=<SUA_SENHA>
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver

spring.jpa.database-platform=org.hibernate.dialect.OracleDialect
spring.jpa.hibernate.ddl-auto=update

spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

management.endpoints.web.exposure.include=health
````

Usando Oracle Database XE [(recomendo instalação via DOCKER)](https://chatgpt.com/share/68434468-80b0-8008-817e-c2fcdf2da861):

```properties
spring.application.name=safealert

spring.datasource.url=jdbc:oracle:thin:@//localhost:1521/freepdb1
spring.datasource.username=<SEU_USERNAME>
spring.datasource.password=<SUA_SENHA>
spring.datasource.driver-class-name=oracle.jdbc.OracleDriver

spring.jpa.database-platform=org.hibernate.dialect.OracleDialect
spring.jpa.hibernate.ddl-auto=update

spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

management.endpoints.web.exposure.include=health 
```

### ⚠️ Observação Importante

> **Caso você enfrente erros como `ORA-12519`, `ORA-12516` ou mensagens relacionadas a *session limits* ao usar o Oracle da FIAP, recomendamos utilizar o Oracle XE como segunda opção.**
> O Oracle XE pode ser facilmente instalado localmente via Docker e oferece mais estabilidade para testes e desenvolvimento sem limitações de sessões simultâneas.


### 4. Execute o projeto

Em linux:
```bash
./mvnw spring-boot:run
```

Em Windows:
```bash
mvnw.cmd spring-boot:run
```

### 5. Teste localmente

```bash
http://localhost:8080/api/<endpoint>
```

ou

```bash
http://<IP LOCAL DA MÁQUINA>:8080/api/<endpoint>
```

> Caso esteja online, utilize a URL de Deploy:
> `https://gs-javaadvanced.onrender.com/api/<endpoint>`

---

## ✅ Execução via Eclipse IDE

### 1. Abra o Eclipse

### 2. Vá em: `File > Import...`

### 3. Selecione: `Maven > Existing Maven Projects`

### 4. Clique em "Browse" e selecione a pasta do projeto (`GS-JavaAdvanced/safealert`)

### 5. Marque o arquivo `pom.xml`

### 6. Clique em "Finish" para concluir

### 7. Configure o `application.properties` conforme instruções anteriores

### 8. Execute o projeto com: `Run As > Java Application`

---

## 🔐 Credenciais de Acesso para Token JWT

* **Usuário:** `admin@safealert.com`
* **Senha:** `2tdsb-2025`

> Use o método **POST** no Postman ou Insomnia para obter o token JWT.

---

## 🎥 Vídeos

📽️ [Vídeo Pitch](https://www.youtube.com/watch?v=YEXlSVQTqaA)


📽️ [Vídeo Demonstrando a API](https://youtu.be/SbV9s94TQM8)

---

## 👨‍💻 Membros do Grupo

* **João Gabriel Boaventura Marques e Silva** — RM554874
* **Léo Mota Lima** — RM557851
* **Lucas Leal das Chagas** — RM551124

> Turma: 2TDSB – 2025
