import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    lazy var label = UILabel()
    lazy var switcher = UISwitch()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addViews()
        constraintViews()
        configureAppearance()
    }
    
    private func addViews() {
        contentView.setupView(label)
        contentView.setupView(switcher)
        
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 244),
            
            switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            switcher.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
    private func configureAppearance() {
        contentView.backgroundColor = R.Colors.trBackgroundDay.withAlphaComponent(0.3)
        
        switcher.onTintColor = .systemBlue
    }
}
