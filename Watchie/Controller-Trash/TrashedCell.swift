import UIKit

class TrashedCell: UICollectionViewCell, UIContextMenuInteractionDelegate {
    
    static var identifier: String = "TrashedCell"
    weak var trashedNavController: TrashedNavController!
    weak var trashedCollectionController: TrashedCollectionController!
    var snippet: Snippet!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        posterImageView.addInteraction(interaction)
        posterImageView.isUserInteractionEnabled = true
        posterImageView.layer.cornerRadius = 10
        
        contentView.addSubview(posterImageView)
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    @objc func tapped() {
        //print("movie details tapped..")
//        let detailVC = DetailViewController()
//        detailVC.id = listMovie.id
//        detailVC.name = listMovie.name
//        topNavVC.pushViewController(detailVC, animated: true)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            return self.createContextMenu()
        }
    }
    
    func createContextMenu() -> UIMenu {
        
        let itemsFromCoreData = CoreDataAPI.shared.fetchFromCoreData()
        
        let todoIds = itemsFromCoreData.filter { $0.group == "Todo"}.map { $0.id }
        let watchedIds = itemsFromCoreData.filter { $0.group == "Watched"}.map { $0.id }
        let trashedIds = itemsFromCoreData.filter { $0.group == "Trashed"}.map { $0.id }
        
        let todoEnabled = todoIds.filter { $0 == snippet.id}.count == 0
        let watchedEnabled = watchedIds.filter { $0 == snippet.id}.count == 0
        let trashedEnabled = trashedIds.filter { $0 == snippet.id}.count == 0
        
        return UIMenu(title: "", children: generateActionItems(todoEnabled: todoEnabled, watchedEnabled: watchedEnabled, watchedEnabled: trashedEnabled))
    }
    
    func generateActionItems(todoEnabled: Bool, watchedEnabled: Bool, watchedEnabled trashedEnabled: Bool) -> [UIAction] {
        
        let todoActionEnabled = UIAction(title: "Add to To-do List", image: UIImage(systemName: "newspaper.fill")) { _ in
            let _ = NotificationPopupView(frame: self.frame, parentView: self.trashedNavController.view, message: "\(self.snippet.title) has been added to To-do List")
            CoreDataAPI.shared.addOrReplaceToCoreData(id: self.snippet.id, group: "Todo", watchedDate: Date())
            self.trashedCollectionController.updateDisplay()
        }
        let todoActionDisabled = UIAction(title: "Add to To-do List", image: UIImage(systemName: "newspaper.fill"), attributes: .disabled) { _ in
        }
        
        let watchedActionEnabled = UIAction(title: "Mark as Watched", image: UIImage(systemName: "play.tv.fill")) { _ in
            let _ = NotificationPopupView(frame: self.frame, parentView: self.trashedNavController.view, message: "\(self.snippet.title) has been marked as Watched")
            CoreDataAPI.shared.addOrReplaceToCoreData(id: self.snippet.id, group: "Watched", watchedDate: nil)
            self.trashedCollectionController.updateDisplay()
        }
        
        let watchedActionDisabled = UIAction(title: "Mark as Watched", image: UIImage(systemName: "play.tv.fill"), attributes: .disabled) { _ in
        }
        
        let trashedActionEnabled = UIAction(title: "Send to Trash Bin", image: UIImage(systemName: "trash.fill")) { _ in
            let _ = NotificationPopupView(frame: self.frame, parentView: self.trashedNavController.view, message: "\(self.snippet.title) has been sent to the Trash Bin")
            CoreDataAPI.shared.addOrReplaceToCoreData(id: self.snippet.id, group: "Trashed", watchedDate: nil)
            self.trashedCollectionController.updateDisplay()
        }
        
        let trashedActionDisabled = UIAction(title: "Send to Trash Bin", image: UIImage(systemName: "trash.fill"), attributes: .disabled) { _ in
        }
        
        return [todoEnabled ? todoActionEnabled : todoActionDisabled,
                watchedEnabled ? watchedActionEnabled : watchedActionDisabled,
                trashedEnabled ? trashedActionEnabled : trashedActionDisabled]
    }
}
