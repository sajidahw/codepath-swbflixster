//
//  MovieGridViewController.swift
//  SW Flix
//
//  Created by Sajidah Wahdy on 2/12/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //grid view layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout  //flowlayout wraps into next row
        
        
        layout.minimumLineSpacing = 4 // controls space inbtwn the rows in pixels
        layout.minimumInteritemSpacing = 4 // space btwn the items
        
        //change dynamically width size for how many posters are put in a row ie 2 or 3; math for what size you want grid items to be
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3 //width of phone which will dynamically change for user, if wanted in 3 poster views
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        // Do any additional setup after loading the view.
        //downloading superhero movies
        // get info from the network
        let url = URL(string: "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!//"https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                 // added 2 self.movies and self.tableView.reloadData()
                 self.movies = dataDictionary["results"] as! [[String:Any]] //stores result from key but casted as an array of dictionaries
                 
                 //reload screen after grabbing the collection from dictionary
                 self.collectionView.reloadData()
                 
                 print(self.movies)
                 
                }
        }
        task.resume()
                 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        //inserting movie posters from api
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseURL + posterPath)!
        cell.posterView.af.setImage(withURL: posterUrl)  //d/l images and posts it
        
        
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
