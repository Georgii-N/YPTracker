import UIKit

final class CategoryCell: UITableViewCell {
    lazy var titleLabel = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
        setupUI()
    }
    
    private func setupViews() {
        contentView.setupView(titleLabel)
       
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupUI() {
        titleLabel.textColor = R.Colors.trBlack
        self.backgroundColor = R.Colors.trBackgroundDay.withAlphaComponent(0.3)
    }
}
