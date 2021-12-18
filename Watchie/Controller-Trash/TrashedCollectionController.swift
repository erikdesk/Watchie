import UIKit

private let reuseIdentifier = "TrashedCell"

class TrashedCollectionController: UICollectionViewController {
    
    let spinner = UIActivityIndicatorView(style: .large)
    var dataSource: UICollectionViewDiffableDataSource<String, Snippet>!
    var items: [Snippet]!
    lazy var sections: [String] = ["section 1"] // need lazy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        
        
        navigationItem.title = "Trash Bin"
        navigationController?.navigationBar.prefersLargeTitles = false
        
//        let switchControl = UISwitch(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30)))
//        switchControl.isOn = true
//        switchControl.onTintColor = UIColor.white
//        switchControl.setOn(true, animated: false)
//        switchControl.addTarget(self, action: #selector(toggleSensitiveInfo), for: .valueChanged)
//        switchControl.onTintColor = .red
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: switchControl)
    }
    
    @objc func toggleSensitiveInfo() {
        //print("hello")
    }
    
    func updateDisplay() {
        reloadDataAndUpdateDisplay(group: "Trashed")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // this runs before tab is clicked, not just on once app load.
        collectionView!.register(TrashedCell.self, forCellWithReuseIdentifier: TrashedCell.identifier)
        reloadDataAndUpdateDisplay(group: "Trashed")
    }
    
    func reloadDataAndUpdateDisplay(group: String) {
        
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXYin(view)
        
        var itemsFromCoreData = CoreDataAPI.shared.fetchFromCoreData()
        itemsFromCoreData = itemsFromCoreData.filter { $0.group == group}
        let ids = itemsFromCoreData.map { $0.id }
        
        FetchSnippet.shared.fromIds(withIds: ids) { (result: Result<[Snippet], Error>) in
            switch result {
                case .success(let items):
                    self.items = items
                    self.items.sort { $0.voteCount > $1.voteCount }
                
                    let imageIds = self.items.map { $0.posterId! }
                    FetchImage.shared.fetchImage(withImageIds: imageIds) { (result: Result<[Image], Error>) in
                        switch result {
                            case .success(let images):
                            
                                for i in 0..<self.items.count {
                                    self.items[i].posterImage = images.filter { $0.id == self.items[i].posterId }[0].image
                                }
                                self.items = self.items.filter { $0.posterImage != nil }
                            
                                self.dataSource = .init(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrashedCell.identifier, for: indexPath) as! TrashedCell
                                    cell.trashedNavController = self.navigationController as? TrashedNavController
                                    cell.trashedCollectionController = self
                                    cell.posterImageView.image = item.posterImage
                                    cell.snippet = item
                                    return cell
                                })

                                var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<String, Snippet> {
                                    var snapshot = NSDiffableDataSourceSnapshot<String, Snippet>()
                                    snapshot.appendSections(["0"])
                                    snapshot.appendItems(self.items, toSection: "0")
                                    return snapshot
                                }

                                self.collectionView.setCollectionViewLayout(Layout.shared.generateRandomComplexLayout(), animated: true)
                                self.dataSource.apply(filteredItemsSnapshot)
                            
                                self.spinner.stopAnimating()
                            
                            case .failure(let error):
                                print(error)
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
