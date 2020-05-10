////
////  APIManager.swift
////  Groupy
////
////  Created by Karan Khullar on 09/09/19.
////  Copyright © 2019 Groopy. All rights reserved.
////
//
import Foundation
import UIKit

class APIManager : BaseAPIManager {

    static let shared = APIManager()

    /// API to fetch overall india update state and district wise
    /// - Parameter completion: completion
    func fetchStatData(_ completion:@escaping (_ isSuccess:Bool,_ overallData:OverallData?,_ error:String?)->Void) {

        let headers = [APIConstants.HeaderKeys.x_rapidapi_host : APIConstants.host,
                       APIConstants.HeaderKeys.x_rapidapi_key: APIConstants.apiKey]
        APIManager.hitAPI(APIConstants.UrlEndPoints.api_india,
                          apiMethod: .get,
                          parameters: nil,
                          headers: headers) { (response, error) in
                            if let error = error {
                                completion(false,
                                           nil,
                                           error)
                            } else {
                                if let responseData = response as? [String:Any] {
                                    let overalldata = OverallData.init(responseData)
                                    completion(true,
                                               overalldata,
                                               nil)
                                } else {
                                    let message = APIManager.getMessage(response)
                                    completion(false,
                                               nil,
                                               message ?? "")
                                }
                            }
        }
    }
    
    /// to get random instruction images
    /// - Parameter completion: completion
    func getRandomInstruction(completion: @escaping(_ isSuccess:Bool,_ feedImage:UIImage?,_ error:String?)->Void) {
        let headers = [APIConstants.HeaderKeys.x_rapidapi_host : "coronavirus-monitor.p.rapidapi.com",
                       APIConstants.HeaderKeys.x_rapidapi_key: APIConstants.apiKey]
        var request = URLRequest.init(url: URL.init(string: APIConstants.instructionRandomUrl)!)
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration
       let task = session.dataTask(with: request) { (data, response, error) in
            if let responseData = data,let image = UIImage.init(data: responseData) {
                completion(true,image,nil)
            } else {
                completion(false,nil,"Couldn't load image")
            }
        }
        task.resume()
    }
    
    
    /// to fetch covid map data to show on map
    /// - Parameter completion: completion call
    func fetchCovidMapGeoJsonData(_ completion:@escaping (_ isSuccess:Bool,_ featureCollection:GeoJsonFeatureCollection?,_ error:String?)->Void) {
        APIManager.hitAPI(APIConstants.UrlEndPoints.mapGeoJson,
                          apiMethod: .get,
                          parameters: nil,
                          headers: nil) { (response, error) in
                            if let error = error {
                                completion(false,
                                           nil,
                                           error)
                            } else {
                                if let geoJsonData = response as? [String:Any] {
                                    let mapJson = GeoJsonFeatureCollection.init(geoJsonData: geoJsonData)
                                    completion(true,
                                               mapJson,
                                               nil)
                                } else {
                                    completion(false,
                                               nil,
                                               "An error occured while fethcing map data")
                                }
                            }
        }
    }

}


extension APIManager {

    //Server calls
    private class func serverCall(_ params: NSDictionary, urlEnding: NSString, notifName: String) {

        let fullUrl = (APIConstants.baseUrl as String) + (urlEnding as String) as NSString
        //            let theFullUrlStr = NSURL.init(string: fullUrl as String)


        // var error: NSError?
        let data = try? JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue:0))
        // let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        //        let parameters = [jsonString!]
        //
        //        let manager = AFHTTPSessionManager()


        let request = NSMutableURLRequest(url: URL(string: fullUrl as String)!)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let ud = UserDefaults.standard
        //        if ud.objectForKey("userToken") != nil {
        //            let str = ud.objectForKey("userToken") as! String
        //            request.addValue(str, forHTTPHeaderField: "token")
        //            request.addValue(str, forHTTPHeaderField: "accessToken")
        //
        //        }
        //

        if ud.object(forKey: "userToken") != nil {

            let tokenStr = ud.object(forKey: "userToken") as! String
            request.addValue(tokenStr, forHTTPHeaderField: "X-Auth-Token")
        }

        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data,response,error in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            let result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!


            let resultDict = self.convertStringToDictionary(result as String)

            //            var error: NSError?
            //            let jsonData: NSData = data!
            //

            // print(resultDict)
//            DispatchQueue.main.async(execute: { () -> Void in
//
//                ProgressHUD.dismiss()
//            })

            NotificationCenter.default.post(name: Notification.Name(rawValue: notifName as String), object: resultDict, userInfo: nil)
        })
        task.resume()
    }

    class func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}
