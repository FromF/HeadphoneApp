//
//  HeadphoneViewModel.swift
//  headphone
//
//  Created by 藤治仁 on 2021/12/03.
//

import UIKit
import AVFoundation

class HeadphoneViewModel: ObservableObject {
    @Published var isSpeaker = false
    @Published var isHeadphone = false
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setActive(true, options: [])
        } catch {
            fatalError("\(error.localizedDescription)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeAudioSessionRoute(_:)), name:  AVAudioSession.routeChangeNotification, object: nil)
        
        judgeHeadphone()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    @objc private func didChangeAudioSessionRoute(_ notification: Notification) {
        judgeHeadphone()
    }
    
    private func judgeHeadphone() {
        for component in AVAudioSession.sharedInstance().currentRoute.outputs {
            print(component)
            if component.portType == AVAudioSession.Port.headphones ||
                component.portType == AVAudioSession.Port.bluetoothA2DP ||
                component.portType == AVAudioSession.Port.bluetoothLE ||
                component.portType == AVAudioSession.Port.bluetoothHFP {
                // イヤホン(Bluetooth含む)
                isHeadphone = true
                isSpeaker = false
                return
            }
        }
        // イヤホン(Bluetooth含む)以外
        isHeadphone = false
        isSpeaker = true
    }
}
