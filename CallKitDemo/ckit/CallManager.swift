//
//  CallManager.swift
//  CallKitDemo
//
//  Created by Rezaul Islam on 17/1/24.
//

import Foundation
import CallKit

class CallManager : NSObject, ObservableObject, CXProviderDelegate{
    
    @Published var isCalling = false
    @Published var uuid : UUID?

        public let provider: CXProvider

        override init() {
            let configuration = CXProviderConfiguration()
            configuration.includesCallsInRecents = true
            configuration.supportsVideo = true
            provider = CXProvider(configuration: configuration)
            super.init()
            provider.setDelegate(self, queue: nil)
        }

        func showIncommingCallUI(callerName: String) {
            let update = CXCallUpdate()
            //if we want to show Video in Call screen.
            update.hasVideo = true
            update.remoteHandle = CXHandle(type: .generic, value: callerName)
            uuid = UUID()
            provider.reportNewIncomingCall(with: uuid!, update: update) { error in }
        }

        func endCall() {
            print("Ending the call")
            if uuid != nil {
                provider.reportCall(with: uuid!, endedAt: Date(), reason: .remoteEnded)
                    DispatchQueue.main.async { [weak self] in
                        self!.isCalling = false
                    }
            }
        }

        // MARK: - CXProviderDelegate

        func providerDidReset(_ provider: CXProvider) {
            // Implement as needed
        }

        func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
            // Implement as needed
            action.fulfill()
            print("Call Start Action")
        }

        func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
            // Implement as needed
            action.fulfill()
            print("Call Answered Action")
        }

        func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
            // Implement as needed
            action.fulfill()
            isCalling = false
            print("Call End Action")
        }
 
}
