//
//  MediaView.swift
//  MediaPlayback
//
//  Created by Melvin John on 05/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import UIKit

public protocol MediaSurfaceView {
    var view: UIView { get }
}

class MediaView: MediaSurfaceView {

    internal var view: UIView

    init(playerView: UIView) {
        view = playerView
    }

}
