//
//  GameScene.swift
//  getLanguage
//
//  Created by p10p093 on 2025/08/24.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    let synthesizer = AVSpeechSynthesizer()
    let wordManager = WordManager()
    
    var onGameOver: (() -> Void)?
    var currentLevel: TOEICLevel = .level600  // 現在のレベルを保持
    
    private var bird: SKSpriteNode!
    private var gameOver = false
    
    // カテゴリ定義
    struct PhysicsCategory {
        static let bird: UInt32 = 1 << 0
        static let obstacle: UInt32 = 1 << 1
        static let word: UInt32 = 1 << 2
    }
    
    // レベルを設定するメソッド
    func setLevel(_ level: TOEICLevel) {
        currentLevel = level
    }
    
    override func didMove(to view: SKView) {
        // シーンが表示された時に呼ばれる
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        physicsWorld.contactDelegate = self
        
        // レベルに応じた背景色を設定
        switch currentLevel {
        case .level600:
            backgroundColor = .cyan
        case .level700:
            backgroundColor = SKColor(red: 0.2, green: 0.1, blue: 0.4, alpha: 1.0) // 濃い紫
        }
        
        // 鳥の初期化
        bird = SKSpriteNode(imageNamed: "cat")
        bird.size = CGSize(width: 70, height: 70)
        bird.position = CGPoint(x: frame.midX / 2, y: frame.midY)
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.isDynamic = true
        
        bird.physicsBody?.categoryBitMask = PhysicsCategory.bird
        bird.physicsBody?.contactTestBitMask = PhysicsCategory.obstacle | PhysicsCategory.word
        bird.physicsBody?.collisionBitMask = PhysicsCategory.obstacle   // 障害物だけ衝突
        
        bird.physicsBody?.mass = 0.1

        addChild(bird)
        
        // レベル表示
        let levelLabel = SKLabelNode(text: currentLevel.displayName)
        levelLabel.fontSize = 18
        levelLabel.fontColor = .white
        levelLabel.position = CGPoint(x: frame.midX, y: frame.height - 50)
        addChild(levelLabel)
        
        // タップでジャンプ
        let tap = UITapGestureRecognizer(target: self, action: #selector(flap))
        view.addGestureRecognizer(tap)
        
        // 障害物を定期生成（レベルに応じて間隔を調整）
        let createPipes = SKAction.run { [weak self] in
            self?.addPipe()
        }
        
        // 700点レベルは少し難しくする（間隔を短く）
        let interval = currentLevel == .level700 ? 1.8 : 2.0
        let delay = SKAction.wait(forDuration: interval)
        run(SKAction.repeatForever(SKAction.sequence([createPipes, delay])))
    }
    
    func speakWord(_ word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
    
    @objc func flap() {
        if gameOver { return }
        // 現在の速度をリセット（これで連打しても安定する）
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        // 小さめのインパルスで「ふわっ」と上がる
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 35))
        
        // 上に向けて少し傾ける
        let tiltUp = SKAction.rotate(toAngle: 0.3, duration: 0.1)
        bird.run(tiltUp)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let velocity = bird.physicsBody?.velocity {
            // 速度に応じて鳥を傾ける（落下時は下向きに）
            bird.zRotation = min(max(velocity.dy / 200, -1.0), 0.5)
        }
        
        // 画面外チェック
        if !gameOver {
            if bird.position.y < 0 || bird.position.y > frame.height {
                gameOver = true
                isPaused = true
                onGameOver?()
                print("🔴 鳥が画面外に出たのでゲームオーバー")
            }
        }
    }
    
    func addPipe() {
        // レベルに応じてギャップサイズを調整
        let gap: CGFloat = currentLevel == .level700 ? 200 : 220  // 700点レベルはより狭く
        let pipeWidth: CGFloat = 60
        let pipeHeight = CGFloat.random(in: 200...400)
        
        // レベルに応じてパイプの色を変更
        let pipeColor: SKColor = currentLevel == .level700 ? .red : .green
        
        let bottomPipe = SKSpriteNode(color: pipeColor, size: CGSize(width: pipeWidth, height: pipeHeight))
        bottomPipe.position = CGPoint(x: frame.width + pipeWidth, y: pipeHeight / 2)
        bottomPipe.physicsBody = SKPhysicsBody(rectangleOf: bottomPipe.size)
        bottomPipe.physicsBody?.isDynamic = false
        bottomPipe.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        bottomPipe.physicsBody?.contactTestBitMask = PhysicsCategory.bird
        bottomPipe.physicsBody?.collisionBitMask = PhysicsCategory.bird   // 鳥と衝突する
        addChild(bottomPipe)
        
        let topPipeHeight = frame.height - pipeHeight - gap
        let topPipe = SKSpriteNode(color: pipeColor, size: CGSize(width: pipeWidth, height: topPipeHeight))
        topPipe.position = CGPoint(x: frame.width + pipeWidth, y: frame.height - topPipeHeight / 2)
        topPipe.physicsBody = SKPhysicsBody(rectangleOf: topPipe.size)
        topPipe.physicsBody?.isDynamic = false
        topPipe.physicsBody?.categoryBitMask = PhysicsCategory.obstacle
        topPipe.physicsBody?.contactTestBitMask = PhysicsCategory.bird
        topPipe.physicsBody?.collisionBitMask = PhysicsCategory.bird
        addChild(topPipe)
        
        // ✨ 英単語ノード（現在のレベルに応じた単語を表示）
        let word = SKLabelNode(text: wordManager.getRandomWord(for: currentLevel))
        word.fontSize = currentLevel == .level700 ? 20 : 24  // 700点レベルは文字を少し小さく
        word.fontColor = currentLevel == .level700 ? .yellow : .black
        word.position = CGPoint(x: frame.width + pipeWidth,
                                y: pipeHeight + gap / 2)
        
        // 当たり判定（押し返さない設定）
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 40))
        body.isDynamic = false
        body.categoryBitMask = PhysicsCategory.word
        body.contactTestBitMask = PhysicsCategory.bird   // 鳥と接触を検知
        body.collisionBitMask = 0                        // 衝突しない
        word.physicsBody = body
        
        addChild(word)
        
        // 移動アニメーション（レベルに応じて速度を調整）
        let speed = currentLevel == .level700 ? 3.5 : 4.0  // 700点レベルは少し速く
        let move = SKAction.moveBy(x: -frame.width - pipeWidth, y: 0, duration: speed)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, remove])
        bottomPipe.run(sequence)
        topPipe.run(sequence)
        word.run(sequence)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
        
        let categories = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        // 🟢 鳥 + 英単語
        if categories == (PhysicsCategory.bird | PhysicsCategory.word) {
            if let wordNode = (contact.bodyA.categoryBitMask == PhysicsCategory.word ? nodeA : nodeB) as? SKLabelNode,
               let word = wordNode.text {

                // エフェクト
                let scaleUp = SKAction.scale(to: 1.5, duration: 0.2)
                let fadeOut = SKAction.fadeOut(withDuration: 0.2)
                let moveUp = SKAction.moveBy(x: 0, y: 20, duration: 0.2)
                let group = SKAction.group([scaleUp, fadeOut, moveUp])
                let remove = SKAction.removeFromParent()
                wordNode.run(SKAction.sequence([group, remove]))

                // ✅ 効果音（効果音ファイルがある場合）
                // run(SKAction.playSoundFileNamed("pickup.wav", waitForCompletion: false))

                // ✅ 読み上げ
                speakWord(word)

                print("✅ 英単語を獲得！ \(word) (レベル: \(currentLevel.displayName))")
            }
            return
        }

        // 🔴 鳥 + 障害物
        if categories == (PhysicsCategory.bird | PhysicsCategory.obstacle) {
            if !gameOver {
                gameOver = true
                isPaused = true
                onGameOver?()
            }
        }
    }
}
