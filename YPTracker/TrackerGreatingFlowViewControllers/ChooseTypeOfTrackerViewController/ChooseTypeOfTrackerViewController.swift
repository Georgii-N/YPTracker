import UIKit

final class ChooseTypeOfTrackerViewController: UIViewController {
    let titleLabel = BaseTitleLabel(title: "Создание трекера")
    let habitButton = BaseBlackButton(with: "Привычка")
    let irregularEventButton = BaseBlackButton(with: "Нерегулярное событие")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        constraintViews()
        configureAppearance()
    }
}

extension ChooseTypeOfTrackerViewController {
    
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
        
        habitButton.addTarget(self, action: #selector(didTappedHabitButton), for: .touchUpInside)
        irregularEventButton.addTarget(self, action: #selector(didTappedIrregularEventButton), for: .touchUpInside)
    }
    
    @objc private func didTappedHabitButton() {
        let createTrackerViewController = CreateTrackerViewController(classType: .regular)
        let createTrackerPresenter = CreateTrackerPresenter()
        createTrackerViewController.presenter = createTrackerPresenter
        createTrackerPresenter.view = createTrackerViewController
        present(createTrackerViewController, animated: true)
    }
    
    @objc private func didTappedIrregularEventButton() {
        let createTrackerViewController = CreateTrackerViewController(classType: .irregular)
        let createTrackerPresenter = CreateTrackerPresenter()
        createTrackerViewController.presenter = createTrackerPresenter
        createTrackerPresenter.view = createTrackerViewController
        present(createTrackerViewController, animated: true)
    }
}
