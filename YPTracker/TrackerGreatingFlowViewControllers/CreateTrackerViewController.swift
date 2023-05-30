import UIKit

enum TypeOfEvent {
    case regular
    case irregular
}

final class CreateTrackerViewController: UIViewController {
    private lazy var scrollView = UIScrollView()
    private lazy var titleLabel = UILabel()
    private lazy var textField = UITextField()
    private lazy var tableView = UITableView()
    private lazy var heightOfTableView = 150
  //  let emojiCollectionView = UICollectionView()
  //  let colorsCollectionView = UICollectionView()
    
    var selectedTitles = ["", "2"]
    
    var titlesFotTableView = ["Категория"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        constraintViews()
        configureAppearance()
        setupDelegatesAndDataSources()
    }
    
    init(classType: TypeOfEvent) {
        super.init(nibName: nil, bundle: nil)
        
        switch classType {
        case .regular:
            titleLabel.text = "Новая привычка"
            titlesFotTableView.append("Расписание")
            heightOfTableView = 150
        case .irregular:
            titleLabel.text = "Новое нерегулярное событие"
            heightOfTableView = 75
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateTrackerViewController {
    
    private func addViews() {
      //  view.setupView(scrollView)
        [titleLabel, textField, tableView].forEach(view.setupView)
        //, emojiCollectionView, colorsCollectionView
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 75),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(heightOfTableView))
            
            
//            emojiCollectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 32),
//            emojiCollectionView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
//            emojiCollectionView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
//
//            colorsCollectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 44),
//            colorsCollectionView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
//            colorsCollectionView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        ])
    }
    
    private func configureAppearance() {
        view.backgroundColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = R.Colors.trBlack
        
        textField.layer.cornerRadius = 16
        textField.backgroundColor = R.Colors.trBackgroundDay.withAlphaComponent(0.3)
        textField.placeholder = "Введите название трекера"
        textField.textColor = R.Colors.trBlack
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        
        tableView.layer.cornerRadius = 17
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setupDelegatesAndDataSources() {
        textField.delegate = self
        tableView.register(CreateTrackerTableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CreateTrackerViewController: UITableViewDelegate {
    
}

extension CreateTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesFotTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? CreateTrackerTableViewCell else { return UITableViewCell()}
        cell.titleLabel.text = titlesFotTableView[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        if selectedTitles[indexPath.row] == "" {
                cell.selectedLabel.isHidden = true
            } else {
                cell.selectedLabel.isHidden = false
                cell.selectedLabel.text = selectedTitles[indexPath.row]
            }
        if indexPath.row == titlesFotTableView.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

extension CreateTrackerViewController: UITextFieldDelegate {
    
}


