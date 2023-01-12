//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Patrick on 12.01.2023..
//

import UIKit

class ViewController: UIViewController {

    var model = APICaller()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("vc initialized")
        model.getVideos()
        view.backgroundColor = .red
    }
}

