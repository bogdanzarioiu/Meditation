//
//  ContentView.swift
//  Meditation
//
//  Created by Bogdan on 6/30/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedPickerValue = 0
    @ObservedObject var timerManager = TimeManager()
    
    let minutesOption = Array(1...59)
    var body: some View {
        ZStack {
                VStack {
                    Spacer()
                    Text("Meditation Time").foregroundColor(.orange)
                        .font(.headline)
                       
                    
                    Text(secondsToMinutesAndSeconds(seconds:
                        timerManager.secondsLeft))
                        .font(.system(size: 80))
                        .padding(.top, 80)
                    
                    Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .foregroundColor(.blue)
                    .overlay(
                        Circle()
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                            .scaleEffect(1.05)
                    )
                        .onTapGesture(perform: {
                            if self.timerManager.timerMode == .initial {
                                self.timerManager.setTimerLength(minutes: self.minutesOption[self.selectedPickerValue]*60)
                            }
                            withAnimation {
                                
                                self.timerManager.timerMode == .running ? self.timerManager.pauseTimer() : self.timerManager.startTimer()
                            }
                        })
                    
                
                        
                        if timerManager.timerMode == .paused {
                            Image(systemName: "gobackward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(.top, 40)
                                .onTapGesture {
                                    withAnimation {
                                        self.timerManager.resetTimer()
                                    }
                            }
                        }
                    
                    
                    if timerManager.timerMode == .initial {
                        Picker(selection: $selectedPickerValue, label: Text("label is hidden anyway")) {
                            ForEach(0 ..< minutesOption.count) {
                                Text("\(self.minutesOption[$0]) min")
                            }
                        }
                        .labelsHidden()
                        
                    }
                    
                    Spacer()
                }
                .navigationBarTitle("Meditation Time")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.init(red: 40/255, green: 40/255, blue: 40/255))
                
                
            }.edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



func secondsToMinutesAndSeconds(seconds: Int) -> String {
    
    let minutes = "\((seconds % 3600) / 60)"; let seconds = "\((seconds % 3600) % 60)"
    let minuteStamp = minutes.count > 1 ? minutes :
        "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds :
        "0" + seconds
    return "\(minuteStamp):\(secondStamp)"
}
