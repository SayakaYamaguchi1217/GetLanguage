//
//  GameView.swift
//  getLanguage
//
//  Created by p10p093 on 2025/08/30.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        SpriteView(scene: createGameScene())
            .ignoresSafeArea()
    }
    
    private func createGameScene() -> GameScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .aspectFill
        
        // 選択されたレベルを設定
        scene.setLevel(appState.selectedLevel)
        
        // ゲームオーバー時のコールバック
        scene.onGameOver = {
            appState.gameOver()
        }
        
        return scene
    }
}

#Preview {
    GameView(appState: AppState())
}
