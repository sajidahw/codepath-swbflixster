//
//  MoviesViewController.swift
//  SW Flix
//
//  Created by Sajidah Wahdy on 2/8/22.
//

import UIKit
import AlamofireImage // special library imported via pods

// created TableView outlets: datasource and delegate

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]() //creation() of an array[] of dictionaries[String:Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // activats the 2 tableView functions below
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        //print("Hello")
        // get info from the network
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                 self.tableView.reloadData()
                 
                 //print(dataDictionary)
                 
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                 
                 
                    // TODO: Reload your table view data

                 self.tableView.reloadData() // so movie titles are populated in the view
             }
        }
        task.resume()
    }
    
    // 2 fxs needed for table views
    //the count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count //movies.count for rows
    }
    
    //the cell creation
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell() // stock cell recipe
        //customized tableView cell instead:
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell  //if another cell offscreen, recycle cell or create a new one
        
        
        let movie = movies[indexPath.row] //store movies in each row
        let title = movie["title"] as! String //d[key] to show title results casted as Str since it's a title
        let synopsis = movie["overview"] as! String
        
        
        
        //cell.textLabel!.text = title
        cell.titleLabel.text = title
        
        //configure synopsis label to fill with text as defined above
        cell.synopsisLabel.text = synopsis
        
//        cell.textLabel!.text = "row: \(indexPath.row)"  // replaces string with value of rows existing; gets refreshed for updates
        
        //inserting movie posters from api
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseURL + posterPath)!
        cell.posterView.af.setImage(withURL: posterUrl)  //d/l images and posts it
        
        
        // swift optionals is '?' inserts or '!'
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation, ie sending data when leaving a screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("Loading up the details screen here.")
        
        //Find the selected movie
        //sender is the cell which was tapped on
        let cell = sender as! UITableViewCell //cell tapped on
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row] //accessing the array
        
        // Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie //referring to movie found in line 110
        
        tableView.deselectRow(at: indexPath, animated: true) //deselects it so it doesn't stay gray after tapping on it
        
        
    }
    

}
