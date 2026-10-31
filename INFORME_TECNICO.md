# INFORME TÉCNICO: BUILD DE PRODUCCIÓN Y FICHA DE PUBLICACIÓN — "TAREAS UCN"

**Institución:** Universidad Central de Nicaragua (UCN)  
**Facultad:** Ingeniería y Arquitectura  
**Carrera:** Ingeniería en Sistemas  
**Asignatura:** Desarrollo de Aplicaciones Móviles con Flutter (IS-1910)  
**Sesión:** Ejercicio Práctico — Sesión 11  
**Estudiante:** Kenneth Mena  
**Fecha:** 30 de Octubre de 2026  

---

## 1. Resumen Ejecutivo
El presente informe documenta el proceso integral de preparación, configuración de seguridad, generación de builds de producción firmados y elaboración de la ficha de publicación en Google Play Console para la aplicación móvil **"Tareas UCN"** (versión `1.0.0+1`).

La aplicación fue desarrollada en **Flutter 3.44.9** con **Dart 3.12.2**, integrando una arquitectura de persistencia local offline, directrices de diseño **Material Design 3** y adaptaciones nativas en Android con **Kotlin DSL (Gradle 9.1)**.

---

## 2. Metadatos e Identidad de la Aplicación

| Parámetro | Configuración Implementada | Ubicación de Archivo |
|---|---|---|
| **Nombre visible** | Tareas UCN | `android/app/src/main/AndroidManifest.xml` |
| **Application ID / Namespace** | `ni.edu.ucn.tareasucn` | `android/app/build.gradle.kts` |
| **Versión (Version Name / Code)**| `1.0.0+1` (VersionName: 1.0.0, VersionCode: 1) | `pubspec.yaml` |
| **Permisos declarados** | Solo consultas de texto del sistema (`queries: ACTION_PROCESS_TEXT`) | `AndroidManifest.xml` (sin permisos invasivos) |
| **Depuración en código** | Limpieza total de `print()`, URLs de prueba o endpoints mock | `lib/main.dart` |

---

## 3. Identidad Visual: Ícono Adaptativo y Splash Screen

1. **Ícono Adaptativo de Alta Resolución:**
   * Se diseñó un arte institucional de **1024×1024 px** en formato PNG (`assets/icon/app_icon.png`), incorporando el color azul corporativo UCN (`#0D47A1`), aro dorado (`#FFC107`) y logotipo de tareas académicas.
   * Mediante `flutter_launcher_icons`, se generaron automáticamente los mipmaps en todas las densidades de pantalla (`mdpi`, `hdpi`, `xhdpi`, `xxhdpi`, `xxxhdpi`) junto con el `adaptive-icon` de Android (fondo y primer plano separados).

2. **Splash Screen Nativa:**
   * Se integró `flutter_native_splash` sobre las capas `drawable` y `values-v31` (Android 12+), garantizando una transición inmediata, sin destellos blancos ni parpadeos al abrir la aplicación desde el launcher.

---

## 4. Firma Digital y Seguridad de Credenciales

Siguiendo las directrices de seguridad de Google Play y las políticas del curso para evitar la exposición de secretos en repositorios versionados:

1. **Generación del Keystore:**
   * Se generó un almacén de claves RSA de 2048 bits con validez de 10,000 días:
     ```bash
     keytool -genkey -v -keystore android/app/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
     ```
2. **Desacoplamiento de Credenciales:**
   * Se configuró el archivo `android/key.properties` para contener las propiedades `storePassword`, `keyPassword`, `keyAlias` y `storeFile`.
   * En `android/app/build.gradle.kts` se programó la lectura dinámica de dicho archivo para asociarlo al bloque `signingConfigs.release`.
3. **Protección en Git:**
   * Se configuró `.gitignore` para excluir estrictamente:
     * `key.properties` y `**/android/key.properties`
     * `*.jks` y `*.keystore`
     * `upload-keystore.jks`
   * Se proveyó únicamente una plantilla pública de referencia `android/key.properties.example`.

---

## 5. Registro y Análisis Comparativo de Builds

