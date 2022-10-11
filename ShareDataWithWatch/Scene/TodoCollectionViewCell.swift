//
//  TodoCollectionViewCell.swift
//  ShareDataWithWatch
//
//  Created by iMac on 2022/10/11.
//

import Foundation
import SnapKit
import UIKit

final class TodoCollectionViewCell: UICollectionViewCell {
    static let identifier = "TodoCollectionViewCell"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14.0)
        label.textAlignment = .center
        
        return label
    }()
    
    func setupCell(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
        setupViews()
    }
}

private extension TodoCollectionViewCell {
    func setupViews() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 4.0
        [
            titleLabel,
            contentLabel
        ]
            .forEach {
                contentView.addSubview($0)
            }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(100.0)
        }
        
        contentLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
        
    }
}
