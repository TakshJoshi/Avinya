//
//  SportsCell.swift
//  MyProfile
//
//  Created by Tanishq Malik on 12/12/24.
//

import UIKit

class SportsCell: UICollectionViewCell {
    
    var gameNameLabel: UILabel!
    var barGraphView: UIStackView!
    var streaksLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Game Name Label
        gameNameLabel = UILabel()
        gameNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        gameNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gameNameLabel)
        
        // Bar Graph
        barGraphView = UIStackView()
        barGraphView.axis = .horizontal
        barGraphView.spacing = 10
        barGraphView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(barGraphView)
        
        // Streaks Label
        streaksLabel = UILabel()
        streaksLabel.font = UIFont.systemFont(ofSize: 16)
        streaksLabel.textColor = .red
        streaksLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(streaksLabel)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            gameNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            gameNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            barGraphView.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 20),
            barGraphView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            barGraphView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            barGraphView.heightAnchor.constraint(equalToConstant: 50),
            
            streaksLabel.topAnchor.constraint(equalTo: barGraphView.bottomAnchor, constant: 10),
            streaksLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func configureSportsCell(gameName: String, months: [String], streaks: [Int]) {
        gameNameLabel.text = gameName
        
        // Create bar graph for months
        for (index, month) in months.enumerated() {
            let monthLabel = UILabel()
            monthLabel.text = month
            monthLabel.font = UIFont.systemFont(ofSize: 12)
            monthLabel.textAlignment = .center
            barGraphView.addArrangedSubview(monthLabel)
            
            let streakBar = UIView()
            streakBar.backgroundColor = .blue
            streakBar.frame = CGRect(x: 0, y: 0, width: 20, height: CGFloat(streaks[index] * 5))  // Modify for actual scale
            barGraphView.addArrangedSubview(streakBar)
        }
        
        streaksLabel.text = "Total Streaks: \(streaks.reduce(0, +))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

