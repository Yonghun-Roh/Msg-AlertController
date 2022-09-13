//
//  ViewController.swift
//  Msg-AlertController
//
//  Created by Yonghun Roh on 2022/09/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var result: UILabel!
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    @IBAction func alert(_ sender: Any) {
        // 메시지창 객체 생성
        let alert = UIAlertController(title: "선택", message: "항목을 선택해주세요", preferredStyle: .alert)
        
        let cancle = UIAlertAction(title: "취소", style: .cancel){ (_) in  // 취소버튼
            self.result.text = "취소 버튼을 클릭했습니다." }
        
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            self.result.text = "확인 버튼을 클릭했습니다." } // 확인버튼
            
        let exe = UIAlertAction(title: "실행", style: .destructive) {(_) in
            self.result.text = "실행 버튼을 클릭했습니다." } // 실행버튼
        
        let stop = UIAlertAction(title: "중지", style: .default) { (_) in
            self.result.text = "중지 버튼을 클릭했습니다."
        } // 중지버튼
        
    
        
        // 버튼을 컨트롤러에 등록
        alert.addAction(cancle)
        alert.addAction(ok)
        alert.addAction(exe)
        alert.addAction(stop)
        
        // 메시지 창 실행
        self.present(alert, animated: false)
        
        
    }
    
    


}

