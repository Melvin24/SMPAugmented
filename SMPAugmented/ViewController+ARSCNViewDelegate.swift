//
//  ViewController+ARSCNViewDelegate.swift
//  SMPAugmented
//
//  Created by Melvin John on 16/11/2018.
//  Copyright © 2018 melvin. All rights reserved.
//

import ARKit

extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // Place content only for anchors found by plane detection.
        guard let planeAnchor = anchor as? ARPlaneAnchor else {
            return
        }
        
        let plane = Plane(withAnchor: planeAnchor, hidden: false)
        self.planes[planeAnchor.identifier] = plane
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        // Update content only for plane anchors and nodes matching the setup created in `renderer(_:didAdd:for:)`.
        guard let plane = planes[anchor.identifier],
            let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        plane.update(anchor: planeAnchor)

    }
}
