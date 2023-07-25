import UIKit

final class TrackersCollectionSupplementaryView: UICollectionReusableView {
    lazy var headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            headerLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -28)
        ])
        
        headerLabel.font = UIFont.systemFont(ofSize: 19, weight: .bold)
       
    }
    
    private func applyCurrentTheme() {
        if traitCollection.userInterfaceStyle == .dark {
            headerLabel.textColor = .white
        } else if traitCollection.userInterfaceStyle == .light {
            headerLabel.textColor = R.Colors.trBlack
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *),
           traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            applyCurrentTheme()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

