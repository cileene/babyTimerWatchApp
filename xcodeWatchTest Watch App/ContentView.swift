//
//  ContentView.swift
//  xcodeWatchTest Watch App
//
//  Created by Nick Jerlung on 06/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    // storing babyName and timestamps in @AppStorage
    @AppStorage("babyName") private var babyName: String = "Vincent"
    
    @AppStorage("lastFeeding 0") private var lastFeeding0: Double = 0
    @AppStorage("lastFeeding 1") private var lastFeeding1: Double = 0
    @AppStorage("lastFeeding 2") private var lastFeeding2: Double = 0
    @AppStorage("lastFeeding 3") private var lastFeeding3: Double = 0
    @AppStorage("lastFeeding 4") private var lastFeeding4: Double = 0
    @AppStorage("lastFeeding 5") private var lastFeeding5: Double = 0
    @AppStorage("lastFeeding 6") private var lastFeeding6: Double = 0
    @AppStorage("lastFeeding 7") private var lastFeeding7: Double = 0
    @AppStorage("lastDiaperChange 0") private var lastDiaperChange0: Double = 0
    @AppStorage("lastDiaperChange 1") private var lastDiaperChange1: Double = 0
    @AppStorage("lastDiaperChange 2") private var lastDiaperChange2: Double = 0
    @AppStorage("lastDiaperChange 3") private var lastDiaperChange3: Double = 0
    @AppStorage("lastDiaperChange 4") private var lastDiaperChange4: Double = 0
    @AppStorage("lastDiaperChange 5") private var lastDiaperChange5: Double = 0
    @AppStorage("lastDiaperChange 6") private var lastDiaperChange6: Double = 0
    @AppStorage("lastDiaperChange 7") private var lastDiaperChange7: Double = 0
    
    
    // our current time
    @State private var currentTime = Date()
    
    // timer for updating the count
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            
            // a bit of visual flair
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundStyle(.red)
                .padding(.top, -25)
                
            // display babyName
            Text(babyName)
                .font(.headline)
                .foregroundColor(Color.white)
                .padding(.top, -10)
            
            // the Feed button
            Button(action: {
                // Shift the feeding times
                (lastFeeding7, lastFeeding6, lastFeeding5, lastFeeding4, lastFeeding3, lastFeeding2, lastFeeding1, lastFeeding0) =
                (lastFeeding6, lastFeeding5, lastFeeding4, lastFeeding3, lastFeeding2, lastFeeding1, lastFeeding0, Date().timeIntervalSince1970)
                
                print(babyName, "just finished eating!")
                // print interval to console
                print(timeSince(timeInterval: lastFeeding1))
            }) {
                Text("Feed")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }

            // display time since last feeding
            Text("Ate \(timeSince(timeInterval: lastFeeding0)) min ago")
                .padding(-3)
                .foregroundColor(.orange)
                
            
            // display interval between last two feedings
            Text("Interval \(Int((lastFeeding0 - lastFeeding1) / 60)) min")
                .font(.caption2)
                .padding(-3)
                .foregroundColor(.red)

            // the Change button
            Button(action: {
                // Shift the diaper change times
                (lastDiaperChange7, lastDiaperChange6, lastDiaperChange5, lastDiaperChange4, lastDiaperChange3, lastDiaperChange2, lastDiaperChange1, lastDiaperChange0) =
                (lastDiaperChange6, lastDiaperChange5, lastDiaperChange4, lastDiaperChange3, lastDiaperChange2, lastDiaperChange1, lastDiaperChange0, Date().timeIntervalSince1970)
                
                print(babyName, "just got a fresh diaper!")
                // print interval to console
                print(timeSince(timeInterval: lastDiaperChange1))
            }) {
                Text("Change")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }

            // display time since last diaper change
            Text("Changed \(timeSince(timeInterval: lastDiaperChange0)) min ago")
                .padding(-3)
                .foregroundColor(.orange)
            
            // display interval between last two diaper changes
            Text("Interval \(Int((lastDiaperChange0 - lastDiaperChange1) / 60)) min")
                .font(.caption2)
                .padding(-3)
                .foregroundColor(.red)
        }
        
        .padding()
        .onReceive(timer) { _ in
            self.currentTime = Date()
        }
    }

    // function to return time since last event
    func timeSince(timeInterval: Double) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let timeInterval = currentTime.timeIntervalSince(date)
        let minutes = Int(timeInterval / 60)
        return timeInterval > 0 ? "\(minutes)" : "N/A"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
