# GetLanguage

## Overview
GetLanguage is an iOS game inspired by Flappy Bird where players collect English words while avoiding obstacles. The goal is to learn vocabulary through gameplay.

Flappy Bird風のゲームで、障害物を避けながら英単語を集める英語学習アプリです。

## Screenshots

<img width="295" height="640" alt="Simulator Screen Recording - iPhone 17 Pro - 2026-07-05 at 15 03 33" src="https://github.com/user-attachments/assets/25e72a6f-9191-4d16-9de7-f7a949dbdfde" />

## Motivation
Most language learning apps focus on memorization, which can become boring. That's why I wanted to combine English learning with gameplay inspired by Flappy Bird. Through this project, I also aimed to improve my SwiftUI and game development skills.

多くの英語学習アプリは暗記が中心で、単調になりがちです。

そこで、Flappy Bird風のシンプルなゲーム性を取り入れることで、英単語学習をより楽しくできるのではないかと考えました。

また、このプロジェクトを通してSwiftUIやゲーム開発のスキル向上も目指しました。

## Features
- Flappy Bird style gameplay
- Random word generation
- Game Over screen
- Restart game

## Architecture

```
ContentView
     │
     ▼
AppState
 ├── TitleView
 ├── GameView
 └── GameOverView

GameView
     │
     ▼
GameScene (SpriteKit)
     │
     ▼
WordManager
```

## Technologies
- SwiftUI
- AVFoundation
- SpriteKit

## Challenges
- adjust of difficulty level
- Customized pixel fonts to match the retro game style

## Future Improvements
- Online leaderboard
- More game stages
- Daily challenges
- Sound settings
- Multiple difficulty levels
- Vocabulary categories

## Demo

https://github.com/user-attachments/assets/362fd764-7241-4229-b399-cf62c7befd9f
