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
            
            LottieView(isEnded: $isLoading)
                .opacity(isLoading ? 1 : 0)
            
            WebView(htmlString: "", url: URL(string: urlString)!)
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .onChanged { scale in
                            self.scale = 1.0
                        }
                )
                .opacity(isLoading ? 0 : 1)
        }
        .ignoresSafeArea()
        .background(Color(uiColor: UIColor(named: "conectablue")!))
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
