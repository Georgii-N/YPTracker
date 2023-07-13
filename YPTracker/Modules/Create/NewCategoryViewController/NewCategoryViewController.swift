import UIKit

final class NewCategoryViewController: UIViewController, NewCategoryViewControllerProtocol {
    var presenter: NewCategoryPresenterProtocol?
    
    private lazy var titleLabel = BaseTitleLabel(title: NSLocalizedString("category", comment: ""))
    private lazy var textField = UITextField()
    private lazy var warningLabel = UILabel()
    private lazy var addCategoryButton = BaseBlackButton(with: NSLocalizedString("done", comment: ""))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupUI()
        
        textField.delegate = self
    }
}


extension NewCategoryViewController {
    private func setupViews() {
        [titleLabel, textField, warningLabel, addCategoryButton].forEach(view.setupView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 75),
            
            warningLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            addCategoryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.textAlignment = .center
        
        textField.backgroundColor = R.Colors.trBackgroundDay.withAlphaComponent(0.3)
        textField.placeholder = NSLocalizedString("nameCategoryPlaceholder", comment: "")
        textField.layer.cornerRadius = 16
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        
        warningLabel.isHidden = true
        warningLabel.textColor = R.Colors.trRed
        warningLabel.textAlignment = .center
        warningLabel.text = NSLocalizedString("warningCategoryExist", comment: "")
        
        
        addCategoryButton.isEnabled = false
        addCategoryButton.backgroundColor = R.Colors.trGray
        addCategoryButton.addTarget(self,
                                    action: #selector(didTapNewCategoryButton),
                                    for: .touchUpInside)
        
    }
    
    @objc
    private func didTapNewCategoryButton() {
        presenter?.addNewCategory()
        dismiss(animated: true)
    }
    
    func makeButtonIsEnable() {
        addCategoryButton.isEnabled = true
        addCategoryButton.backgroundColor = R.Colors.trBlack
    }
    
    func makeButtonIsDisable() {
        addCategoryButton.isEnabled = false
        addCategoryButton.backgroundColor = R.Colors.trGray
    }
    
    func showWarningMessage() {
        warningLabel.isHidden = false
    }
    
    func hideWarningMessage() {
        warningLabel.isHidden = true
    }
}

extension NewCategoryViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.count > 0 {
            presenter?.newCategory = text
            presenter?.checkCategoryIsNew()
        }
    }
}


