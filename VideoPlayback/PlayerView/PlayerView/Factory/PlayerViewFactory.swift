//
//  PlayerViewFactory.swift
//  PlayerView
//
//  Created by William Robinson on 05/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import UIKit

public struct PlayerViewFactory {

    public init() {}

    public func make(mediaSurfaceProvider: MediaSurfaceProvider) -> UIViewController {
        return PlayerViewViewController(mediaSurfaceView: mediaSurfaceProvider.mediaSurface())
    }
}
