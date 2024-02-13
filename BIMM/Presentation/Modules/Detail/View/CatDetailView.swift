//
//  CatDetailView.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import SwiftUI

struct CatDetailView: View {
    let cat: Cat
    @StateObject var catDetailViewModel: CatDetailViewModel = CatDetailViewModel()
    @State private var selected: DetailTab = .information
    
    var body: some View {
        Content(
            id: cat.id,
            cat: catDetailViewModel.cat,
            requestState: catDetailViewModel.requestState,
            selected: $selected,
            onRetry: {
                Task {
                    await catDetailViewModel.fetchCat(for: cat)
                }
            }
        )
        .task {
            await catDetailViewModel.fetchCat(for: cat)
        }
    }
    
    struct Content : View {
        @Environment(\.theme) var theme
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.dismiss) var dismiss
        
        let id: String
        let cat: CatDetail?
        let requestState: RequestState
        @Binding var selected: DetailTab
        let onRetry: () -> Void
        
        
        private let catImageSize: CGFloat = 150
        private var background: Color {
            theme.backgrounds.background
        }
        
        init(id: String, cat: CatDetail?, requestState: RequestState, selected: Binding<DetailTab>, onRetry: @escaping () -> Void = {}) {
            self.id = id
            self.cat = cat
            self.requestState = requestState
            self._selected = selected
            self.onRetry = onRetry
        }
        
        
        var body: some View {
            GeometryReader { proxy in
                let width = proxy.size.width
                let height: CGFloat = 300
                let topInset = getSafeAreaTop() ?? 80
                
                    ZStack(alignment: .topLeading) {
                        
                        //Prevent loading first with 0 value
                        if width > 0 {
                            CatImageView(
                                id: id,
                                cached: true,
                                queryParameters: ["height": "\(height)", "width": "\(Int(width))"]
                            )
                                .frame(width: width, height: height)
                                .background(.thickMaterial)
                        }

                        ScrollView() {
                            VStack(alignment: requestState == .loading ? .center : .leading) {
                                    
                                HStack(alignment: .center) {
                                    (Text("detail_for") + Text(" \(id)"))
                                        .font(.headline)
                                        .accessibilityAddTraits([.isHeader])
                                    Spacer()
                                }
                                
                                if let cat {
                                    SuccessView(cat: cat)
                                }else{
                                    switch requestState {
                                    case .loading, .none:
                                        LoadingCatView()
                                    case .error(let error):
                                        ErrorView(error: error)
                                    default:
                                        ErrorView(error: nil)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding()
                            //The height of the screen minus the top bar
                            .frame(minHeight: proxy.size.height - (topInset + 40))
                            .frame(maxWidth: .infinity)
                            .background(background, ignoresSafeAreaEdges: .bottom)
                            .clipShape(theme.shapes.regular)
                            .padding(.top, height - 25)
                                
                                
                        }
                        .scrollDismissesKeyboard(.interactively)
                        .scrollIndicators(.hidden)
                     
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                        })
                        .background(Color.tertiarySystemBackground)
                        .buttonStyle(BorderedButtonStyle())
                        .clipShape(Circle())
                        .padding(.leading)
                        .padding(.top, topInset)
                    }
                
            }
            .addKeyboardDismissAction()
            .toolbar(.hidden)
            .background(
                background,
                ignoresSafeAreaEdges: .bottom
            )
            .ignoresSafeArea(.all, edges: .vertical)
        }
        
        private func ErrorView(error: Error?) -> some View {
            SadCatErrorView(title: "cat_loading_error", error: error, onRetry: onRetry)
                .padding(.top)
        }
        
        
        @ViewBuilder
        private func SuccessView(cat: CatDetail) -> some View {
            TabRows(
                selected: $selected,
                items: DetailTab.allCases,
                localized: true
            )
            .tabColor(colorScheme == .dark ? .white : theme.palette.primary)
            
            
            switch selected {
            case .information:
                CatDetailInformationView(cat: cat)
            case .talk:
                CatDetailTalkView(id: cat.id)
            }
        }
    }
}

#Preview("Success Info") {
    NavigationStack
    {
        CatDetailView.Content(
            id: "iaQ7TgfKYQXIubuW",
            cat: .init(
                id: "iaQ7TgfKYQXIubuW",
                tags: ["test", "test2", "test3", "test4", "test5", "test6", "test7 large to test it", "test7", "test8", "test89"],
                owner: nil,
                mimetype: "text",
                createdAt: Date(),
                updatedAt: Date()
            ),
            requestState: .success,
            selected: .init(get: { DetailTab.information }, set: { _ in })
        )
    }
}

#Preview("Success Talk") {
    NavigationStack
    {
        CatDetailView.Content(
            id: "iaQ7TgfKYQXIubuW",
            cat: .init(
                id: "iaQ7TgfKYQXIubuW",
                tags: ["test", "test2", "test3", "test4", "test5", "test6", "test7 large to test it", "test7", "test8", "test89"],
                owner: nil,
                mimetype: "text",
                createdAt: Date(),
                updatedAt: Date()
            ),
            requestState: .success,
            selected: .init(get: { DetailTab.talk }, set: { _ in })
        )
    }
}

#Preview("Loading") {
    NavigationStack
    {
        CatDetailView.Content(
            id: "iaQ7TgfKYQXIubuW",
            cat: nil,
            requestState: .loading,
            selected: .init(get: { DetailTab.talk }, set: { _ in })
        )
    }
}

#Preview("Error") {
    NavigationStack
    {
        CatDetailView.Content(
            id: "iaQ7TgfKYQXIubuW",
            cat: nil,
            requestState: .error(BundleError.bundleNotFound),
            selected: .init(get: { DetailTab.talk }, set: { _ in })
        )
    }
}
