//
//  AppState.swift
//  getLanguage
//
//  Created by p10p093 on 2025/08/30.
//

import SwiftUI

// ゲームの状態を管理
enum GameState {
    case title
    case playing
    case gameOver
}

// TOEIC レベルを定義
enum TOEICLevel: String, CaseIterable {
    case level600 = "TOEIC 600点"
    case level700 = "TOEIC 700点"
    
    var displayName: String {
        return self.rawValue
    }
}

// アプリ全体の状態を管理するObservableObject
class AppState: ObservableObject {
    @Published var gameState: GameState = .title
    @Published var selectedLevel: TOEICLevel = .level600
    
    func startGame(level: TOEICLevel) {
        selectedLevel = level
        gameState = .playing
    }
    
    func gameOver() {
        gameState = .gameOver
    }
    
    func returnToTitle() {
        gameState = .title
    }
}
