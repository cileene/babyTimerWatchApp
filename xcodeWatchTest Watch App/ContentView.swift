//
//  ContentView.swift
//  xcodeWatchTest Watch App
//
//  Created by Nick Jerlung on 06/11/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("lastFeeding") private var lastFeeding: Double = 0
    @AppStorage("lastDiaperChange") private var lastDiaperChange: Double = 0
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
            
            Text(babyName)
            
            Button(action: {
                self.lastFeeding = Date().timeIntervalSince1970
                print(babyName,"just finished eating!")
            }) {
                Text("Feed")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                
            }

            Text(timeSince(timeInterval: lastFeeding))
                .padding()
                .foregroundColor(.red)

            Button(action: {
                self.lastDiaperChange = Date().timeIntervalSince1970
                print(babyName,"just got a fresh diaper!")
            }) {
                Text("Change")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }

            Text(timeSince(timeInterval: lastDiaperChange))
                .padding()
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
        return timeInterval > 0 ? "\(minutes) min ago" : "N/A"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
