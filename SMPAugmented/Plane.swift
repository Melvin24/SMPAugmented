//
//  Plane.swift
//  SMPAugmented
//
//  Created by Melvin John on 16/11/2018.
//  Copyright © 2018 melvin. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class Plane: SCNNode {
    
    let planeAnchor: ARPlaneAnchor
    let planeGeometry: SCNPlane
    
    init(withAnchor anchor: ARPlaneAnchor, hidden: Bool) {
        
        planeAnchor = anchor
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        
        planeGeometry = SCNPlane(width: width, height: height)
        
        super.init()
        
        planeGeometry.materials.first?.diffuse.contents = UIColor.transparentLightBlue
        
        let planeNode = SCNNode(geometry: planeGeometry)
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        
        planeNode.position = SCNVector3(x,y,z)
        
        planeNode.eulerAngles.x = -.pi / 2
        
        // Give the plane a physics body so that items we add to the scene interact with it
        planeNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: planeGeometry, options: nil))
        
        setTextureScale()

        addChildNode(planeNode)

    }
    
    func setTextureScale() {
        let width = Float(planeGeometry.width)
        let height = Float(planeGeometry.height)
        
        // As the width/height of the plane updates, we want our tron grid material to
        // cover the entire plane, repeating the texture over and over. Also if the
        // grid is less than 1 unit, we don't want to squash the texture to fit, so
        // scaling updates the texture co-ordinates to crop the texture in that case
        let material = planeGeometry.materials.first
        material?.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1);
        material?.diffuse.wrapS = .repeat;
        material?.diffuse.wrapT = .repeat;
    }
    
    func update(anchor: ARPlaneAnchor) {
        
        simdPosition = float3(anchor.center.x, 0, anchor.center.z)
        
        /*
         Plane estimation may extend the size of the plane, or combine previously detected
         planes into a larger one. In the latter case, `ARSCNView` automatically deletes the
         corresponding node for one plane, then calls this method to update the size of
         the remaining plane.
         */
        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.height = CGFloat(anchor.extent.z)
        
        _ = self.childNodes.map {
            $0.physicsBody?.physicsShape = SCNPhysicsShape(geometry: planeGeometry, options: nil)
        }
        //        position = SCNVector3(anchor.center.x, 0, anchor.center.z);
        
        setTextureScale()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
