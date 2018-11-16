//
//  PlayerViewViewControllerTests.swift
//  PlayerViewViewControllerTests
//
//  Created by William Robinson on 05/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import XCTest
@testable import PlayerView

class PlayerViewViewControllerTests: XCTestCase {

    var mediaSurfaceView: UIView!
    var playerViewViewController: PlayerViewViewController!

    override func setUp() {
        mediaSurfaceView = UIView()
        playerViewViewController = PlayerViewViewController(mediaSurfaceView: mediaSurfaceView)
    }

    override func tearDown() {
        playerViewViewController = nil
    }

    func testSetupMediaSurfaceView() {
        XCTAssertTrue(playerViewViewController.view.subviews.count == 1)
        XCTAssertTrue(playerViewViewController.view.subviews[0] == mediaSurfaceView)
    }
}
