# 🔌 Especificación Técnica y API — ProjectJaina_Carbonite

[![GitHub](https://img.shields.io/badge/GitHub-DarckRovert%2FProjectJaina_Carbonite-black?logo=github)](https://github.com/DarckRovert/ProjectJaina_Carbonite)
[![Ecosistema](https://img.shields.io/badge/Ecosistema-Project%20Jaina%203.3.5a-gold.svg)](https://darckrovert.github.io/ProjectJaina_Web/)

## 📌 Resumen Arquitectónico
Suite unificada hardened de Carbonite (v3.34) con cartografía HD, navegación satelital, rastreo de misiones, base de datos de nodos de recolección y optimización contra bucles nil.

- **Rol en el Ecosistema:** Módulo Oficial #13 / Suite Satelital — Cartografía & Nodos
- **Archivo Principal TOC:** `Carbonite.toc`
- **Compatibilidad del Motor:** World of Warcraft 3.3.5a (Build 12340)

---

## ⌨️ Comandos de Consola (Slash Commands)
- `/carb`: Acceso principal o comando del addon.
- `/nx`: Acceso principal o comando del addon.

---

## 📡 Protocolo de Red y Eventos
- `Carbonite`: Prefijo registrado para sincronización de datos.

### Eventos del Motor 3.3.5a Gestionados
- `PLAYER_LOGIN` / `ADDON_LOADED`: Inicialización atómica de tablas de configuración y hooks.
- `PLAYER_ENTERING_WORLD`: Sincronización de estado tras transiciones de pantalla o mapa.
- `PLAYER_LOGOUT`: Guardado seguro en disco de las variables locales.

---

## 💾 Persistencia de Datos (SavedVariables)
- `NxData`: Almacenamiento estructurado de configuración y estado persistente.
- `NxCombatOpts`: Almacenamiento estructurado de configuración y estado persistente.
- `NxMapOpts`: Almacenamiento estructurado de configuración y estado persistente.
- `NxCData`: Almacenamiento estructurado de configuración y estado persistente.
- `CarboniteTransferData`: Almacenamiento estructurado de configuración y estado persistente.

---

## 🛠️ Buenas Prácticas de Integración
1. Toda invocación a funciones públicas debe verificar previamente la existencia del espacio de nombres en `_G`.
2. Las tablas de configuración deben consultarse en modo lectura sin sobreescribir valores por omisión no validados.
3. El intercambio de datos con otros addons debe efectuarse a través del bus oficial `ProjectJaina_Companion` o hooks de eventos estándar.
