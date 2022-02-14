//
//  MovieDetailsViewController.swift
//  SW Flix
//
//  Created by Sajidah Wahdy on 2/12/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
//outlets at top
    
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]! //singular movie for dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(movie["title"])
        
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()//fit as grows since auto layout isn't configured
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
    
        //inserting movie posters from api
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseURL + posterPath)!
        posterView.af.setImage(withURL: posterUrl)  //d/l images and posts it
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!//changed resolution to 780
        backdropView.af.setImage(withURL: backdropUrl)  //d/l images and posts it
    
    
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
