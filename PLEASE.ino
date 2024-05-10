#include "Arduino.h"
#include "WiFi.h"
#include "esp_camera.h"
#include "soc/soc.h"           // Disable brownout problems
#include "soc/rtc_cntl_reg.h"  // Disable brownout problems
#include "driver/rtc_io.h"
#include <Firebase_ESP_Client.h>
#include <addons/TokenHelper.h>

//Replace with your network credentials
const char* ssid = "JuDaeng";
const char* password = "11111111";

// Insert Firebase project API Key
#define API_KEY "AIzaSyA2esd832UG9sCVCZ4kdfc2q_UN20MFAHY"
#define DATABASE_URL "testlogin-85595-default-rtdb.firebaseio.com"
// Insert Authorized Email and Corresponding Password
#define USER_EMAIL "kjuhun00@ajou.ac.kr"
#define USER_PASSWORD "**********"     

// Insert Firebase storage bucket ID e.g bucket-name.appspot.com
#define STORAGE_BUCKET_ID "testlogin-85595.appspot.com"
// For example:
//#define STORAGE_BUCKET_ID "esp-iot-app.appspot.com"

//Define Firebase Data objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig configF;

// Capture Photo and Save it to LittleFS

void initWiFi(){
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
}

void setup() {
  // Serial port for debugging purposes
  Serial.begin(115200);
  initWiFi();
  // Turn-off the 'brownout detector'
  // int intValue = 12345;
  // String intString = String(intValue);
  //Firebase
  // Assign the api key
  configF.api_key = API_KEY;
  configF.database_url = DATABASE_URL;
  //Assign the user sign in credentials
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  //Assign the callback function for the long running token generation task

  Firebase.begin(&configF, &auth);
  Firebase.reconnectWiFi(true);

  //  if (Firebase.Storage.upload(&fbdo, STORAGE_BUCKET_ID, intString.c_str(), mem_storage_type_flash, "/integerValue.txt", "text/plain", fcsUploadCallback)) {
  //   Serial.printf("\nDownload URL: %s\n", fbdo.downloadURL().c_str());
  // }
}

void loop() {
 if (Firebase.ready()){
    //Assuming 'value' is the integer you want to upload
    int value = 42; // Replace with your value
    Serial.println("...................");
    if (Firebase.RTDB.setInt(&fbdo, "test/value", value)){
      Serial.println("Value set successfully!");
    }
    else{
      Serial.println("Failed to set value");
      Serial.println(fbdo.errorReason());
    }
  }
  delay(3000); // Delay between uploads
}

// The Firebase Storage upload callback function
// void fcsUploadCallback(FCS_UploadStatusInfo info){
//     if (info.status == firebase_fcs_upload_status_init){
//         Serial.printf("Uploading file %s (%d) to %s\n", info.localFileName.c_str(), info.fileSize, info.remoteFileName.c_str());
//     }
//     else if (info.status == firebase_fcs_upload_status_upload)
//     {
//         Serial.printf("Uploaded %d%s, Elapsed time %d ms\n", (int)info.progress, "%", info.elapsedTime);
//     }
//     else if (info.status == firebase_fcs_upload_status_complete)
//     {
//         Serial.println("Upload completed\n");
//         FileMetaInfo meta = fbdo.metaData();
//         Serial.printf("Name: %s\n", meta.name.c_str());
//         Serial.printf("Bucket: %s\n", meta.bucket.c_str());
//         Serial.printf("contentType: %s\n", meta.contentType.c_str());
//         Serial.printf("Size: %d\n", meta.size);
//         Serial.printf("Generation: %lu\n", meta.generation);
//         Serial.printf("Metageneration: %lu\n", meta.metageneration);
//         Serial.printf("ETag: %s\n", meta.etag.c_str());
//         Serial.printf("CRC32: %s\n", meta.crc32.c_str());
//         Serial.printf("Tokens: %s\n", meta.downloadTokens.c_str());
//         Serial.printf("Download URL: %s\n\n", fbdo.downloadURL().c_str());
//     }
//     else if (info.status == firebase_fcs_upload_status_error){
//         Serial.printf("Upload failed, %s\n", info.errorMsg.c_str());
//     }
// }