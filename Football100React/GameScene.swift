//
//  GameScene.swift
//  100ReactFootball
//
//  Created by Ramon Geronimo on 12/8/19.
//  Copyright © 2019 Ramon Geronimo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var level = 2
    var duration: CGFloat = 0.5
    var temp: CGFloat = 3.6
    
    var lastTouchLocation: CGPoint?
    var defensePlayer = SKSpriteNode()
    var defenseTimer : Timer?
    
    var runnerArray = [SKTexture]()
    var defenseArray = [SKTexture]()
    
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    var runningbackMovePointsPerSec: CGFloat = 600.0
    var velocity = CGPoint.zero
    
    var scoreLabel: SKLabelNode!
    var tackleLabel: SKLabelNode!
    var downLabel: SKLabelNode!
    
    var score = 0
    var tackle = 0
    var down = 0
    var endZone: Bool = false
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var touchdown = SKSpriteNode(imageNamed: "touchdown")
    var lossDown = SKSpriteNode(imageNamed: "LossDown")
    
    let runningbackCategory: UInt32 =  1
    let defenseCategory: UInt32 = 2
    
    var cameraMovePointsPerSec: CGFloat = 3.6
    var cameraNode: SKCameraNode!
    var playableRect: CGRect
    var cameraRect : CGRect {
        let x = cameraNode.position.x - size.width/2 + (size.width - playableRect.width)/2
        let y = cameraNode.position.y - size.height/2 + (size.height - playableRect.height)/2
        return CGRect(x: x, y: y, width: playableRect.width, height: playableRect.height)
    }
    
    
    override init(size: CGSize) {
       playableRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
       super.init(size: size)
    }
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func backgroundNode() -> SKSpriteNode {
        // 1
        let backgroundNode = SKSpriteNode()
        backgroundNode.anchorPoint = CGPoint.zero
        backgroundNode.name = "background"
        // 2
        let background1 = SKSpriteNode(imageNamed: "homeTouchDown")
        background1.anchorPoint = CGPoint.zero
        background1.position = CGPoint(x: 0, y: 0)
        background1.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background1)
        // 3
        let background2 = SKSpriteNode(imageNamed: "-10yard")
        background2.anchorPoint = CGPoint.zero
        background2.position = CGPoint(x: 0, y: background1.size.height)
        background2.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background2)
        // 4
        let background3 = SKSpriteNode(imageNamed: "-20yard")
        background3.anchorPoint = CGPoint.zero
        background3.position = CGPoint(x: 0, y: background1.size.height + background2.size.height)
        background3.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background3)
        // 5
        let background4 = SKSpriteNode(imageNamed: "-30yard")
        background4.anchorPoint = CGPoint.zero
        background4.position = CGPoint(x: 0, y: background1.size.height + background2.size.height + background3.size.height)
        background4.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background4)
        // 6
        let background5 = SKSpriteNode(imageNamed: "-40yard")
        background5.anchorPoint = CGPoint.zero
        background5.position = CGPoint(x: 0, y: background1.size.height + background2.size.height + background3.size.height + background4.size.height)
        background5.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background5)
        // 7
        let background6 = SKSpriteNode(imageNamed: "50yard")
        background6.anchorPoint = CGPoint.zero
        background6.position = CGPoint(x: 0, y: background1.size.height + background2.size.height + background3.size.height + background4.size.height + background5.size.height)
        background6.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background6)
        // 8
        let background7 = SKSpriteNode(imageNamed: "40yard")
        background7.anchorPoint = CGPoint.zero
        background7.position = CGPoint(x: 0, y: background1.size.height + background2.size.height + background3.size.height + background4.size.height + background5.size.height + background6.size.height)
        background7.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background7)
        // 9
        let background8 = SKSpriteNode(imageNamed: "30yard")
        background8.anchorPoint = CGPoint.zero
        background8.position = CGPoint(x: 0, y: background1.size.height + background2.size.height + background3.size.height + background4.size.height + background5.size.height + background6.size.height + background7.size.height)
        background8.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background8)
        // 10
        let background9 = SKSpriteNode(imageNamed: "20yard")
        background9.anchorPoint = CGPoint.zero
        background9.position = CGPoint(x: 0, y: background1.size.height + background2.size.height + background3.size.height + background4.size.height + background5.size.height + background6.size.height + background7.size.height + background8.size.height)
        background9.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background9)
        // 11
        let background10 = SKSpriteNode(imageNamed: "10yard")
        background10.anchorPoint = CGPoint.zero
        background10.position = CGPoint(x: 0, y: background1.size.height + background2.size.height + background3.size.height + background4.size.height + background5.size.height + background6.size.height + background7.size.height + background8.size.height + background9.size.height)
        background10.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background10)
        // 12
        let background11 = SKSpriteNode(imageNamed: "awayTouchDown")
        background11.anchorPoint = CGPoint.zero
        background11.position = CGPoint(x: 0, y: background1.size.height + background2.size.height + background3.size.height + background4.size.height + background5.size.height + background6.size.height + background7.size.height + background8.size.height + background9.size.height + background10.size.height)
        background11.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background11)
        //
        backgroundNode.size = CGSize(width: background1.size.width , height: background1.size.height + background2.size.height + background3.size.height + background4.size.height + background5.size.height + background6.size.height + background7.size.height + background8.size.height + background9.size.height + background10.size.height + background11.size.height)
        return backgroundNode
    }
    
    func moveCamera() {
        cameraNode.position.y += cameraMovePointsPerSec
        runningback.position.y = cameraNode.position.y - 250
        scoreLabel.position.y = cameraNode.position.y + 300
        tackleLabel.position.y = cameraNode.position.y + 270
        downLabel.position.y = cameraNode.position.y + 240
        

        enumerateChildNodes(withName: "background") { node, _ in
          let background = node as! SKSpriteNode
          if background.position.y + background.size.height <
            self.cameraRect.origin.y {
            self.level += 1
            print("Level: ", self.level)
            self.cameraMovePointsPerSec += 2
            self.temp = self.cameraMovePointsPerSec
            self.newLevel = true
            print("New Level", self.newLevel)
            background.position = CGPoint(
            x: background.position.x,
            y: background.position.y + background.size.height)
            print(background.position.y)
            }
           
        }
        
        

    }
    
    func createCamera() {
        cameraNode = SKCameraNode()
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    var newLevel = false
    func createBackground(){
        
        for i in 0...1 {
            background = backgroundNode()
            background.anchorPoint = CGPoint.zero
            background.position = CGPoint(x: 0, y: CGFloat(i)*background.size.height)
            background.name = "background"
            background.zPosition = -1
           
            addChild(background)
            
            
        }
        
        
    }
    
    func createRunningback(){
        runningback.position = CGPoint(x: size.width/2, y: size.height/2)
        runningback.size = CGSize(width: 300, height: 500)
        addChild(runningback)
        runningAnimation()
        
        runningback.name = "runningback"
        runningback.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 150, height: 250))
        runningback.physicsBody?.isDynamic = true
        runningback.physicsBody?.affectedByGravity = false
        runningback.physicsBody?.allowsRotation = false
        runningback.physicsBody?.categoryBitMask = runningbackCategory
        runningback.physicsBody?.collisionBitMask = runningbackCategory
        runningback.physicsBody?.contactTestBitMask = defenseCategory
        
    }
    
    
    var runningback = SKSpriteNode(imageNamed: "tile0")
    var background = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createBackground()
        debugDrawPlayableArea()
        createCamera()
        
        createRunningback()
        
        defenseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            if self.cameraMovePointsPerSec > 0 {
                self.createDefenseTop()
                self.createMoreDefenseRightTop()
                self.createMoreDefenseRight()
                self.createDefense()
                self.createMoreDefenseLeftTop()
                self.createMoreDefenseRight()
                self.createMoreDefenseLeftTop()
                self.createMoreDefenseLeft()
                self.createDefenseTop()
                self.createMoreDefenseRight()
                self.createDefense()
            } else if self.cameraMovePointsPerSec == 0 {
                self.defensePlayer.removeFromParent()
            }

        })
        
        createScoreLabel()
        createTackleLabel()
        createDownLabel()
        scoreLabel.text = "Score: \(score)"
        tackleLabel.text = "Tackle: \(tackle)"
        downLabel.text = "Down: \(down)"
        
        if newLevel {
            

            let touchdownAction = SKAction.run {
                self.touchdown.position.y = self.background.position.y + self.background.size.height
                self.touchDown()
            }
            let hide = SKAction.run {
                self.defensePlayer.removeFromParent()
            }
            
            
            let seq = SKAction.sequence([hide, touchdownAction])
            
            
            background.run(seq)
            newLevel = false
        }

       
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
            
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime

        if let lastTouchLocation = lastTouchLocation {
            let diff = lastTouchLocation - runningback.position
            if (diff.length() <= runningbackMovePointsPerSec * CGFloat(dt)) {
                runningback.position = lastTouchLocation
                velocity = CGPoint.zero
                
            }
        } else {
            moveSprite(runningback, velocity: velocity)
            
            
        }
        boundsCheckRunningback()
        moveCamera()
        scoreLabel.text = "Score: \(score)"
        tackleLabel.text = "Tackle: \(tackle)"
        downLabel.text = "Down: \(down)"
        
       
    }
    
    func moveSprite(_ sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = CGPoint(x: velocity.x * CGFloat(dt), y: velocity.y * CGFloat(dt))
        sprite.position = CGPoint(x: sprite.position.x + amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
    func moveRunningbackToward(location: CGPoint) {
        let offset = CGPoint(x: location.x - runningback.position.x, y: location.y - runningback.position.y)
        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x / CGFloat(length), y: offset.y / CGFloat(length))
        velocity = CGPoint(x: direction.x * runningbackMovePointsPerSec, y: direction.y * runningbackMovePointsPerSec)
        
    }
    
    func sceneTouched(touchLocation:CGPoint) {
      moveRunningbackToward(location: touchLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let touchLocation = touch.location(in: self)
            let node = atPoint(touchLocation)
            if node.name == "defense" {
                node.removeFromParent()
                if cameraMovePointsPerSec > 0 {
                    tackle += 1
                    print("Tackle: ", tackle)
                }
                
            } else if node.name == "runningback" {
                let move = SKAction.run {
                    self.runningAnimation()
                }
                let animate = SKAction.animate(with: runnerArray, timePerFrame: 0.1)
                runningback.run(SKAction.repeatForever(SKAction.group([animate, move])))
                background.isPaused = false
                self.cameraMovePointsPerSec = self.temp
                
            }
            
            sceneTouched(touchLocation: touchLocation)
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    func runningAnimation() {
        
        for i in 0..<12 {
            runnerArray.append(SKTexture(imageNamed: "tile\(i)"))
        }
        runningback.run(SKAction.repeatForever(SKAction.animate(with: runnerArray, timePerFrame: 0.1)))
    }
    
    
    
    

    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        let path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        shape.path = path
        shape.lineWidth = 4.0
//        shape.strokeColor = SKColor.red
        addChild(shape)
    }
    
    func boundsCheckRunningback() {
        let view = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let bottomLeft = CGPoint(x: view.minX, y: view.minY)
        let topRight = CGPoint(x: view.maxX, y: view.maxY)
        
        if runningback.position.x <= bottomLeft.x {
            runningback.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        
        if runningback.position.x >= topRight.x {
            runningback.position.x = topRight.x
            velocity.x = -velocity.x
        }
        
        if runningback.position.y <= bottomLeft.y {
            runningback.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        
        if runningback.position.y >= topRight.y {
        runningback.position.y = topRight.y
        velocity.y = -velocity.y
        }
    }
    
    
    func createDefense(){
        self.defensePlayer = SKSpriteNode(imageNamed: "a0")
        
        
        for i in 0..<24 {
            defenseArray.append(SKTexture(imageNamed: "a\(i)"))
        }
        defensePlayer.size = CGSize(width: 300, height: 500)
        defensePlayer.name = "defense"
        let runAction = SKAction.repeatForever(SKAction.animate(with: defenseArray, timePerFrame: 0.01))
        defensePlayer.run(runAction)
        defensePlayer.position = CGPoint(x:  CGFloat.random(min: playableRect.minX, max: playableRect.maxX), y:  -cameraNode.position.y + defensePlayer.size.height / 2 + defensePlayer.size.height)
        defensePlayer.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 150, height: 250) )
        defensePlayer.physicsBody?.isDynamic = true
        defensePlayer.physicsBody?.affectedByGravity = false
        defensePlayer.physicsBody?.allowsRotation = false
        defensePlayer.physicsBody?.categoryBitMask = defenseCategory
        defensePlayer.physicsBody?.collisionBitMask = defenseCategory
        defensePlayer.physicsBody?.contactTestBitMask = runningbackCategory
       
        addChild(defensePlayer)
        moveDefenseDownTop(defensePlayer: defensePlayer)
    }
    
    func createDefenseTop(){
        
        self.defensePlayer = SKSpriteNode(imageNamed: "a0")
        
        
        for i in 0..<24 {
            defenseArray.append(SKTexture(imageNamed: "a\(i)"))
        }
        defensePlayer.size = CGSize(width: 300, height: 500)
        
        let runAction = SKAction.repeatForever(SKAction.animate(with: defenseArray, timePerFrame: 0.01))
        defensePlayer.run(runAction)
        
        defensePlayer.name = "defense"
        defensePlayer.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 300, height: 500))
        defensePlayer.physicsBody?.isDynamic = true
        defensePlayer.physicsBody?.affectedByGravity = false
        defensePlayer.physicsBody?.allowsRotation = false
        defensePlayer.physicsBody?.categoryBitMask = defenseCategory
        defensePlayer.physicsBody?.collisionBitMask = defenseCategory
        defensePlayer.physicsBody?.contactTestBitMask = runningbackCategory
        
        
        moveDefenseDownTop(defensePlayer: defensePlayer)
        
        addChild(defensePlayer)
        
    }
    
    func createMoreDefenseLeft(){
        
        self.defensePlayer = SKSpriteNode(imageNamed: "a0")
        
        for i in 0..<24 {
            defenseArray.append(SKTexture(imageNamed: "a\(i)"))
        }
        defensePlayer.size = CGSize(width: 300, height: 500)
        
        let runAction = SKAction.repeatForever(SKAction.animate(with: defenseArray, timePerFrame: 0.01))
        defensePlayer.run(runAction)
        defensePlayer.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 300, height: 500))
        defensePlayer.physicsBody?.isDynamic = true
        defensePlayer.physicsBody?.affectedByGravity = false
        defensePlayer.physicsBody?.allowsRotation = false
        defensePlayer.physicsBody?.categoryBitMask = defenseCategory
        defensePlayer.physicsBody?.collisionBitMask = defenseCategory
        defensePlayer.physicsBody?.contactTestBitMask = runningbackCategory
        
        
        moveDefenseDown(defensePlayer: defensePlayer)
        moveDefenseLeft(defensePlayer: defensePlayer)
        
        
        addChild(defensePlayer)
        
    }
    
    func createMoreDefenseLeftTop(){
        
        self.defensePlayer = SKSpriteNode(imageNamed: "a0")
        
        
        for i in 0..<24 {
            defenseArray.append(SKTexture(imageNamed: "a\(i)"))
        }
        defensePlayer.size = CGSize(width: 300, height: 500)
        
        let runAction = SKAction.repeatForever(SKAction.animate(with: defenseArray, timePerFrame: 0.01))
        defensePlayer.run(runAction)
        defensePlayer.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 300, height: 500))
        defensePlayer.physicsBody?.isDynamic = true
        defensePlayer.physicsBody?.affectedByGravity = false
        defensePlayer.physicsBody?.allowsRotation = false
        defensePlayer.physicsBody?.categoryBitMask = defenseCategory
        defensePlayer.physicsBody?.collisionBitMask = defenseCategory
        defensePlayer.physicsBody?.contactTestBitMask = runningbackCategory
        
        moveDefenseDown(defensePlayer: defensePlayer)
        moveDefenseLeftTop(defensePlayer: defensePlayer)
        
        
        addChild(defensePlayer)
        
    }
    
    
    func createMoreDefenseRight(){
        
        self.defensePlayer = SKSpriteNode(imageNamed: "a0")
        
        
        for i in 0..<24 {
            defenseArray.append(SKTexture(imageNamed: "a\(i)"))
        }
        defensePlayer.size = CGSize(width: 300, height: 500)
        
        let runAction = SKAction.repeatForever(SKAction.animate(with: defenseArray, timePerFrame: 0.01))
        defensePlayer.run(runAction)
        defensePlayer.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 300, height: 500) )
        defensePlayer.physicsBody?.isDynamic = true
        defensePlayer.physicsBody?.affectedByGravity = false
        defensePlayer.physicsBody?.allowsRotation = false
        defensePlayer.physicsBody?.categoryBitMask = defenseCategory
        defensePlayer.physicsBody?.collisionBitMask = defenseCategory
        defensePlayer.physicsBody?.contactTestBitMask = runningbackCategory

        
        moveDefenseDown(defensePlayer: defensePlayer)
        moveDefenseRight(defensePlayer: defensePlayer)
        
        
        
        addChild(defensePlayer)
        
    }
    
    func createMoreDefenseRightTop(){
        
        self.defensePlayer = SKSpriteNode(imageNamed: "a0")
        
        
        for i in 0..<24 {
            defenseArray.append(SKTexture(imageNamed: "a\(i)"))
        }
        defensePlayer.size = CGSize(width: 300, height: 500)
        
        let runAction = SKAction.repeatForever(SKAction.animate(with: defenseArray, timePerFrame: 0.01))
        defensePlayer.run(runAction)
        defensePlayer.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 300, height: 500) )
        defensePlayer.physicsBody?.isDynamic = true
        defensePlayer.physicsBody?.affectedByGravity = false
        defensePlayer.physicsBody?.allowsRotation = false
        defensePlayer.physicsBody?.categoryBitMask = defenseCategory
        defensePlayer.physicsBody?.collisionBitMask = defenseCategory
        defensePlayer.physicsBody?.contactTestBitMask = runningbackCategory
        
        
        moveDefenseDown(defensePlayer: defensePlayer)
        moveDefenseRightTop(defensePlayer: defensePlayer)
        
        
        
        addChild(defensePlayer)
        
    }
    
    func moveDefenseDown(defensePlayer: SKSpriteNode) {
        guard let view = self.view else {
            return
        }
        let random = arc4random_uniform(UInt32(view.bounds.width))
        
        
        defensePlayer.position.x = cameraNode.position.x / 2
        defensePlayer.position.y = cameraNode.position.y + 400

        let moveDown = SKAction.moveBy(x: 0.0, y: -(scene?.view!.frame.height)! + defensePlayer.size.height / 2 + defensePlayer.size.height, duration: 2.0)
        let removeDefense = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, removeDefense])
        
        defensePlayer.run(sequence)
    }
    
    func moveDefenseDownTop(defensePlayer: SKSpriteNode) {
        guard let view = self.view else {
            return
        }
        let random = arc4random_uniform(UInt32(view.bounds.width))
        
        
        defensePlayer.position.x = cameraNode.position.x / 2
        defensePlayer.position.y = cameraNode.position.y + 400
        
        let moveDown = SKAction.moveBy(x: 0.0, y: -(scene?.view!.frame.height)! + defensePlayer.size.height / 2 + defensePlayer.size.height, duration: 5.0)
        let removeDefense = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, removeDefense])
        
        defensePlayer.run(sequence)
    }
    
    func moveDefenseLeft(defensePlayer: SKSpriteNode) {
        guard let view = self.view else {
            return
        }
        let random = arc4random_uniform(UInt32(view.bounds.width))
        
        
        defensePlayer.position.x = cameraNode.position.x / 2
        defensePlayer.position.y = cameraNode.position.y + 400
        
        let moveDown = SKAction.moveBy(x: -(scene?.view!.frame.width)! + defensePlayer.size.width / 2 + defensePlayer.size.height, y: 0.0, duration: 5.0)
        let removeDefense = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, removeDefense])
        
        defensePlayer.run(sequence)
    }
    
    func moveDefenseLeftTop(defensePlayer: SKSpriteNode) {
        guard let view = self.view else {
            return
        }
        let random = arc4random_uniform(UInt32(view.bounds.width))
        
        
        defensePlayer.position.x = cameraNode.position.x / 2
        defensePlayer.position.y = cameraNode.position.y + 400
        
        let moveDown = SKAction.moveBy(x: -(scene?.view!.frame.width)! + defensePlayer.size.width / 2 + defensePlayer.size.height, y: 0.0, duration: 5.0)
        let removeDefense = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, removeDefense])
        
        defensePlayer.run(sequence)
    }
    
    func moveDefenseRight(defensePlayer: SKSpriteNode) {
        guard let view = self.view else {
            return
        }
        let random = arc4random_uniform(UInt32(view.bounds.width))
        
        
        defensePlayer.position.x = cameraNode.position.x / 2
        defensePlayer.position.y = cameraNode.position.y + 400
        
        let moveDown = SKAction.moveBy(x: (scene?.view!.frame.width)! + defensePlayer.size.width / 2 + defensePlayer.size.height, y: 0.0, duration: 5.0)
        let removeDefense = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, removeDefense])
        
        defensePlayer.run(sequence)
    }
    
    func moveDefenseRightTop(defensePlayer: SKSpriteNode) {
        guard let view = self.view else {
            return
        }
        let random = arc4random_uniform(UInt32(view.bounds.width))
        
        
        defensePlayer.position.x = cameraNode.position.x / 2
        defensePlayer.position.y = cameraNode.position.y + 400
        
        let moveDown = SKAction.moveBy(x: (scene?.view!.frame.width)! + defensePlayer.size.width / 2 + defensePlayer.size.height, y: 0.0, duration: 5.0)
        let removeDefense = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, removeDefense])
        
        defensePlayer.run(sequence)
    }
    
    
    func touchDown() {
        touchdown.position.x = cameraNode.position.x / 2
        touchdown.position.y = cameraNode.position.y / 2
        touchdown.size = CGSize(width: screenWidth, height: screenHeight)
        touchdown.scene?.scaleMode = .aspectFill
        let wait = SKAction.wait(forDuration: 5)
        let dismiss = SKAction.removeFromParent()
        let background = SKAction.run {
            self.createBackground()
        }
        let score = SKAction.run {
            self.score += 7
            self.down = 0
            print("Score: ", self.score)
        }
        
        let seq = SKAction.sequence([wait, dismiss, score, background])
        touchdown.run(seq)
        addChild(touchdown)
    }
    
    func lossdown() {
        lossDown.position.x = cameraNode.position.x
        lossDown.position.y = cameraNode.position.y
        lossDown.size = (scene?.view?.frame.size)!
        lossDown.scene?.scaleMode = .aspectFill
        let wait = SKAction.wait(forDuration: 5)
        let dismiss = SKAction.removeFromParent()
        let seq = SKAction.sequence([wait, dismiss])
        lossDown.run(seq)
        addChild(lossDown)
        
    }


    
    func didBegin(_ contact: SKPhysicsContact) {
    

        if contact.bodyA.node?.name == "runningback" && cameraMovePointsPerSec > 0 {
            down += 1
            print("Down: ", down)
            collisionBetween(runningback: contact.bodyA.node!, defense: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "defense"  && cameraMovePointsPerSec > 0 {
            down += 1
            print("Down: ", down)
            collisionBetween(runningback: contact.bodyB.node!, defense: contact.bodyA.node!)
        }

        if down == 4 {
            defensePlayer.removeAllActions()
            defensePlayer.removeFromParent()
            lossdown()
            down = 0
            
        }

    }

    
    func collisionBetween(runningback: SKNode, defense: SKNode) {
        if runningback.name == "runningback" {
            print("collision occured")
            runningback.removeAllActions()
            defensePlayer.removeAllActions()
            defensePlayer.removeFromParent()
            background.isPaused = true
            cameraMovePointsPerSec = 0
            
            
        } else {
            print("it didn't work! collisionBetween")
        }
    }
    
    func createScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Helvetica")
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.fontColor = .black
        scoreLabel.position = CGPoint(x: 20, y: 700)
        addChild(scoreLabel)
    }
    
    func createTackleLabel() {
        tackleLabel = SKLabelNode(fontNamed: "Helvetica")
        tackleLabel.fontColor = .black
        tackleLabel.horizontalAlignmentMode = .left
        tackleLabel.position = CGPoint(x: 20, y: 670)
        addChild(tackleLabel)
    }
    
    func createDownLabel() {
        downLabel = SKLabelNode(fontNamed: "Helvetica")
        downLabel.fontColor = .black
        downLabel.horizontalAlignmentMode = .left
        downLabel.position = CGPoint(x: 20, y: 640)
        addChild(downLabel)
    }
}


