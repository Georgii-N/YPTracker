import UIKit

final class CreateTrackerTableViewCell: UITableViewCell {
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let selectedLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
        setupUI()
    }
    
    private func setupViews() {
        contentView.setupView(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(selectedLabel)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -41),
            
            titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            selectedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            selectedLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            selectedLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
    }
    
    private func setupUI() {
        titleLabel.textColor = R.Colors.trBlack
        selectedLabel.textColor = R.Colors.trGray
        self.backgroundColor = R.Colors.trBackgroundDay.withAlphaComponent(0.3)
        
        stackView.spacing = 2
        stackView.axis = .vertical
    
    }
}

