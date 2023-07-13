//
//  FinalResult.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/13.
//

import Foundation

class FinalResult{
    private(set) var attendees: [Attendee]
    
    init(){
        attendees = []
    }
    
    init(attendeeNum : AttendeeNum){
        attendees = Array(repeating: Attendee(), count: attendeeNum.rawValue)
    }
}
