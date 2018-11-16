//
//  HeadlessSMPPluginFactory.swift
//  MediaPlayback
//
//  Created by Melvin John on 05/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import UIKit
import SMP

class HeadlessSMPPluginFactory: NSObject, BBCSMPPluginFactory {

    func createPlugin(withEnvironment environment: BBCSMPPluginEnvironment) -> BBCSMPPlugin {
        var view = UIView()
        environment.add(button: view, in: BBCSMPButtonPosition.titleBarRight)

        let playerViewClass: AnyClass = NSClassFromString("BBCSMPPlayerView")!
        let playbackControlView: AnyClass = NSClassFromString("BBCSMPPlaybackControlView")!
        let titleBar: AnyClass = NSClassFromString("BBCSMPTitleBar")!
        let gradientView: AnyClass = NSClassFromString("BBCSMPGradientView")!

        let classesToHide = [playbackControlView, titleBar, gradientView]
        while !view.isKind(of: playerViewClass) {
            guard let superview = view.superview else { break }
            view = superview
        }
        view.isUserInteractionEnabled = false

        view.subviews.filter({ subview -> Bool in
            return classesToHide.contains(where: { clazz -> Bool in
                return subview.isKind(of: clazz)
            })
        }).forEach { view in
            view.forceHide()
        }

        return EmptyPlugin()
    }
}

fileprivate extension UIView {
    func forceHide() {
        isHidden = true
        layer.isHidden = true
        alpha = 0
        isUserInteractionEnabled = false
    }
}
