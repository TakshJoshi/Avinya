//
//  MyGamesCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 13/12/24.
//

import UIKit

class MyGamesCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
       private let locationLabel = UILabel()
       private let dateLabel = UILabel()
       private let levelLabel = UILabel()
       private let viewButton = UIButton()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupViews()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    
    private func setupViews() {
            contentView.backgroundColor = .systemGray6
            contentView.layer.cornerRadius = 12
            
            // Add subviews
            [titleLabel, locationLabel, dateLabel, levelLabel, viewButton].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview($0)
            }
            
            // Configure views
            titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
            locationLabel.font = .systemFont(ofSize: 14)
            dateLabel.font = .systemFont(ofSize: 14)
            levelLabel.font = .systemFont(ofSize: 12)
            
            viewButton.setTitle("View", for: .normal)
            viewButton.backgroundColor = .systemBlue
            viewButton.layer.cornerRadius = 8
            
        NSLayoutConstraint.activate([
                   titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                   titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                   
                   locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                   locationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                   
                   dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
                   dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                   
                   levelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                   levelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                   
                   viewButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
                   viewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                   viewButton.widthAnchor.constraint(equalToConstant: 80),
                   viewButton.heightAnchor.constraint(equalToConstant: 32)
               ])
           }
           
           func configure(title: String, location: String, date: String) {
               titleLabel.text = title
               locationLabel.text = location
               dateLabel.text = date
               levelLabel.text = "Beginner"
           }
    
}
