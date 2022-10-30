//
//  CrewMember.swift
//  Moonshot
//
//  Created by Alexandru Tenie on 29.10.2022.
//

import Foundation

struct CrewMember {
    let role: String
    let astronaut: Astronaut
    
    var image: String {
        astronaut.id
    }
}
