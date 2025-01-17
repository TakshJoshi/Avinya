//
//  MyHubCollectionViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 14/01/25.
//

//
//  MyHubCollectionViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 14/01/25.
//

import UIKit

private let headerReuseIdentifier = "Header"
private let myGamesCellId = "MyGamesCell"
private let interestCellId = "InterestCell"
private let gamesCellId = "GamesCell"

struct GameData {
    let personName: String
    let personImage: String
    let going: String
    let mutual: String
    let gameType: String
    let gameIcon: String
    let date: String
    let location: String
}

class MyHubCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView.backgroundColor = .black  // Set background color to black
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
    }
    
    private func setupUI() {
        navigationItem.title = "My Hub"
        
        let profileButton = UIButton(type: .system)
        profileButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
        profileButton.tintColor = .white
        
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }

    @objc func profileTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "AccountModalViewController")
        
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0: // My Games section
                return self.createMyGamesSection()
            case 1: // Interest section
                return self.createInterestSection()
            case 2: // Games section
                return self.createGamesSection()
            default:
                return nil
            }
        }
    }
    
    private let gamesData = [
        GameData(
            personName: "Aseem Bhardwaj",
            personImage: "person1",
            going: "5 Going",
            mutual: "2 Mutual",
            gameType: "Boxing",
            gameIcon: "figure.boxing",
            date: "26 Dec, Night",
            location: "Court 1, Chitkara university"
        ),
        GameData(
            personName: "Aseem Bhardwaj",
            personImage: "person1",
            going: "5 Going",
            mutual: "2 Mutual",
            gameType: "Badminton",
            gameIcon: "figure.badminton",
            date: "26 Dec, Night",
            location: "Court 1, Chitkara university"
        ),
    ]
    
    private func createMyGamesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                            heightDimension: .fractionalHeight(0.8))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                             heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createInterestSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                            heightDimension: .fractionalHeight(0.7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: -30, trailing: 15)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createGamesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(380),
                                            heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // MARK: - Collection View Data Source & Delegate
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 3  // My Games
        case 1: return 4  // Interest
        case 2: return gamesData.count  // Games
        default: return 0
        }
    }
    
    private let myGames = [
        ("Wednesday Evening Game", "Beginner", "Court 1, Chitkara university", "12 Nov, Evening"),
        ("Friday Morning Game", "Intermediate", "Court 2, Chitkara university", "15 Nov, Morning"),
        ("Sunday Practice", "Advanced", "Court 3, Chitkara university", "17 Nov, Evening")
    ]
    
    private let interests = [
        ("Badminton", "badminton"),
        ("Basketball", "basketball"),
        ("Cricket", "cricket"),
        ("Football", "football")
    ]
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myGamesCellId, for: indexPath) as! MyGamesCollectionViewCell
            let game = myGames[indexPath.item]
            cell.dayLabel.text = game.0
            cell.dayLabel.textColor = .white
            cell.levelLabel.text = game.1
            cell.levelLabel.textColor = .white
            cell.locationLabel.text = game.2
            cell.locationLabel.textColor = .white
            cell.dateLabel.text = game.3
            cell.dateLabel.textColor = .white
            cell.backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0)
            cell.layer.cornerRadius = 12
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestCellId, for: indexPath) as! InterestCollectionViewCell
            let interest = interests[indexPath.item]
            cell.categoryLabel.text = interest.0
            cell.categoryLabel.textColor = .white
            cell.image.image = UIImage(named: interest.1)
            cell.layer.cornerRadius = 12
            cell.backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0)
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gamesCellId, for: indexPath) as! GamesCollectionViewCell
            cell.configure(with: gamesData[indexPath.item])
            cell.backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0)
            cell.layer.cornerRadius = 12
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        
        header.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: header.frame.width - 15, height: header.frame.height))
        switch indexPath.section {
        case 0:
            label.text = "My Games >"
//            label.text = "Games you have Created"
        case 1:
            label.text = "Interest"
        case 2:
            label.text = "Games"
        default:
            break
        }
        
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        header.addSubview(label)
        
        return header
    }
}
