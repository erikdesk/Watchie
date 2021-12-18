import UIKit

private let reuseIdentifier = "SearchCell"

class SearchCollectionController: UICollectionViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    let spinner = UIActivityIndicatorView(style: .large)
    var dataSource: UICollectionViewDiffableDataSource<String, Snippet>!
    var items: [Snippet]!
    lazy var sections: [String] = ["section 1"] // need lazy?
    
    
    
    
    
    
    
    
    
    
    
    
    let searchBarButtonItem = UIBarButtonItem()
//    let switchControl = UISwitch(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30)))
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        
        
        
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        // Do any additional setup after loading the view.
        
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = false
        
//        switchControl.isOn = true
//        switchControl.onTintColor = UIColor.white
//        switchControl.setOn(true, animated: false)
//        switchControl.addTarget(self, action: #selector(infoSwitchTapped), for: .valueChanged)
//        switchControl.onTintColor = .red
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: switchControl)
        
        searchBarButtonItem.action = #selector(searchButtonTapped)
        searchBarButtonItem.image = UIImage(systemName: "magnifyingglass")
        searchBarButtonItem.target = self
        searchBarButtonItem.tintColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
        navigationItem.leftBarButtonItems = [searchBarButtonItem]
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        // self.searchController.dimsBackgroundDuringPresentation = true // what is this?
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search All Movies"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // this runs before tab is clicked, not just on once app load.
        collectionView!.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
        
//        let url = URL(string: "https://api.themoviedb.org/3/movie/335984?api_key=abf690bbe6b0f182815420cfe570a539")!
//        FetchAPI.shared.fetchData(from: url, withCancelDataTask: true) { (result: Result<FetchL1Movie, Error>) in // is [weak self] needed here?
//            print("fetched..")
//            switch result {
//                case .success(let x):
//                    x.show()
//                case .failure(let error):
//                    print(error)
//            }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated) // this runs after tab is clicked, not just on once app load.
        searchButtonTapped() // so that search opens once tab is clicked. // i think need more conditions on when this should show up.
        
        // BUG! BUG! scroll keeps getting messed up when doing some actions.
        //self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.collectionView.setContentOffset(.zero, animated: false)
    }
    
    func updateDisplay() {
        //print("updateDisplayyyyy")
    }
    
    @objc func infoSwitchTapped() {
        //print("infoSwitchTapped")
    }
    
    @objc func searchButtonTapped() {
        //print("searchButtonTapped")
        
        self.navigationItem.titleView = searchController.searchBar
        navigationItem.leftBarButtonItem = .none
        navigationItem.rightBarButtonItems = []
        searchController.searchBar.becomeFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // print("what is this?") // this updates whenever search bar text changes // for dynamic search. // not used now.
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { // when cancelled at the top.
        //print("searchBarCancelButtonClicked")
        
        self.dismiss(animated: true, completion: nil)
        self.navigationItem.titleView = .none
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: switchControl)
        navigationItem.leftBarButtonItems = [searchBarButtonItem]
        
        
        // fix bug where it's not scrolled to the top.
        //self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.collectionView.setContentOffset(.zero, animated: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // when keyboard search button pressed.
        searchBar.resignFirstResponder()
        
        self.dismiss(animated: true, completion: nil)
        self.navigationItem.titleView = .none
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: switchControl)
        navigationItem.leftBarButtonItems = [searchBarButtonItem]
        
        //print(searchBar.text!)
        
        var query = searchBar.text!
        query = query.replacingOccurrences(of: "[^A-Za-z0-9]+", with: "+", options: [.regularExpression])
        //print(query)
        
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXYin(view)
        
        FetchSnippet.shared.searchMovie(withQuery: query) { (result: Result<[Snippet], Error>) in
        //FetchSnippet.shared.searchMovie(withQuery: "iron+man") { (result: Result<[Snippet], Error>) in
        //FetchSnippet.shared.searchMovie(withQuery: "dune") { (result: Result<[Snippet], Error>) in
        //FetchSnippet.shared.searchMovie(withQuery: "spiderman") { (result: Result<[Snippet], Error>) in
            switch result {
                case .success(let items):
                    self.items = items
                
                    // remove dupe ids.
                    self.items = self.items.uniques(by: \.id)
                
                    // handyplast filter.. need to do better.
//                    self.items = self.items.filter { $0.genreIds.count > 0 }
                    
                    self.items = self.items.filter { $0.popularity > 0 }
                    self.items = self.items.filter { $0.voteAverage > 0 }
                    self.items = self.items.filter { $0.voteCount > 0 }
                    
                    self.items = self.items.filter { $0.releaseDate != nil }
                    self.items = self.items.filter { $0.posterId != nil }
                
                    // handyplast sort.. need to do better. actually dont sort. results returned by tmdb are better.
                    self.items.sort { $0.voteCount > $1.voteCount }
//                    self.items.sort { $0.popularity > $1.popularity }
                
                    //print(self.items.count)
                
                    let imageIds = self.items.map { $0.posterId! }
                    FetchImage.shared.fetchImage(withImageIds: imageIds) { (result: Result<[Image], Error>) in
                        switch result {
                            case .success(let images):
                            
                                // handyplast filter again.. need to do better.
                                for i in 0..<self.items.count {
                                    self.items[i].posterImage = images.filter { $0.id == self.items[i].posterId }[0].image
                                }
                                self.items = self.items.filter { $0.posterImage != nil }
                            
                                // final items to be displayed.
                                // print(self.items)
                            
                                self.dataSource = .init(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
                                    cell.searchNavController = self.navigationController as? SearchNavController
                                    cell.searchCollectionController = self
                                    
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
                
                //print(imageIds)
                
                case .failure(let error):
                    print(error)
            }
        }
        
//        var fetch = Fetch()
//        fetch.searchMovies(withQuery: "spiderman") { (result: Result<[MovieSnippet], Error>) in
//
//        }
//        Fetch.getItemsFromAllPages(<#T##self: &Fetch##Fetch#>)
        
        // searchBar.text!
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
