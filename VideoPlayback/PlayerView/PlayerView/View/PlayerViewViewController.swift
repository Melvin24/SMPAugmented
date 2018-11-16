//
//  PlayerViewViewController.swift
//  PlayerView
//
//  Created by William Robinson on 05/11/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import UIKit

class PlayerViewViewController: UIViewController {

    private let mediaSurfaceView: UIView

    init(mediaSurfaceView: UIView) {
        self.mediaSurfaceView = mediaSurfaceView

        super.init(nibName: "PlayerViewViewController", bundle: Bundle(for: PlayerViewViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMediaSurfaceView()
    }

    func setupMediaSurfaceView() {
        mediaSurfaceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mediaSurfaceView)
        view.addConstraints([mediaSurfaceView.topAnchor.constraint(equalTo: view.topAnchor),
                             mediaSurfaceView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                             mediaSurfaceView.leftAnchor.constraint(equalTo: view.leftAnchor),
                             mediaSurfaceView.rightAnchor.constraint(equalTo: view.rightAnchor)])
    }
}
