//
//  PopUpViewController.swift
//  PopUpChallenage
//
//  Created by 김라영 on 2022/12/29.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var bgButton: UIButton!
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var detailBtn: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var neverSeeBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    var closeBtnCompletionClosure: ((String) -> ())? = nil
    
    let gray400 = UIColor(named: "gray400")
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        print("popUp viewDidLoad() called")
        
        popUpView.layer.cornerRadius = 10
        popUpView.layer.borderWidth = 1
        popUpView.clipsToBounds = true
//        popUpView.layer.borderColor = gray400?.cgColor
        detailBtn.layer.cornerRadius = 23
        neverSeeBtn.addRightBorder(borderColor: .lightGray, borderWidth: 1.0)
    }
    
    //다시보지 않기 버튼을 누를 경우
    @IBAction func neverSeeBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line, "- neverSeeBtn")
        
        //userDefault저장
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "clickedNeverSeeBtn")
        
        //main view controller에 closeBtnCompletionClosure의 값이 있다면 closeBtnCompletionClosure이 실행된다
        if let closeBtnCompletionClosure = closeBtnCompletionClosure {
            print("closueBtnCompletionClosure called in popUpViewController")
            closeBtnCompletionClosure("https://www.youtube.com/")
        } else {
            print("why nil?")
        }
        self.dismiss(animated: true)
    }
    
    //닫기 버튼 누를경우
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        //webViewController가 열리고 webViewController가 webViewController가 열렸다는 것을 인지하고 url을 통해서 web을 가져와서 보여줘야 한다
        //근데 여기서 그냥 present main을 해서 바로 webView세팅을 해서 보여주면 되는 거 아닌가?
        //웹 뷰를 보여주는 거는 main view controller가 하는 것이므로 독립적인 운영을 위해서 webview가 처리하는게 맞다
        if let closeBtnCompletionClosure = closeBtnCompletionClosure {
            print("closueBtnCompletionClosure called in popUpViewController")
            closeBtnCompletionClosure("https://www.youtube.com/")
        } else {
            print("why nil?")
        }
        self.dismiss(animated: true)
    }
    
    //팝업창 바깥 부분을 누를 경우
    @IBAction func bgBtnclicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.closeBtnCompletionClosure?("https://www.youtube.com/")
        })
    }
    
}


extension UIButton {
    func addRightBorder(borderColor: UIColor, borderWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = CGRect(x: self.frame.size.width - borderWidth, y: 0, width: borderWidth, height: self.frame.size.height)
        
        self.layer.addSublayer(border)
    }
    
}


