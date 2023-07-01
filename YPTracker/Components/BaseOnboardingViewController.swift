import UIKit

final class BaseOnboardingViewController: UIViewController {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    let customTitle: String
    let titleButton: String
    let image: UIImage
    
    lazy var onboardingButton = BaseBlackButton(with: titleButton)
    
    init(customTitle: String, titleButton: String, image: UIImage) {
        self.customTitle = customTitle
        self.titleButton = titleButton
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupUI()
        
    }
    
    private func setupViews() {
        [imageView, titleLabel, onboardingButton].forEach(view.setupView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 432),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            onboardingButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 160),
            onboardingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onboardingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupUI() {
        imageView.image = image
        
        titleLabel.text = customTitle
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = R.Colors.trBlack
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        onboardingButton.addTarget(self,
                         action: #selector(didTappOnboardingButton),
                         for: .touchUpInside)
        
    }
    
    @objc
    func didTappOnboardingButton() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
}
