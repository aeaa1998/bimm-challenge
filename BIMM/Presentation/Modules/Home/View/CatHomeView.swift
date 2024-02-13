//
//  CatHomeView.swift
//  BIMM
//
//  Created by Augusto Alonso on 8/02/24.
//

import SwiftUI

struct CatHomeView: View {
    @EnvironmentObject var router: Router<CataasNavigation>
    @StateObject var catHomeViewModel = CatHomeViewModel()
    @State var filtersVisible: Bool = false
    
    private var cats: [Cat] {
        catHomeViewModel.cats
    }
    
    private var catHomeFilterState: CatHomeFilterState {
        catHomeViewModel.catHomeFilterState
    }
    
    private var requestState: RequestState {
        catHomeViewModel.requestState
    }
    
    var body: some View {
        Content(
            requestState: requestState,
            tagsRequestState: catHomeViewModel.tagsRequestState,
            cats: cats,
            filterTags: catHomeViewModel.selectedFilters,
            filtersVisible: $filtersVisible,
            onCatSelected: { cat in
                //We will push in the stack the cat
                router.navigate(to: .detail(cat: cat))
            },
            onRetry: {
                Task {
                    await catHomeViewModel.fetchCats()
                }
            }
        )
        .onAppear {
            Task {
                await catHomeViewModel.fetchCats()
            }
            Task.detached {
                await catHomeViewModel.fetchTags()
            }
        }
        .sheet(isPresented: $filtersVisible) {
            CatHomeFilterBottomSheetView(state: catHomeFilterState)
        }
    }
    
    struct Content : View {
        @Environment(\.theme) var theme
        
        let requestState: RequestState
        let tagsRequestState: RequestState
        let cats: [Cat]
        let filterTags: [String]
        @Binding var filtersVisible: Bool
        let onCatSelected: (Cat) -> Void
        let onRetry: () -> Void
        
        private var catsFiltered: [Cat] {
            cats
                .filter { cat in
                    cat.tags.contains { tag in
                        self.filterTags.isEmpty || self.filterTags.contains(tag)
                    }
                }
        }
        
        init(
            requestState: RequestState,
            tagsRequestState: RequestState,
            cats: [Cat],
            filterTags: [String],
            filtersVisible: Binding<Bool>,
            onCatSelected: @escaping (Cat) -> Void = {_ in },
            onRetry: @escaping () -> Void
        ) {
            self.requestState = requestState
            self.tagsRequestState = tagsRequestState
            self.cats = cats
            self.filterTags = filterTags
            self._filtersVisible = filtersVisible
            self.onRetry = onRetry
            self.onCatSelected = onCatSelected
        }
        
        var body: some View {
            Group {
                switch requestState {
                case .loading, .none:
                    LoadingCatView()
                case .success:
                    if catsFiltered.isEmpty {
                        emptyView
                    }else {
                        ScrollView {
                            LazyVStack {
                                ForEach(catsFiltered) { cat in
                                    CatCardView(cat: cat, filterTags: filterTags)
                                        .accessibilityHint("Double tap to Navigate \(cat.id) detail")
                                        .onTapGesture {
                                            onCatSelected(cat)
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                case .error(let error):
                    VStack {
                        Spacer()
                        SadCatErrorView(title: "cat_loading_error", error: error, onRetry: onRetry)
                        Spacer()
                    }
                }
            }
            .navigationTitle(Text("cat_home_title"))
            .toolbar {
                if tagsRequestState != .loading && tagsRequestState != .none {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            filtersVisible = true
                        }){
                            Image(systemName: "slider.vertical.3")
                        }
                        .accessibilityLabel("show_filters")
                    }
                }
            }
            .background(theme.backgrounds.background)
        }
        
        
        private var emptyView: some View {
            VStack(spacing: 8) {
                Spacer()
                Image("sad-cat")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())

                Text("no_cats_found")
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(14)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview("Sucess") {
    NavigationStack {
        CatHomeView.Content(
            requestState: .success,
            tagsRequestState: .success,
            cats: [
                .init(id: "JYpbBMDo6Hexm6OB", tags: ["test"], owner: ""),
                .init(id: "aAZvpzuvIspNZB3H", tags: ["test2"], owner: nil),
                .init(id: "iaQ7TgfKYQXIubuW", tags: ["test2"], owner: nil),
            ], 
            filterTags: [],
            filtersVisible: .constant(false),
            onRetry: {}
        )
    }
}

#Preview("Empty") {
    NavigationStack {
        CatHomeView.Content(
            requestState: .success,
            tagsRequestState: .loading,
            cats: [],
            filterTags: [],
            filtersVisible: .constant(false),
            onRetry: {}
        )
    }
}




#Preview("Error") {
    CatHomeView.Content(
        requestState: .error(BundleError.resourceNotFound),
        tagsRequestState: .success,
        cats: [],
        filterTags: [],
        filtersVisible: .constant(false),
        onRetry: {}
    )
}

#Preview("Loading") {
    CatHomeView.Content(
        requestState: .loading,
        tagsRequestState: .success,
        cats: [],
        filterTags: [],
        filtersVisible: .constant(false),
        onRetry: {}
    )
}
