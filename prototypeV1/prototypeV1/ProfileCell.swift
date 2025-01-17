//
//  ProfileCell.swift
//  MyProfile
//
//  Created by Tanishq Malik on 12/12/24.
//
import UIKit

class ProfileCell: UICollectionViewCell {
    
    var profileImageView: UIImageView!
    var gamesLabel: UILabel!
    var friendsLabel: UILabel!
    var streaksLabel: UILabel!
    var lastPlayedLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Profile Image
        profileImageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 80, height: 80))
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .gray
        addSubview(profileImageView)
        
        // Labels
        gamesLabel = UILabel(frame: CGRect(x: 120, y: 20, width: 100, height: 30))
        friendsLabel = UILabel(frame: CGRect(x: 120, y: 60, width: 100, height: 30))
        streaksLabel = UILabel(frame: CGRect(x: 120, y: 100, width: 100, height: 30))
        
        addSubview(gamesLabel)
        addSubview(friendsLabel)
        addSubview(streaksLabel)
        
        // Last Played Label
        lastPlayedLabel = UILabel(frame: CGRect(x: 20, y: 120, width: 200, height: 20))
        lastPlayedLabel.font = UIFont.systemFont(ofSize: 12)
        lastPlayedLabel.textColor = .gray
        addSubview(lastPlayedLabel)
    }
    
    func configureProfileCell(gamesCount: Int, friendsCount: Int, streaksCount: Int, lastPlayed: String) {
        // Set labels with data
        profileImageView.image = UIImage(named: "profilePic")  // Replace with actual profile image
        
        gamesLabel.text = "\(gamesCount)\nGames"
        friendsLabel.text = "\(friendsCount)\nFriends"
        streaksLabel.text = "\(streaksCount)\nStreaks"
        
        // Red text for count
        gamesLabel.textColor = .red
        friendsLabel.textColor = .red
        streaksLabel.textColor = .red
        
        lastPlayedLabel.text = "Last played: \(lastPlayed)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


