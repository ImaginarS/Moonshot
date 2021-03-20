//
//  ContentView.swift
//  Moonshot
//
//  Created by Sandra Q on 3/17/21.
//

import SwiftUI

struct CrewMember {
    let astronaut: Astronaut
}

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let mission: Mission
    let people: [CrewMember]
    
    @State private var showGreeting = true
    
    var body: some View {
        NavigationView {
            VStack{
                Toggle("", isOn: $showGreeting)
                
                List(missions) { mission in
                    NavigationLink(
                        destination: MissionView(mission: mission, astronauts: self.astronauts))  {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName).font(.headline)
                            
                            if showGreeting {
                                Text(mission.formattedLaunchDate).font(.caption)
                            } else {
                                ForEach(0..<people.count) { value in
                                    Text(people[value].astronaut.name)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            
        }
    }
    
    init(missions: [Mission], astronauts: [Astronaut]) {
        self.mission = missions[0]
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = self.astronauts.first(where: { $0.id == member.name}) {
                matches.append(CrewMember(astronaut: match))
            }
        }
        print("\(matches)")
        
        self.people = matches
    }
    
    func matchAstronauts(mission: Mission) -> [CrewMember]{
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = self.astronauts.first(where: { $0.id == member.name}) {
                matches.append(CrewMember(astronaut: match))
            }
        }
        return matches
    }
}
struct ContentView_Previews: PreviewProvider {
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ContentView(missions: mission, astronauts: astronauts)
    }
}
