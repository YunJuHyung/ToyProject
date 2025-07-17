//
//  RegistrationController.swift
//  AutoLayout-3
//
//  Created by 윤주형 on 5/31/24.
//

import UIKit
import SwiftUI

class AuthCheckViewController: UIViewController {
    
    @IBOutlet weak var agreeAllButton: UIButton!
    @IBOutlet weak var termsDefinedButton: UIButton!
    @IBOutlet weak var checkBox1: UIButton!
    @IBOutlet weak var checkBox2: UIButton!
    @IBOutlet weak var checkBox3: UIButton!
    @IBOutlet weak var checkBox4: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func tap1(_ sender: UIButton) {
        toggle(button: sender)
        termsDefinedButtonClear()
    }
    
    @IBAction func showalert(_ sender: UIButton) {
            showMessage(title: "알림", message: "완료됐습니다.", text: "확인")
        
    }
    
    
    private func toggle(button: UIButton) {
        if button == agreeAllButton {
            agreeAllButton.tintColor = button.isSelected ? .systemBlue : .white
            checkBox1.isSelected = button.isSelected
            checkBox2.isSelected = button.isSelected
            checkBox3.isSelected = button.isSelected
            checkBox4.isSelected = button.isSelected
        }
        
        if button.isSelected {
            button.isSelected = false
        } else {
            button.isSelected = true
        }
        
    }
    
    private func termsDefinedButtonClear() {
        if checkBox1.isSelected && checkBox2.isSelected && checkBox3.isSelected && checkBox4.isSelected {
            termsDefinedButton.isEnabled = true
            termsDefinedButton.setTitleColor(.blue, for: .normal)
        } else {
            termsDefinedButton.isEnabled = false
            termsDefinedButton.setTitleColor(.white, for: .normal)
        }
        
        //coredata로 bool타입 지정해서 뭔가 하면 시작하기 버튼까지 될수도?
        
    }
    
    private func showMessage(title: String, message: String, text: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let OkBtn = UIAlertAction(title: text, style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(OkBtn)
        present(alertController, animated: true, completion: nil)
    }
}
