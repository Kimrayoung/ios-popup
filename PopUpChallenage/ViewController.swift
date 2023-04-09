//
//  ViewController.swift
//  PopUpChallenage
//
//  Created by 김라영 on 2022/12/29.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view Did appear")
        
        //UserDefault를 통해서 다시보지 않기 버튼이 눌렸는지 판단
        let notShow = UserDefaults.standard.bool(forKey: "clickedNeverSeeBtn")
        
        if !notShow {
            showPopUp()
        } else {
            if let calledUrl: URL = URL(string: "https://www.youtube.com/") {
                self.webView.load(URLRequest(url: calledUrl))
            }
        }
    }

    fileprivate func showPopUp() {
        // 팝업 스토리보드 가져오기
        let popUpStoryBoard = UIStoryboard.init(name: "PopUp", bundle: nil)
        //팝업 스토리보드의 vc가져오기
        guard let popUpVC = popUpStoryBoard.instantiateViewController(withIdentifier: "PopUp") as? PopUpViewController else {
            return print("없다ㅏㅏ")
        }
        
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        
        self.present(popUpVC, animated: true)
        
        //popVC에서 호출이 되면 이부분이 실행됨
        popUpVC.closeBtnCompletionClosure = {
            print("completion 블럭 호출")
            
            if let calledUrl: URL = URL(string: $0) {
                self.webView.load(URLRequest(url: calledUrl))
            } else {
                print("url 없음")
            }
        }
    }

}

