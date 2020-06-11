//
//  FirstViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let visited = UserDefaults.standard.object(forKey: "visited") {
            let sb = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "main")
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false, completion: nil)
        }
        else {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "onboarding")
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false, completion: nil)
        }
    }

}
