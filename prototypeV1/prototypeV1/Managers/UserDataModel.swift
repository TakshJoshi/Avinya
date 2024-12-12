//
//  UserDataModel.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//

import Foundation

// MARK: - Sample User Data
/// Sample user instance for testing and initial setup
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

// MARK: - UserDataModel Class
/// Manages user authentication, sports interests, and user data storage
/// Uses singleton pattern to ensure single source of truth for user data
class UserDataModel {
    // MARK: Properties
    
    /// Array to store all registered users in the application
    private var users: [UserData] = [firstUser]
    
    /// Reference to currently logged in user, nil if no user is logged in
    private var currentUser: UserData?
    
    /// Shared instance for singleton pattern implementation
    static var shared: UserDataModel = UserDataModel()
    
    /// Private initializer to enforce singleton pattern
    private init() {}
    
    // MARK: Authentication Methods
    
    /// Creates a new user account
    /// - Parameters:
    ///   - name: User's full name
    ///   - email: User's email address (must be unique)
    ///   - password: User's password
    ///   - dateOfBirth: User's date of birth as string
    ///   - university: User's university name
    /// - Returns: Boolean indicating success (true) or failure (false) of signup
    func signup(name: String, email: String, password: String, dateOfBirth: String,
                university: String) -> Bool {
        // Check for existing email to prevent duplicates
        if users.contains(where: { $0.email == email }) {
            return false
        }
        
        // Create and initialize new user
        let newUser = UserData(
            id: users.count + 1,  // Generate new ID based on array count
            name: name,
            email: email,
            password: password,
            dateOfBirth: dateOfBirth,
            university: university,
            sports: [],  // Initialize with empty sports array
            profileImage: "profile_default.jpeg"
        )
        
        users.append(newUser)
        currentUser = newUser  // Automatically login after successful signup
        return true
    }
    
    /// Authenticates user credentials and logs them in
    /// - Parameters:
    ///   - email: User's email address
    ///   - password: User's password
    /// - Returns: Boolean indicating successful (true) or failed (false) login
    func login(email: String, password: String) -> Bool {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            currentUser = user
            return true
        }
        return false
    }
    
    // MARK: User Data Methods
    
    /// Retrieves currently logged in user
    /// - Returns: Optional UserData of current user, nil if no user is logged in
    func getCurrentUser() -> UserData? {
        return currentUser
    }
    
    /// Adds new sport interest or updates existing one for current user
    /// - Parameters:
    ///   - selectedSport: Sport to add/update
    ///   - skillLevel: User's skill level in the sport
    /// - Returns: Boolean indicating success (true) or failure (false) of update
    func updateSportsInterests(selectedSport: Sport, skillLevel: SkillLevel) -> Bool {
        guard var currentUser = currentUser else {
            return false  // No logged in user
        }
        
        // Update existing sport or add new one
        if let index = currentUser.sports.firstIndex(where: { $0.sport == selectedSport }) {
            // Update skill level of existing sport
            currentUser.sports[index].skillLevel = skillLevel
        } else {
            // Add new sport interest
            let newSportInterest = SportInterest(
                sport: selectedSport,
                skillLevel: skillLevel
            )
            currentUser.sports.append(newSportInterest)
        }
        
        // Update user data in users array
        if let userIndex = users.firstIndex(where: { $0.id == currentUser.id }) {
            users[userIndex] = currentUser
            self.currentUser = currentUser
            return true
        }
        
        return false
    }
    
    /// Removes a sport interest from current user's profile
    /// - Parameter sport: Sport to be removed
    /// - Returns: Boolean indicating success (true) or failure (false) of removal
    func removeSportInterest(sport: Sport) -> Bool {
        guard var currentUser = currentUser else {
            return false  // No logged in user
        }
        
        currentUser.sports.removeAll { $0.sport == sport }
        
        // Update user data in users array
        if let index = users.firstIndex(where: { $0.id == currentUser.id }) {
            users[index] = currentUser
            self.currentUser = currentUser
            return true
        }
        
        return false
    }
    
    /// Retrieves all sports interests for current user
    /// - Returns: Optional array of SportInterest, nil if no user is logged in
    func getCurrentUserSports() -> [SportInterest]? {
        return currentUser?.sports
    }
}

// MARK: - Usage Examples
/*
// Signup Example
let signupSuccess = UserDataModel.shared.signup(
    name: "John Doe",
    email: "john@gmail.com",
    password: "John@1234",
    dateOfBirth: "Jan 15, 2003",
    university: "Chitkara University"
)

// Login Example
let loginSuccess = UserDataModel.shared.login(
    email: "john@gmail.com",
    password: "John@1234"
)

// Update Sports Interests Example
if loginSuccess {
    _ = UserDataModel.shared.updateSportsInterests(
        selectedSport: .football,
        skillLevel: .beginner
    )
    
    _ = UserDataModel.shared.updateSportsInterests(
        selectedSport: .cricket,
        skillLevel: .intermediate
    )
}

// Get Current User Sports Example
if let sports = UserDataModel.shared.getCurrentUserSports() {
    for sport in sports {
        print("Sport: \(sport.sport.rawValue), Level: \(sport.skillLevel.rawValue)")
    }
}
*/
