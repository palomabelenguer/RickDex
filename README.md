# RickDex (SwiftUI + MVVM)

Pequeña app que consume la API pública de Rick & Morty y muestra personajes en una **List** con **NavigationStack** y **Detail**.

- **API pública**: https://rickandmortyapi.com  
- **Endpoint (GET)**: https://rickandmortyapi.com/api/character
- **Arquitectura**: MVVM
- **iOS Target**: iOS 17+
- **Xcode**: 15+

## Qué hace
- Lista paginada de personajes (nombre, especie, status, imagen).
- Tap en un item → detalle con más información.
- Loading con `ProgressView`.
- Manejo de errores y modo offline (banner).

## Cómo correr
1. Abre el proyecto en Xcode (15+).
2. iOS Deployment Target: 17.0.
3. Run en simulador o dispositivo.

## Commits sugeridos
- `feat: initial project scaffolding with MVVM`
- `feat: add API service, models, list + detail views`
- `chore: add error handling, offline banner, and README`

