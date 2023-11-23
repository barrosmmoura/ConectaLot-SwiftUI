//
//  ContentView.swift
//  ConectaLot-SwifUI
//
//  Created by Mariana Moura de Barros on 22/11/23.
//
import SwiftUI
import WebKit


struct ContentView: View {
    @State private var showWebView = false
    @State private var scale: CGFloat = 1.0
    @State private var isLoading = false
    
    private let urlString: String = "https://conectalot.com.br/login"
    
    var body: some View {
        ZStack {
            if isLoading {
                ZStack{
                    Color("conectablue")
                        .edgesIgnoringSafeArea(.all)
                       
                    LottieView(isEnded: $isLoading)
//                        .opacity(0.5)
                }
                
                
            } else {
                WebView(htmlString: "", url: URL(string: urlString)!)
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { scale in
                                self.scale = 1.0
                            }
                    )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            self.isLoading = true
        }
    }
}

struct WebView: UIViewRepresentable {
    let htmlString: String
    var url: URL?
    
    init(htmlString: String, url: URL? = nil) {
        self.htmlString = htmlString
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            let request = URLRequest(url: url)
            uiView.load(request)
        } else {
            uiView.loadHTMLString(htmlString, baseURL: nil)
        }
    }
}
