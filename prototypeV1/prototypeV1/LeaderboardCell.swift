//
//  LeaderboardCell.swift
//  MyProfile
//
//  Created by Tanishq Malik on 12/12/24.
//

import UIKit

class LeaderboardCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var circularGraphView: UIView!
    var gameListLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Title Label
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // Circular Graph
        circularGraphView = UIView()
        circularGraphView.layer.cornerRadius = 50
        circularGraphView.layer.borderWidth = 10
        circularGraphView.layer.borderColor = UIColor.red.cgColor
        circularGraphView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circularGraphView)
        
        // Game List Label
        gameListLabel = UILabel()
        gameListLabel.numberOfLines = 0
        gameListLabel.font = UIFont.systemFont(ofSize: 14)
        gameListLabel.textAlignment = .center
        gameListLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameListLabel)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            circularGraphView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            circularGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circularGraphView.widthAnchor.constraint(equalToConstant: 100),
            circularGraphView.heightAnchor.constraint(equalToConstant: 100),
            
            gameListLabel.topAnchor.constraint(equalTo: circularGraphView.bottomAnchor, constant: 20),
            gameListLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameListLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            gameListLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func configureLeaderboardCell(title: String, gamesPlayed: Int, games: [String]) {
        titleLabel.text = title
        
        // For circular graph (simple border indicating stats, can be replaced with real graph implementation)
        circularGraphView.layer.borderColor = UIColor.red.cgColor  // Modify with actual circular graph data
        
        var gameText = ""
        for game in games {
            gameText += game + "\n"
        }
        gameListLabel.text = gameText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

