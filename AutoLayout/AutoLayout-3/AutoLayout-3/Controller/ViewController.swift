//
//  ViewController.swift
//  AutoLayout-3
//
//  Created by 윤주형 on 5/31/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var KLabelButton: UIButton!
    @IBOutlet weak var GLabelButton: UIButton!
    @IBOutlet weak var ALabelButton: UIButton!
    @IBOutlet weak var FLabelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setButtonDesign()
    }
    
    @IBAction func KakaoButton(_ sender: UIButton) {
        print("KakaoButton pressed")
        didTapButton()
    }
    
    @IBAction func GoogleButton(_ sender: UIButton) {
        didTapButton()
        print("GoogleButton pressed")
    }
    
    @IBAction func AppleButton(_ sender: UIButton) {
        didTapButton()
        print("AppleButton pressed")
    }
    
    @IBAction func FacebookButton(_ sender: UIButton) {
        didTapButton()
        print("FacebookButton pressed")
    }
    
    private func didTapButton() {
        if let nextVC = self.storyboard?.instantiateViewController(identifier: "AuthCheckViewController") as? AuthCheckViewController {
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    private func setButtonDesign() {
        configureButton(button: GLabelButton, title: "Google로 시작", imageName: "GLogo2")
        configureButton(button: ALabelButton, title: "Apple로 등록", imageName: "ALogo")
        configureButton(button: FLabelButton, title: "FaceBook으로 시작", imageName: "FLogo")
    }
    
    private func configureButton(button: UIButton, title: String, imageName: String) {
        //
        guard let image = UIImage(named: imageName) else {
            print("image \(imageName) is nil")
            return
        }
        
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 24, height: 24))
        
        
        
        //버튼 캡슐모양 관련
        var configuration = UIButton.Configuration.filled()
            configuration.title = title
            configuration.image = resizedImage
            configuration.imagePlacement = .leading
            configuration.imagePadding = 15
            configuration.cornerStyle = .capsule
            configuration.baseForegroundColor = .black
            configuration.baseBackgroundColor = .white
        
        
        //위에 configuration 버튼에전달
            button.configuration = configuration
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = button.frame.height / 2
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .center
    }
    
    //MARK: -- image 사이즈 관련 문제 해결 방안*
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Determine the scale factor to use
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new size
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        
        // Create a new image context
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}

