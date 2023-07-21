import UIKit

final class StatisticViewController: UIViewController, StatisticViewControllerProtocol {
    private lazy var titleLabel = UILabel()
    private let resultView = UIView()
    private let gradientView = UIView()
    private lazy var stackView = UIStackView()
    private lazy var textCountLabel = UILabel()
    private lazy var textLabel = UILabel()
    
    var presenter: StatisticPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupUI()
        presenter?.updateCount()
    }
    
    override func viewDidLayoutSubviews() {
        gradientView.layer.cornerRadius = 16
        gradientView.layer.masksToBounds = true
        gradientView.withGradienBackground(color1: UIColor(hexString: "#007BFA"), color2: UIColor(hexString: "#46E69D"), color3: UIColor(hexString: "#FD4C49"))
    }
}

extension StatisticViewController {
    private func setupViews() {
        [titleLabel, gradientView, resultView, stackView].forEach(view.setupView)
        stackView.addArrangedSubview(textCountLabel)
        stackView.addArrangedSubview(textLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            resultView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            gradientView.centerXAnchor.constraint(equalTo: resultView.centerXAnchor),
            gradientView.centerYAnchor.constraint(equalTo: resultView.centerYAnchor),
            gradientView.heightAnchor.constraint(equalTo: resultView.heightAnchor, constant: 2),
            gradientView.widthAnchor.constraint(equalTo: resultView.widthAnchor, constant: 2),
            
            stackView.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -12)
        ])
    }
    
    
    
    private func setupUI() {
        view.backgroundColor = .white
        
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = R.Colors.trBlack
        
        resultView.layer.cornerRadius = 16
        resultView.layer.masksToBounds = true
        resultView.backgroundColor = .white
        
        textCountLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        textCountLabel.textColor = R.Colors.trBlack
        
        stackView.spacing = 7
        stackView.axis = .vertical
        
        textLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        textLabel.textColor = R.Colors.trBlack
        textLabel.text = NSLocalizedString("trackersCompleted", comment: "")
    }
    
    private func addGradientToView(view: UIView, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    func setNewCount(count: String) {
        textCountLabel.text = count
    }
}
