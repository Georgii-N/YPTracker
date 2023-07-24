import UIKit

final class FilterViewController: UIViewController {
    private lazy var titleLabel = BaseTitleLabel(title: NSLocalizedString("filters", comment: ""))
    private lazy var tableView = UITableView()
    
    private var filtersTitles = [
        NSLocalizedString("allTrackers", comment: ""),
        NSLocalizedString("currentDayTrackers", comment: ""),
        NSLocalizedString("completedTrackers", comment: ""),
        NSLocalizedString("uncompletedTrackers", comment: "")
    ]
    
    var presenter: TrackersPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupUI()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FilterCell.self, forCellReuseIdentifier: "filterCell")
        
    }
}

extension FilterViewController {
    private func setupViews() {
        [titleLabel, tableView].forEach(view.setupView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filtersTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as? FilterCell else { return UITableViewCell() }
        
        cell.titleLabel.text = filtersTitles[indexPath.row]
        
        if indexPath.row == filtersTitles.count - 1 {
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
        }
        
        let index = presenter?.getCurrentFilter()
        
        cell.accessoryType = indexPath.row == index ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterCell else { return }
        
        switch indexPath.row {
        case 0:
            presenter?.resetAllfilters()
            dismiss(animated: true)
            cell.accessoryType = .checkmark
        case 1:
            presenter?.filterByToday()
            cell.accessoryType = .checkmark
            dismiss(animated: true)
        case 2:
            presenter?.filterCompletedTracker()
            cell.accessoryType = .checkmark
            dismiss(animated: true)
        case 3:
            presenter?.filterUncompletedTracker()
            cell.accessoryType = .checkmark
            dismiss(animated: true)
        default:
            break
        }
    }
}
