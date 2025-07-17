//
//  ViewController.swift
//  GDWebDesgin1
//
//  Created by 윤주형 on 6/13/24.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var orderUIButton: UIButton! //orderUIButton이랑 orderUiButton이 어떤게더 나은 문장인지 궁금합니다.
    @IBOutlet weak var menuPictureView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuPictureView.layer.cornerRadius = 5
        
        
        

    }
    
    @IBAction func moveToCashView(_ sender: UIButton) {
        guard let manageCashViewController = self.storyboard?.instantiateViewController(withIdentifier: "ManageCashViewController") as? ManageCashViewController else { return }
                // 화면 전환 애니메이션 설정
        manageCashViewController.modalTransitionStyle = .coverVertical
                // 전환된 화면이 보여지는 방법 설정 (fullScreen)
        manageCashViewController.modalPresentationStyle = .fullScreen
                self.present(manageCashViewController, animated: true, completion: nil)
    }
    
}

