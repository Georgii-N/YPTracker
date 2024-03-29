import UIKit

final class StatisticViewController: UIViewController, StatisticViewControllerProtocol {
    private lazy var titleLabel = UILabel()
    private let resultView = UIView()
    private let gradientView = UIView()
    private lazy var stackView = UIStackView()
    private lazy var textCountLabel = UILabel()
    private lazy var textLabel = UILabel()
    
    private lazy var stubImageView = UIImageView()
    private lazy var stubTextLabel = UILabel()
    
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
        [titleLabel, gradientView, resultView, stackView, stubImageView, stubTextLabel].forEach(view.setupView)
        stackView.addArrangedSubview(textCountLabel)
        stackView.addArrangedSubview(textLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            resultView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            gradientView.centerXAnchor.constraint(equalTo: resultView.centerXAnchor),
            gradientView.centerYAnchor.constraint(equalTo: resultView.centerYAnchor),
            gradientView.heightAnchor.constraint(equalTo: resultView.heightAnchor, constant: 2),
            gradientView.widthAnchor.constraint(equalTo: resultView.widthAnchor, constant: 2),
            
            stubImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stubTextLabel.topAnchor.constraint(equalTo: stubImageView.bottomAnchor, constant: 8),
            stubTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
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
        titleLabel.text = NSLocalizedString("statisticView.title", comment: "")
        
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
        
        stubImageView.image = R.Images.Statistic.statisticStub
        
        stubTextLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        stubTextLabel.textColor = R.Colors.trBlack
        stubTextLabel.textAlignment = .center
        stubTextLabel.text = NSLocalizedString("statisticStub", comment: "")
        
    }
    
    func showStub() {
        stubImageView.isHidden = false
        stubTextLabel.isHidden = false
        
        gradientView.isHidden = true
        stackView.isHidden = true
    }
    
    func hideStub() {
        stubImageView.isHidden = true
        stubTextLabel.isHidden = true
        
        gradientView.isHidden = false
        stackView.isHidden = false
    }

    
    func setNewCount(count: String) {
        textCountLabel.text = count
    }
}
