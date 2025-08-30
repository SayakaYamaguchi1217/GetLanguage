//
//  TitleView.swift
//  getLanguage
//
//  Created by p10p093 on 2025/08/30.
//

import SwiftUI

struct TitleView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Get Language")
                .font(.custom("PixelMplus12-Bold", size: 50))
                .foregroundColor(.primary)
                .padding(.top, 50)
            
            Text("TOEICレベルを選択してください")
                .font(.custom("PixelMplus12-Regular", size: 22))
                .foregroundColor(.secondary)
                .padding(.bottom, 10)
            
            VStack(spacing: 20) {
                // TOEIC 600点ボタン
                Button(action: {
                    appState.startGame(level: .level600)
                }) {
                    HStack {
                        Image(systemName: "graduationcap.fill")
                        Text("TOEIC 600点レベル")
                            .font(.custom("PixelMplus12-Bold", size: 25))
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                // TOEIC 700点ボタン
                Button(action: {
                    appState.startGame(level: .level700)
                }) {
                    HStack {
                        Image(systemName: "star.fill")
                        Text("TOEIC 700点レベル")
                            .font(.custom("PixelMplus12-Bold", size: 25))
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal, 40)
            
            Spacer()
            
            // 説明文
            VStack(spacing: 10) {
                Text("🐈️ 猫をタップしてジャンプ")
                Text("📚 英単語を集めながら飛び続けよう！")
                Text("🔊 単語は音声で読み上げられます")
            }
            .font(.custom("PixelMplus10-Regular", size: 20))
            
            .foregroundColor(.secondary)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    TitleView(appState: AppState())
}
