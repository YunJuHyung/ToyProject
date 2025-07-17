//
//  ViewController.swift
//  CoinTinder
//
//  Created by 윤주형 on 11/27/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var resultButton: UIButton!
    override func viewDidLoad() {
        makeUIButtonSetColor(button: startButton, color: UIColor.systemRed, borderWidth: 2, cornerRadius: 10)
        makeUIButtonSetColor(button: resultButton, color: UIColor.systemYellow, borderWidth: 2, cornerRadius: 10)
        
    }
    
    
    
    
    
    
    func makeUIButtonSetColor(button: UIButton, color: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = cornerRadius
    }
    
}

