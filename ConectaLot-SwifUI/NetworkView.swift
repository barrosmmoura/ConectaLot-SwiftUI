//
//  NetworkView.swift
//  ConectaLot-SwifUI
//
//  Created by Mariana Moura de Barros on 07/12/23.
//

import Foundation
import SwiftUI
import Network

@Observable
class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
        }
        networkMonitor.start(queue: workerQueue)
    }
}

struct NetworkView: View {

    @Binding var isConnected: Bool
    @State private var networkMonitor = NetworkMonitor()

    var body: some View {
        VStack {
            Image("Error")
                .resizable()
                .frame(width: 200, height: 47.5)
                .padding(.bottom, 20)
            Text("NÃO FOI POSSÍVEL CONECTAR AO SERVIDOR.")
                .foregroundColor(.white)
                .font(.subheadline)
                .fontWeight(.bold)

//            Button("RECARREGAR") {
//                isConnected = false
//            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: UIColor(named: "conectablue")!))
        .onChange(of: networkMonitor.isConnected) { _, newValue in
            isConnected = newValue
        }
    }
       
}
