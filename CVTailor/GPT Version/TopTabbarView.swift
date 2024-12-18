//
//  TopTabbarView.swift
//  CVTailor
//
//  Created by Valery Zazulin on 18/12/24.
//

import SwiftUI

struct TopTabbarView: View {
    @State private var activeTab: TabModel = .personal
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    CustomTabBar(activeTab: $activeTab)
                }
            }
            
            .navigationTitle(Text("Resume Data"))
            
//            .background(.gray.opacity(0.1))
        }
        
    }
}

struct CustomTabBar: View {
    @Binding var activeTab: TabModel
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        GeometryReader { _ in
            ScrollViewReader { value in
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        HStack(spacing: activeTab == .full ? -20 : 8) {
                            ForEach(TabModel.allCases.filter({ $0 != .full }), id: \.self) { tab in
                                Button {
                                    value.scrollTo(tab, anchor: .center)
                                } label: {
                                    ResizableTabButton(tab)
                                        .id(tab)
                                }
                                    
                                
                            }
                        }
                        if activeTab == .full {
                            ResizableTabButton(.full)
                                .transition(.offset(x: 200))
                                .id(TabModel.full)
                        }
                    }
                    
                    .padding(.horizontal, 15)
                }
                .scrollIndicators(.hidden)
            }
            
            
        }
        .frame(height: 50)
    }
    
    @ViewBuilder
    func ResizableTabButton(_ tab: TabModel) -> some View {
        HStack(spacing: 8) {
            Image(systemName: tab.symbolImage)
                .opacity(activeTab != tab ? 1 : 0)
                .overlay {
                    Image(systemName: tab.symbolImage)
                        .symbolVariant(.fill)
                        .opacity(activeTab == tab ? 1 : 0)
                }
//                .symbolVariant(activeTab == tab ? .fill : .none)
            
            if activeTab == tab {
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                    .lineLimit(1)
            }
        }
        .foregroundStyle(tab == .full ? schemeColor : activeTab == tab ? .white : .gray)
        .frame(maxHeight: .infinity)
        .frame(maxWidth: activeTab == tab ? .infinity : nil)
        .padding(.horizontal, /*activeTab == tab ? 20 :*/ 20)
        .background {
            Rectangle()
                .fill(activeTab == tab ? tab.color : .inActiveTab)
        }
        .clipShape(.rect(cornerRadius: 20, style: .continuous))
        .background {
            RoundedRectangle(cornerRadius: 23, style: .continuous)
                .fill(.background)
                .padding(activeTab == .full && tab != .full ? -3 : 3)
        }
        .contentShape(.rect)
        .onTapGesture {
            withAnimation(.bouncy) {
                guard tab != .full else { return }
                if activeTab == tab {
                    activeTab = .full
                } else {
                    activeTab = tab
                }
            }
        }
    }
    
    var schemeColor: Color {
        scheme == .dark ? .black : .white
    }
}

#Preview {
    TopTabbarView()
}
