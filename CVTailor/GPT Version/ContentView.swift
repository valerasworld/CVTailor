//
//  ContentView.swift
//  CVTailor
//
//  Created by Valery Zazulin on 09/12/24.
//

import SwiftUI
import PDFKit

// DataModel
struct DataModel {
    var firstName: String
    var lastName: String
    var position: String
    var citizenship: String
    var email: String
    var phoneNumber: String
    var links: [String]
    
    var summaryBullets: [String]
    var skillsBullets: [String]
    var experiences: [Experience]
    var educations: [Education]
    var additionalBlock: [Addition]
}

struct Experience: Identifiable {
    var id = UUID()
    var position: String
    var companyName: String
    var location: String
    var startTime: Date
    var endTime: Date
    var companyDescription: String
    var experienceBullets: [String]
}

struct Education: Identifiable, Hashable {
    var id = UUID()
    var qualification: String
    var graduation: Date
    var university: String
    var location: String
    var major: String
    var minor: String
}

struct Addition {
    var additionName: String
    var description: [String]
}

// 1️⃣ Функция для создания PDF-документа с динамическим размещением текста
enum PageFormat {
    case a4, letter
}



func createSamplePDF(pageFormat: PageFormat) -> PDFDocument {
    
    let pdfData = NSMutableData()
    var pageWidth: CGFloat {
        switch pageFormat {
        case .a4: 595.2
        case .letter: 8.5 * 72
        }
    }
    var pageHeight: CGFloat {
        switch pageFormat {
        case .a4: 841.8
        case .letter: 11 * 72
        }
    }
    let pageRect = CGRect(
        x: 0,
        y: 0,
        width: pageWidth,
        height: pageHeight
    )
    
    // 1️⃣ Начинаем PDF-контекст и создаём страницу
    UIGraphicsBeginPDFContextToData(pdfData, pageRect, nil)
    UIGraphicsBeginPDFPageWithInfo(pageRect, nil)
    
    // 2️⃣ Проверяем, что контекст существует
    guard let context = UIGraphicsGetCurrentContext() else {
        print("Ошибка: Контекст не найден")
        return PDFDocument()
    }
    
    // 3️⃣ Список текстовых блоков для отображения
    let newPDFData = MyNewPDFData().newPDFData
    
    func findFontDescriptor(_ textKind: TextKind) -> UIFontDescriptor {
        let regularFont = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withDesign(.serif)!
        let boldFont = regularFont.withSymbolicTraits(.traitBold)!
        //        let italicFont = regularFont.withSymbolicTraits(.traitItalic)!
        let boldItalicTraits: UIFontDescriptor.SymbolicTraits = [.traitBold, .traitItalic] // объединяем признаки
        let boldItalicFont = regularFont.withSymbolicTraits(boldItalicTraits)!
        
        switch textKind {
        case .titleNoLine, .titleUnderlined, .experience, .education:
            return boldFont
        case .companyDescription:
            return boldItalicFont
        default:
            return regularFont
        }
    }
    
    func findFontSize(_ textKind: TextKind) -> CGFloat {
        switch textKind {
        case .titleNoLine, .titleUnderlined, .experience, .education:
            return 13
        default:
            return 11
        }
    }
    
    func findVerticalSpacing(_ categoryTexts: [(TextKind, String)], index: Int) -> CGFloat {
        let lastIndex = categoryTexts.count - 1
        
        guard index != lastIndex else {
            return 10
        }
        let currentTextKind = categoryTexts[index].0
        let nextTextKind = categoryTexts[index + 1].0
        
        if currentTextKind == .experience {
            return 4
        }
        if currentTextKind == .titleUnderlined {
            return 8
        }
        if currentTextKind == .shiftedBullet && nextTextKind != .shiftedBullet {
            return 8
        }
        
        return 0
    }
    
    func findTextShift(_ textKind: TextKind) -> CGFloat {
        if textKind == .shiftedBullet || textKind == .companyDescription {
            return 20
        }
        return 0
    }
    
    // 5️⃣ Начальная позиция для текста (начинаем сверху страницы)
    var currentY: CGFloat = 50 // 50 точек от верхнего края страницы
    
    for category in newPDFData {
        for index in 0..<category.1.count {
            let tuple = category.1[index]
            let textKind = tuple.0
            let text = tuple.1
            
            // 4️⃣ Настройки шрифта
            let fontDescriptor: UIFontDescriptor = findFontDescriptor(textKind)
            
            let serifFont = UIFont(
                descriptor: fontDescriptor,
                size: findFontSize(textKind)
            )
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textKind == .date ? .right : .left
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: serifFont,
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle
            ]
            
            let verticalSpacing: CGFloat = findVerticalSpacing(category.1, index: index) // Отступ между текстовыми блоками
            let textShift = findTextShift(textKind)
            // 6️⃣ Вычисляем размер текста
            let textWidth = pageWidth - 100 - textShift // Отступы по 50 с каждой стороны + textShift in case of shiftedBullet
            let textRect = CGRect(
                x: 50 + textShift,
                y: currentY,
                width: textWidth,
                height: .greatestFiniteMagnitude // sets an extremely large height (but not infinity) to allow text content to determine its own required size
            )
            
            let boundingBox = text.boundingRect(
                with: textRect.size,
                options: [.usesLineFragmentOrigin, .usesFontLeading], // Ensure the text layout accounts for multi-line wrapping and line spacing (leading)
                attributes: attributes,
                context: nil
            )
            let textHeight = ceil(boundingBox.height) // ceil - Round UP to the nearest whole number to prevent visual artifacts and avoid clipping of text
            let adjustedRect = CGRect(
                x: 50 + textShift,
                y: currentY,
                width: textWidth,
                height: textHeight
            )
            
            // 7️⃣ Рисуем текст
            text.draw(in: adjustedRect, withAttributes: attributes)
            
            if textKind == .titleUnderlined {
                // LINE LINE LINE LINE LINE LINE LINE
                context.setLineWidth(1)
                context.setStrokeColor(UIColor.black.cgColor)
                context.move(to: CGPoint(x: 50, y: currentY + textHeight))
                context.addLine(to: CGPoint(x: pageWidth - 50, y: currentY + textHeight))
                context.strokePath()
            }
            
            // 8️⃣ Обновляем позицию для следующего текста (увеличиваем Y, а не уменьшаем)
            let isDate = textKind == .date
            currentY += isDate ? 0 : textHeight + verticalSpacing
            
        }
    }
    
    // 9️⃣ Завершаем PDF-контекст
    UIGraphicsEndPDFContext()
    
    // 🔟 Преобразуем PDF-данные в PDFDocument
    guard let document = PDFDocument(data: pdfData as Data) else {
        print("Error: Impossible to create PDFDocument from data")
        return PDFDocument()
    }
    
    return document
}

