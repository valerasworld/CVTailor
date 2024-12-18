//
//  Untitled.swift
//  CVTailor
//
//  Created by Valery Zazulin on 05/12/24.
//

import SwiftUI
import PDFKit


@MainActor
struct PDFTry: View {
    @State private var pdfURL: URL?
    @State private var isVisible = true
    var body: some View {
        VStack{
            
//            PDFDataView()
            if isVisible {
                Document()
            }
            Button("Generate PDF") {
                pdfURL = generatePDF()
                isVisible.toggle()
            }
            .padding()
            if let pdfURL = pdfURL {
                PDFKitView(url: pdfURL)
                
                
                ShareLink("Export PDF", item: pdfURL)
            }
        }
    }
    
    
    // PDF Viewer
    struct PDFKitView: UIViewRepresentable {
        
        let url: URL
        
        func makeUIView(context: Context) -> PDFView {
            let pdfView = PDFView()
            pdfView.document = PDFDocument(url: self.url)
            pdfView.autoScales = true
            return pdfView
        }
        
        func updateUIView(_ pdfView: PDFView, context: Context) {
            // Update pdf if needed
        }
    }
    
    
    // generate pdf from given view
    func generatePDF() -> URL {
        //  Select UI View to render as pdf
        let renderer = ImageRenderer(content: Document())
        
        let url = URL.documentsDirectory.appending(path: "generatedPDF.pdf")
       
        renderer.render { size, context in
            var pdfDimension = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            guard let pdf = CGContext(url as CFURL, mediaBox: &pdfDimension, nil) else {
                return
            }
            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
}

#Preview {
    PDFTry()
}
