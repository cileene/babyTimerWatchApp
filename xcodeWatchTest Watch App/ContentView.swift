//
//  ContentView.swift
//  xcodeWatchTest Watch App
//
//  Created by Nick Jerlung on 06/11/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("lastFeeding 0") private var lastFeeding0: Double = 0
    @AppStorage("lastFeeding 1") private var lastFeeding1: Double = 0
    @AppStorage("lastDiaperChange 0") private var lastDiaperChange0: Double = 0
    @AppStorage("lastDiaperChange 1") private var lastDiaperChange1: Double = 0
    @State private var currentTime = Date()
    
    // set the babys name
    let babyName = "Vincent"
    
    // timer for updating the count
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Image(systemName: "heart")
                .imageScale(.large)
                .foregroundStyle(.red)
                .padding(.top, -25)
                
            
            Text(babyName)
                .padding(.top, -10)
            
            Button(action: {
                lastFeeding1 = lastFeeding0
                self.lastFeeding0 = Date().timeIntervalSince1970
                print(babyName,"just finished eating!")
                // print interval to console
                print(timeSince(timeInterval: lastFeeding1))
            }) {
                Text("Feed")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }

            Text("Fed \(timeSince(timeInterval: lastFeeding0)) min ago")
                .padding(-3)
                .foregroundColor(.red)
            
            Text("Interval \(timeSince(timeInterval: lastFeeding1)) min")
                .font(.caption2)
                .fontWeight(.thin)
                .padding(-3)
                .foregroundColor(.red)

            Button(action: {
                lastDiaperChange1 = lastDiaperChange0
                self.lastDiaperChange0 = Date().timeIntervalSince1970
                print(babyName,"just got a fresh diaper!")
                // print interval to console
                print(timeSince(timeInterval: lastDiaperChange1))
            }) {
                Text("Change")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }

            Text("Changed \(timeSince(timeInterval: lastDiaperChange0)) min ago")
                .padding(-3)
                .foregroundColor(.red)
            Text("Interval \(timeSince(timeInterval: lastDiaperChange1)) min")
                .font(.caption2)
                .fontWeight(.thin)
                .padding(-3)
                .foregroundColor(.red)
            
          
        }
        .padding()
        .onReceive(timer) { _ in
            self.currentTime = Date()
        }
    }

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
