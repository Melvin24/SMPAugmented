//
//  MediaPlaybackFactory.swift
//  MediaPlayback
//
//  Created by Melvin John on 05/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

public struct MediaPlaybackFactory {

    public init() {}

    public func makeMediaPlaybackController() -> MediaPlaybackController {

       return SMPMediaPlaybackController()

    }

}
