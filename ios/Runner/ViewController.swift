//
//  ViewController.swift
//  Runner
//
//  Created by Zohaib Kambrani on 06/03/2023.
//

import Foundation
import Flutter
import PassKit

class ViewController : FlutterViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        apple(viewController: self)
    }
}
