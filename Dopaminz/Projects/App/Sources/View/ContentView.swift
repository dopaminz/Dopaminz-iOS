//
//  ContentView.swift
//  Dopaminz
//
//  Created by 서원지 on 4/4/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import Shareds
import DesignSystem
import AVFoundation

struct ContentView: View {
    @State var test = Test()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .pretendardFont(family: .SemiBold, size: 20)
            .onAppear {
                test.testRecord()
            }
    }
}

#Preview {
    ContentView()
}

@Observable class Test {
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    
    func testRecord() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            // 오디오 세션의 카테고리와 모드를 설정한다.
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            // 음성 녹음 권한을 요청한다.
            recordingSession.requestRecordPermission() { allowed in
                if allowed {
                    print("음성 녹음 허용")
                } else {
                    print("음성 녹음 비허용")
                }
            }
        } catch {
            print("음성 녹음 실패")
        }
    }
    
    
}
