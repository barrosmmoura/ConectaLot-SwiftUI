//
//  LottieView.swift
//  ConectaLot-SwifUI
//
//  Created by Mariana Moura de Barros on 23/11/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    @Binding var isEnded: Bool
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: "loading")
        animationView.play { completed in
            isEnded.toggle()
        }
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 250),
            animationView.heightAnchor.constraint(equalToConstant: 250),
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
    
    
}

