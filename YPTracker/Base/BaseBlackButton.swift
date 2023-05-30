import UIKit

final class BaseBlackButton: UIButton {
    let labelText: String
    
    init(with title: String) {
        self.labelText = title
        super.init(frame: .zero)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAppearance() {
        self.backgroundColor = R.Colors.trBlack
        self.setTitle(labelText, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 16
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
