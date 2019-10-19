//
//  ViewController.swift
//  metal-player
//
//  Created by Serg Liamthev on 10/19/19.
//  Copyright © 2019 serglam. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    private let contentView = StartView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

