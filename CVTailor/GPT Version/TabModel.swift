//
//  TabModel.swift
//  CVTailor
//
//  Created by Valery Zazulin on 18/12/24.
//
import SwiftUI

enum TabModel: String, CaseIterable, Hashable {
    case personal = "Personal"
    case summary = "Summary"
    case skills = "Skills"
    case experience = "Experience"
    case education = "Education"
    case additional = "Additional"
    case full = "Full"
    
    var color: Color {
        switch self {
        case .personal: .blue
        case .summary: .green
        case .skills: .indigo
        case .experience: .pink
        case .education: .orange
        case .additional: .teal
        case .full: Color.primary
        }
    }

    var symbolImage: String {
        switch self {
        case .personal: "person"
        case .summary: "waveform"
        case .skills: "star"
        case .experience: "briefcase"
        case .education: "graduationcap"
        case .additional: "asterisk"
        case .full: "paperplane"
        }
    }
}
