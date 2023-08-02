//
//  LookAroundViewController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/08/02.
//

import UIKit

class LookAroundViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    let recentMovie = MovieInfo.recentMovie
    let recommendMovie = MovieInfo().movie
    let sectionTitle = ["요즘 인기 작품"]
    
    
    @IBOutlet var backView: UICollectionView!
    
    @IBOutlet var collectionViewTitleLabel: UILabel!
    @IBOutlet var recentCollectionView: UICollectionView!
    @IBOutlet var recommendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "둘러보기"
        
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        
        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        
        let cvNib = UINib(nibName: "RecentCollectionViewCell", bundle: nil)
        recentCollectionView.register(cvNib, forCellWithReuseIdentifier: "RecentCollectionViewCell")
        let tvNib = UINib(nibName: "RecommendTableViewCell", bundle: nil)
        recommendTableView.register(tvNib, forCellReuseIdentifier: "RecommendTableViewCell")
                
        designCollectionViewTitleLabel()
        configureRecentCollectionViewLayOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        recentCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recentMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCollectionViewCell", for: indexPath) as! RecentCollectionViewCell
        
        cell.recentCollectionViewImage.image = UIImage(named: "\(recentMovie[indexPath.row].title)")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieInfo().movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell") as! RecommendTableViewCell
        
        cell.recommendTitleLabel.tag = indexPath.row
        
        cell.configureRecommendTableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        let row = indexPath.row
        
        vc.getData(data: recommendMovie[row])
        
        let nav = UINavigationController(rootViewController: vc)

        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func configureRecentCollectionViewLayOut() {
        let layout = UICollectionViewFlowLayout()
        let spacing = CGFloat(10)
        let spaceNum = CGFloat(recentMovie.count)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - (spacing * (spaceNum + 1))) / spaceNum, height: 150)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        recentCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        let row = indexPath.row
        
        vc.getData(data: recommendMovie[row])
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func designCollectionViewTitleLabel() {
        collectionViewTitleLabel.text = "최근 항목"
        collectionViewTitleLabel.font = .boldSystemFont(ofSize: 15)
        collectionViewTitleLabel.textColor = .gray
    }
}
