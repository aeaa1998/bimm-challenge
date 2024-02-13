//
//  CatImageView.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import SwiftUI
import CachedAsyncImage

struct CatImageView: View {
    let id: String
    let cached: Bool
    let talk: String?
    let queryParameters: [String: String]?
    
    @State var phase: GifView.Phase = .none
    
    init(
        id: String,
        cached: Bool = false,
        talk: String? = nil,
        queryParameters: [String : String]? = nil
    ) {
        self.id = id
        self.cached = cached
        self.talk = talk
        self.queryParameters = queryParameters
    }
    
    init(
        cat: CatProtocol,
        cached: Bool = false,
        talk: String? = nil,
        queryParameters: [String : String]? = nil
    ) {
        self.id = cat.id
        self.cached = cached
        self.talk = talk
        self.queryParameters = queryParameters
    }
    
    var url: URL? {
        var path = "\(BIMMEnvironment.baseURL.value)cat/\(id)"
        if let talk {
            path += "/says/\(talk)"
        }
        
        let url = URL(string: path)
        if let queryParameters, let url {
        
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            let queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            urlComponents?.queryItems = queryItems

            return urlComponents?.url
        }
        return url
    }
    
    var body: some View {
        if let url {
            if cached {
                CachedAsyncImage(url: url, urlCache: URL.imageCache) { phase in
                    ImagePhaseView(phase)
                }
                .tag("cat_image_cached_\(id)")
            }else{
                AsyncImage(url: url) { phase in
                    ImagePhaseView(phase)
                }
                .tag("cat_image_\(id)")
            }
        } else {
            errorView
        }
    }

    @ViewBuilder
    private func ImagePhaseView(_ phase: AsyncImagePhase) -> some View {
        switch phase {
        case .success(let image):
            image
                .resizable()
                .accessibilityLabel(imageAccessibilityLabel)
                
        case .failure(_):
            errorView
        case.empty:
            ProgressView()
        @unknown default:
            errorView
        }
    }
    
    private var imageAccessibilityLabel : Text {
        if let talk {
          return Text("cat_image_with_text".localized()) + Text(" \(talk)")
        } else{
          return Text("cat_image".localized())
        }
    }
    
    private var errorView: some View {
        Text("cat_image_error")
            .font(.body)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    CatImageView(cat: Cat(id: "rV1MVEh0Af2Bm4O0", tags: [], owner: nil), queryParameters: ["height": "175", "width": "175"])
        .background(BIMMTheme.default.palette.secondary)
}
