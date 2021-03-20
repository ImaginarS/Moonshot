//
//  AstronautView.swift
//  Moonshot
//
//  Created by Sandra Q on 3/18/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.name)
                        .padding()
                    Text(self.astronaut.description)
                        .padding()
                    
                    Section(header: Text("Missions"), content: {
                        
                        List(self.missions) { mission in
                            
                            Text(mission.displayName)
                                .font(.headline)
                            
                            Spacer()
                        }
                    })
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        var matches = [Mission]()
        let missions = Missions.missions
        
        for mission in missions {
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                matches.append(mission)
            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        
        MissionView(mission: mission[0], astronauts: astronauts)
    }
}
