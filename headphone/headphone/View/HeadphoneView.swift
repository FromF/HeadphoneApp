//
//  HeadphoneView.swift
//  headphone
//
//  Created by 藤治仁 on 2021/12/03.
//

import SwiftUI

struct HeadphoneView: View {
    @ObservedObject var viewModel = HeadphoneViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isHeadphone {
                Text("Audio Device: Headphone")
            } else if viewModel.isSpeaker {
                Text("Audio Device: Speaker")
            } else {
                Text("Audio Device: Unknown")
            }
        }
    }
}

struct HeadphoneView_Previews: PreviewProvider {
    static var previews: some View {
        HeadphoneView()
    }
}
