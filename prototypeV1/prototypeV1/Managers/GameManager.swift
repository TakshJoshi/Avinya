//
//  GameManager.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//
import Foundation

class GameManager {
    private var games: [Game] = []
    static let shared = GameManager()
    
    private init() {}
    
    func createGame(title: String,
                   sport: Sport,
                   startTime: Date,
                   organizer: UserData,
                   skillLevel: SkillLevel,
                   accessType: GameAccessType,
                   maxParticipants: Int) -> Game? {
        
        let endTime = startTime.addingTimeInterval(TimeInterval(sport.defaultDuration * 60))
        
        let availableCourts = ResourceManager.shared.getAvailableCourts(
            sport: sport,
            startTime: startTime,
            endTime: endTime
        )
        
        guard let court = availableCourts.first else {
            return nil
        }
        
        let gameId = games.count + 1
        
        guard ResourceManager.shared.reserveCourt(
            courtId: court.id,
            startTime: startTime,
            endTime: endTime,
            gameId: gameId
        ) else {
            return nil
        }
        
        let newGame = Game(
            id: gameId,
            title: title,
            sport: sport,
            startTime: startTime,
            endTime: endTime,
            court: court,
            skillLevel: skillLevel,
            accessType: accessType,
            maxParticipants: maxParticipants,
            organizer: organizer,
            participants: [organizer],
            rules: ["Respect", "Be good", "Stay safe"],
            createdAt: Date()
        )
        
        games.append(newGame)
        return newGame
    }
    
    func getAvailableTimeSlots(sport: Sport, date: Date) -> [Date] {
        let calendar = Calendar.current
        var availableSlots: [Date] = []
        
        guard let dayStart = calendar.date(
            bySettingHour: 6, minute: 0, second: 0, of: date),
              let dayEnd = calendar.date(
                bySettingHour: 22, minute: 0, second: 0, of: date) else {
            return []
        }
        
        var currentTime = dayStart
        while currentTime < dayEnd {
            let slotEndTime = currentTime.addingTimeInterval(
                TimeInterval(sport.defaultDuration * 60)
            )
            
            let availableCourts = ResourceManager.shared.getAvailableCourts(
                sport: sport,
                startTime: currentTime,
                endTime: slotEndTime
            )
            
            if !availableCourts.isEmpty {
                availableSlots.append(currentTime)
            }
            
            currentTime = calendar.date(byAdding: .minute, value: 30, to: currentTime) ?? dayEnd
        }
        
        return availableSlots
    }
    
    func getGamesForDate(_ date: Date) -> [Game] {
        let calendar = Calendar.current
        return games.filter { game in
            calendar.isDate(game.startTime, inSameDayAs: date)
        }
    }
}
