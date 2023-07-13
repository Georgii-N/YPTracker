import UIKit

enum TypeOfStub {
    case searchFilter
    case dateFilter
}

class TrackersViewController: UIViewController {
    
    var presenter: TrackersPresenterProtocol?
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var navBar: TrackersNavBar = {
        let navBar = TrackersNavBar()
        navBar.searchTextField.delegate = self
        return navBar
    }()
    
    lazy var stubImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.Images.Common.stubImage
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Что будем отслеживать?"
        textLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return textLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupUI()
        setupCollectionView()
        
        presenter?.setupCurrentDate(date: navBar.datePicker.date)
        presenter?.checkVisibleTrackersAfterFilter(by: .dateFilter)
        showActualTrackers()
    }
}

extension TrackersViewController {
    
    private func setupViews() {
        [navBar, collectionView, stubImage, textLabel].forEach(view.setupView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stubImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubImage.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 220),
            
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: stubImage.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        navBar.plusButton.addTarget(self,
                                    action: #selector(didTapPlusButton),
                                    for: .touchUpInside)
        
        navBar.datePicker.addTarget(self,
                                    action: #selector(datePickerValueChanged(_:)),
                                    for: .valueChanged)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TrackersCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.register(TrackersCollectionSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    func hideStub() {
        stubImage.isHidden = true
        textLabel.isHidden = true
    }
    
    @objc private func didTapPlusButton() {
        let chooseHabitOrIrregularEventViewController = ChooseTypeOfTrackerViewController()
        let chooseTypeOfTrackerPresenter = ChooseTypeOfTrackerPresenter()
        present(chooseHabitOrIrregularEventViewController, animated: true, completion: nil)
        guard let presenter = presenter else { return }
        chooseHabitOrIrregularEventViewController.presenter = chooseTypeOfTrackerPresenter
    }
    
    func showStub(after filter: TypeOfStub) {
        switch filter {
        case .dateFilter:
            stubImage.image = R.Images.Common.stubImage
            textLabel.text = "Что будем отслеживать"
        case .searchFilter:
            stubImage.image = R.Images.Common.stubAfterSearch
            textLabel.text = "Ничего не найдено"
        }
        stubImage.isHidden = false
        textLabel.isHidden = false
    }
    
    private func showStubAfterSearch() {
        stubImage.image = R.Images.Common.stubAfterSearch
        textLabel.text = "Ничего не найдено"
        
        stubImage.isHidden = false
        textLabel.isHidden = false
    }
    
    @objc
    private func datePickerValueChanged(_ sender: UIDatePicker) {
        presenter?.setupCurrentDate(date: sender.date)
    }
}

extension TrackersViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let updatedText = text.replacingCharacters(in: range, with: string)
            presenter?.filterArray(for: updatedText)
        }
        
        return true
    }
}

extension TrackersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let visibleCategories = presenter?.visibleCategories else { return 0 }
        return visibleCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let visibleCategories = presenter?.visibleCategories else { return 0 }
        return visibleCategories[section].listOfTrackers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "collectionCell",
            for: indexPath) as? TrackersCollectionViewCell,
              let visibleCategories = presenter?.visibleCategories,
              let presenter = presenter
        else { return UICollectionViewCell() }
        cell.delegate = self
        let currentTracker = visibleCategories[indexPath.section].listOfTrackers[indexPath.row]
        
        cell.cellView.backgroundColor = currentTracker.color
        cell.trackerButton.backgroundColor = currentTracker.color
        cell.emojiLabel.text = currentTracker.emoji
        cell.cellTextLabel.text = currentTracker.name
        
        cell.countOfDaysLabel.text = presenter.countOfCompletedDays(id: currentTracker.id)
        presenter.checkTrackerCompletedForCurrentData(id: currentTracker.id) ? cell.markTrackerAsCompleted() : cell.unmarkTrackerAsCompleted()
        presenter.checkCurrentDateIsTodayDate() ? cell.unlockTrackerButton() : cell.lockTrackerButton()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        default:
            id = ""
        }
        
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? TrackersCollectionSupplementaryView,
              let visibleCategories = presenter?.visibleCategories
        else { return UICollectionReusableView() }
        
        view.headerLabel.text = visibleCategories[indexPath.section].name
        return view
    }
}

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width / 2
        let cellWidth = availableWidth - 24
        return CGSize(width: cellWidth, height: cellWidth * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        
        let headerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                             at: indexPath)
        
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
}

extension TrackersViewController: TrackersViewControllerProtocol {
    func showActualTrackers() {
        collectionView.reloadData()
    }
    
    func showTrackerIsCompleted(_ cell: TrackersCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              let tracker = presenter?.visibleCategories?[indexPath.section].listOfTrackers[indexPath.row]
        else { return }
        presenter?.createOrDeleteTrackerRecord(with: tracker.id)
    }
}
