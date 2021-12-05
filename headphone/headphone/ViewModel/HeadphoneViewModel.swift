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
    @Published var isExternalAudio = false
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
        isHeadphone = false
        isExternalAudio = false
        isSpeaker = false
        for component in AVAudioSession.sharedInstance().currentRoute.outputs {
            print(component)
            if component.portType == .headphones ||
                component.portType == .bluetoothA2DP ||
                component.portType == .bluetoothLE ||
                component.portType == .bluetoothHFP ||
                component.portType == .usbAudio
            {
                // イヤホン(Bluetooth含む)
                isHeadphone = true
            }
            if component.portType == .builtInReceiver ||
                component.portType == .builtInSpeaker {
                // 内蔵スピーカーはスピーカーとする
                isSpeaker = true
            }
            if component.portType == .airPlay ||
                component.portType == .HDMI ||
                component.portType == .lineOut ||
                component.portType == .AVB ||
                component.portType == .displayPort ||
                component.portType == .carAudio ||
                component.portType == .fireWire ||
                component.portType == .PCI ||
                component.portType == .thunderbolt ||
                component.portType == .virtual
            {
                //その他オーディオデバイスは外部出力扱いする
                isExternalAudio = true
            }
        }
    }
}
