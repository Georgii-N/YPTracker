import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    lazy var label = UILabel()
    lazy var switcher = UISwitch()
    
    var delegate: ScheduleViewControllerCellDelegateProtocol?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
        setupUI()
    }
    
    private func setupViews() {
        contentView.setupView(label)
        contentView.setupView(switcher)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.widthAnchor.constraint(equalToConstant: 244),
            
            switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            switcher.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
    
    private func setupUI() {
        contentView.backgroundColor = R.Colors.trBackgroundDay.withAlphaComponent(0.3)
        
        switcher.onTintColor = .systemBlue
        switcher.addTarget(self,
                           action: #selector(didChangeSwitcherValue),
                           for: .valueChanged)
        
    }
    
    @objc
    func didChangeSwitcherValue() {
        delegate?.refreshSelectedDaysArray(cell: self)
    }
}
