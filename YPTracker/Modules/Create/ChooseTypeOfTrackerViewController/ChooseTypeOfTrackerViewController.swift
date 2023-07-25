import UIKit

final class ChooseTypeOfTrackerViewController: UIViewController {
    let titleLabel = BaseTitleLabel(title: NSLocalizedString("ChooseTypeOfTracker.title", comment: ""))
    let habitButton = BaseBlackButton(with: NSLocalizedString("habit", comment: ""))
    let irregularEventButton = BaseBlackButton(with: NSLocalizedString("irregularEvent", comment: ""))
    
    var presenter: ChooseTypeOfTrackerPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupUI()
    }
}

extension ChooseTypeOfTrackerViewController {
    
    private func setupViews() {
        [titleLabel, habitButton, irregularEventButton].forEach(view.setupView)
    }
    
    private func setupConstraints() {
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
    
    private func setupUI() {
        view.backgroundColor = .white
        
        habitButton.addTarget(self, action: #selector(didTapHabitButton), for: .touchUpInside)
        irregularEventButton.addTarget(self, action: #selector(didTapIrregularEventButton), for: .touchUpInside)
    }
    
    @objc private func didTapHabitButton() {
        let createTrackerViewController = CreateTrackerViewController(classType: .regular)
        let createTrackerPresenter = CreateTrackerPresenter()
        createTrackerViewController.presenter = createTrackerPresenter
        createTrackerPresenter.view = createTrackerViewController
        createTrackerViewController.isEdit = false
        createTrackerViewController.chooseTypeOfTrackerViewController = self
        present(createTrackerViewController, animated: true)
    }
    
    @objc private func didTapIrregularEventButton() {
        let createTrackerViewController = CreateTrackerViewController(classType: .irregular)
        let createTrackerPresenter = CreateTrackerPresenter()
        createTrackerViewController.presenter = createTrackerPresenter
        createTrackerPresenter.view = createTrackerViewController
        createTrackerViewController.isEdit = false
        createTrackerViewController.chooseTypeOfTrackerViewController = self
        present(createTrackerViewController, animated: true)
    }
}

