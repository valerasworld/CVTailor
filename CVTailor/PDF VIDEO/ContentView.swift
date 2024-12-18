//
//  ContentView.swift
//  CVTailor
//
//  Created by Valery Zazulin on 07/12/24.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    var body: some View {
        VStack {
            PDFKitView(pdfData: PDFDocument(data: generatePDF())!)
        }
    }
    // 8.5 * 72
    // 11 * 72
    @MainActor
    private func generatePDF() -> Data {
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842)) // for A4 format
        
        let data = pdfRenderer.pdfData { context in
            context.beginPage()
            
            alignText(value: "Name Surname | Professinal role", x: 45, y: 50, width: 505, height: 150, alignment: .left, textFont: UIFont.systemFont(ofSize: 16, weight: .bold))
            alignText(value: "Name Surname | Professinal role", x: 45, y: 870, width: 505, height: 150, alignment: .left, textFont: UIFont.systemFont(ofSize: 16, weight: .bold))
            
            
            
        }
        return data
    }
    
    func alignText(value: String, x: Int, y: Int, width: Int, height: Int, alignment: NSTextAlignment, textFont: UIFont) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        let attributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        
        let textRect = CGRect(x: x, y: y, width: width, height: height)
        value.draw(in: textRect, withAttributes: attributes)
    }
}

#Preview {
    ContentView()
}
