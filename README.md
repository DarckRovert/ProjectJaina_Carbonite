<p align="center">
  <img src="https://raw.githubusercontent.com/DarckRovert/ProjectJaina_Web/main/images/project_jaina_official_logo.jpg" alt="Project JAIna Official Crest" width="180">
</p>

# ❄️ Project JAIna — Carbonite (v3.34 Hardened HD Edition)

**Versión:** 3.34-Jaina (WotLK Hardened Edition)  
**Autor Original:** Carbon Based Creations, LLC  
**Mantenimiento & Refactorización:** DarckRovert (Ingame: `Elnazzareno`) & Project JAIna Staff  
**Servidor Destino:** [Project JAIna](https://darckrovert.github.io/ProjectJaina_Web/) — Theramore  
**Entorno de Ejecución:** World of Warcraft 3.3.5a (Build 12340) | Lua 5.1 puro  
**Repositorio Oficial:** [DarckRovert/ProjectJaina_Carbonite](https://github.com/DarckRovert/ProjectJaina_Carbonite)  

---

[![WoW Client](https://img.shields.io/badge/WoW%20Client-3.3.5a%20(Build%2012340)-blue.svg)](https://darckrovert.github.io/ProjectJaina_Web/)
[![Servidor](https://img.shields.io/badge/Servidor-Project%20JAIna-00ccff.svg)](https://darckrovert.github.io/ProjectJaina_Web/)
[![Version](https://img.shields.io/badge/version-3.34--Jaina-brightgreen.svg)](https://github.com/DarckRovert/ProjectJaina_Carbonite/releases)
[![Build Status](https://img.shields.io/badge/Status-Hardened%20Production-success.svg)](https://github.com/DarckRovert/ProjectJaina_Carbonite)
[![License: EULA / Proprietary](https://img.shields.io/badge/License-EULA%20%2F%20Proprietary-lightgrey.svg)](LICENSE)

---

## 🌟 ¿Qué es ProjectJaina_Carbonite?

**ProjectJaina_Carbonite** es la edición hardened, optimizada y re-estilizada del legendario addon de cartografía, misiones y navegación satelital **Carbonite**, diseñada específicamente para el cliente **Project Jaina FHD / 3.3.5a**.

Esta bifurcación soluciona fallos históricos de estabilidad que provocaban miles de errores silenciosos en clientes 3.3.5a, repara el diseño visual integrando un tema oscuro nativo elegante (*Charcoal Dark Mode*), y optimiza el consumo de CPU en equipos de cabina de internet.

```
┌────────────────────────────────────────────────────────────────────────┐
│                   MEJORAS ARQUITECTÓNICAS DE PROJECT JAINA                  │
├────────────────────────┬──────────────────────┬────────────────────────┤
│ 🛡️ RESILIENCIA RUNTIME │ 🎨 TEMA OSCURO NATIVO │ 🗺️ MAPA SATELITAL HD   │
│ Eliminados 15,000+     │ Corregido el bug de  │ Zoom continuo, rutas   │
│ errores de nil en      │ fondo blanco (#ECECEC)│ inteligentes y nodos   │
│ quest tracking y mapas │ en menú de opciones   │ integrados de recursos │
└────────────────────────┴──────────────────────┴────────────────────────┘
```

---

## 🚀 Mejoras y Correcciones Implementadas

### 1. 🎨 Corrección Crítica del Fondo Blanco en Opciones (`NxOpts`)
- **Problema en 3.3.5a:** Al abrir `/carb options`, la ventana se renderizaba con un fondo blanco deslumbrante (`#ECECEC`) que arruinaba la visibilidad y desentonaba con la estética del cliente.
- **Causa Raíz:** El motor C++ de WoW resetea el color del vértice a blanco puro `(1, 1, 1, 1)` cada vez que se llama a `SetBackdrop("White8x8")`. Carbonite no llamaba a `SetBackdropColor` en la inicialización y su script `OnUpdate` dejaba de pintar en cuanto terminaba la micro-animación de fade.
- **Solución Implementada:**
  - Inyección explícita de `SetBackdropColor(0.12, 0.12, 0.12, 0.88)` y bordes dorados/azulados en `Nx.Win:CrB1()`, `Nx.Win:ReB()`, `Nx.Opt:Cre()` y `Nx.Opt:Ope()`.
  - Blindaje con `local this = self or this` para compatibilidad de contexto en WoW 3.3.5a.

### 2. 🛡️ Supresión de Nil-Comparisons en Quest Tracker (`F()` y `InT1`)
- **Problema:** El ordenamiento de objetivos de misiones generaba errores masivos continuos:
  `Carbonite.lua:18190: attempt to compare nil with number` acumulando más de 15,000 llamadas fallidas por sesión.
- **Solución:** Guardias de validación estricta en el comparador de distancia `F()` (`(a.Dis or 999999) < (b.Dis or 999999)`) y protección ante IDs de zonas no indexadas en `InT1` y `ITCZ`.

### 3. 🖥️ Compatibilidad con Cliente HD y Monitores Modernos
- Corrección de escalado de fuentes y anclajes en resoluciones ultrawide y pantallas 1080p/1440p/4K.
- Soporte optimizado para coexistencia con `ProjectJaina_DragonflightUI` (`cDF`) y `ProjectJaina_RaidSuite`.

### 4. ⚡ Optimización de Memoria y CPU para Cabinas
- Reducción del ciclo de recálculo de rutas innecesarias cuando el jugador se encuentra en reposo en ciudades principales (Dalaran, Orgrimmar, Ventormenta).
- Persistencia robusta en `SavedVariables` contra apagados forzados o congeladores de disco (Deep Freeze).

---

## 📦 Módulos Incluidos en la Suite (4 Carpetas)

La suite oficial **ProjectJaina_Carbonite** se distribuye como un paquete modular unificado compuesto por 4 carpetas:

```
ProjectJaina_Carbonite/
├── Carbonite/               # 🗺️ Núcleo: Cartografía satelital, misiones, HUD y parches visuales
├── CarboniteItems/          # 💎 Base de datos de items para búsqueda rápida (LoadOnDemand)
├── CarboniteNodes/          # 🌿 Nodos de recolección de minería y herboristería (LoadOnDemand)
└── CarboniteTransfer/       # 📦 Sincronización y transferencia de almacén entre cuentas
```

### 1. `Carbonite` (Motor Principal)
- Cartografía satelital con zoom continuo y vista transparente.
- Rastreador inteligente de misiones con cálculo dinámico de distancias y ordenamiento de ruta.
- HUD direccional y brújula 3D flotante.
- Tema oscuro nativo (*Charcoal Dark Mode*) en todas las ventanas fijas y modal de opciones (`NxOpts`).

### 2. `CarboniteItems` (Base de Datos de Ítems)
- Catálogo de base de datos de ítems de WotLK 3.3.5a con carga diferida (`LoadOnDemand: 1`).
- Permite buscar objetos y enlaces de equipo sin consumir memoria del cliente hasta que se solicita.

### 3. `CarboniteNodes` (Nodos de Recursos)
- Contiene las ubicaciones precalculadas de menas de minería y hierbas en Rasganorte, Terrallende y Azeroth.
- Importación instantánea desde la pestaña *Guía* de las opciones de Carbonite.

### 4. `CarboniteTransfer` (Transferencia de Datos)
- Facilita la exportación y sincronización de datos de almacén (*Warehouse*) entre cuentas y perfiles locales mediante `SavedVariables`.

---

## 💾 Instalación en el Cliente de Juego

1. Descarga el repositorio o la última versión desde [Releases](https://github.com/DarckRovert/ProjectJaina_Carbonite/releases).
2. Extrae el contenido en tu ordenador.
3. Copia las **4 carpetas** (`Carbonite`, `CarboniteItems`, `CarboniteNodes`, `CarboniteTransfer`) directamente en:
   ```text
   World of Warcraft\Interface\AddOns\
   ```
4. Inicia el juego o escribe `/reload` en el chat. En la pantalla de selección de personajes, asegúrate de marcar **"Cargar accesorios antiguos"** (*Load out of date AddOns*).

---

## 🛠️ Comandos Rápidos en el Juego

| Comando | Acción |
|---|---|
| `/carb` | Muestra la ayuda rápida de comandos en el chat. |
| `/carb map` | Alterna el mapa satelital maximizado / minimizado. |
| `/carb options` | Abre el panel de configuración (con tema oscuro nativo). |
| `/carb reset` | Restaura la posición y escala de todas las ventanas flotantes. |
| `/carb clear` | Limpia los objetivos y destinos activos del mapa. |

---

## 🌐 Integración con el Ecosistema Project Jaina

| Addon Coexistente | Tipo de Integración |
|---|---|
| **`ProjectJaina_DragonflightUI`** | Coexistencia limpia con el Minimapa moderno y barras de acción. |
| **`ProjectJaina_IntiObjGPS`** | Complemento de navegación satelital con waypoints andinos. |
| **`ProjectJaina_RaidSuite`** | Liberación de Combat Log para priorizar telemetría de raid. |
| **`ProjectJaina_Companion`** | Reconocimiento automático de presencia en el cliente. |

---

## 📄 Licencia y Estatus Legal

Carbonite es software de cartografía originalmente desarrollado por **Carbon Based Creations, LLC** bajo su Acuerdo de Licencia de Usuario Final (EULA) privativo original, el cual prohíbe la descompilación con fines comerciales y redistribución no autorizada. Consulta el texto completo en [LICENSE](LICENSE).

Las optimizaciones de rendimiento para WotLK 3.3.5a, parches de estabilidad contra excepciones `nil`, y la reconstrucción del tema oscuro *Charcoal Dark Mode* son desarrollados y mantenidos por el equipo de **Project Jaina** con fines exclusivos de preservación y funcionamiento en el servidor comunitario. Consulta el desglose técnico y atribución en [NOTICE.md](NOTICE.md).

---

## 📚 Documentación del Ecosistema

* [Ficha Técnica Oficial del Ecosistema](ECOSYSTEM_REGISTRY.md)
* [Historial de Cambios](CHANGELOG.md)
* [Acuerdo de Licencia Original (EULA)](LICENSE)
* [Aviso Legal y Atribución Upstream](NOTICE.md)
