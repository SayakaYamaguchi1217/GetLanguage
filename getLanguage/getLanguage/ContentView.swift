//
//  ContentView.swift
//  getLanguage
//
//  Created by p10p093 on 2025/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        switch appState.gameState {
        case .title:
            TitleView(appState: appState)
        case .playing:
            GameView(appState: appState)
        case .gameOver:
            GameOverView(appState: appState)
        }
    }
}

#Preview {
    ContentView()
}