// 2️⃣ PDFViewer — отображает PDF-документ
struct PDFViewer: UIViewRepresentable {
    let document: PDFDocument
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        pdfView.autoScales = true // Automatically scales the PDF to fit the view's size
        pdfView.document = document
        
        // Устанавливаем ограничения на масштабирование после загрузки
        DispatchQueue.main.async {
            let initialScaleFactor = pdfView.scaleFactor
            pdfView.minScaleFactor = initialScaleFactor * 0.9 // Минимальный зум (в 2 раза меньше)
            pdfView.maxScaleFactor = initialScaleFactor * 2.0 // Максимальный зум (в 2 раза больше)
            pdfView.scaleFactor = initialScaleFactor // Устанавливаем изначальный масштаб
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {}
}

// 3️⃣ SwiftUI ContentView для просмотра PDF
struct ContentView: View {
    var body: some View {
        VStack {
            PDFViewer(document: createSamplePDF(pageFormat: .a4))
                .frame(height: 700) // Высота PDF-просмотра
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

// 4️⃣ Превью для SwiftUI
struct ContentViewViewView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyNewPDFData {
    var newPDFData: [(Category, [(TextKind, String)])] = [
        (.personal, [
            (.titleUnderlined, "Name Surname | Professional Role"),
            (.personalInfo, "Citizenship | test@gmail.com | +1234567890 | Linkedin.com/username | Github.com/username")
        ]),
        
        (.summary, [
            (.titleUnderlined, "Summary"),
            (.bullet, "• My experience in particular roles, industries, technologies, managment"),
            (.bullet, "• 1-3 specific examples (results, achievements) from my experience, that are highly relevant to the vacancy")
        ]),
        
        (.skills, [
            (.titleUnderlined, "Skills"),
            (.bullet, "• This stack of technologies"),
            (.bullet, "• That stack of tools"),
            (.bullet, "• And even used theese technologies (mention the technologies from the vacancy)")
        ]),
        
        (.experience, [
            (.titleUnderlined, "Experience"),
            (.date, "Mon YYYY – Mon YYYY"),
            (.experience, "Position 1 | Company Name"),
            (.companyDescription, "Brief description of the company, its' main purpose and  size"),
            (.shiftedBullet, "• Main responsibilities and projects you've done"),
            (.shiftedBullet, "• Key results and/or achievements"),
            (.shiftedBullet, "• Stack and tools you used"),
            (.date, "Mon YYYY – Mon YYYY"),
            (.experience, "Position 2 with very very very long name\nCompany 2 with very very   very very very very long name"),
            (.companyDescription, "Brief description of the company, its' main purpose and  size"),
            (.shiftedBullet, "• Main responsibilities and projects you've done"),
            (.shiftedBullet, "• Key results and/or achievements"),
            (.shiftedBullet, "• Stack and tools you used"),
            (.date, "Mon YYYY – Mon YYYY"),
            (.experience, "Position 3 | Company Name"),
            (.companyDescription, "Brief description of the company, its' main purpose and  size"),
            (.shiftedBullet, "• Main responsibilities and projects you've done"),
            (.shiftedBullet, "• Key results and/or achievements"),
            (.shiftedBullet, "• Stack and tools you used"),
        ]),
        
        (.education, [
            (.titleUnderlined, "Education"),
            (.date, "Mon YYYY – Mon YYYY"),
            (.experience, "Position 3 | Company Name"),
            (.companyDescription, "Brief description of the company, its' main purpose and size"),
            (.shiftedBullet, "• Main responsibilities and projects you've done"),
            (.shiftedBullet, "• Key results and/or achievements"),
            (.shiftedBullet, "• Stack and tools you used")
        ])
    ]
}

enum TextKind: Hashable {
    case titleNoLine, titleUnderlined, bullet, shiftedBullet, date, experience, education, personalInfo, companyDescription
}

enum Category: String, CaseIterable, Hashable {
    case personal = "Personal"
    case summary = "Summary"
    case skills = "Skills"
    case experience = "Experience"
    case education = "Education"
    case additional = "Additional"
}
