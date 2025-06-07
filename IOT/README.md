# Monitor de Nível de Rio com ESP32, Wokwi e Node-RED

## 📖 Descrição
Este projeto simula um sistema de monitoramento do nível de um rio utilizando um ESP32, o simulador online Wokwi e o Node-RED. O sensor ultrassônico HC-SR04, conectado ao ESP32, mede a distância até a superfície da água. Esses dados são enviados via protocolo MQTT para um fluxo no Node-RED, que processa a informação, determina o estado de alerta (Normal, Alerta ou Perigo) e envia comandos de volta para o ESP32 para acionar LEDs de sinalização e um buzzer.

O sistema também é capaz de receber um comando de alerta externo (via API, por exemplo), que pode sobrepor o estado medido pelo sensor, aumentando a robustez do sistema de alerta.

## ✨ Como Funciona
O fluxo de trabalho do sistema é o seguinte:

### Simulação no Wokwi
- Um ESP32 com um sensor ultrassônico HC-SR04 simula a medição da distância até a água.
- O código no ESP32 se conecta a uma rede Wi-Fi e a um broker MQTT público.
- A distância medida é publicada em um tópico MQTT (`iot/sensor/distancia`).
- O ESP32 também se inscreve em tópicos MQTT para receber comandos para controlar três LEDs (verde, amarelo, vermelho) e um buzzer.

### Processamento no Node-RED
- O fluxo do Node-RED se inscreve no tópico de distância do sensor e em um tópico de alerta externo (`iot/api/alerta`).
- Um nó de função principal calcula o nível real da água com base na altura do sensor.
- Com base no nível da água e no alerta externo, a função determina o status: Normal, Alerta ou Perigo.
- O Node-RED publica mensagens nos tópicos apropriados para ligar/desligar os LEDs e o buzzer no Wokwi.
- Um status completo com todos os dados (distância, nível, status dos atuadores) é publicado para depuração ou visualização em um dashboard (`iot/status/dados`).

## 🛠️ Componentes (Simulação Wokwi)
A simulação no Wokwi utiliza os seguintes componentes virtuais:

1x Placa de Desenvolvimento ESP32 DevKit v1

1x Sensor Ultrassônico HC-SR04
1x LED Verde
1x LED Amarelo
1x LED Vermelho
1x Buzzer
3x Resistor de 220Ω

- 1x Placa de Desenvolvimento ESP32 DevKit v1
- 1x Sensor Ultrassônico HC-SR04
- 1x LED Verde
- 1x LED Amarelo
- 1x LED Vermelho
- 1x Buzzer
- 3x Resistor de 220Ω

A montagem dos componentes está definida no arquivo `diagram.json`.

## ⚙️ Software e Serviços
- **Wokwi**: Simulador online para projetos de eletrônica e IoT.
- **Node-RED**: Ferramenta de programação visual baseada em fluxos.
- **Broker MQTT Público**: Utilizado para a comunicação entre o ESP32 e o Node-RED (neste caso, `broker.hivemq.com`).

## 🚀 Configuração e Uso

### 1. Configurar o Wokwi
1.  Acesse o Wokwi.
2.  Carregue os arquivos do projeto:
    *   `diagram.json`: Define a montagem dos componentes no painel.
    *   `sketch.ino` (ou o seu arquivo de código principal do Arduino): Contém o código que será executado no ESP32.
    *   `libraries.txt`: Para garantir que a biblioteca `PubSubClient` seja instalada.
3.  **Código do ESP32**: O arquivo `sketch.ino` já contém o código C++ para o ESP32 que realiza as seguintes tarefas:
    *   Conexão com a rede Wi-Fi.
    *   Conexão com o broker MQTT.
    *   Leitura periódica do sensor HC-SR04.
    *   Publicação da distância no tópico `iot/sensor/distancia`.
    *   Subscrição aos tópicos `iot/led/verde`, `iot/led/amarelo`, `iot/led/vermelho` e `iot/buzzer/estado` para controlar os atuadores.
