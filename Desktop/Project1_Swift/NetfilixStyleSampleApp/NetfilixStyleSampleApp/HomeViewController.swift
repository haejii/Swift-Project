//
//  HomeViewController.swift
//  NetfilixStyleSampleApp
//
//  Created by 양혜지 on 2022/02/20.
//

import UIKit

class HomeViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션 설정
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.hidesBarsOnSwipe = true
        
        // 네비게이션 버튼
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "netfiix_icon"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "person.crop.circle"), style: .plain, target: nil, action: nil)
        
   
    }
}
