# 🚨 SAFE-ALERT – API REST para Monitoramento de Eventos Extremos

A **SAFE-ALERT** é uma plataforma para **monitoramento, alerta e comunicação em tempo real** sobre **eventos extremos** como enchentes, incêndios e deslizamentos. Esta API REST atua como backend e se integra a uma **aplicação Java Web**, permitindo:

- Gerenciamento de usuários
- Registro e consulta de ocorrências
- Publicação de alertas
- Monitoramento de localidades

---

## 📦 Instalação

1. Clone o repositório:

```bash
git clone https://github.com/leomotalima/SafeAlertDotNet.git
cd SafeAlertDotNet
```

2. Restaure os pacotes:

```bash
dotnet restore
```

3. Configure a conexão com o Oracle no arquivo `appsettings.json`:

```json
"ConnectionStrings": {
  "OracleDb": "User Id=usuario;Password=senha;Data Source=oracle.fiap.com.br:1521/orcl"
}
```

4. Crie o banco com EF Core:

```bash
dotnet ef migrations add Inicial
dotnet ef database update
```

5. Rode o projeto:

```bash
dotnet run
```

# 6. Acesse a documentação Swagger
```txt
http://localhost:5241/swagger
```

---


## 📂 Endpoints Disponíveis

Os principais endpoints estão organizados por entidade:
---

## 📂 Endpoints

### 👤 Usuários

- `GET /usuarios`
- `GET /usuarios/{id}`
- `POST /usuarios`
- `PUT /usuarios/{id}`
- `DELETE /usuarios/{id}`

### 🌍 Localidades

- `GET /localidades`
- `GET /localidades/{id}`
- `POST /localidades`
- `PUT /localidades/{id}`
- `DELETE /localidades/{id}`

### 🌪️ Eventos

- `GET /eventos`
- `GET /eventos/{id}`
- `POST /eventos`
- `PUT /eventos/{id}`
- `DELETE /eventos/{id}`

### 📢 Postagens

- `GET /postagens`
- `GET /postagens/{id}`
- `POST /postagens`
- `PUT /postagens/{id}`
- `DELETE /postagens/{id}`

### 🆘 Ocorrências

- `GET /ocorrencias`
- `GET /ocorrencias/{id}`
- `POST /ocorrencias`
- `PUT /ocorrencias/{id}`
- `DELETE /ocorrencias/{id}`

---

## 🧪 Tecnologias Usadas

- .NET 8 (Minimal API)
- Entity Framework Core
- Oracle Database
- Swagger (OpenAPI)
- Java Web (frontend)

---

## 🎓 Disciplinas Envolvidas

| Disciplina        | Aplicação                                                                 |
|-------------------|---------------------------------------------------------------------------|
| Java Advanced     | Interface web integrada à API REST                                        |
| Banco de Dados    | Persistência com Oracle                                                   |

## 📌 Observações

* Existe um arquivo **POST.txt** com templates para testar a api;
* O projeto utiliza o padrão **DTO** para encapsulamento e segurança dos dados;
* Os dados trafegam via JSON;
* Ideal para uso interno de sistemas de monitoramento e controle de frotas de motos;

---


## 👥 Equipe de Desenvolvimento

- **João Gabriel Boaventura Marques e Silva** - RM554874 - 2TDSB2025
- **Léo Mota Lima** - RM557851 - 2TDSB2025
- **Lucas Leal das Chagas** - RM551124 - 2TDSB2025
