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
    //    @State private var scale: CGFloat = 1.0
    @State private var isLoading = false
    @State private var isConnected = false

    private let urlString: String = "https://conectalot.com.br/login"

    var body: some View {
        ZStack {

            LottieView(isEnded: $isLoading)
                .opacity(isLoading ? 1 : 0)
                .background(Color(uiColor: UIColor(named: "conectablue")!))


            WebView(htmlString: "", url: URL(string: urlString)!, isError: $isConnected)
                .background(Color(uiColor: UIColor(named: "conectabg")!))
                .opacity(isLoading ? 0 : 1)


        }
//        .ignoresSafeArea()
//        .background(Color(uiColor: UIColor(named: "conectablue")!))
        .onAppear {
            self.isLoading = true
        }
        .sheet(isPresented: $isConnected) {
            NetworkView(isConnected: $isConnected)
        }
    }
 //fullScreenCover


}

struct WebView: UIViewRepresentable {
    let htmlString: String
    var url: URL?
    @Binding var isError: Bool

    init(htmlString: String, url: URL? = nil, isError: Binding<Bool>) {
        self.htmlString = htmlString
        self.url = url
        self._isError = isError
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.delegate = context.coordinator
        webView.navigationDelegate = context.coordinator
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

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, UIScrollViewDelegate {

        var parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        // MARK: WKNavigationDelegate
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            // Handle network errors
            parent.isError = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Reset error state when navigation is successful
            parent.isError = false
        }

        // MARK: UIScrollViewDelegate
        func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
            scrollView.pinchGestureRecognizer?.isEnabled = false
        }
    }
}
