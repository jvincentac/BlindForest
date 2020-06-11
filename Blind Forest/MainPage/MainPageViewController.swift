//
//  MainPageViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func toGame(_ sender: Any) {
        let sb = UIStoryboard(name: "Game", bundle: nil).instantiateViewController(withIdentifier: "game")
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: false, completion: nil)
    }
}
