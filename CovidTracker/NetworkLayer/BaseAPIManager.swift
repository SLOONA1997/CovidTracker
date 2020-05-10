//
//  BaseApiManager.swift
//  Groupy
//
//  Created by Karan Khullar on 05/08/19.
//  Copyright © 2019 ChicMic. All rights reserved.

import Foundation
//import SVProgressHUD

/// This Class is the Base API manager which manages the basic request creation,
/// get data call and hit API calls.
internal class BaseAPIManager: NSObject {

    static func getMessage(_ response: Any?) -> String? {
        if let data = response as? [String: Any] {
                if let errCode = data[APIConstants.Keys.statusCode] as? Int{
                    switch errCode {
                    case 5004:
                        return "This email is not registered with us."
                    default:
                        let error = data[APIConstants.Keys.message] as? String
                        return error
                    }
                }else {
                    let error = data[APIConstants.Keys.message] as? String
                    return error
            }
        }
        return nil
    }

    /// to get staus code
    /// - Parameter response: response data
   static func getStatusCode(_ response: Any?) -> String?{
        if let data = response as? [String : Any] {
            if let errCode = data[APIConstants.Keys.statusCode] as? String {
                return errCode
            }
        }
        return nil
    }

    /// This method returns the data request object including the request url,
    /// method, parameters and headers if any.
    /// - Parameters:
    ///   - apiUrl: API url to be requested
    ///   - apiMethod: Type of request
    ///   - parameters: parameters to be send with the request
    ///   - headers: headers to be attached wiht the request
    /// - Returns: Almofire data request including the request url,
    /// method, parameters and headers if any.
    //    static func getAlamofireObject(_ apiUrl: String,
    //                                   apiMethod: HTTPMethod,
    //                                   parameters: [String: Any]?,
    //                                   headers: [String: String]?) -> DataRequest {
    //
    //        var header: [String: String] = [String: String]()
    //
    //        if let unwrappedHeaders = headers {
    //            for key in unwrappedHeaders.keys {
    //                header[key] = unwrappedHeaders[key]
    //            }
    //        }
    //        header[APIConstants.HeaderKey.appApiKey] = APIConstants.apiKey
    //        let baseUrlToUse = APIConstants.URL.base
    //        let api = Alamofire.request(baseUrlToUse + apiUrl,
    //                                    method: apiMethod,
    //                                    parameters: parameters,
    //                                    headers: header)
    //        return api
    //    }

    /// This method hit the API call with all the headers and parameters if any.
    ///
    /// - Parameters:
    ///   - apiUrl: API url to be requested
    ///   - apiMethod: Type of request
    ///   - parameters: If any parameters to be send with the request
    ///   - headers: Any headers to be attached with the request
    ///   - completionHandler: gives the response data or error if any
    ///   - result: response data
    ///   - error: error description if any
    internal static func hitAPI(_ apiUrl: String,
                                apiMethod: MethodType,
                                parameters: [String: Any]?,
                                headers: [String: String]?,
                                showLoader : Bool = true,
                                stopLoader : Bool = true,
                                completionHandler: @escaping (_ result: Any?,
        _ error: String?) -> Void) {
//        if (APPDELEGATE.isReachable == false) {
//            completionHandler(nil, NO_INTERNET_CONNECTION)
//            return
//        }
        var finalData: Any?
        var errorString: String?
        var header = headers
        //        if var unWrappedHeader = header {
        //            unWrappedHeader[APIConstants.HeaderKey.appApiKey] = APIConstants.apiKey
        //            header = unWrappedHeader
        //        } else {
        //            header = [APIConstants.HeaderKey.appApiKey: APIConstants.apiKey]
        //        }
        //        if UserSession.sessionToken != "" {
        //            header?[APIConstants.HeaderKey.sessionToken] = UserSession.sessionToken
        //        }
        if showLoader {
//            SVProgressHUD.show()
        }

        ServiceHelper.request(params: parameters ?? [:], method: apiMethod, apiName: apiUrl, headers: header) { (result, error, _) in
            if stopLoader {
//                    SVProgressHUD.dismiss()
            }
            if let JSON = result {
                print("JSON: \(JSON)")
                finalData = JSON
            } else if let ERROR = error {
                print("Error: \(ERROR)")
                errorString = ERROR.localizedDescription
                if !stopLoader {
//                    SVProgressHUD.show()
                }
            } else {
                errorString = "Unknown error occurred"
            }
            if let response = finalData as? [String: Any],
                let errResponse = response[APIConstants.Keys.message] as? [String:Any],
                let statusCode = errResponse[APIConstants.Keys.statusCode] as? Int,
                statusCode == APIConstants.StatusCode.sessionExpired {
//                SVProgressHUD.dismiss()
//                AlertController.alert(title: "",
//                                      message: getMessage(finalData) ?? "Session expired",
//                                      buttons: ["Ok"],
//                                      tapBlock: { (_, _) in
//                                      Global.sharedInstance.logout()
//                })
            } else {
                completionHandler(finalData, errorString)
            }
        }
    }

    //    static func getHeaders() -> [String: String] {
    //
    //        let requestHeaders = [APIConstants.HeaderKey.appApiKey: APIConstants.apiKey
    ////                              APIConstants.Key.session_token: UserSession.sessionToken
    //        ]
    //        return requestHeaders
    //    }
}
