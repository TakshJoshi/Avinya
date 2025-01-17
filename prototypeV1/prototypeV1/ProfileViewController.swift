

import UIKit

class ProfileViewController: UIViewController {

    // First Section
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var gamesCountLabel: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    @IBOutlet weak var streaksCountLabel: UILabel!
    @IBOutlet weak var lastPlayedLabel: UILabel!

    // Second Section
    @IBOutlet weak var bar1View: UIView!
    @IBOutlet weak var bar1Label: UILabel!
    @IBOutlet weak var month1Label: UILabel!
    @IBOutlet weak var bar2View: UIView!
    @IBOutlet weak var bar2Label: UILabel!
    @IBOutlet weak var month2Label: UILabel!
    @IBOutlet weak var bar3View: UIView!
    @IBOutlet weak var bar3Label: UILabel!
    @IBOutlet weak var month3Label: UILabel!
    @IBOutlet weak var mysportslabel: UILabel!
    
    // Third Section
    @IBOutlet weak var leaderboardTitleLabel: UILabel!
    @IBOutlet weak var circularGraphView: UIView!
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    @IBOutlet weak var gameListLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white  // Ensure the background is not transparent
        print("ProfileViewController Loaded")
        NotificationCenter.default.addObserver(self, selector: #selector(profileUpdated(_:)), name: NSNotification.Name("ProfileUpdated"), object: nil)
        setupUI()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editProfile))
    }
    
    @objc private func editProfile() {
        performSegue(withIdentifier: "editProfileSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editProfileSegue", let editVC = segue.destination as? EditProfileViewController {
            // Pass current profile data to EditProfileViewController
            editVC.currentName = nameLabel.text
            editVC.currentUniversity = universityLabel.text
            editVC.currentProfileImage = profileImageView.image
        }
    }
    
    @objc private func profileUpdated(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any] {
            nameLabel.text = userInfo["name"] as? String
            universityLabel.text = userInfo["university"] as? String
            if let profileImage = userInfo["profileImage"] as? UIImage {
                profileImageView.image = profileImage
            }
        }
    }
    
    private func setupUI() {
        // Set background color to black
        view.backgroundColor = .black

        // Profile Picture Styling
        guard let profileImageView = profileImageView else {
            print("profileImageView is nil!")
            return
        }
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(named: "1") // Replace "profile_picture" with the name of your image in assets

        // Populate Profile Details with white text
        nameLabel?.text = "Alex Garrison"
        nameLabel?.numberOfLines = 0
        nameLabel?.lineBreakMode = .byWordWrapping
        nameLabel?.adjustsFontSizeToFitWidth = true
        nameLabel?.minimumScaleFactor = 0.5
        nameLabel?.textColor = .white // Set text color to white

        universityLabel?.text = "Chitkara University"
        universityLabel?.numberOfLines = 1
        universityLabel?.lineBreakMode = .byWordWrapping
        universityLabel?.textColor = .white // Set text color to white

        gamesCountLabel?.text = "4\nGames"
        gamesCountLabel?.textColor = .white // Set text color to white

        friendsCountLabel?.text = "20\nFriends"
        friendsCountLabel?.textColor = .white // Set text color to white

        streaksCountLabel?.text = "10\nStreaks"
        streaksCountLabel?.textColor = .white // Set text color to white

        lastPlayedLabel?.text = "Last played: 27th November"
        lastPlayedLabel?.textColor = .white // Set text color to white

        // Bar Graph for My Sports
        setupBarGraph(barView: bar1View, barLabel: bar1Label, barValue: 3, monthLabel: month1Label, monthText: "Sep")
        setupBarGraph(barView: bar2View, barLabel: bar2Label, barValue: 5, monthLabel: month2Label, monthText: "Oct")
        setupBarGraph(barView: bar3View, barLabel: bar3Label, barValue: 2, monthLabel: month3Label, monthText: "Nov")

        // Leaderboard
        leaderboardTitleLabel?.text = "Leaderboard"
        leaderboardTitleLabel?.textColor = .white // Set text color to white

        circularGraphView?.layer.cornerRadius = circularGraphView?.frame.width ?? 0 / 2
        circularGraphView?.layer.borderWidth = 5
        circularGraphView?.layer.borderColor = UIColor.white.cgColor // Set border color to white

        gamesPlayedLabel?.text = "Games Played: 10"
        gamesPlayedLabel?.textColor = .white // Set text color to white

        gameListLabel?.text = "Basketball\nFootball"
        gameListLabel?.textColor = .white // Set text color to white
    }

    private func setupBarGraph(barView: UIView?, barLabel: UILabel?, barValue: Int, monthLabel: UILabel?, monthText: String) {
        guard let barView = barView, let barLabel = barLabel, let monthLabel = monthLabel else {
            print("Bar graph elements are nil!")
            return
        }
        barLabel.text = "\(barValue)"
        barLabel.textColor = .white // Set text color to white
        monthLabel.text = monthText
        monthLabel.textColor = .white // Set text color to white
        barView.backgroundColor = .blue
        barView.frame.size.height = CGFloat(barValue * 20) // Scale bar height
    }
    
}