Se ejecutaron las compilaciones en modo `--release` utilizando Gradle y R8 (code shrinking y tree-shaking de fuentes):

| Tipo de Build | Ruta de Salida Generada | Tamaño (MB) | Reducción vs. Universal | Arquitectura Destino |
|---|---|---|---|---|
| **APK Universal** | `build/app/outputs/flutter-apk/app-release.apk` | **49.22 MB** | 0.0% (Base) | Multi-arquitectura (todas las CPUs) |
| **APK ABI `arm64-v8a`** | `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` | **17.66 MB** | **64.12% de reducción** | Smartphones modernos de 64 bits |
| **APK ABI `armeabi-v7a`** | `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` | **15.08 MB** | **69.36% de reducción** | Dispositivos de 32 bits |
| **APK ABI `x86_64`** | `build/app/outputs/flutter-apk/app-x86_64-release.apk` | **18.98 MB** | **61.44% de reducción** | Emuladores y laptops con Android OS |
| **App Bundle (AAB)** | `build/app/outputs/bundle/release/app-release.aab` | **129.70 MB** | Paquete Integral | Generación dinámica de APKs en Play Store |

### Conclusión Técnica del Análisis de Tamaño:
El uso de `--split-per-abi` permite una optimización de transferencia móvil de hasta un **69.3%**, garantizando que el usuario final descargue únicamente las librerías binarias correspondientes al procesador de su teléfono.

---

## 6. Lista de Verificación en Dispositivo Físico

| Criterio Evaluado | Estado | Hallazgo / Observación |
|---|---|---|
| **Ícono y nombre en Launcher** | ✅ APROBADO | El ícono institucional UCN se renderiza nítido y con marco adaptativo. Nombre visible: "Tareas UCN". |
| **Splash Screen sin parpadeo** | ✅ APROBADO | Transición suave desde la animación nativa de inicio hacia la interfaz principal. |
| **Ausencia de banner DEBUG** | ✅ APROBADO | Al compilarse con firma release, la marca de agua superior derecha queda eliminada. |
| **CRUD de Tareas (Crear, Editar, Completar, Eliminar)** | ✅ APROBADO | Operaciones instantáneas; el checkbox actualiza inmediatamente el tachado y los contadores del panel. |
| **Persistencia de Datos** | ✅ APROBADO | Al cerrar la aplicación o reiniciar el dispositivo, las tareas y sus estados se conservan intactos. |
| **Fluidez y Desplazamiento** | ✅ APROBADO | 60 FPS estables sin tirones durante el scroll de listas ni al desplegar el modal inferior. |

---

## 7. Problemas Encontrados y Soluciones Aplicadas

1. **Espacios en ruta del Android SDK:**
   * *Problema:* El diagnóstico de Flutter detectó espacios en la ruta por defecto (`C:\Users\Kenneth Mena\...`).
   * *Solución:* Se verificó que las tareas estándar de Gradle y empaquetado de Flutter funcionaran invocando directamente los scripts internos y evitando dependencias innecesarias de NDK C++, logrando una compilación 100% limpia.
2. **Sintaxis de Kotlin DSL en Gradle 9 (`build.gradle.kts`):**
   * *Problema:* Las versiones modernas de Flutter inicializan proyectos de Android con Kotlin DSL en lugar de Groovy, por lo que la sintaxis tradicional de `Properties` genera incompatibilidades de tipado.
   * *Solución:* Se importaron explícitamente `java.io.FileInputStream` y `java.util.Properties`, tipando `keystoreProperties.getProperty(...)?.let { file(it) }` de forma segura.
3. **Deprecación de propiedades de color y formularios en Flutter 3.44:**
   * *Problema:* `Colors.withOpacity()` y `DropdownButtonFormField.value` mostraron advertencias de deprecación.
   * *Solución:* Se migraron a `Color.withValues(alpha: ...)` e `initialValue` respectivamente, logrando cero advertencias en `flutter analyze`.

---

## 8. Conclusiones
Se completaron con éxito todos los requisitos estipulados en la guía de la Sesión 11. El producto final cuenta con arquitectura modular, firma de producción segura y documentación profesional para su posterior publicación en Google Play Console.
