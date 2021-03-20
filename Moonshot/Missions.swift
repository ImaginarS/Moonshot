//
//  Missions.swift
//  Moonshot
//
//  Created by Sandra Q on 3/19/21.
//

import Foundation

struct Missions {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
}
