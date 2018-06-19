//
//  ViewController.swift
//  init_project
//
//  Created by julien on 18/06/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func action(_ sender: Any) {
        // Todo - replace
        ObjectWS.testAPICall(userId: "486", success: { (messages) in
            print("success : \(messages)")
        }) { (error) in
            print("error : \(error)")
        }
    }
}

