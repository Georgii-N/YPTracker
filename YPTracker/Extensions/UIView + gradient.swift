import UIKit

extension UIView {
        func withGradienBackground(color1: UIColor, color2: UIColor, color3: UIColor) {
            let layerGradient = CAGradientLayer()

            layerGradient.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
            layerGradient.frame = bounds
            layerGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            layerGradient.endPoint = CGPoint(x: 1.0, y: 1.0)

            layer.insertSublayer(layerGradient, at: 0)
        }
}