4.  Inicie a simulação no Wokwi.

### 2. Configurar o Node-RED
1.  Abra sua instância do Node-RED.
2.  Clique no menu no canto superior direito > **Import**.
3.  Cole o conteúdo do arquivo `node.json` e importe o fluxo.
4.  O fluxo já está configurado para se conectar ao broker público do HiveMQ. Se necessário, você pode alterar a configuração no nó `mqtt-broker-config`.
5.  Clique em **Deploy** para ativar o fluxo.

### 3. Executando a Simulação
1.  Com a simulação rodando no Wokwi e o fluxo ativo no Node-RED, o sistema estará operacional.
2.  No Wokwi, clique no sensor HC-SR04 para alterar a distância simulada.
3.  Observe como os LEDs e o buzzer respondem de acordo com a lógica definida no Node-RED.

## 📡 Tópicos MQTT

| Tópico                | Publicado por   | Consumido por   | Descrição                                                              |
|-----------------------|-----------------|-----------------|------------------------------------------------------------------------|
| `iot/sensor/distancia`| ESP32 (Wokwi)   | Node-RED        | Envia a distância medida pelo sensor em centímetros.                     |
| `iot/api/alerta`      | Cliente Externo | Node-RED        | Envia um nível de alerta manual (0: sem alerta, 1: Alerta, 2: Perigo). |
| `iot/led/verde`       | Node-RED        | ESP32 (Wokwi)   | Comando para ligar/desligar o LED verde (`1` ou `0`).                        |
| `iot/led/amarelo`     | Node-RED        | ESP32 (Wokwi)   | Comando para ligar/desligar o LED amarelo (`1` ou `0`).                      |
| `iot/led/vermelho`    | Node-RED        | ESP32 (Wokwi)   | Comando para ligar/desligar o LED vermelho (`1` ou `0`).                     |
| `iot/buzzer/estado`   | Node-RED        | ESP32 (Wokwi)   | Comando para ligar/desligar o buzzer (`1` ou `0`).                           |
| `iot/status/dados`    | Node-RED        | (Opcional)      | Publica um JSON com o estado completo do sistema para depuração.         |

🧠 Lógica de Alerta (Node-RED)
A lógica principal está no nó de função "Calcula Nível e Define Alertas":

Constantes:

ALTURA_SENSOR: Altura do sensor em relação ao leito do rio (ex: 300 cm).
NIVEL_NORMAL: Nível máximo para o status "Normal" (ex: 150 cm).
NIVEL_ALERTA: Nível máximo para o status "Alerta" (ex: 220 cm).

Cálculo:

nivelAgua = ALTURA_SENSOR - distancia
Regras de Status:

PERIGO: nivelAgua > NIVEL_ALERTA OU alertaApi == 2. Ativa o LED vermelho e o buzzer.
ALERTA: nivelAgua > NIVEL_NORMAL OU alertaApi == 1. Ativa o LED amarelo.
NORMAL: Caso contrário. Ativa o LED verde.

### Constantes:
-   `ALTURA_SENSOR`: Altura do sensor em relação ao leito do rio (ex: `300 cm`).
-   `NIVEL_NORMAL`: Nível máximo para o status "Normal" (ex: `150 cm`).
-   `NIVEL_ALERTA`: Nível máximo para o status "Alerta" (ex: `220 cm`).

### Cálculo:
-   `nivelAgua = ALTURA_SENSOR - distancia`

### Regras de Status:
-   **PERIGO**: `nivelAgua > NIVEL_ALERTA` OU `alertaApi == 2`. Ativa o LED vermelho e o buzzer.
-   **ALERTA**: `nivelAgua > NIVEL_NORMAL` OU `alertaApi == 1`. Ativa o LED amarelo.
-   **NORMAL**: Caso contrário. Ativa o LED verde.
