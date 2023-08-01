//
//  BookWarmCollectionViewController.swift
//  BookWarm
//
//  Created by 선상혁 on 2023/07/31.
//

import UIKit

class BookWarmCollectionViewController: UICollectionViewController {

    var movie = MovieInfo().movie
    
    @IBOutlet var searchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "선상혁님의 책장"
                
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
        
        return movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookWarmCollectionViewCell", for: indexPath) as! BookWarmCollectionViewCell
        
        let row = indexPath.row
        cell.bookWarmLikeButton.tag = row

        cell.configureCell(data: movie[row])
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
        
        vc.viewTitle = movie[row].title
        vc.releaseDate = "개봉일: \(movie[row].releaseDate)"
        vc.runtime = "상영 시간: \(movie[row].runtime)분"
        vc.overView = movie[row].overview
        vc.rate = "평점: \(movie[row].rate)점"
        
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
