//
//  TMDBMovieVideo.swift
//  MovieMoves
//
//  Created by Ankit Kumar on 4/23/16.
//  Copyright © 2016 Ankit Kumar. All rights reserved.
//

// MARK: - TMDBMovieVideo

struct TMDBMovieVideo {
    
    // MARK: Properties
    
    let id: String
    let name: String?
    var url: String?
    // MARK: Initializers
    
    // construct a TMDBMovieVideo from a dictionary
    init(dictionary: [String:AnyObject]) {
        id = dictionary[TMDBClient.JSONResponseKeys.MovieID] as! String
        name = dictionary[TMDBClient.JSONResponseKeys.MovieVideoName] as? String
        url = dictionary[TMDBClient.JSONResponseKeys.MovieVideoURL] as? String
        if let url = url{
            self.url = TMDBClient.Constants.YoutubeVideoURL + url
        }
    }
    
    static func moviesFromResults(results: [[String:AnyObject]]) -> [TMDBMovieVideo] {
        
        var videos = [TMDBMovieVideo]()
        
        // iterate through array of dictionaries, each Video is a dictionary
        for video in results {
            videos.append(TMDBMovieVideo(dictionary: video))
        }
        
        return videos
    }
}

// MARK: - TMDBMovie: Equatable

extension TMDBMovieVideo: Equatable {}

func ==(lhs: TMDBMovieVideo, rhs: TMDBMovieVideo) -> Bool {
    return lhs.id == rhs.id
}
