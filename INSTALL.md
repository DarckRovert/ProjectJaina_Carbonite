# 📦 Guía de Instalación y Despliegue — ProjectJaina_Carbonite

[![WoW Version](https://img.shields.io/badge/WoW-3.3.5a%20(12340)-blue.svg)](https://darckrovert.github.io/ProjectJaina_Web/)
[![Repositorio](https://img.shields.io/badge/GitHub-DarckRovert%2FProjectJaina_Carbonite-black?logo=github)](https://github.com/DarckRovert/ProjectJaina_Carbonite)

## 📋 Requisitos Previos
- **Cliente:** World of Warcraft 3.3.5a (Build 12340), en español (`esES`) o inglés (`enUS`).
- **Servidor:** JainaCore con Eluna habilitado (**Project Jaina — Theramore**).

---

## 🚀 Instalación Paso a Paso

1. **Localizar la Carpeta de Addons:**  
   Dirígete a tu directorio de instalación del juego:  
   `World of Warcraft\Interface\AddOns\`

2. **Copiar o Clonar el Addon:**  
   Coloca la carpeta del addon dentro de `AddOns\`:  
   ```bash
   git clone https://github.com/DarckRovert/ProjectJaina_Carbonite.git
   ```

3. **Verificación de Estructura:**  
   Asegúrate de que el archivo `Carbonite.toc` se encuentre directamente dentro de la carpeta del addon y no anidado en una subcarpeta redundante:  
   `Interface\AddOns\ProjectJaina_Carbonite\Carbonite.toc`

4. **Activación en el Juego:**  
   - Inicia el cliente del juego o escribe `/reload` si ya estás conectado.
   - En la pantalla de selección de personajes, haz clic en el botón **Accesorios** (esquina inferior izquierda) y marca la casilla de `ProjectJaina_Carbonite`.
   - Asegúrate de tener marcada la opción **"Cargar accesorios antiguos"**.

5. **Prueba de Funcionamiento:**  
   En el chat del juego, escribe: `/carb` para abrir la interfaz o verificar que el módulo responde.
