# Love Game Memories 💕

Un juego emotivo y artístico en Godot donde expresas tus sentimientos a través de recuerdos interactivos.

## 🎮 Concepto

El jugador se encuentra en una habitación vista en primera persona. Puede ver sus manos, su cara en un espejo y está sentado frente a un ordenador. La habitación está decorada con objetos escondidos (peluches, fotos, etc.) que el jugador puede encontrar y colocar en el escritorio.

Cada objeto desbloqueado revela cartas/recuerdos en el ordenador - dedicatorios especiales con imágenes y música que expresan sentimientos de manera dulce y nostálgica.

## 🎨 Estilo Visual

- **Habitación**: Estilo tinta china en blanco y negro - todo se mezcla pero mantiene belleza
- **Ordenador**: Realista con color - contrasta con el resto
- **Cartas/Recuerdos**: Con color, imágenes y música desbloqueable
- **Efecto de profundidad**: Sobreposición 2D que simula 3D sin usar motor 3D

## 📁 Estructura del Proyecto

```
love-game-memories1/
├── scenes/
│   ├── main_room.tscn           # Escena principal de la habitación
│   ├── computer_ui.tscn         # UI del ordenador
│   ├── player_hands.tscn        # Manos del jugador (vista primera persona)
│   ├── mirror.tscn              # Espejo con reflejo del personaje
│   └── collectibles/            # Objetos coleccionables
│       ├── collectible_base.tscn
│       ├── plushie.tscn
│       ├── photo.tscn
│       └── item_base.tscn
├── scripts/
│   ├── game_manager.gd          # Gestor principal del juego
│   ├── player.gd                # Control del jugador
│   ├── collectible_system.gd    # Sistema de objetos coleccionables
│   ├── memory_system.gd         # Sistema de recuerdos/cartas
│   ├── computer_ui.gd           # Lógica del ordenador
│   ├── visual_effects.gd        # Efectos visuales (B&N a color)
│   └── audio_manager.gd         # Gestor de música y audio
├── assets/
│   ├── graphics/
│   │   ├── ink_style/           # Dibujos estilo tinta china
│   │   ├── hands/               # Manos en primera persona
│   │   ├── mirror/              # Espejo y reflejo
│   │   ├── furniture/           # Muebles de la habitación
│   │   └── collectibles/        # Sprites de objetos
│   ├── memories/
│   │   ├── letters/             # Imágenes de cartas
│   │   └── photos/              # Fotos desbloqueables
│   └── audio/
│       ├── music/               # Música de cartas
│       └── sfx/                 # Efectos de sonido
├── data/
│   ├── collectibles.json        # Datos de objetos coleccionables
│   ├── memories.json            # Datos de recuerdos/cartas
│   └── game_state.json          # Estado de progreso del juego
└── project.godot
```

## 🎯 Mecánicas Principales

1. **Exploración**: Buscar objetos escondidos en la habitación
2. **Colección**: Coger objetos y decorar el escritorio
3. **Desbloqueo**: Cada objeto desbloqueador cartas/recuerdos
4. **Lectura**: Ver cartas con imágenes y música en el ordenador
5. **Nostalgia**: Atmósfera emotiva que expresa sentimientos

## 🚀 Próximos Pasos

- [ ] Crear escena base de la habitación
- [ ] Implementar sistema de recogida de objetos
- [ ] Crear UI del ordenador
- [ ] Implementar sistema de desbloqueo
- [ ] Añadir efectos visuales (blanco/negro → color)
- [ ] Crear cartas/recuerdos
- [ ] Añadir música y audio
- [ ] Polish y efectos finales

## 💝 Dedicatoria

Este juego es un proyecto especial para expresar amor y aprecio de manera creativa y significativa.
