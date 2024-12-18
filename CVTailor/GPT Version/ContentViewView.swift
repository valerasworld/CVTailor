////
////  ContentViewView.swift
////  CVTailor
////
////  Created by Valery Zazulin on 09/12/24.
////
//
//import SwiftUI
//import PDFKit
//
//// DataModel
//struct DataModel {
//    var firstName: String
//    var lastName: String
//    var position: String
//    var citizenship: String
//    var email: String
//    var phoneNumber: String
//    var links: [String]
//    
//    var summaryBullets: [String]
//    var skillsBullets: [String]
//    var experiences: [Experience]
//    var educations: [Education]
//    var additionalBlock: [Addition]
//}
//
//struct Experience: Identifiable {
//    var id = UUID()
//    var position: String
//    var companyName: String
//    var location: String
//    var startTime: Date
//    var endTime: Date
//    var companyDescription: String
//    var experienceBullets: [String]
//}
//
//struct Education: Identifiable, Hashable {
//    var id = UUID()
//    var qualification: String
//    var graduation: Date
//    var university: String
//    var location: String
//    var major: String
//    var minor: String
//}
//
//struct Addition {
//    var additionName: String
//    var description: [String]
//}
//
//// 1️⃣ Функция для создания PDF-документа с динамическим размещением текста
//enum PageFormat {
//    case a4
//    case letter
//}
//
//enum Textblock {
//    case title
//    case header
//    case bullet
//    case companyDescription
//    case shiftedBullet
//}
//
//func createSamplePDF(pageFormat: PageFormat) -> PDFDocument {
//    
//    let pdfData = NSMutableData()
//    var pageWidth: CGFloat {
//        switch pageFormat {
//        case .a4: 595.2
//        case .letter: 8.5 * 72
//        }
//    }
//    var pageHeight: CGFloat {
//        switch pageFormat {
//        case .a4: 841.8
//        case .letter: 11 * 72
//        }
//    }
//    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
//    
//    // 1️⃣ Начинаем PDF-контекст и создаём страницу
//    UIGraphicsBeginPDFContextToData(pdfData, pageRect, nil)
//    UIGraphicsBeginPDFPageWithInfo(pageRect, nil)
//    
//    // 2️⃣ Проверяем, что контекст существует
//    guard UIGraphicsGetCurrentContext() != nil else {
//        print("Ошибка: Контекст не найден")
//        return PDFDocument()
//    }
//    
//    // 3️⃣ Список текстовых блоков для отображения
//    let texts = [
//        "Hello, this is a preview of the PDF in Xcode Canvas!",
//        "This is the second block of text, which might be longer and span multiple lines.",
//        "Here is a third paragraph that demonstrates how dynamic layout works.",
//        "Here is some really long text that should span multiple lines to showcase the bounding rect calculation and how the dynamic layout ensures it all fits properly in the document."
//    ]
//    
//    // 4️⃣ Настройки шрифта
//    let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(.serif)?.withSymbolicTraits(.traitBold)
//    let serifFont = UIFont(descriptor: fontDescriptor!, size: 22)
//    let attributes: [NSAttributedString.Key: Any] = [
//        .font: serifFont,
//        .foregroundColor: UIColor.black
//    ]
//    
//    // 5️⃣ Начальная позиция для текста (начинаем сверху страницы)
//    var currentY: CGFloat = 50 // 50 точек от верхнего края страницы
//    let verticalSpacing: CGFloat = 12 // Отступ между текстовыми блоками
//    
//    for text in texts {
//        // 6️⃣ Вычисляем размер текста
//        let textWidth = pageWidth - 100 // Отступы по 50 с каждой стороны
//        let textRect = CGRect(x: 50, y: currentY, width: textWidth, height: .greatestFiniteMagnitude) // .gretFinMagn.. sets an extremely large height (but not infinity) to allow text content to determine its own required size
//        
//        let boundingBox = text.boundingRect(
//            with: textRect.size,
//            options: [.usesLineFragmentOrigin, .usesFontLeading], // Ensure the text layout accounts for multi-line wrapping and line spacing (leading)
//            attributes: attributes,
//            context: nil
//        )
//        
//        let textHeight = ceil(boundingBox.height) // ceil - Round UP to the nearest whole number to prevent visual artifacts and avoid clipping of text
//        let adjustedRect = CGRect(x: 50, y: currentY, width: textWidth, height: textHeight)
//        
//        // 7️⃣ Рисуем текст
//        text.draw(in: adjustedRect, withAttributes: attributes)
//        
//        // 8️⃣ Обновляем позицию для следующего текста (увеличиваем Y, а не уменьшаем)
//        currentY += textHeight + verticalSpacing
//    }
//    
//    // 9️⃣ Завершаем PDF-контекст
//    UIGraphicsEndPDFContext()
//    
//    // 🔟 Преобразуем PDF-данные в PDFDocument
//    guard let document = PDFDocument(data: pdfData as Data) else {
//        print("Error: Impossible to create PDFDocument from data")
//        return PDFDocument()
//    }
//    
//    return document
//}
//
//// 2️⃣ PDFViewer — отображает PDF-документ
//struct PDFViewer: UIViewRepresentable {
//    let document: PDFDocument
//    
//    func makeUIView(context: Context) -> PDFView {
//        let pdfView = PDFView()
//        
//        pdfView.autoScales = true // Automatically scales the PDF to fit the view's size
//        pdfView.document = document
//        
//        // Устанавливаем ограничения на масштабирование после загрузки
//        DispatchQueue.main.async {
//            let initialScaleFactor = pdfView.scaleFactor
//            pdfView.minScaleFactor = initialScaleFactor * 0.9 // Минимальный зум (в 2 раза меньше)
//            pdfView.maxScaleFactor = initialScaleFactor * 2.0 // Максимальный зум (в 2 раза больше)
//            pdfView.scaleFactor = initialScaleFactor // Устанавливаем изначальный масштаб
//        }
//        
//        return pdfView
//    }
//    
//    func updateUIView(_ uiView: PDFView, context: Context) {}
//}
//
//// 3️⃣ SwiftUI ContentView для просмотра PDF
//struct ContentViewView: View {
//    var body: some View {
//        VStack {
//            PDFViewer(document: createSamplePDF(pageFormat: .a4))
//                .frame(height: 700) // Высота PDF-просмотра
//            
//            Spacer()
//        }
//        .ignoresSafeArea()
//    }
//}
//
//// 4️⃣ Превью для SwiftUI
//struct ContentViewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViewView()
//    }
//}
//
//
