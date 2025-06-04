// Pinos do sensor ultrassônico HC-SR04
const int TRIG_PIN = 7;
const int ECHO_PIN = 6;

// Pinos dos LEDs
const int LED_VERDE_PIN = 10;
const int LED_AMARELO_PIN = 9;
const int LED_VERMELHO_PIN = 8;

// Pino do Buzzer
const int BUZZER_PIN = 5;

// Configurações de nível de água (em cm)
const float ALTURA_SENSOR_DO_LEITO_RIO_CM = 300.0;
const float NIVEL_NORMAL_MAX_CM = 150.0;
const float NIVEL_ALERTA_MAX_CM = 220.0;

// Alerta externo simulado (0 = nenhum, 1 = moderado, 2 = alto)
int alertaApiSimulado = 0;

long duracaoOnda;
float distanciaCmMedida;
float nivelAguaAtualCm;

void setup() {
  Serial.begin(115200);

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);

  pinMode(LED_VERDE_PIN, OUTPUT);
  pinMode(LED_AMARELO_PIN, OUTPUT);
  pinMode(LED_VERMELHO_PIN, OUTPUT);

  pinMode(BUZZER_PIN, OUTPUT);

  Serial.println("Monitor de Nivel de Rio Inicializado");
}

void loop() {
  // Dispara pulso ultrassônico
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  duracaoOnda = pulseIn(ECHO_PIN, HIGH);
  distanciaCmMedida = duracaoOnda * 0.0343 / 2.0;
  nivelAguaAtualCm = ALTURA_SENSOR_DO_LEITO_RIO_CM - distanciaCmMedida;

  // Validação da leitura
  if (distanciaCmMedida <= 0 || distanciaCmMedida > ALTURA_SENSOR_DO_LEITO_RIO_CM) {
    if (distanciaCmMedida <= 0 && duracaoOnda > 0) {
      nivelAguaAtualCm = ALTURA_SENSOR_DO_LEITO_RIO_CM;
    } else if (nivelAguaAtualCm < 0) {
      nivelAguaAtualCm = 0;
    }
  }

  Serial.print("Distancia: ");
  Serial.print(distanciaCmMedida);
  Serial.print(" cm | Nivel: ");
  Serial.print(nivelAguaAtualCm);
  Serial.print(" cm | Alerta API: ");
  Serial.println(alertaApiSimulado);

  bool estadoLedVermelho = false;
  bool estadoLedAmarelo = false;
  bool estadoLedVerde = false;
  String mensagemEstado = "";

  // Estado baseado no nível da água
  if (nivelAguaAtualCm > NIVEL_ALERTA_MAX_CM) {
    estadoLedVermelho = true;
    mensagemEstado = "PERIGO DE INUNDACAO (Nivel ALTO)";
  } else if (nivelAguaAtualCm > NIVEL_NORMAL_MAX_CM) {
    estadoLedAmarelo = true;
    mensagemEstado = "ALERTA (Nivel MODERADO)";
  } else {
    estadoLedVerde = true;
    mensagemEstado = "NORMAL (Nivel BAIXO)";
  }

  // Estado influenciado pelo alerta externo
  if (alertaApiSimulado == 2) {
    estadoLedVermelho = true;
    estadoLedAmarelo = false;
    estadoLedVerde = false;
    if (!mensagemEstado.startsWith("PERIGO DE INUNDACAO (Nivel ALTO)")) {
      mensagemEstado = "PERIGO DE INUNDACAO (Alerta Externo MAXIMO)";
    }
  } else if (alertaApiSimulado == 1) {
    if (estadoLedVerde) {
      estadoLedAmarelo = true;
      estadoLedVerde = false;
      mensagemEstado = "ALERTA (Alerta Externo MODERADO)";
    }
  }

  digitalWrite(LED_VERDE_PIN, estadoLedVerde ? HIGH : LOW);
  digitalWrite(LED_AMARELO_PIN, estadoLedAmarelo ? HIGH : LOW);
  digitalWrite(LED_VERMELHO_PIN, estadoLedVermelho ? HIGH : LOW);

  Serial.print("Estado: ");
  Serial.println(mensagemEstado);

  if (estadoLedVermelho) {
    tone(BUZZER_PIN, 1000);
  } else {
    noTone(BUZZER_PIN);
  }

  Serial.println("------------------------------------------------------");
  delay(1000);
}
