//
//  UserDataModel.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//
import Foundation
let firstUser = UserData(
    id: 1,
    name: "Alex Garrison",
    email: "alex.garrison@gmail.com",
    password: "Alex@2345",
    dateOfBirth: "Sep 22, 2002",
    university: "Chitkara University",
    sports: [
        SportInterest(sport: .cricket, skillLevel: .beginner),
        SportInterest(sport: .football, skillLevel: .beginner)
    ],
    profileImage: "profile_default.jpeg"
)


class UserDataModel{
//    users array which stores the different users that will signup
    private var users : [UserData] = [firstUser]
//    Current user optional to point to and reference to the current user logged in
    private var currentUser : UserData?

//    Statically instantiated shared UserDataModel instance so that there is only one instance of the UserDataModel which wont be tampered by anyone else or anywhere else in the code
    static var shared : UserDataModel = UserDataModel()
    
    private init(){
//        private constructor function so that we maintain singleton instance that can't be accessed by everyone
    }
    
//    Signup Function
//    Takes given parameters and checks if there is a user registered with an already existing email , else creates a new instance of UserData updates the count and appends it in the array
    func signup(name: String, email: String, password: String, dateOfBirth: String,
                    university: String) -> Bool {
            // Check if email already exists
            if users.contains(where: { $0.email == email }) {
                return false
            }
            
            // Create new user
            let newUser = UserData(
                id: users.count + 1,  // Simple ID generation
                name: name,
                email: email,
                password: password,
                dateOfBirth: dateOfBirth,
                university: university,
                sports: [],  // Empty sports array initially
                profileImage: "profile_default.jpeg"
            )
            
            users.append(newUser)
            currentUser = newUser  // Auto login after signup
            return true
        }
    
//    Login Function
    func login(email: String, password: String) -> Bool {
           if let user = users.first(where: { $0.email == email && $0.password == password }) {
               currentUser = user
               return true
           }
           return false
       }
    
// Get current user
        func getCurrentUser() -> UserData? {
            return currentUser
        }
    
// Add or update sport interest
        func updateSportsInterests(selectedSport: Sport, skillLevel: SkillLevel) -> Bool {
            guard var currentUser = currentUser else {
                return false
            }
            
            // Check if sport already exists for user
            if let index = currentUser.sports.firstIndex(where: { $0.sport == selectedSport }) {
                // Update existing sport's skill level
                currentUser.sports[index].skillLevel = skillLevel
            } else {
                // Add new sport
                let newSportInterest = SportInterest(
                    sport: selectedSport,
                    skillLevel: skillLevel
                )
                currentUser.sports.append(newSportInterest)
            }
            
            // Update user in the users array
            if let userIndex = users.firstIndex(where: { $0.id == currentUser.id }) {
                users[userIndex] = currentUser
                self.currentUser = currentUser
                return true
            }
            
            return false
        }
        
// Remove sport interest
        func removeSportInterest(sport: Sport) -> Bool {
            guard var currentUser = currentUser else {
                return false
            }
            
            currentUser.sports.removeAll { $0.sport == sport }
            
            if let index = users.firstIndex(where: { $0.id == currentUser.id }) {
                users[index] = currentUser
                self.currentUser = currentUser
                return true
            }
            
            return false
        }
        
// Get all sports for current user
        func getCurrentUserSports() -> [SportInterest]? {
            return currentUser?.sports
        }
    }


//Example functions to run on playground to check the following
    
//let signupSuccess = UserDataModel.shared.signup(
//    name: "John Doe",
//    email: "john@gmail.com",
//    password: "John@1234",
//    dateOfBirth: "Jan 15, 2003",
//    university: "Chitkara University"
//)
//
//// Login
//let loginSuccess = UserDataModel.shared.login(
//    email: "john@gmail.com",
//    password: "John@1234"
//)
//
//if loginSuccess {
//    _ = UserDataModel.shared.updateSportsInterests(
//        selectedSport: .football,
//        skillLevel: .beginner
//    )
//
//    _ = UserDataModel.shared.updateSportsInterests(
//        selectedSport: .cricket,
//        skillLevel: .intermediate
//    )
//}
//
//
//if let sports = UserDataModel.shared.getCurrentUserSports() {
//    for sport in sports {
//        print("Sport: \(sport.sport.rawValue), Level: \(sport.skillLevel.rawValue)")
//    }
//}
