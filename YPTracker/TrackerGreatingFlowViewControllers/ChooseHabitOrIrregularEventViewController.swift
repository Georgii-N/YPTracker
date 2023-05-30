import UIKit

final class ChooseHabitOrIrregularEventViewController: UIViewController {
    let titleLabel = UILabel()
    let habitButton = BaseBlackButton(with: "Привычка")
    let irregularEventButton = BaseBlackButton(with: "Нерегулярное событие")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        constraintViews()
        configureAppearance()
    }
}

extension ChooseHabitOrIrregularEventViewController {
    
    private func addViews() {
        [titleLabel, habitButton, irregularEventButton].forEach(view.setupView)
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            habitButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 295),
            habitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            habitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            irregularEventButton.topAnchor.constraint(equalTo: habitButton.bottomAnchor, constant: 16),
            irregularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            irregularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
    private func configureAppearance() {
        view.backgroundColor = .white
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.text = "Создание трекера"
        
        habitButton.addTarget(self, action: #selector(didTappedHabitButton), for: .touchUpInside)
        irregularEventButton.addTarget(self, action: #selector(didTappedIrregularEventButton), for: .touchUpInside)
    }
    
    @objc private func didTappedHabitButton() {
        let createTrackerViewController = CreateTrackerViewController(classType: .regular)
        present(createTrackerViewController, animated: true)
    }
    
    @objc private func didTappedIrregularEventButton() {
        let createTrackerViewController = CreateTrackerViewController(classType: .irregular)
        present(createTrackerViewController, animated: true)
    }
}
