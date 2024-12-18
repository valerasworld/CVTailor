//
//  PDFKitView.swift
//  CVTailor
//
//  Created by Valery Zazulin on 07/12/24.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let pdfDoc: PDFDocument
    
    init(pdfData pdfDoc: PDFDocument) {
        self.pdfDoc = pdfDoc
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDoc
        pdfView.autoScales = true
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdfDoc
    }
}

