//
//  MainViewController.swift
//  custom half-modal
//
//  Created by 양혜지 on 2022/03/15.
//

import UIKit
import SnapKit
import RxSwift

class MainViewController : UIViewController {
    
    let button : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //UINavigationController 설정
        view.backgroundColor = .white
        title = "custom half Modal"
        navigationController?.navigationBar.prefersLargeTitles = true
        self.setUILayouts()
    }
}


extension MainViewController {
    fileprivate func setUILayouts() {
        
        self.view.addSubview(self.button)
        self.button.snp.makeConstraints{ make in
            make.centerX.centerY.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    @objc internal func onClick(_ sender: Any){
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        self.present(bottomSheetVC, animated: false, completion: nil)
        print("oncloick")
    }
}
