// TEST TEST ---- FOR BIG PREVIEW ---- DO NEXT TIME ----
//    UIContextMenuInteractionDelegate
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//        return UIContextMenuConfiguration(identifier: nil, previewProvider: MountainsPreviewViewController.init) { suggestedActions in
//
//            // Create an action for sharing
//            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
//                // Show system share sheet
//            }
//
//            // Create an action for renaming
//            let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
//                // Perform renaming
//            }
//
//            // Here we specify the "destructive" attribute to show that it’s destructive in nature
//            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
//                // Perform delete
//            }
//
//            // Create and return a UIMenu with all of the actions as children
//            return UIMenu(title: "", children: [share, rename, delete])
//        }
//    }
//
//    // TEST //
//    private let menuView = UIView()
//    // TEST //
//
//    // TEST //
//    menuView.translatesAutoresizingMaskIntoConstraints = false
//    menuView.backgroundColor = .systemBlue
////        menuView.frame.size = CGSize(width: 100, height: 100)
//    view.addSubview(menuView)
//    menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//    menuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
//    menuView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//    menuView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//    menuView.layer.cornerRadius = 30
//
//    let interaction = UIContextMenuInteraction(delegate: self)
//    menuView.addInteraction(interaction)
//    // TEST //
// TEST TEST ---- FOR BIG PREVIEW ---- DO NEXT TIME ----
