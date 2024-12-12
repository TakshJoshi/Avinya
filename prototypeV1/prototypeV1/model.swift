import Foundation

// MARK: - Models

struct User {
    var id: String
    var name: String
    var age: Int
    var location: String
    var schoolOrCollegeName: String
    var interests: [String]
    var level: String
    var email: String
    var password: String
    var skills: [String]
    var imageURL: String?
    var isOnline: Bool
    var lastSeen: Date?
}

struct Message {
    var id: String
    var sender: User
    var content: String
    var timestamp: Date
}

struct Community {
    var id: String
    var name: String
    var description: String
    var imageURL: String?
    var members: [User]
    var messages: [Message]
    var unreadMessagesCount: Int
    var createdAt: Date
    var lastMessageAt: Date?
}

struct Game {
    var id: String
    var title: String
    var createdAt: Date
    var sportName: String
    var areaOrArena: String
    var gameStartDate: Date
    var gameStartTime: Date
    var activityAccess: ActivityAccess
    var skillLevel: Int
    var bringYourOwnEquipment: Bool
    var members: [User]
    var gameDuration: Int
    var maxPlayers: Int
    var joinRequests: [User]
    var status: GameStatus
}

enum GameStatus {
    case upcoming
    case ongoing
    case completed
}

enum ActivityAccess {
    case publicAccess
    case inviteOnly
}

// MARK: - Dummy Data Manager

class DummyDataManager {
    static let shared = DummyDataManager()

    // Dummy Users
    private var users: [User] = [
        User(
            id: "1",
            name: "Alice Smith",
            age: 25,
            location: "New York",
            schoolOrCollegeName: "NYU",
            interests: ["Basketball", "Music"],
            level: "Intermediate",
            email: "alice@example.com",
            password: "password123",
            skills: ["Shooting", "Dribbling"],
            imageURL: nil,
            isOnline: true,
            lastSeen: nil
        ),
        User(
            id: "2",
            name: "Bob Johnson",
            age: 30,
            location: "Los Angeles",
            schoolOrCollegeName: "UCLA",
            interests: ["Soccer", "Gaming"],
            level: "Advanced",
            email: "bob@example.com",
            password: "password456",
            skills: ["Strategy", "Teamwork"],
            imageURL: nil,
            isOnline: false,
            lastSeen: Date()
        )
    ]

    // Dummy Communities
    private var communities: [Community] = [
        Community(
            id: "1",
            name: "Sports Enthusiasts",
            description: "A group for all sports lovers.",
            imageURL: nil,
            members: [],
            messages: [],
            unreadMessagesCount: 0,
            createdAt: Date(),
            lastMessageAt: nil
        )
    ]

    // Dummy Games
    private var games: [Game] = [
        Game(
            id: "1",
            title: "Friendly Soccer Match",
            createdAt: Date(),
            sportName: "Soccer",
            areaOrArena: "Central Park",
            gameStartDate: Date(),
            gameStartTime: Date(),
            activityAccess: .publicAccess,
            skillLevel: 5,
            bringYourOwnEquipment: true,
            members: [],
            gameDuration: 90,
            maxPlayers: 22,
            joinRequests: [],
            status: .upcoming
        )
    ]

    // MARK: - User Methods

    func getUsers() -> [User] {
        return users
    }

    func loginUser(email: String, password: String) -> User? {
        return users.first { $0.email == email && $0.password == password }
    }

    // MARK: - Community Methods

    func getCommunities() -> [Community] {
        return communities
    }

    // MARK: - Game Methods

    func getGames() -> [Game] {
        return games
    }
}
