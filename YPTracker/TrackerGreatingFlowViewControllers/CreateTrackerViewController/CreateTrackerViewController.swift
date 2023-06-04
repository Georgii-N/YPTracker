import UIKit

enum TypeOfEvent {
    case regular
    case irregular
}

final class CreateTrackerViewController: UIViewController, CreateTrackerViewControllerProtocol {
    
    private lazy var scrollView = UIScrollView()
    private lazy var titleLabel = UILabel()
    private lazy var textField = UITextField()
    private lazy var tableView = UITableView()
    private lazy var heightOfTableView = 150
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var buttonStackView = UIStackView()
    private lazy var cancelButton = UIButton()
    private lazy var createButton = UIButton()
    
    var presenter: CreateTrackerPresenterProtocol?
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
        view.setupView(scrollView)
        [titleLabel, textField, tableView, collectionView, cancelButton, createButton].forEach(scrollView.setupView)
    }
    
    private func constraintViews() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 75),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(heightOfTableView)),
            tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            
            collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 32),
            collectionView.heightAnchor.constraint(equalToConstant: 500),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 46),
            cancelButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -10),
            cancelButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -34),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            
            createButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 46),
            createButton.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10),
            createButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            createButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -34),
            createButton.heightAnchor.constraint(equalToConstant: 60)
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
        
        collectionView.allowsMultipleSelection = true
        collectionView.isScrollEnabled = false
        
        
        
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(R.Colors.trRed, for: .normal)
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = R.Colors.trRed.cgColor
        cancelButton.layer.cornerRadius = 16
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        cancelButton.addTarget(self, action: #selector(didTapedCancelButton), for: .touchUpInside)
        
        createButton.setTitle("Создать", for: .normal)
        createButton.layer.cornerRadius = 16
        createButton.backgroundColor = R.Colors.trGray
        createButton.setTitleColor(.white, for: .normal)
        createButton.addTarget(self, action: #selector(didTapedCreateButton), for: .touchUpInside)
    }
    
    private func setupDelegatesAndDataSources() {
        textField.delegate = self
        tableView.register(CreateTrackerTableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        collectionView.register(CreateTrackerCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.register(CreateTrackerSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc
    private func didTapedCancelButton() {
        
    }
    
    @objc
    private func didTapedCreateButton() {
        
    }
}

extension CreateTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let categoryViewController = CategoryViewController()
            present(categoryViewController, animated: true)
        case 1:
            let scheduleViewController = SсheduleViewController()
            present(scheduleViewController, animated: true)
        default:
            return
        }
    }
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

extension CreateTrackerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return section == 0 ? presenter.emojiArray.count : presenter.colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CreateTrackerCollectionViewCell,
              let presenter = presenter  else
        {
            return UICollectionViewCell()
        }
        switch indexPath.section {
        case 0:
            cell.setTitleLable()
            cell.titleLabel.text = presenter.emojiArray[indexPath.item]
        case 1:
            cell.setColorView()
            cell.colorView.backgroundColor = presenter.colorArray[indexPath.item]
        default:
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        default:
            return UICollectionReusableView()
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? CreateTrackerSupplementaryView else { return UICollectionReusableView() }
        
        switch indexPath.section {
        case 0:
            view.headerLabel.text = "Emoji"
        case 1:
            view.headerLabel.text = "Цвет"
        default:
            view.headerLabel.text = ""
        }
        
        return view
    }
}

extension CreateTrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidht = collectionView.frame.width / 6
        switch indexPath.section {
        case 0:
            let cellWidght = availableWidht - 15
            return CGSize(width: cellWidght, height: cellWidght)
        case 1:
            let cellWidght = availableWidht - 20
            return CGSize(width: cellWidght, height: cellWidght)
        default:
            let cellWidght = availableWidht - 15
            return CGSize(width: cellWidght, height: cellWidght)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 29, bottom: 40, right: 29)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CreateTrackerCollectionViewCell else { return }
        
        switch indexPath.section {
        case 0:
            cell.backgroundColor = R.Colors.trBackgroundDay
            
        case 1:
            let color = cell.colorView.backgroundColor?.withAlphaComponent(0.3)
            cell.layer.borderWidth = 3
            cell.layer.borderColor = color?.cgColor
        default:
            cell.backgroundColor = R.Colors.trBackgroundDay
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems {
            let selectedIndexPathsInSection = selectedIndexPaths.filter { $0.section == indexPath.section }
            
            if selectedIndexPathsInSection.count > 0 {
                selectedIndexPathsInSection.forEach { selectedIndexPath in
                    collectionView.deselectItem(at: selectedIndexPath, animated: true)
                }
            }
        }
        return true
    }
}

