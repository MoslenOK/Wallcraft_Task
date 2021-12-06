//
//  UnsplashManager.swift
//  Wallcraft_Task
//
//  Created by DENIS SYTYTOV on 06.12.2021.
//

import Foundation
import UIKit

protocol UnsplashManagerDeligate{
    func didUpdateUnsplashResult(_ unsplashManager: UnsplashManager, unsplashResultModel: UnsplashResultModel)
    func didFailWithError(error: Error)
}

struct UnsplashManager {
    
    
    var delegate : UnsplashManagerDeligate?
    let accessKey = "0pqbuBSe2T2OWr5L0axYXtFxGKnjC6yu3hIcneyXMVA"
    
    
    func GetResult() {
        if let url = URL(string: "https://api.unsplash.com/photos/random?client_id=\(accessKey)"){
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let unsplashResult = self.parseJSON(safeData){
                        self.delegate?.didUpdateUnsplashResult(self, unsplashResultModel: unsplashResult)
                    }
                }
            }.resume()
            
            
        }
        
    }
    
    func parseJSON(_ unsplashResultData: Data) -> UnsplashResultModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(UnsplashResultData.self, from: unsplashResultData)
            let id = decodedData.id
            let description = decodedData.description
            let user = decodedData.user.name
            let urls = decodedData.urls.small
            
            let unsplashResultModel = UnsplashResultModel(id: id, name: user, description: description, url: urls)
            return unsplashResultModel
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
