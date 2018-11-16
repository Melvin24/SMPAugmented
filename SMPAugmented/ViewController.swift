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
    
    lazy var playView: PlayView? = {
        let nib = Bundle.main.loadNibNamed("PlayView", owner: self, options: nil)
        let view = nib?.first as? PlayView
        return view
    }()
    
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

        sceneView.scene.rootNode.addChildNode(node)
        
    }
    
    func nodeAt(hitResult: ARHitTestResult) -> SCNNode {
        
        let aBox = SCNBox(width: 0.533, height: 0.01, length: 0.3, chamferRadius: 0)
        aBox.materials = [playViewMaterial()]
        
        let node = SCNNode(geometry: aBox)
        
        // We insert the geometry slightly above the point the user tapped
        // so that it drops onto the plane using the physics engine
        node.position = SCNVector3Make(
            hitResult.worldTransform.columns.3.x,
            hitResult.worldTransform.columns.3.y + 0.2,
            hitResult.worldTransform.columns.3.z
        )
        
        return node
    }
    
    func playViewMaterial() -> SCNMaterial {
        let material = SCNMaterial()
        material.diffuse.contents = self.playView
        return material
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

