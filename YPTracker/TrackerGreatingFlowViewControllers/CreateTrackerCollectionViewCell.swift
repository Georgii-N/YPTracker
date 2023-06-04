import UIKit

final class CreateTrackerCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let colorView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 12
    }

    func setTitleLable() {
        self.contentView.setupView(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
    
    func setColorView() {
        self.contentView.setupView(colorView)
        colorView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            colorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}
