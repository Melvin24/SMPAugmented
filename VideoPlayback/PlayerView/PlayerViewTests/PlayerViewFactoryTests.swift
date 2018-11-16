//
//  PlayerViewFactoryTests.swift
//  PlayerViewTests
//
//  Created by William Robinson on 06/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import XCTest
@testable import PlayerView

class PlayerViewFactoryTests: XCTestCase {

    var mediaSurfaceProvider: StubMediaSurfaceProvider!
    var playerViewFactory: PlayerViewFactory!

    override func setUp() {
        mediaSurfaceProvider = StubMediaSurfaceProvider()
        playerViewFactory = PlayerViewFactory(mediaSurfaceProvider: mediaSurfaceProvider)
    }

    override func tearDown() {
        mediaSurfaceProvider = nil
        playerViewFactory = nil
    }

    func testMake() {
        let playerViewViewController = playerViewFactory.make()
        XCTAssert(playerViewViewController is PlayerViewViewController)
    }
}

class StubMediaSurfaceProvider: MediaSurfaceProvider {
    func mediaSurface() -> UIView {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }
}
