# 🚨 SafeAlert – Mobile (React Native + Expo) + API (Java)

**SafeAlert** é um aplicativo mobile desenvolvido com **React Native (Expo)** para **reportar e monitorar eventos extremos em tempo real** — como desastres naturais, acidentes e emergências — **na cidade de São Paulo**. O objetivo é auxiliar **cidadãos e autoridades locais** com informações ágeis e confiáveis, promovendo uma resposta mais rápida em situações críticas.

---

## 📱 Funcionalidades

* Cadastro e login de usuários
* Criação de alertas com título, descrição, localização e tipo do evento
* Visualização de alertas em tempo real

---

## 🧪 Tecnologias Utilizadas

* **React Native** com **Expo**
* **React Navigation** (navegação de telas)
* **Axios** (comunicação com a API)
* **AsyncStorage** (armazenamento local das informações do usuário)

---


## 📁 Estrutura do Repositório

```
global-solution-1-semestre-safealert/
│
├── SafeAlert/ 
│   ├── .expo/                
│   ├── .vscode/                 
│   ├── assets/                      
│   ├── Images/
│   ├── Navigation/
│   ├── Source/
│   │   ├── Components/
│   │   │   └── PostCard/ 
│   │   │       ├── PostCard.tsx
│   │   │       └── StylePostCard.ts
│   │   └── Screens/ 
│   │       ├── BuscarPostagens/
│   │       ├── Cadastro/
│   │       ├── Login/
│   │       ├── PerfilDoUsuario/
│   │       ├── RegistrarEventoExtremo/
│   │       └── VerPostagens/
│   ├── Types/
│   │       ├── ApiBase.ts
│   │       ├── Cores.ts
│   │       ├── Localidade.ts
│   │       ├── Post.ts
│   │       ├── PropsTypes.ts
│   │       ├── Telas.ts
│   │       └── User.ts
│   ├── App.tsx   
│   ├── app.json                  
│   ├── index.ts                      
│   ├── package.json                 
│   ├── package-lock.json
│   └── tsconfig.json                
│
└── README.md 
```

---

## 🎥 Vídeo

📽️ [Demonstração do Aplicativo](https://youtu.be/E7OMUrOjvd4)

---

## 🚀 Como Rodar o Projeto

### 🔧 Pré-requisitos

* Node.js (v18 ou superior)
* Expo CLI instalado:
* Java 17
* Maven
* Oracle Database (Usar FIAP ou do ORACLE XE)
* App **Expo Go** instalado no celular (Android/iOS)

---

## 🚀 Como Rodar o Projeto

### 🔧 Pré-requisitos

* Node.js (v18 ou superior)
* Expo CLI instalado:

```bash
npm install -g expo-cli
```

* Java 17 + Maven
* Oracle Database (FIAP)
* App **Expo Go** no celular (Android/iOS)

---

## 🛠️ Como Executar o Projeto (API + Mobile)

Antes de começar, **crie uma pasta local** para organizar os dois repositórios (API e App Mobile), por exemplo:

```bash
mkdir SafeAlert-GlobalSolution
cd SafeAlert-GlobalSolution
```

---

### ▶️ Rodar a API Backend Localmente

1. **Clone o repositório do backend:**

```bash
git clone https://github.com/thejaobiell/GS-JavaAdvanced.git
```

2. **Acesse o diretório do projeto:**

```bash
cd GS-JavaAdvanced/safealert
code .
```

3. **Configure o `application.properties` com os dados do Oracle da FIAP:**

### 🗂️ **Caminho completo do arquivo:**

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

4. **Execute o projeto:**

No **Linux**:

```bash
./mvnw spring-boot:run
```

No **Windows**:

```bash
mvnw.cmd spring-boot:run
```

5. **Testar localmente a API:**

```bash
http://localhost:8080/api/<endpoint>
```

ou

```bash
http://<IP LOCAL DA MÁQUINA>:8080/api/<endpoint>
```

> 💡 Para descobrir o IP local da sua máquina:
> - **Linux:** use `hostname -I` ou `ip a`
> - **Windows:** use `ipconfig` no Prompt de Comando

---

### ▶️ Rodar o App Mobile (Expo)

1. **Volte para a pasta criada anteriormente:**

```bash
cd ../..
```

2. **Clone o repositório do app mobile:**

```bash
git clone https://github.com/FIAP-MOBILE/global-solution-1-semestre-safealert.git
```

3. **Acesse o diretório do projeto:**

```bash
cd global-solution-1-semestre-safealert/SafeAlert
code .
```

4. **Instale as dependências:**

```bash
npm install
```

5. **Configurar a URL da API (OBRIGATÓRIO):**

Abra o arquivo:

```
Types/ApiBase.ts
```

E altere a baseURL conforme o IP local da máquina onde o backend está rodando:

```ts
baseURL: 'http://<SEU_IP_LOCAL>:8080/api',
```

> 💡 Para descobrir o IP local da sua máquina:
> - **Linux:** use `hostname -I` ou `ip a`
> - **Windows:** use `ipconfig` no Prompt de Comando

6. **Inicie o servidor Expo:**

```bash
npm start
```

ou

```bash
npx expo start --tunnel
```

7. **Abra o app no celular:**

* Escaneie o QR Code com o **Expo Go**
* Ou utilize um **emulador Android/iOS** já configurado

---

## 👨‍💻 Desenvolvedores

* **João Gabriel Boaventura Marques e Silva** — RM554874
* **Léo Mota Lima** — RM557851
* **Lucas Leal das Chagas** — RM551124

> Turma: 2TDSB – FIAP 2025
