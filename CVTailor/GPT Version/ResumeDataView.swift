//
//  TopTabbarView.swift
//  CVTailor
//
//  Created by Valery Zazulin on 18/12/24.
//

import SwiftUI
// [(Category, [(TextKind, String)])]
struct ResumeDataView: View {
    @State var newPDFData = MyNewPDFData(newPDFData: [
        (.personal, []),
        (.summary, []),
        (.skills, []),
        (.experience, []),
        (.education, []),
        (.additional, [])
    ])
    
    // View Properties
    @State private var activeTab: TabModel = .full
    
    // Scroll Properties
    @State private var scrollOffset: CGFloat = 0
    @State private var topInset: CGFloat = 0
    @State private var startTopInset: CGFloat = 0
    
    // PERSONAL
    @State private var firstName: String = ""
    //    @State private var middleNameToggle: Bool = false
    //    @State private var middleName: String = ""
    @State private var lastName: String = ""
    
    @State private var position: String = ""
    
    @State private var citizenship: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    @State private var link1: String = "Linkedin.com/"
    @State private var link2: String = "Github.com/"
    
    // SUMMARY
    
    @State var summaryBullet1: String = ""
    @State var summaryBullet2: String = ""
    @State var summaryBullet3: String = ""
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        CustomTabBar(activeTab: $activeTab)
                            .padding(.vertical, 5)
                            .background {
                                let progress = min(max((scrollOffset + startTopInset - 62) / 15, 0), 1)
                                
                                ZStack(alignment: .bottom) {
                                    Rectangle()
                                        .fill(colorScheme == .light ? .white : .black)
                                    // Divider
                                    Rectangle()
                                        .fill(.gray.opacity(0.3))
                                        .frame(height: 1)
                                }
                                .padding(.top, -topInset)
                                .opacity(progress)
                            }
                        
                            .offset(y: (scrollOffset + topInset) > 0 ? (scrollOffset + topInset) : 0)
                            .zIndex(1000)
                        
                        // VIEW VIEW VIEW VIEW VIEW VIEW VIEW ------------------------
                        CustomFormView(
                            newPDFData: $newPDFData,
                            activeTab: $activeTab,
                            firstName: $firstName,
                            lastName: $lastName,
                            position: $position,
                            citizenship: $citizenship,
                            email: $email,
                            phoneNumber: $phoneNumber,
                            link1: $link1,
                            link2: $link2,
                            summaryBullet1: $summaryBullet1,
                            summaryBullet2: $summaryBullet2,
                            summaryBullet3: $summaryBullet3
                        )
                    }
                    .frame(height: proxy.size.height + 50)
                }
                
                
            }
            .ignoresSafeArea(edges: .bottom)
            .onScrollGeometryChange(for: CGFloat.self, of: {
                $0.contentOffset.y
            }, action: { oldValue, newValue in
                scrollOffset = newValue
            })
            .onScrollGeometryChange(for: CGFloat.self, of: {
                $0.contentInsets.top
            }, action: { oldValue, newValue in
                if startTopInset == .zero {
                    startTopInset = newValue
                }
                topInset = newValue
            })
            .navigationTitle(Text("Resume Data"))
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        }
        .background(Color.gray.ignoresSafeArea())
    }
    
    
    
}

struct CustomFormView: View {
    @Binding var newPDFData: MyNewPDFData
    
    // View Properties
    @Binding var activeTab: TabModel
    
    // PERSONAL
    @Binding var firstName: String
    //    @Binding private var middleNameToggle: Bool
    //    @Binding private var middleName: String
    @Binding var lastName: String
    
    @Binding var position: String
    
    @Binding var citizenship: String
    @Binding var email: String
    @Binding var phoneNumber: String
    
    @Binding var link1: String
    @Binding var link2: String
    
    // SUMMARY
    
    @Binding var summaryBullet1: String
    @Binding var summaryBullet2: String
    @Binding var summaryBullet3: String
    
