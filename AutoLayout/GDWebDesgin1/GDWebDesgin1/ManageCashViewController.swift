//
//  ManageCashViewController.swift
//  GDWebDesgin1
//
//  Created by 윤주형 on 6/21/24.
//

import UIKit

class ManageCashViewController: UIViewController {
    


    @IBOutlet weak var userAccumulatedLabelColor: UILabel!
    @IBOutlet weak var userCancledOrderLabelColor: UILabel!
    @IBOutlet weak var userUsesLabelColor: UILabel!
    @IBOutlet weak var userWithdrawLabelColor: UILabel!
    @IBOutlet weak var userAccumulatedCardView: UIView!
    @IBOutlet weak var userCancledOrderCardView: UIView!
    @IBOutlet weak var userUsesCardView: UIView!
    @IBOutlet weak var userWithdrawCardView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        userPointUsesViewLayout(userAccumulatedCardView)
        userPointUsesViewLayout(userCancledOrderCardView)
        userPointUsesViewLayout(userUsesCardView)
        userPointUsesViewLayout(userWithdrawCardView)
        
        membershipPointLabel(userAccumulatedLabelColor, backgroundColor: .cyan)
        membershipPointLabel(userCancledOrderLabelColor, backgroundColor: .systemGray3)
        membershipPointLabel(userUsesLabelColor, backgroundColor: .yellow)
        membershipPointLabel(userWithdrawLabelColor,backgroundColor: .systemPink)
        
        
        
    }
    
    //카드 레이아웃 뷰
    func userPointUsesViewLayout(_ view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    //멤버쉽 포인트 사용한 곳
    func membershipPointLabel(_ label:UILabel, backgroundColor color: UIColor) {
        label.backgroundColor = color
        label.layer.cornerRadius = label.frame.height / 2
        label.layer.masksToBounds = true
        
    }

    
}
