import UIKit

class TrackersViewController: UIViewController {
    
    let navBar = TrackersNavBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        constraintViews()
        configureAppearance()
    }
}

extension TrackersViewController {
    func addViews() {
        view.setupView(navBar)
    }
    
    func constraintViews() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureAppearance() {
        navigationController?.navigationBar.isHidden = true
    }
}

