import UIKit

class TrackersViewController: UIViewController {
    
    let navBar = TrackersNavBar()
  //   let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var currentDate: Date?
    var visibleCategories = [TrackerCategory]()
    var categories = [TrackerCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        constraintViews()
        configureAppearance()
        showStub()
        
        navBar.searchTextField.delegate = self
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
    }
}

extension TrackersViewController {
    private func addViews() {
        view.setupView(navBar)
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureAppearance() {
        navigationController?.navigationBar.isHidden = true
        
        navBar.plusButton.addTarget(self, action: #selector(didTappedPlusButton), for: .touchUpInside)
    }
    
    @objc private func didTappedPlusButton() {
        let chooseHabitOrIrregularEventViewController = ChooseTypeOfTrackerViewController()
        present(chooseHabitOrIrregularEventViewController, animated: true, completion: nil)
    }
    
    private func showStub() {
        let stubImage: UIImageView = {
            let imageView = UIImageView()
            imageView.image = R.Images.Common.stubImage
            return imageView
        }()
        
        let textLabel: UILabel = {
            let textLabel = UILabel()
            textLabel.text = "Что будем отслеживать?"
            textLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            return textLabel
        }()
        
        [stubImage, textLabel].forEach(view.setupView)
        
        NSLayoutConstraint.activate([
            stubImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubImage.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 220),
            
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: stubImage.bottomAnchor, constant: 8)
        ])
    }
}

extension TrackersViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Поиск..." {
            textField.text = ""
        }
    }
}

