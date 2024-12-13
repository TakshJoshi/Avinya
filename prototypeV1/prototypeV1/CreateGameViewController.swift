//
//  CreateGameViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

protocol CreateGameDelegate: AnyObject {
    func gameCreated(sport: String, area: String, date: String, time: String)
}

class CreateGameViewController: UIViewController {

    
    @IBOutlet weak var sportButton: UIButton!
       @IBOutlet weak var areaButton: UIButton!
       @IBOutlet weak var dateButton: UIButton!
       @IBOutlet weak var timeButton: UIButton!
       @IBOutlet weak var activityAccessSegmentControl: UISegmentedControl!
       @IBOutlet weak var advancedSettingsButton: UIButton!
       @IBOutlet weak var createGameButton: UIButton!
        
    
    weak var delegate: CreateGameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    private func setupUI() {
            title = "Create Game"
            createGameButton.backgroundColor = .systemGreen
            createGameButton.layer.cornerRadius = 12
            
            // Setup navigation items
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        }
        
        // MARK: - Actions
        @IBAction func sportButtonTapped(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let sportVC = storyboard.instantiateViewController(withIdentifier: "SportViewController") as? SportViewController {
                navigationController?.pushViewController(sportVC, animated: true)
            }
        }
    
    
    @IBAction func areaButtonTapped(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let areaVC = storyboard.instantiateViewController(withIdentifier: "AreaViewController") as? AreaViewController {
                navigationController?.pushViewController(areaVC, animated: true)
            }
        }
        
        @IBAction func createGameButtonTapped(_ sender: UIButton) {
            // Handle create game
            
            let sport = sportButton.title(for: .normal) ?? ""
                let area = areaButton.title(for: .normal) ?? ""
                let date = dateButton.title(for: .normal) ?? ""
                let time = timeButton.title(for: .normal) ?? ""
                
                delegate?.gameCreated(sport: sport, area: area, date: date, time: time)
                dismiss(animated: true)
        }
        
        @objc private func cancelTapped() {
            dismiss(animated: true)
        }
        
        @objc private func doneTapped() {
            // Handle done
        }
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let dateVC = storyboard.instantiateViewController(withIdentifier: "DateViewController") as? DateViewController {
//            dateVC.delegate = self
//            navigationController?.pushViewController(dateVC, animated: true)
//        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTimeViewController":
            if let timeVC = segue.destination as? TimeViewController {
                timeVC.delegate = self
            }
            
        case "showDateViewController":
            if let dateVC = segue.destination as? DateViewController {
                dateVC.delegate = self
            }
            
        default:
            break
        }
    }
    
}


extension CreateGameViewController: DateViewControllerDelegate {
    func updateDate(_ date: String) {
        dateButton.setTitle(date, for: .normal)
        dateButton.setTitleColor(.systemRed, for: .normal)
    }
}


extension CreateGameViewController: TimeViewControllerDelegate {
    func updateTime(_ timeSlot: String) {
        timeButton.setTitle(timeSlot, for: .normal)
        timeButton.setTitleColor(.systemRed, for: .normal)
    }
}

