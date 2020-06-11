//
//  resultsViewController.swift
//  Blind Forest
//
//  Created by Vincent Alexander Christian on 11/06/20.
//  Copyright © 2020 HKV. All rights reserved.
//

import UIKit

class resultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let sb = UIStoryboard(name: "MainPage", bundle: nil).instantiateViewController(withIdentifier: "main")
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: false, completion: nil)
    }

}
