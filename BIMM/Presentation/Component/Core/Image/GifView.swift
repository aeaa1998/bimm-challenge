//
//  GifView.swift
//  BIMM
//
//  Created by Augusto Alonso on 9/02/24.
//

import SwiftUI
import WebKit

struct GifView: UIViewRepresentable {
    let url: URL
    
    @Binding var phase: GifView.Phase
   
    func makeUIView(context: Context) -> some WKWebView {
        DispatchQueue.main.async {
            phase = .loading
        }
        let webView = WKWebView()
        var urlRequest = URLRequest(url: url)
        
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        webView.navigationDelegate = context.coordinator
        webView.load(urlRequest)
 
        webView.scrollView.isScrollEnabled = false
        
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.reload()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(phase: $phase)
    }
    
    enum Phase {
        case loading, succeded, failed, none
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
        @Binding var phase: GifView.Phase
        
        init(phase: Binding<GifView.Phase>) {
            self._phase = phase
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async { [weak self] in
                self?.phase = .succeded
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async { [weak self] in
                self?.phase = .failed
            }
        }
        
    }
}

fileprivate struct Preview : View {
    @State var phase = GifView.Phase.none
    
    var body: some View {
        GifView(
            url: URL(string: "https://cataas.com/cat/rV1MVEh0Af2Bm4O0?height=200&width=200")!,
            phase: $phase
        )
            .frame(width: 200, height: 200)
            .background(.gray)
    }
}

#Preview {
    Preview()
}
