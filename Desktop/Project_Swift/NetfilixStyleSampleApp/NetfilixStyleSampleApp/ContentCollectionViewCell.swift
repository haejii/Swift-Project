//
//  ContentCollectionViewCell.swift
//  NetfilixStyleSampleApp
//
//  Created by 양혜지 on 2022/02/22.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 갑자기 컨텐트 뷰가 어디서나온거지,,, 기본 셀의 contentView(superView)객체가 기본적으로 있다.
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
