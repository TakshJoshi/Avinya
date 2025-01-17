


import UIKit

class AccountModalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
            super.viewDidLoad()
            setupNavigationBar()
            setupTableView()
            view.backgroundColor = .black // Set the entire view's background to black
        }
        
        private func setupNavigationBar() {
            navigationItem.title = "Account"
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white] // White title text
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(BackTapped))
        }
        
        private func setupTableView() {
            tableView.backgroundColor = .black // Set table view background to black
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorColor = .darkGray // Optional: Dark gray separators
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCellMain")
        }
        
        @objc private func BackTapped() {
            if let navigationController = navigationController {
                for viewController in navigationController.viewControllers {
                    if viewController.restorationIdentifier == "main" {
                        navigationController.popToViewController(viewController, animated: true)
                        return
                    }
                }
            }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let myHubViewController = storyboard.instantiateViewController(withIdentifier: "main") as? UIViewController {
                navigationController?.setViewControllers([myHubViewController], animated: true)
            }
        }
        
        func numberOfSections(in tableView: UITableView) -> Int { return 5 }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section {
            case 0: return 1
            case 1: return 4
            case 2: return 2
            case 3, 4: return 1
            default: return 0
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCellMain", for: indexPath)
            
            cell.backgroundColor = .black // Set cell background to black
            cell.textLabel?.textColor = .white // Set cell text color to white
            
            switch indexPath.section {
            case 0:
                configureProfileCell(cell)
            case 1:
                let titles = ["Favorites", "Health Summary", "Notifications", "Games Played"]
                cell.textLabel?.text = titles[indexPath.row]
                cell.accessoryType = .disclosureIndicator
            case 2:
                let titles = ["Help", "Invite a Friend"]
                cell.textLabel?.text = titles[indexPath.row]
                cell.accessoryType = .disclosureIndicator
            case 3:
                cell.textLabel?.text = "Delete Account"
                cell.textLabel?.textColor = .systemRed // Red text for "Delete Account"
                cell.textLabel?.textAlignment = .center
            case 4:
                cell.textLabel?.text = "Log Out"
                cell.textLabel?.textColor = .systemRed // Red text for "Log Out"
                cell.textLabel?.textAlignment = .center
            default: break
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return indexPath.section == 0 ? 100 : 44
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            switch (indexPath.section, indexPath.row) {
            case (0, 0):
                performSegue(withIdentifier: "ShowProfile", sender: nil)
            case (1, 1):
                performSegue(withIdentifier: "ShowHealthSummary", sender: nil)
            case (1, 3):
                performSegue(withIdentifier: "ShowGamesPlayed", sender: nil)
            default:
                break
            }
        }
        
        private func configureProfileCell(_ cell: UITableViewCell) {
            let profileImageView = UIImageView()
            profileImageView.image = UIImage(named: "1")
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 40
            profileImageView.clipsToBounds = true
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
            let nameLabel = UILabel()
            nameLabel.text = "Alex Garrison"
            nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            nameLabel.textColor = .white // Set name text color to white
            
            let detailsLabel = UILabel()
            detailsLabel.text = "Cricket, Soccer"
            detailsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            detailsLabel.textColor = .lightGray // Set details text color to light gray
            
            let textStackView = UIStackView(arrangedSubviews: [nameLabel, detailsLabel])
            textStackView.axis = .vertical
            textStackView.spacing = 4
            textStackView.alignment = .leading
            
            let horizontalStackView = UIStackView(arrangedSubviews: [profileImageView, textStackView])
            horizontalStackView.axis = .horizontal
            horizontalStackView.spacing = 16
            horizontalStackView.alignment = .center
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            cell.contentView.addSubview(horizontalStackView)
            
            NSLayoutConstraint.activate([
                horizontalStackView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
                horizontalStackView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                horizontalStackView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 8),
                horizontalStackView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -8)
            ])
            
            cell.accessoryType = .disclosureIndicator
        }
    }
