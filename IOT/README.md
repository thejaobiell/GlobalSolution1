# 🌊💧 Monitor de Nível de Rio e Alerta de Enchentes (Simulação no Wokwi)

## 👋 Olá! Bem-vindo ao nosso projeto de simulação de um sistema de alerta de enchentes!

### O que é este projeto?

Imagine que podemos construir um "vigia" eletrônico para um rio. Ele usa um sensor para medir o nível da água. Se a água subir demais, ele acende luzes de alerta e até dispara um alarme! Vamos simular tudo isso usando o [Wokwi](https://wokwi.com).

### Para que serve?

Aprender a usar sensores, programar o Arduino para tomar decisões e criar alertas para situações de perigo, como uma enchente.

## ✨ O que o nosso "Vigia Eletrônico" faz?

### Mede a Água:

* Usa o sensor **HC-SR04** que envia som ultrassônico e mede o tempo de retorno.

### Calcula o Nível:

* Usa a distância medida e a altura do sensor para saber o nível da água:

  ```
  Nivel da Água = Altura do Sensor - Distância Medida
  ```

### Mostra Alertas com LEDs:

* 🟢 **Verde**: Nível normal
* 🟡 **Amarelo**: Alerta
* 🔴 **Vermelho**: Perigo de Inundação

### Alarme Sonoro:

* Um **buzzer** 🔊 toca se o LED vermelho estiver ativo

### Simula Alerta Externo:

* A variável `alertaApiSimulado` simula avisos meteorológicos:

  * `0` = sem alerta
  * `1` = alerta moderado
  * `2` = alerta alto

### Exibe Dados no Monitor Serial:

* Mostra distância, nível da água e alerta ativo

### Personalizável:

* Os valores de alerta são fáceis de mudar no código

## ⚙️ Como Funciona?

### 1. Sensor HC-SR04:

* Arduino envia pulso (TRIG)
* Sensor emite ultrassom
* Reflete na água e volta (ECHO)
* Arduino mede o tempo e calcula a distância

### 2. Cálculo:

* Distância \* 0.0343 / 2 = cm
* Nível da água = altura total - distância

### 3. Decisão e Alerta:

* Compara nível com os limites
* Considera o `alertaApiSimulado`
* Aciona LEDs e buzzer conforme necessidade

## 🛠️ Componentes no Wokwi

* Arduino Uno
* Sensor HC-SR04
* LEDs (verde, amarelo, vermelho)
* 3 resistores 220Ω
* Buzzer

## 💻 Software e Configuração

### sketch.ino

* O código que controla o funcionamento

### diagram.json

* O diagrama que conecta os componentes virtualmente

## 🚀 Como Simular no Wokwi (Passo a Passo)

### 1. Acesse o Wokwi

* [Crie um novo projeto](https://wokwi.com/projects/new/arduino-uno)

### 2. Diagrama

* Apague o conteúdo de `diagram.json`
* Cole o fornecido no projeto

### 3. Código

* Apague o `sketch.ino` existente
* Cole o código do projeto

### 4. Inicie a Simulação

* Clique no botão ▶️ (play)

### 5. Interaja

* Clique no sensor HC-SR04 e use o slider
* Diminua a distância para simular subida da água

### 6. Veja os Resultados

* Observe as cores dos LEDs
* Ouça o buzzer
* Veja o Monitor Serial

### 7. Teste o Alerta Externo

* Pare a simulação
* Edite `int alertaApiSimulado = 0;`
* Altere para 1 ou 2 e reinicie

## 🔧 Quer Personalizar?

Edite no `sketch.ino`:

```cpp
const float ALTURA_SENSOR_DO_LEITO_RIO_CM = 300.0;
const float NIVEL_NORMAL_MAX_CM = 150.0;
const float NIVEL_ALERTA_MAX_CM = 220.0;
int alertaApiSimulado = 0;
```

* Ajuste os limites ou altura do sensor

## ⚠️ Limitações

* Simulação: não é um sensor real
* Alerta externo é manual
* Sensor virtual é idealizado

## 💡 Ideias para o Futuro

* Usar ESP32 com Wi-Fi para alertas reais
* Gravar dados em SD ou nuvem
* Enviar alertas por notificações/SMS
* Usar energia solar

---

Divirta-se explorando e aprendendo com este projeto! Se tiver dúvidas, pergunte! 😊
