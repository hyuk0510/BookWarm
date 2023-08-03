//
//  BookWarmCollectionViewController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit

class BookWarmCollectionViewController: UICollectionViewController {

    var movie = MovieInfo().movie
    let searchBar = UISearchBar()
    var searchList: [Movie] = []
    var isSearch: Bool = false
    
    @IBOutlet var searchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "선상혁님의 책장"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        searchBar.placeholder = "검색어를 입력해주세요."
        
        let nib = UINib(nibName: "BookWarmCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookWarmCollectionViewCell")
        
        designSearchButton()
        setCollectionViewLayout()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIBarButtonItem) {
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return isSearch ? searchList.count: movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookWarmCollectionViewCell", for: indexPath) as! BookWarmCollectionViewCell
        
        let row = indexPath.row
        cell.bookWarmLikeButton.tag = row

        isSearch ? cell.configureCell(data: searchList[row]): cell.configureCell(data: movie[row])
        cell.bookWarmLikeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        
        return cell
    }
    
    @objc
    func likeButtonPressed(_ sender: UIButton) {
        movie[sender.tag].isLike.toggle()
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard!.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        let row = indexPath.row
        
        MovieInfo.recentMovie.insert(movie[row], at: 0)
        
        if MovieInfo.recentMovie.count > 4 {
            MovieInfo.recentMovie.removeLast()
        }
                
        vc.getData(data: movie[row])
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func designSearchButton() {
        searchButton.title = ""
        searchButton.image = UIImage(systemName: "magnifyingglass")
        searchButton.tintColor = .black
    }
    
    func getRandomColor() -> UIColor{
            
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        let cellWidth = width / 2
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
}

extension BookWarmCollectionViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch.toggle()
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        for item in movie {
            if item.title.contains(searchBar.text ?? "") {
                searchList.append(item)
            }
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearch.toggle()
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchBarSearchButtonClicked(searchBar)
        
    }
}
//hello
