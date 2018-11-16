//
//  SMPMediaPlaybackController.swift
//  MediaPlayback
//
//  Created by Dan Ellis on 08/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import SMP

internal class SMPMediaPlaybackController: MediaPlaybackController {

    private let smpView: UIView
    private let smpPlayer: BBCSMP

    init() {
        let itemProvider: BBCSMPItemProvider = BBCSMPMediaSelectorPlayerItemProvider(mediaSet: "mobile-phone-main",
                                                                                     vpid: "p06mr086")

        let smpBuilder = BBCSMPPlayerBuilder().withPlayerItemProvider(itemProvider)
        smpPlayer = smpBuilder.build()

        let smpUIBuilder = smpPlayer.buildUserInterface().withPluginFactories([HeadlessSMPPluginFactory()])
        smpView = smpUIBuilder.buildView()

        smpPlayer.play()
    }

    func mediaSurfaceView() -> MediaSurfaceView {
        return MediaView(playerView: smpView)
    }

}
