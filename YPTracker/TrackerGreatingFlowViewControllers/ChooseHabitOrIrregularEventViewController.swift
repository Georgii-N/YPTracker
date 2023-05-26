import UIKit

final class ChooseHabitOrIrregularEventViewController: UIViewController {
    let titleLable = UILabel()
    let habitButton = BaseButton(with: "Привычка")
    let irregularEventButton = BaseButton(with: "Нерегулярное событие")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        constraintViews()
        configureAppearance()
    }
}

extension ChooseHabitOrIrregularEventViewController {
    
    private func addViews() {
        [titleLable, habitButton, irregularEventButton].forEach(view.setupView)
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            habitButton.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 295),
            habitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            habitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            irregularEventButton.topAnchor.constraint(equalTo: habitButton.bottomAnchor, constant: 16),
            irregularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            irregularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
    private func configureAppearance() {
        view.backgroundColor = .white
        
        titleLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLable.text = "Создание трекера"
    }
}
