import UIKit

final class SсheduleViewController: UIViewController, ScheduleViewControllerProtocol {
    let titleLabel = BaseTitleLabel(title: "Расписание")
    let tableView = UITableView()
    let createButton = BaseBlackButton(with: "Готово")
    
    var presenter: SchedulePresenterProtocol?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension SсheduleViewController {
    private func setupViews() {
        [titleLabel, tableView, createButton].forEach(view.setupView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            tableView.heightAnchor.constraint(equalToConstant: 525),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            createButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 47),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 16
        
        createButton.addTarget(self,
                               action: #selector(didTapCreateButton),
                               for: .touchUpInside)
        
    }
    
    @objc
    func didTapCreateButton() {
        presenter?.setupSchedule()
        dismiss(animated: true)
    }
}

extension SсheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.weekDays.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScheduleTableViewCell,
              let presenter
        else { return UITableViewCell() }
        cell.delegate = self
        cell.label.text = presenter.weekDays[indexPath.row]
        
        if indexPath.row == presenter.weekDays.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

extension SсheduleViewController: UITableViewDelegate {
    
}

extension SсheduleViewController: ScheduleViewControllerCellDelegateProtocol {
    func refreshSelectedDaysArray(cell: ScheduleTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
              var presenter = presenter
        else { return }
        let selectedIndex = indexPath.row
        
        if cell.switcher.isOn {
            presenter.selectedIndexes.append(selectedIndex)
        } else {
            if let index = presenter.selectedIndexes.firstIndex(of: selectedIndex) {
                presenter.selectedIndexes.remove(at: index)
            }
        }
    }
}


