#  Proyecto: Aplicación de Inventario con Spring Boot, JSP y React Native (Expo)

##  Descripción  
Este proyecto es una aplicación de inventario con un backend en **Spring Boot**, vistas en **JSP** para la versión web, y un frontend móvil en **React Native** con **Expo**.  

---  

#  Instalación del Entorno  

##  Backend (Spring Boot + JSP)  

### 1 Requisitos Previos  
Asegúrate de tener instalados los siguientes programas:  
- **Java JDK 17** o superior  
- **Apache Tomcat 8** (para desplegar archivos WAR)  
- **Maven** (para compilar el proyecto)  
- **MySQL** (o cualquier otra base de datos compatible con Spring Boot)  

### 2 Clonar el Proyecto  
```bash
git clone https://github.com/diego410711/prueba-novahold
cd prueba-novahold/aplicacion-prueba
```  

### 3 Configurar la Base de Datos  

Crea la base de datos en MySQL ejecutando el siguiente script:  

```sql
CREATE DATABASE aplicacion_prueba;
USE aplicacion_prueba;

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    nombre VARCHAR(255),
    password VARCHAR(255) NOT NULL
);
```  

Modifica el archivo `application.properties` para establecer la conexión con la base de datos:  

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/aplicacion_prueba
spring.datasource.username=root
spring.datasource.password="tu-contraseña"
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=update
```  

### 4 Generar el Archivo WAR  

Para empaquetar el proyecto en un archivo `.war`, ejecuta:  
```bash
mvn clean package
```  
Esto generará el archivo `.war` en la carpeta `target/`.  

### 5 Ejecutar la Aplicación en Tomcat 8  

1. Copia el archivo `.war` generado en la carpeta `webapps` dentro de la instalación de Tomcat:  
   ```bash
   cp target/aplicacion-prueba-0.0.1-SNAPSHOT.war /path/to/tomcat8/webapps/
   ```  
2. Inicia Tomcat:  
   ```bash
   sh /path/to/tomcat8/bin/startup.sh  # Linux/macOS
   /path/to/tomcat8/bin/startup.bat    # Windows
   ```  
3. Accede a la aplicación en `http://localhost:8080/aplicacion-prueba-0.0.1-SNAPSHOT/`  

---  

##  Rutas de las Vistas JSP  

| Vista       | URL                                     |  
|------------|------------------------------------------|  
| Login     | `/auth/login`|  
| Registro | `/auth/registro`|  
| Lista de productos luego del login | `/home`|  
| Nuevo Producto | `/productos/nuevo`|  

--- 

#  Instalación del Frontend (React Native con Expo)  

### 1⃣ Requisitos Previos  
Asegúrate de tener instalado:  
- **Node.js** (v16 o superior)  
- **Expo CLI**  
- **Android Studio o un dispositivo físico**  

### 2 Clonar y Ejecutar  
```bash
git clone https://github.com/diego410711/prueba-novahold.git
cd prueba-novahold/prueba-react-native
npm install
```  

### 3 Configurar la API en la Aplicación Expo  
Edita para que apunte a la IP de tu servidor en la misma red:  
```javascript
const API_BASE_URL = 'http://192.168.X.X:8080/aplicacion-prueba-0.0.1-SNAPSHOT/api';
```  
Reemplaza `192.168.X.X` con la IP de tu computadora.  

### 4 Ejecutar la Aplicación en Expo  
Para iniciar el entorno de desarrollo:  
```bash
npm start
```  
Si quieres probar en un dispositivo físico, instala la app **Expo Go** en tu móvil y escanea el código QR.  

---  

#  Endpoints de la API  

| Método | Endpoint                           | Descripción                  |  
|--------|------------------------------------|------------------------------|  
| GET    | `/api/productos`                  | Obtener todos los productos  |  
| POST   | `/api/productos/guardar`          | Guardar un nuevo producto    |  
| PUT    | `/api/productos/actualizar/`      | Actualizar un producto       |  
| DELETE | `/api/productos/eliminar/`        | Eliminar un producto         |  
| POST   | `/api/auth/registro`              | Registrar un nuevo usuario   |  
| POST   | `/api/auth/login`                 | Iniciar sesión             |

---  

#  Despliegue en Producción  

Para desplegar en producción, usa **Tomcat 8** para el backend y un servidor como **Vercel** o **Expo EAS** para el frontend móvil.  

### Desplegar Backend en un Servidor  

1. Subir el WAR al servidor con Tomcat 8.  
2. Configurar la base de datos MySQL en producción.  
3. Configurar un dominio o IP pública.  

### Desplegar Expo en Producción  

Para compilar la app móvil:  
```bash
expo build:android
expo build:ios
```  
Esto generará un `.apk` o `.ipa` para su instalación.  

---  
