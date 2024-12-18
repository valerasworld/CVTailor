//
//  CVTailorApp.swift
//  CVTailor
//
//  Created by Valery Zazulin on 04/12/24.
//

import SwiftUI

@main
struct CVTailorApp: App {
    
//    init() {
//        // Customize navigation bar title globally
//        let appearance = UINavigationBarAppearance()
//        appearance.largeTitleTextAttributes = [
//            .font: UIFont.init(descriptor: UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(.serif)!.withSymbolicTraits(.traitBold)!, size: 34)
//        ]
////        appearance.titleTextAttributes = [
////            .font: UIFont.systemFont(ofSize: 17, weight: .regular, design: .serif)
////        ]
//        
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//    }
    
    var body: some Scene {
        WindowGroup {
            TopTabbarView()
        }
    }
}
