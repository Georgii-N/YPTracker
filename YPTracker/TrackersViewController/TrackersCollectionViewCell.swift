import UIKit

final class TrackersCollectionViewCell: UICollectionViewCell {
    lazy var cellView = UIView()
    lazy var emojiBackgroundView = UIView()
    lazy var emojiLabel = UILabel()
    lazy var cellTextLabel = UILabel()
    lazy var countOfDaysLabel = UILabel()
    lazy var statesButton = UIButton()
    
    var delegate: TrackersViewControllerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TrackersCollectionViewCell {
    private func addViews() {
        [   cellView,
            emojiBackgroundView,
            emojiLabel,
            cellTextLabel,
            countOfDaysLabel,
            statesButton
        ].forEach(contentView.setupView)
    }
    
    private func constraintViews() {
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
            
            cellTextLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            cellTextLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
            cellTextLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -12),
            
            countOfDaysLabel.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -16),
            countOfDaysLabel.leadingAnchor.constraint(equalTo: cellTextLabel.leadingAnchor),
            
            statesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            statesButton.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 8),
            statesButton.heightAnchor.constraint(equalToConstant: 34),
            statesButton.widthAnchor.constraint(equalToConstant: 34),
            statesButton.centerYAnchor.constraint(equalTo: countOfDaysLabel.centerYAnchor)
        ])
    }
    
    private func configureAppearance() {
        cellView.layer.cornerRadius = 16
        
        emojiBackgroundView.layer.cornerRadius = 12
        emojiBackgroundView.backgroundColor = .white.withAlphaComponent(0.3)
        
        emojiLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        
        cellTextLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        cellTextLabel.textColor = .white
        
        countOfDaysLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        countOfDaysLabel.textColor = R.Colors.trBlack
        countOfDaysLabel.text = "0 дней"
        
        statesButton.layer.cornerRadius = 17
        statesButton.setTitle("+", for: .normal)
        statesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        statesButton.setTitleColor(.white, for: .normal)
        statesButton.addTarget(self, action: #selector(trackerIsCompleted), for: .touchUpInside)
    }
    
    func lockStatesButton() {
        statesButton.isEnabled = false
    }
    
    func unlockStatesButton() {
        statesButton.isEnabled = true
    }
    
    func statesButtonTappedToCompleted() {
        statesButton.setTitle("✓", for: .normal)
        statesButton.alpha = 0.3
    }
    
    func statesButtonTappedToDeselect() {
        statesButton.setTitle("+", for: .normal)
        statesButton.alpha = 1
    }
    
    @objc func trackerIsCompleted() {
      
        if statesButton.titleLabel?.text == "+" {
            statesButtonTappedToCompleted()
            delegate?.trackerIsCompleted(self)
        } else {
            statesButtonTappedToDeselect()
            delegate?.trackerIsCompleted(self)
        }
    }
}

