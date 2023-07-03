import UIKit

final class CategoryViewController: UIViewController {
    var categoryViewModel: CategoryViewModel
    
    let titleLabel = BaseTitleLabel(title: "Категория")
    let addCategoryButton = BaseBlackButton(with: "Добавить категорию")
    let tableView = UITableView()
    let stubImageView = UIImageView()
    let stubLabel = UILabel()
    
    func showStub() {
        stubImageView.isHidden = false
        stubLabel.isHidden = false
    }
    
    func hideStub() {
        stubImageView.isHidden = true
        stubLabel.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupUI()
        showOrHideStub()
        bind()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
    }
    
    init(categoryViewModel: CategoryViewModel) {
        self.categoryViewModel = categoryViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryViewController {
    private func setupViews() {
        [titleLabel, tableView, stubImageView, stubLabel, addCategoryButton].forEach(view.setupView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            stubImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 246),
            stubImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubImageView.heightAnchor.constraint(equalToConstant: 80),
            stubImageView.widthAnchor.constraint(equalToConstant: 80),
            
            stubLabel.topAnchor.constraint(equalTo: stubImageView.bottomAnchor, constant: 8),
            stubLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stubLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: addCategoryButton.topAnchor, constant: -34)
        ])
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        stubImageView.image = R.Images.Common.stubImage
        
        stubLabel.text = "Привычки и события можно\n объединить по смыслу"
        stubLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        stubLabel.textColor = R.Colors.trBlack
        stubLabel.textAlignment = .center
        stubLabel.numberOfLines = 2
        
        tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 16
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        addCategoryButton.addTarget(self,
                                    action: #selector(didTapAddCategoryButton),
                                    for: .touchUpInside)
        
    }
    
    @objc
    private func didTapAddCategoryButton() {
        let newCategoryViewController = NewCategoryViewController()
        let newCategoryPresenter = NewCategoryPresenter()
        newCategoryViewController.presenter = newCategoryPresenter
        newCategoryPresenter.view = newCategoryViewController
        
        present(newCategoryViewController, animated: true)
    }
    
    private func bind() {
        
        categoryViewModel.$visibleCategories.bind {
            [weak self] _ in
            guard let self = self else { return }
            self.showOrHideStub()
            self.tableView.reloadData()
        }
    }
    
    func showOrHideStub() {
        categoryViewModel.visibleCategories.isEmpty ? self.showStub() : self.hideStub()
    }
}


extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryViewModel.visibleCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryCell else { return UITableViewCell() }
        cell.titleLabel.text = categoryViewModel.visibleCategories[indexPath.row]
        
        if indexPath.row == (categoryViewModel.visibleCategories.count) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }  else {
            cell.layer.cornerRadius = 0
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else { return }
        cell.accessoryType = cell.accessoryType == UITableViewCell.AccessoryType.none ? .checkmark : .none
        cell.selectionStyle = .none
        categoryViewModel.setSelectedCategory(with: cell.titleLabel.text ?? "")
        dismiss(animated: true)
    }
}