    var body: some View {
        
        switch activeTab {
        case .personal:
            if activeTab == .personal {
                Form {
                    Section(header: Text("Candidate Personal Information")) {
                        TextField("First Name", text: $firstName)
                        //                                    HStack {
                        //                                        TextField(middleNameToggle ? "Middle Name" : "", text: $middleName).disabled(!middleNameToggle)
                        //                                        Toggle(middleNameToggle ? "" : "Middle Name", isOn: $middleNameToggle)
                        //                                    }
                        
                        TextField("Last Name", text: $lastName)
                    }
                    
                    Section {
                        TextField("Professional Role", text: $position)
                    } header: {
                        Text("Desired Position")
                    } footer: {
                        Text("Tip: Use one from the vacancy")
                    }
                    
                    Section(header: Text("Location and contacts")) {
                        TextField("Citizenship / Place of Living", text: $citizenship)
                        TextField("Email", text: $email)
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                    }
                    .submitLabel(.next)
                    
                    Section(header: Text("Links")) {
                        TextField("Linkedin", text: $link1)
                        TextField("Github", text: $link2)
                    }
                    
                    Button {
                        let header = firstName + " " + lastName + " | " + position
                        let personalData = citizenship + " | " + email + " | " + phoneNumber  + " | " + link1 + " | " + link2
                        
                        let checkResult = checkIfCategoryExists(newPDFdata: newPDFData, activeTab)
                        let categoryIndex = checkResult.1
                        
                        if checkResult.0 {
                            newPDFData.newPDFData[categoryIndex].1.append((.titleNoLine, header))
                            newPDFData.newPDFData[categoryIndex].1.append((.titleNoLine, personalData))
                            print("!!! DATA FOR \(activeTab.rawValue) already exists!")
                            print(newPDFData.newPDFData)
                        } else {
                            newPDFData.newPDFData[categoryIndex].1.append((.titleNoLine, header))
                            newPDFData.newPDFData[categoryIndex].1.append((.titleNoLine, personalData))
                            print("+++ SUCCESSFULLY ADDED NEW DATA FOR \(activeTab.rawValue)!")
                            print(newPDFData.newPDFData)
                        }
                    } label: {
                        Text("Add to this CV")
                    }
                }
                .fontDesign(.serif)
                .tint(activeTab.color)
                .zIndex(0)
            }
        case .summary:
            if activeTab == .summary {
                Form {
                    Section {
                        TextField("My experience in particular roles...", text: $summaryBullet1)
                        TextField("...industries, technologies, managment", text: $summaryBullet2)
                    } header: {
                        Text("Describe yourself as a professional")
                    } footer: {
                        Text("Tip: 1-3 specific examples (results, achievements) from my experience, that are highly relevant to the vacancy")
                    }
                    
                    Button {
                        let header = "Summary"
                        let bullet1 = "• " + summaryBullet1
                        let bullet2 = "• " + summaryBullet2
                        
                        let checkResult = checkIfCategoryExists(newPDFdata: newPDFData, activeTab)
                        let categoryIndex = checkResult.1
                        
                        if checkResult.0 {
                            print("!!! DATA FOR \(activeTab.rawValue) already exists!")
                            print(newPDFData.newPDFData)
                        } else {
                            newPDFData.newPDFData[categoryIndex].1.append((.titleNoLine, header))
                            newPDFData.newPDFData[categoryIndex].1.append((.bullet, bullet1))
                            newPDFData.newPDFData[categoryIndex].1.append((.bullet, bullet2))
                            print("+++ SUCCESSFULLY ADDED NEW DATA FOR \(activeTab.rawValue)!")
                            print(newPDFData.newPDFData)
                        }
                    } label: {
                        Text("Add to this CV")
                    }
                }
                .fontDesign(.serif)
                .tint(activeTab.color)
                .zIndex(0)
            }
        case .skills:
            Form {
                Text("Skills")
            }
            .fontDesign(.serif)
            .tint(activeTab.color)
            .zIndex(0)
        case .experience:
            Form {
                Text("Experience")
            }
            .fontDesign(.serif)
            .tint(activeTab.color)
            .zIndex(0)
        case .education:
            Form {
                Text("Education")
            }
            .fontDesign(.serif)
            .tint(activeTab.color)
            .zIndex(0)
        case .additional:
            Form {
                Text("Additional")
            }
            .fontDesign(.serif)
            .tint(activeTab.color)
            .zIndex(0)
        case .full:
            DataBankTry()
        }
        
        
    }
    
    func checkIfCategoryExists(newPDFdata: MyNewPDFData, _ activeTab: TabModel) -> (Bool, Int) {
        let categories = newPDFData.newPDFData
        for index in 0..<categories.count {
            if categories[index].0.rawValue == activeTab.rawValue {
                if !categories[index].1.isEmpty {
                    return (true, index)
                }
            }
        }
        return (false, 0)
    }
}


struct CustomTabBar: View {
    @Binding var activeTab: TabModel
    @State var scrollOffset: CGFloat = 0
    
    @Environment(\.colorScheme) private var scheme
    var body: some View {
        GeometryReader { _ in
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    HStack(spacing: activeTab == .full ? -20 : 4) {
                        ForEach(TabModel.allCases.filter({ $0 != .full }), id: \.rawValue) { tab in
                            ResizableTabButton(tab)
                        }
                    }
                    .offset(x: -findScrollOffset(activeTab)) // !!! YOUHOOOO
                    
                    if activeTab == .full {
                        ResizableTabButton(.full)
                            .transition(.offset(x: 200))
                    }
                }
                .padding(.horizontal, 15)
            }
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
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
            
            if activeTab == tab {
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .fontDesign(.serif)
                    .lineLimit(1)
            }
        }
        .foregroundStyle(tab == .full ? schemeColor : activeTab == tab ? .white : scheme == .light ? .black : .white)
        .frame(maxHeight: .infinity)
        .frame(maxWidth: activeTab == tab ? .infinity : nil)
        .padding(.horizontal, 20)
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
    
    func findScrollOffset(_ tab: TabModel) -> CGFloat {
        switch tab {
        case .personal: return 0
        case .summary: return 0
        case .skills: return 35
        case .experience: return 60
        case .education: return 104
        case .additional: return 108
        case .full: return 0
        }
    }
}

#Preview {
    ResumeDataView()
}
