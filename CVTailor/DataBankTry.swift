//
//  DataBankTry.swift
//  CVTailor
//
//  Created by Valery Zazulin on 11/12/24.
//

import SwiftUI

struct DataBankTry: View {
    @Environment(\.colorScheme) var colorScheme
    @State var user = User()
    @State var isExpanded: Bool = false
    
    var body: some View {
        let data = user.docDataDemo
        
        List {
            UserInfoSectionView(data: data, isExpanded: isExpanded)
            .listRowSeparator(.hidden)
            
//            SummarySectionView(data: data, isExpanded: isExpanded)
//            .listRowSeparator(.hidden)
//            
//            SkillsSectionView(data: data, isExpanded: isExpanded)
//            .listRowSeparator(.hidden)
//            
//            ExperienceSectionView(data: data, isExpanded: isExpanded)
//            .listRowSeparator(.hidden)
            
            /*
             qualification: "Your Qualificaion 2",
             graduation: Date.now,
             university: "University Name 2",
             location: "City, Country",
             major: "Your major",
             minor: "Your minor"
             */
            
            DisclosureGroup(isExpanded: $isExpanded) {
                ForEach(data.educations, id: \.self) { education in
                    let educationTitle = "\(education.university)\n\(education.qualification)"
                    DisclosureGroup(isExpanded: $isExpanded) {
                        Text("")
                    } label: {
                        SectionLabelView(sectionTitle: educationTitle, hasLine: $isExpanded)
                    }
                }
            } label: {
                SectionLabelView(sectionTitle: "Education", hasLine: $isExpanded)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.grouped)
        .tint(colorScheme == .light ? .black : .white)
    }
}

struct UserInfoSectionView: View {
    
    @State var data: DataModel
    @State var isExpanded = false
    
    var body: some View {
        let userNameSectionTitle = data.firstName + " " + data.lastName + " | " + data.position
        
        DisclosureGroup(isExpanded: $isExpanded) {
            Group {
                Text(data.citizenship)
                Text(data.email)
                Text(data.phoneNumber)
                ForEach(data.links, id: \.self) { link in
                    Text(link)
                }
            }
            .font(.system(.body, design: .serif))
        } label: {
            SectionLabelView(sectionTitle: userNameSectionTitle, hasLine: $isExpanded)
        }
    }
}

struct SummarySectionView: View {
    
    @State var data: DataModel
    @State var isExpanded = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            ForEach(data.summaryBullets, id: \.self) { summaryBullet in
                Text(summaryBullet)
                    .font(.system(.body, design: .serif))
            }
        } label: {
            SectionLabelView(sectionTitle: "Summary", hasLine: $isExpanded)
        }
    }
}

struct SkillsSectionView: View {
    @State var data: DataModel
    @State var isExpanded = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            ForEach(data.skillsBullets, id: \.self) { skillBullet in
                Text(skillBullet)
                    .font(.system(.body, design: .serif))
            }
        } label: {
            SectionLabelView(sectionTitle: "Skills", hasLine: $isExpanded)
        }
    }
}

struct ExperienceSectionView: View {
    @State var data: DataModel
    @State var isExpanded = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            ForEach(data.experiences) { experience in
                ExperienceDisclosureGroupView(experience: experience, isExpanded: isExpanded)
            }
        } label: {
            SectionLabelView(sectionTitle: "Experience", hasLine: $isExpanded)
        }
    }
}


struct ExperienceDisclosureGroupView: View {
    @State var experience: Experience
    @State var isExpanded = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            Group {
                Group {
                    Text(dateFormated(date: experience.startTime))
                    + Text(" – ") +
                    Text(dateFormated(date: experience.endTime))
                }
                .font(.system(.body, design: .serif)).bold()
                
                Text(experience.companyDescription)
                    .font(.system(.body, design: .serif)).italic().bold()
            }
            .font(.system(.body, design: .serif))
            
            ForEach(experience.experienceBullets, id: \.self) { experienceBullet in
                Text(experienceBullet)
                    .font(.system(.body, design: .serif))
            }
        } label: {
            SectionLabelView(sectionTitle: "\(experience.position)\n\(experience.companyName)", hasLine: $isExpanded)
            
        }
    }
    
    func dateFormated(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: date)
    }
}



struct SectionLabelView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var sectionTitle: String
    @Binding var hasLine: Bool
    
    var body: some View {
        let hasLine = hasLine
        
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .foregroundStyle(colorScheme == .light ? .black : .white)
                .frame(height: 1)
                .frame(maxWidth: hasLine ? .infinity : 0)
            
            Text(sectionTitle)
                .font(.system(.title3, design: .serif)).bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
}


struct User {
    let docDataDemo: DataModel = DataModel(
        firstName: "Name",
        lastName: "Surname",
        position: "Professional Role",
        citizenship: "Citizenship",
        email: "test@gmail.com",
        phoneNumber: "+1234567890",
        links: [
            "Github.com/username",
            "Linkedin.com/username"
        ],
        summaryBullets: [
            "• My experience in particular roles, industries, technologies, managment ",
            "• 1-3 specific examples (results, achievements) from my experience, that are highly relevant to the vacancy"
        ],
        skillsBullets: [
            "• This stack of technologies",
            "• That stack of tools",
            "• And even used theese technologies (mention the technologies from the vacancy)"
        ],
        experiences: [
            Experience(
                position: "Position 1",
                companyName: "Company Name",
                location: "City, Country",
                startTime: Date.now,
                endTime: Date.now,
                companyDescription: "Brief description of the company, its' main purpose and size",
                experienceBullets: [
                    "• Main responsibilities and projects you've done",
                    "• Key results and/or achievements",
                    "• Stack and tools you used"
                ]),
            Experience(
                position: "Position 2",
                companyName: "Very Long Company Name",
                location: "City, Country",
                startTime: Date.now,
                endTime: Date.now,
                companyDescription: "Brief description of the company, its' main purpose and size",
                experienceBullets: [
                    "• Main responsibilities and projects you've done",
                    "• Key results and/or achievements",
                    "• Stack and tools you used"
                ]),
            Experience(
                position: "Position 3 (Very Very Very Long Name)",
                companyName: "Company Name",
                location: "City, Country",
                startTime: Date.now,
                endTime: Date.now,
                companyDescription: "Brief description of the company, its' main purpose and size",
                experienceBullets: [
                    "• Main responsibilities and projects you've done",
                    "• Key results and/or achievements",
                    "• Stack and tools you used"
                ])
        ],
        educations: [
            Education(
                qualification: "Your Qualificaion 1",
                graduation: Date.now,
                university: "University Name 1",
                location: "City, Country",
                major: "Your major",
                minor: "Your minor"
            ),
            Education(
                qualification: "Your Qualificaion 2",
                graduation: Date.now,
                university: "University Name 2",
                location: "City, Country",
                major: "Your major",
                minor: "Your minor"
            )
        ],
        additionalBlock: [
            Addition(
                additionName: "Addition 1 Name",
                description: [
                    "Description 1",
                    "Description 2",
                    "Description 3",
                    "Description 4",
                    "Description 5"
                ]
            ),
            Addition(
                additionName: "Addition 2 Name",
                description: [
                    "Description 1",
                    "Description 2",
                    "Description 3",
                    "Description 4",
                    "Description 5"
                ]
            )
        ]
    )
}
#Preview {
    DataBankTry(isExpanded: true)
}
