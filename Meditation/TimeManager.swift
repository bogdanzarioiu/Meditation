//
//  TimeManager.swift
//  Meditation
//
//  Created by Bogdan on 6/30/20.
//  Copyright © 2020 Bogdan Zarioiu. All rights reserved.
//

import Foundation
import SwiftUI

class TimeManager: ObservableObject {
   @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    var timer = Timer()
    
    func startTimer() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer  in
            if self.secondsLeft == 0 {
                self.resetTimer()
            }
            self.secondsLeft -= 1
        })
    }
    
    func resetTimer() {
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pauseTimer() {
        self.timerMode = .paused
        self.timer.invalidate()
    }
    
    func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
    
}
