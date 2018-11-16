//
//  MediaViewTests.swift
//  MediaPlaybackTests
//
//  Created by Chris Williamson on 06/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import XCTest
@testable import MediaPlayback

class MediaViewTests: XCTestCase {
    func testMediaSurfaceView() {
        let testView = UIView()
        let mediaSurfaceView: MediaSurfaceView = MediaView(playerView: testView)
        XCTAssertEqual(mediaSurfaceView.view, testView)
    }
}
