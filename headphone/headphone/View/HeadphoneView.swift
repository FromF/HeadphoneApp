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
                Image(systemName: "headphones")
                    .font(.system(size: 100))
            } else if viewModel.isSpeaker {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.system(size: 100))
            } else {
                Image(systemName: "questionmark")
                    .font(.system(size: 100))
            }
        }
    }
}

struct HeadphoneView_Previews: PreviewProvider {
    static var previews: some View {
        HeadphoneView()
    }
}
