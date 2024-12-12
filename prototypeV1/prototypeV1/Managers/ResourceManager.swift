//
//  ResourceManager.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//

import Foundation

class ResourceManager {
    static let shared = ResourceManager()
    private var courts: [Court]
    private var timeSlots: [TimeSlot] = []
    
    private init() {
        courts = [
            Court(id: 1, name: "Football Ground", sport: .football),
            Court(id: 2, name: "Basketball Court", sport: .basketball),
            Court(id: 3, name: "Cricket Ground", sport: .cricket),
            Court(id: 4, name: "Badminton Court 1", sport: .badminton),
            Court(id: 5, name: "Badminton Court 2", sport: .badminton),
            Court(id: 6, name: "Table Tennis Room", sport: .tableTennis)
        ]
    }
    
    func isCourtAvailable(courtId: Int, startTime: Date, endTime: Date) -> Bool {
        // Check each existing booking
        for slot in timeSlots {
            // First check if this slot is for our court
            if slot.courtId == courtId {
                // Check if there's an overlap
                let hasOverlap = startTime < slot.endTime && endTime > slot.startTime
                
                // If we found an overlap, court is not available
                if hasOverlap {
                    return false
                }
            }
        }
        
        // If we checked all slots and found no overlaps, court is available
        return true
    }
    
    func reserveCourt(courtId: Int, startTime: Date, endTime: Date, gameId: Int) -> Bool {
        guard isCourtAvailable(courtId: courtId, startTime: startTime, endTime: endTime) else {
            return false
        }
        
        let newSlot = TimeSlot(
            startTime: startTime,
            endTime: endTime,
            courtId: courtId,
            gameId: gameId
        )
        timeSlots.append(newSlot)
        return true
    }
    
    func getAvailableCourts(sport: Sport, startTime: Date, endTime: Date) -> [Court] {
        return courts.filter { court in
            court.sport == sport &&
            isCourtAvailable(courtId: court.id, startTime: startTime, endTime: endTime)
        }
    }
}

//let resourceManager = ResourceManager.shared
//
//// 1. Check available basketball courts for 7-8 PM today
//let calendar = Calendar.current
//let today7PM = calendar.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!
//let today8PM = calendar.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
//
//let availableCourts = resourceManager.getAvailableCourts(
//    sport: .basketball,
//    startTime: today7PM,
//    endTime: today8PM
//)
//
//// 2. If court available, try to reserve it
//if let court = availableCourts.first {
//    let booked = resourceManager.reserveCourt(
//        courtId: court.id,
//        startTime: today7PM,
//        endTime: today8PM,
//        gameId: 1
//    )
//    
//    if booked {
//        print("Basketball court reserved!")
//    }
//}
//
//// 3. Later, check if specific time is available
//let isAvailable = resourceManager.isCourtAvailable(
//    courtId: 2,  // Basketball court
//    startTime: today7PM,
//    endTime: today8PM
//)
//
