import UIKit

final class TrackersCollectionViewCell: UICollectionViewCell {
    lazy var cellView = UIView()
    lazy var emojiBackgroundView = UIView()
    lazy var emojiLabel = UILabel()
    lazy var cellTextLabel = UILabel()
    lazy var countOfDaysLabel = UILabel()
    lazy var trackerButton = UIButton()
    lazy var pinnedImageView = UIImageView()
    
    var delegate: TrackersViewControllerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        setupUI()
        applyCurrentTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyCurrentTheme() {
        if traitCollection.userInterfaceStyle == .dark {
            countOfDaysLabel.textColor = .white
            trackerButton.setTitleColor(R.Colors.trBlack, for: .normal)
        } else if traitCollection.userInterfaceStyle == .light {
            countOfDaysLabel.textColor = R.Colors.trBlack
            trackerButton.setTitleColor(.white, for: .normal)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *),
           traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            applyCurrentTheme()
        }
    }
}

extension TrackersCollectionViewCell {
    private func setupViews() {
        [   cellView,
            emojiBackgroundView,
            emojiLabel,
            cellTextLabel,
            countOfDaysLabel,
            trackerButton,
            pinnedImageView
        ].forEach(contentView.setupView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.heightAnchor.constraint(equalToConstant: 90),
            
            emojiBackgroundView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            emojiBackgroundView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 12),
            emojiBackgroundView.heightAnchor.constraint(equalToConstant: 24),
            emojiBackgroundView.widthAnchor.constraint(equalToConstant: 24),
            
            emojiLabel.centerXAnchor.constraint(equalTo: emojiBackgroundView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: emojiBackgroundView.centerYAnchor),
            
            pinnedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            pinnedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            
            cellTextLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            cellTextLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
            cellTextLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -12),
            
            countOfDaysLabel.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -16),
            countOfDaysLabel.leadingAnchor.constraint(equalTo: cellTextLabel.leadingAnchor),
            
            trackerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            trackerButton.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 8),
            trackerButton.heightAnchor.constraint(equalToConstant: 34),
            trackerButton.widthAnchor.constraint(equalToConstant: 34),
            trackerButton.centerYAnchor.constraint(equalTo: countOfDaysLabel.centerYAnchor)
        ])
    }
    
    private func setupUI() {
        cellView.layer.cornerRadius = 16
        
        emojiBackgroundView.layer.cornerRadius = 12
        emojiBackgroundView.backgroundColor = .white.withAlphaComponent(0.3)
        
        emojiLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        pinnedImageView.image = R.Images.Common.pinned
        pinnedImageView.isHidden = true
        
        cellTextLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        cellTextLabel.textColor = .white
        
        countOfDaysLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        countOfDaysLabel.text = "0 дней"
        
        trackerButton.layer.cornerRadius = 17
        trackerButton.setTitle("+", for: .normal)
        trackerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        trackerButton.setTitleColor(.white, for: .normal)
        trackerButton.addTarget(self, action: #selector(didTapTrackerButton), for: .touchUpInside)
    }
    
    func lockTrackerButton() {
        trackerButton.isEnabled = false
    }
    
    func unlockTrackerButton() {
        trackerButton.isEnabled = true
    }
    
    func markTrackerAsCompleted() {
        trackerButton.setTitle("✓", for: .normal)
        trackerButton.alpha = 0.3
    }
    
    func unmarkTrackerAsCompleted() {
        trackerButton.setTitle("+", for: .normal)
        trackerButton.alpha = 1
    }
    
    @objc func didTapTrackerButton() {
        if trackerButton.titleLabel?.text == "+" {
            markTrackerAsCompleted()
            delegate?.showTrackerIsCompleted(self)
        } else {
            unmarkTrackerAsCompleted()
            delegate?.showTrackerIsCompleted(self)
        }
    }
}
