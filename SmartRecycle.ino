#include <Servo.h>
#include <LiquidCrystal_I2C.h>
#include <Wire.h>

Servo myservo;  // 서보모터 객체 생성
const int pressureSensor = A0; // 압력 센서 핀 설정
const int trigPin = 9;        // 초음파 센서 Trig 핀
const int echoPin = 10;       // 초음파 센서 Echo 핀
const int servoPin = 11;      // 서보모터 핀

const float VCC = 4.98; // Measured voltage of Ardunio 5V line

const float R_DIV = 3230.0; // Measured resistance of 3.3k resistor

LiquidCrystal_I2C lcd(0x27, 16 ,2);

void setup() {
  myservo.attach(servoPin);   // 서보모터 핀 연결
  myservo.write(0);
  pinMode(trigPin, OUTPUT);   // 초음파 센서 Trig 핀 출력으로 설정
  pinMode(echoPin, INPUT);    // 초음파 센서 Echo 핀 입력으로 설정
  pinMode(pressureSensor, INPUT);
  Serial.begin(9600);         // 시리얼 통신 시작
  lcd.init();
  lcd.backlight();
  lcd.setCursor(1, 0);
  lcd.print("HELLO");
}

void loop() {
  long duration = 0, distance = 0;
  int weight = 0;
  float force = 0 ;
  float fsrV = 0 , fsrR = 0 , fsrG = 0 , fsrADC = 0;
  // 초음파 센서로 거리 측정
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2;

  // 압력 센서로 무게 측정 (가정: 500g 이상일 때 압력 센서 값이 400 이상)
  fsrADC = analogRead(pressureSensor);

  if (fsrADC != 0)
  {
    fsrV = fsrADC * VCC / 1023.0;
    fsrR = R_DIV * (VCC / fsrV - 1.0);
    fsrG = 1.0 / fsrR;
    
    if(fsrR < 600){
      force = (fsrG - 0.00075) / 0.00000032639;
      force -= 500;
    }else{
      force = fsrG / 0.000000642857;
      force -= 500;
    }
  }
  // 조건 확인
  if (force >= 200 && distance < 27) { // 무게가 100g 이상이고 물체가 10cm 이내일 때
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("Weight");
    lcd.setCursor(0,1);
    lcd.print(force);
    lcd.setCursor(6,1);
    lcd.print("g");

    delay(2000); // 2초 대기
    myservo.write(45); // 서보모터 45도로 회전
    delay(3000); // 3초 대기
    myservo.write(0); // 서보모터 원래 위치로
    lcd.clear();
  }

  // 시리얼 모니터에 결과 출력
  Serial.print("Weight: ");
  Serial.print(force);
  Serial.print("g, Distance: ");
  Serial.print(distance);
  Serial.println("cm");

  delay(1000); // 다음 측정을 위한 1초 대기
}
