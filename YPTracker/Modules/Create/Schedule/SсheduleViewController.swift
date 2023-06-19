import UIKit

final class SсheduleViewController: UIViewController {
    let titleLabel = BaseTitleLabel(title: "Расписание")
    let tableView = UITableView()
    let createButton = BaseBlackButton(with: "Готово")
    
    var weekDays = StorageSingleton.storage.weekDays
    
    var selectedIndexes = [Int]()
    var delegate: CreateTrackerPresenterProtocol?
    
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
        StorageSingleton.storage.trackerSchedule = selectedIndexes
        delegate?.updateCreateTrackerSchedule()
        dismiss(animated: true)
    }
}

extension SсheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weekDays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScheduleTableViewCell
        else { return UITableViewCell() }
        cell.delegate = self
        cell.label.text = weekDays[indexPath.row]
        
        if indexPath.row == weekDays.count - 1 {
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
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let selectedIndex = indexPath.row
        
        if cell.switcher.isOn {
            selectedIndexes.append(selectedIndex)
        } else {
            if let index = selectedIndexes.firstIndex(of: selectedIndex) {
                selectedIndexes.remove(at: index)
            }
        }
    }
}


