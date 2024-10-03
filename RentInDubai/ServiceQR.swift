//
//  ServiceQR.swift
//  RentInDubai
//
//  Created by Гриша Шкробов on 20.08.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

struct QRCodeGenerator {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: .utf8)
        filter.correctionLevel = "L"
        filter.message = data!

        guard let outputImage = filter.outputImage else { return nil }
        
        let scaleX = 200 / outputImage.extent.size.width
        let scaleY = 200 / outputImage.extent.size.height
        
        let transformedImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        guard let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) else { return nil }
        
        return UIImage(cgImage: cgImage)
    }
}

struct QRCodeView: View {
    let qrCodeGenerator = QRCodeGenerator()
    let qrString: String

    var body: some View {
        if let qrCodeImage = qrCodeGenerator.generateQRCode(from: qrString) {
            Image(uiImage: qrCodeImage)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
        } else {
            Text("Не удалось сгенерировать QR-код")
        }
    }
}

struct QRCodeView_Previews: PreviewProvider {
    
    static var previews: some View {
        QRCodeView(qrString: "vfdsavcdscdsac")
    }
}

