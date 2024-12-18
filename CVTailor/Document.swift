//
//  Document.swift
//  CVTailor
//
//  Created by Valery Zazulin on 05/12/24.
//

import SwiftUI

struct Document: View {
    var body: some View {
        // Document Data
        VStack(alignment: .leading, spacing: 8) {
            // Header + Links
            VStack(alignment: .leading) {
                Text("Name Surname | Professinal role")
                    .font(.system(.footnote, design: .serif)).bold()
                Text("[test@mail.com](mailto:test@mail.com) | +79856125105 | [Linkedin](https://linkedin.com) | [Github](https://github.com)")
                    .font(.system(.caption2, design: .serif))
            }
            
            // Summary
            VStack(alignment: .leading, spacing: 4) {
                // summary header
                ZStack(alignment: .bottomLeading) {
                    Text("Summary")
                        .font(.system(.footnote, design: .serif))
                    
                    Rectangle()
                        .frame(height: 1)
                        .offset(y: 1)
                }
                // summary bullets
                VStack(alignment: .leading) {
                    Text("• My experience in particular roles, industries, technologies, managment ")
                        
                    Text("• 1-3 specific examples (results, achievements) from my experience, that are highly relevant to the vacancy")
                        
                }
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 320, alignment: .leading)
                .font(.system(.caption2, design: .serif))
                
            }
            
            // Skills
            VStack(alignment: .leading, spacing: 4) {
                // skills header
                ZStack(alignment: .bottomLeading) {
                    Text("Skills")
                        .font(.system(.footnote, design: .serif))
                    
                    Rectangle()
                        .frame(height: 1)
                        .offset(y: 1)
                }
                // skills bullets
                VStack(alignment: .leading) {
                    Text("• This stack of technologies")
                    Text("• That stack of tools")
                    Text("• And even used theese technologies (mention the technologies from the vacancy)")
                }
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 320, alignment: .leading)
                .font(.system(.caption2, design: .serif))
            }
            
            // Experience
            VStack(alignment: .leading, spacing: 4) {
                // experience header
                ZStack(alignment: .bottomLeading) {
                    Text("Experience")
                        .font(.system(.footnote, design: .serif))
                    
                    Rectangle()
                        .frame(height: 1)
                        .offset(y: 1)
                }
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Postion header
                        HStack {
                            Group {
                                Text("Position 1")
                                +
                                Text(" | ")
                                +
                                Text("Company Name")
                            }
                            Spacer()
                            Text("Month YYYY – Month YYYY")
                                .font(.system(.caption2, design: .serif))
                        }
                        
                        Text("Brief description of the company, its' main purpose and size")
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 320, alignment: .leading)
                            .font(.system(.caption2, design: .serif)).italic()
                        
                    }
                    .font(.system(.caption, design: .serif)).bold()
                    // experience bullets
                    VStack(alignment: .leading) {
                        Text("• Main responsibilities and projects you've done")
                        Text("• Key results and/or achievements")
                        Text("• Stack and tools you used")
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 320, alignment: .leading)
                    .font(.system(.caption2, design: .serif))
                    .padding(.leading, 16)
                }
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Postion header
                        HStack {
                            Group {
                                Text("Position 2")
                                +
                                Text(" | ")
                                +
                                Text("Company Name")
                            }
                            Spacer()
                            Text("Month YYYY – Month YYYY")
                                .font(.system(.caption2, design: .serif))
                        }
                        
                        Text("Brief description of the company, its' main purpose and size")
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 320, alignment: .leading)
                            .font(.system(.caption2, design: .serif)).italic()
                        
                    }
                    .font(.system(.caption, design: .serif)).bold()
                    // experience bullets
                    VStack(alignment: .leading) {
                        Text("• Main responsibilities and projects you've done")
                        Text("• Key results and/or achievements")
                        Text("• Stack and tools you used")
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 320, alignment: .leading)
                    .font(.system(.caption2, design: .serif))
                    .padding(.leading, 16)
                }
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0) {
                        // Postion header
                        HStack {
                            Group {
                                Text("Position 3")
                                +
                                Text(" | ")
                                +
                                Text("Company Name")
                            }
                            Spacer()
                            Text("Month YYYY – Month YYYY")
                                .font(.system(.caption2, design: .serif))
                        }
                        
                        Text("Brief description of the company, its' main purpose and size")
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 320, alignment: .leading)
                            .font(.system(.caption2, design: .serif)).italic()
                        
                    }
                    .font(.system(.caption, design: .serif)).bold()
                    // experience bullets
                    VStack(alignment: .leading) {
                        Text("• Main responsibilities and projects you've done")
                        Text("• Key results and/or achievements")
                        Text("• Stack and tools you used")
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 320, alignment: .leading)
                    .font(.system(.caption2, design: .serif))
                    .padding(.leading, 16)
                }
            }
            
            // Education
            VStack {
                
            }
            
            // Additional block
            VStack {
                
            }
        }
        .frame(maxWidth: 595, maxHeight: 842)
        .padding(.horizontal, 40)
        .padding(.vertical, 60)
        
    }
}

#Preview {
    Document()
}
