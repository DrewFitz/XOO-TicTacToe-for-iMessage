//
//  ErrorViewController.swift
//  TicTacToe
//
//  Created by Drew Fitzpatrick on 8/9/16.
//  Copyright © 2016 Drew Fitzpatrick. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        if let gradientView = view as? GradientView {
            let index = UserDefaults.init().integer(forKey: "backgroundGradient")
            gradientView.gradient = ThemeStore.gradient(index)
        }
    }
    
}
