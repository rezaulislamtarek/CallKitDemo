//
//  ContentView.swift
//  CallKitDemo
//
//  Created by Rezaul Islam on 17/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var callManager = CallManager()
    var body: some View {
        VStack (spacing: 16) {
            Button("Start Call") {
                callManager.showIncommingCallUI(callerName: "Md. Rezaul Islam")
            }
            
            Button("End Call") {
                callManager.endCall()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
