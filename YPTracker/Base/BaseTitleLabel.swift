import UIKit

final class BaseTitleLabel: UILabel {
    
    init(title: String) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.textColor = R.Colors.trBlack
        self.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
