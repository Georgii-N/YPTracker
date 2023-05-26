import UIKit

final class TrackersNavBar: UIView {
    lazy var plusButton = UIButton()
    private lazy var textLabel = UILabel()
    lazy var datePicker = UIDatePicker()
    lazy var searchTextField = UISearchTextField()
    
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

extension TrackersNavBar {
    private func addViews() {
        [plusButton, textLabel, datePicker, searchTextField].forEach(self.setupView)
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            plusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            
            textLabel.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 13),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            datePicker.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            
            searchTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 7),
            searchTextField.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: datePicker.trailingAnchor),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func configureAppearance() {
        plusButton.setImage(R.Images.NavBar.plusIcon, for: .normal)
        
        textLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        textLabel.text = "Трекеры"
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        
        searchTextField.text = "Поиск..."
        searchTextField.textColor = R.Colors.trGray
    }
}
