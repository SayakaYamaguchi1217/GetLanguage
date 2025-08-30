//
//  GameOverView.swift
//  getLanguage
//
//  Created by p10p093 on 2025/08/25.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Game Over")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text("プレイしたレベル: \(appState.selectedLevel.displayName)")
                .font(.title2)
                .foregroundColor(.secondary)
            
            VStack(spacing: 20) {
                // リトライボタン（同じレベルで再プレイ）
                Button(action: {
                    appState.startGame(level: appState.selectedLevel)
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("もう一度プレイ")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // レベル選択に戻るボタン
                Button(action: {
                    appState.returnToTitle()
                }) {
                    HStack {
                        Image(systemName: "house.fill")
                        Text("レベル選択に戻る")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    GameOverView(appState: AppState())
}
