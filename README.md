# Tareas UCN — Gestor de Tareas Estudiantiles

[![Flutter](https://img.shields.io/badge/Flutter-3.44.9-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12.2-0175C2?logo=dart)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android-3DDC84?logo=android)](https://developer.android.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Aplicación móvil desarrollada con Flutter para la gestión y organización eficiente de tareas académicas de estudiantes de la **Universidad Central de Nicaragua (UCN)**, como parte de la asignatura **IS-1910 Desarrollo de Aplicaciones Móviles con Flutter** (Sesión 11).

---

## 📱 Capturas y Características

* **Gestión integral (CRUD):** Creación, visualización, edición interactiva y eliminación de tareas.
* **Control de estado:** Checkbox para marcar tareas completadas con tachado estilizado y actualización inmediata de estadísticas.
* **Clasificación y prioridades:** Organización por asignaturas y niveles de prioridad (*Alta*, *Media*, *Baja*).
* **Filtros rápidos y buscador:** Pestañas para segmentar entre *Todas*, *Pendientes* y *Completadas*, además de barra de búsqueda en tiempo real.
* **Persistencia local offline:** Almacenamiento seguro en el dispositivo mediante `SharedPreferences` sin dependencia de internet.
* **Identidad UCN:** Paleta de colores institucionales, ícono adaptativo y splash screen nativa.

---

## 🛠️ Requisitos Previos

* **Flutter SDK:** Versión `>= 3.44.0`
* **Dart SDK:** Versión `>= 3.12.0`
* **Android Studio:** Con Android SDK Platform 34+ y Android Build Tools
* **Java Development Kit (JDK):** Versión 17
* Dispositivo Android físico o emulador con Android 5.0 (API 21) o superior.

---

## 🚀 Guía de Compilación y Ejecución

### 1. Clonar el repositorio
```bash
git clone https://github.com/KennethMena/tareas_ucn.git
cd tareas_ucn
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Ejecución en Modo Depuración (Debug)
Conecta tu dispositivo Android con depuración USB activada y ejecuta:
```bash
flutter run
```

---

## 🔐 Compilación de Producción (Release)

Por estrictas razones de seguridad y buenas prácticas de ingeniería de software, las credenciales de firma (`key.properties` y `*.jks`) **no están incluidas en el repositorio**.

### Paso 1: Configurar el archivo de firma (Solo para administradores de release)
Crea un archivo llamado `key.properties` dentro de la carpeta `android/` con la siguiente estructura:

```properties
storePassword=TU_PASSWORD_DEL_KEYSTORE
keyPassword=TU_PASSWORD_DE_LA_LLAVE
keyAlias=upload
storeFile=upload-keystore.jks
```

Coloca el archivo de tu keystore (`upload-keystore.jks`) dentro del directorio `android/app/`.

### Paso 2: Generar APK Universal de Release
```bash
flutter build apk --release
```
El archivo se generará en:  
`build/app/outputs/flutter-apk/app-release.apk`

### Paso 3: Generar APKs divididos por arquitectura (Split ABI)
Para optimizar el tamaño de descarga según el procesador del dispositivo:
```bash
flutter build apk --split-per-abi
```
Los archivos se encontrarán en:  
`build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk`  
`build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`  
`build/app/outputs/flutter-apk/app-x86_64-release.apk`

### Paso 4: Generar App Bundle (AAB para Google Play)
```bash
flutter build appbundle --release
```
El archivo optimizado para la tienda se generará en:  
`build/app/outputs/bundle/release/app-release.aab`

---

## 📂 Estructura del Proyecto

```text
tareas_ucn/
├── android/                  # Configuración nativa Android y Gradle
│   ├── app/
│   │   ├── build.gradle.kts  # Configuración de compilación y signing configs
│   │   └── src/main/         # AndroidManifest, íconos y drawables
│   └── key.properties.example# Plantilla de referencia para la firma
├── assets/
│   ├── icon/                 # Logo institucional de la app (1024x1024 px)
│   └── splash/               # Gráficos de splash screen
├── lib/
│   └── main.dart             # Lógica completa, modelos y UI de Tareas UCN
├── test/
│   └── widget_test.dart      # Pruebas automatizadas de interfaz
├── FICHA_DE_TIENDA.md        # Simulación de ficha para Google Play Console
├── POLITICA_DE_PRIVACIDAD.md # Declaración y política de privacidad
├── pubspec.yaml              # Dependencias y configuración de assets
└── README.md                 # Documentación técnica del proyecto
```

---

## 👨‍💻 Autor
* **Estudiante:** Kenneth Mena
* **Carrera:** Ingeniería en Sistemas
* **Institución:** Universidad Central de Nicaragua (UCN)
