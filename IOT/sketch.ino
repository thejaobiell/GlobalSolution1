#include <WiFi.h>
#include <PubSubClient.h>

// --- Configurações de Rede e MQTT ---
const char* SSID = "Wokwi-GUEST";
const char* PASSWORD = "";
const char* MQTT_BROKER = "broker.hivemq.com";
const int MQTT_PORT = 1883;

// --- Tópicos MQTT ---
const char* TOPICO_PUBLICAR_DISTANCIA = "iot/sensor/distancia";
const char* TOPICO_INSCREVER_LED_VERDE = "iot/led/verde";
const char* TOPICO_INSCREVER_LED_AMARELO = "iot/led/amarelo";
const char* TOPICO_INSCREVER_LED_VERMELHO = "iot/led/vermelho";
const char* TOPICO_INSCREVER_BUZZER = "iot/buzzer/estado";

// --- Pinos do ESP32 ---
const int PINO_TRIG = 27;
const int PINO_ECHO = 26;
const int PINO_LED_VERDE = 14;
const int PINO_LED_AMARELO = 12;
const int PINO_LED_VERMELHO = 13;
const int PINO_BUZZER = 15;

// --- Variáveis Globais ---
WiFiClient espClient;
PubSubClient client(espClient);
unsigned long lastMsg = 0;
const long interval = 5000; // Publicar a cada 5 segundos

// --- Protótipos de Funções ---
void setup_wifi();
void reconnect();
void callback(char* topic, byte* payload, unsigned int length);
float lerDistanciaCm();

void setup() {
  Serial.begin(115200);

  // Configuração dos pinos
  pinMode(PINO_TRIG, OUTPUT);
  pinMode(PINO_ECHO, INPUT);
  pinMode(PINO_LED_VERDE, OUTPUT);
  pinMode(PINO_LED_AMARELO, OUTPUT);
  pinMode(PINO_LED_VERMELHO, OUTPUT);
  pinMode(PINO_BUZZER, OUTPUT);

  // Iniciar conexões
  setup_wifi();
  client.setServer(MQTT_BROKER, MQTT_PORT);
  client.setCallback(callback);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  unsigned long now = millis();
  if (now - lastMsg > interval) {
    lastMsg = now;

    // Ler o sensor e publicar a distância
    float distancia = lerDistanciaCm();
    Serial.print("Distância medida: ");
    Serial.print(distancia);
    Serial.println(" cm");

    char msg[10];
    dtostrf(distancia, 4, 2, msg);
    client.publish(TOPICO_PUBLICAR_DISTANCIA, msg);
  }
}

// --- Funções Auxiliares ---

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Conectando a ");
  Serial.println(SSID);
  WiFi.begin(SSID, PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi conectado!");
}

void callback(char* topic, byte* payload, unsigned int length) {
  String message;
  for (int i = 0; i < length; i++) {
    message += (char)payload[i];
  }
  int estado = message.toInt();

  Serial.print("Mensagem recebida no tópico: ");
  Serial.println(topic);
  Serial.print("Payload: ");
  Serial.println(message);

  if (String(topic) == TOPICO_INSCREVER_LED_VERDE) {
    digitalWrite(PINO_LED_VERDE, estado == 1 ? HIGH : LOW);
  } else if (String(topic) == TOPICO_INSCREVER_LED_AMARELO) {
    digitalWrite(PINO_LED_AMARELO, estado == 1 ? HIGH : LOW);
  } else if (String(topic) == TOPICO_INSCREVER_LED_VERMELHO) {
    digitalWrite(PINO_LED_VERMELHO, estado == 1 ? HIGH : LOW);
  } else if (String(topic) == TOPICO_INSCREVER_BUZZER) {
    digitalWrite(PINO_BUZZER, estado == 1 ? HIGH : LOW);
  }
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Tentando conexão MQTT...");
    if (client.connect("Wokwi-Client-ESP32")) {
      Serial.println("Conectado!");
      // Inscreve-se nos tópicos de controle
      client.subscribe(TOPICO_INSCREVER_LED_VERDE);
      client.subscribe(TOPICO_INSCREVER_LED_AMARELO);
      client.subscribe(TOPICO_INSCREVER_LED_VERMELHO);
      client.subscribe(TOPICO_INSCREVER_BUZZER);
    } else {
      Serial.print("Falhou, rc=");
      Serial.print(client.state());
      Serial.println(" Tentando novamente em 5 segundos");
      delay(5000);
    }
  }
}

float lerDistanciaCm() {
  digitalWrite(PINO_TRIG, LOW);
  delayMicroseconds(2);
  digitalWrite(PINO_TRIG, HIGH);
  delayMicroseconds(10);
  digitalWrite(PINO_TRIG, LOW);
  
  long duracao = pulseIn(PINO_ECHO, HIGH);
  return (duracao * 0.0343) / 2.0;
}
