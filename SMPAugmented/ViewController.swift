//
//  ViewController.swift
//  SMPAugmented
//
//  Created by Melvin John on 16/11/2018.
//  Copyright © 2018 melvin. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    // A dictionary of all the current planes being rendered in the scene
    var planes: [UUID : Plane] = [:]
    lazy var tapGestureRec = UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment to configure lighting
        // configureLighting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
        setupTapGestureRecogniser(for: sceneView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        removeTapGestureRecogniser(for: sceneView)
    }
    
    func setUpSceneView() {
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)

        UIApplication.shared.isIdleTimerDisabled = true
        
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
    }
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    
    func setupTapGestureRecogniser(for sceneView: ARSCNView) {
        sceneView.addGestureRecognizer(tapGestureRec)
    }
    
    func removeTapGestureRecogniser(for sceneView: ARSCNView) {
        sceneView.removeGestureRecognizer(tapGestureRec)
    }
    
    @objc func tapped(recognizer: UIGestureRecognizer) {
        let tapPoint = recognizer.location(in: sceneView)
        
        let hitResult = sceneView.hitTest(tapPoint, types: [.existingPlaneUsingExtent])
        guard hitResult.count > 0  else {
            return
        }
        
        // If there are multiple hits, just pick the closest plane
        let closestHitResult = hitResult[0]
        
        let node = nodeAt(hitResult: closestHitResult)
        
        //        guard let scene = SCNScene(named: "art.scnassets/ship.scn"),
        //              let shipNode = scene.rootNode.childNode(withName: "ship", recursively: true) else {
        //            return
        //        }
        //
        //        shipNode.scale = SCNVector3(x: 0.25, y: 0.25, z: 0.25)
        //
        //        shipNode.position = SCNVector3Make(
        //            closestHitResult.worldTransform.columns.3.x,
        //            closestHitResult.worldTransform.columns.3.y + 0.3,
        //            closestHitResult.worldTransform.columns.3.z
        //        )
        
        sceneView.scene.rootNode.addChildNode(node)
        //        sceneView.scene.rootNode.addChildNode(sceneNode)
        
        //        boxeqs.append(node)
        
    }
    
    func nodeAt(hitResult: ARHitTestResult) -> SCNNode {
        
        let aBox = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let node = SCNNode(geometry: aBox)
        
        // The physicsBody tells SceneKit this geometry should be
        // manipulated by the physics engine
        node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        node.physicsBody?.mass = 2.0
        
        node.physicsBody?.categoryBitMask = Int(SCNPhysicsCollisionCategory.default.rawValue)
        
        // We insert the geometry slightly above the point the user tapped
        // so that it drops onto the plane using the physics engine
        node.position = SCNVector3Make(
            hitResult.worldTransform.columns.3.x,
            hitResult.worldTransform.columns.3.y + 0.2,
            hitResult.worldTransform.columns.3.z
        )
        
        return node
    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

extension UIColor {
    open class var transparentLightBlue: UIColor {
        return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.50)
    }
}

