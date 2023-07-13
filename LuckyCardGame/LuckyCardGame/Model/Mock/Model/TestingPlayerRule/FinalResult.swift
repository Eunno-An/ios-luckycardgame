//
//  FinalResult.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/13.
//

import Foundation

class FinalResult{
    private(set) var attendees: [Attendee] = []
    private(set) var numsOfThreeDuplicateCard: [[Int]] = [[Int]()]
    init(attendeeNum: AttendeeNum){
        for _ in 0..<attendeeNum.rawValue{
            attendees.append(Attendee(deck: Deck()))
        }
    }
    
    
}
