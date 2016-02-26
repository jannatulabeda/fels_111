//
//  APIHandler.h
//  AFNetworking
//
//  Created by Jannatul Abeda on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFHTTPSessionManager.h"

@interface APIHandler : NSObject

typedef void(^ResponseSuccess)(id response);
typedef void(^ResponseFail)(NSError *error);

/**
 * Do post request
 *
 * @param url Post request url
 * @param params Parameters needed for post request
 * @param success Success block for receiving success response
 * @param fail fail block for receiving failure response
 */
+ (void)postWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(ResponseSuccess)success
                             fail:(ResponseFail)fail;

/**
 * Do get request
 *
 * @param url GET request url
 * @param params Parameters needed for get request
 * @param success Success block for receiving success response
 * @param fail fail block for receiving failure response
 */
+ (void)getWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(ResponseSuccess)success
              fail:(ResponseFail)fail;

/**
 * Do patch request
 *
 * @param url patch request url
 * @param params Parameters needed for get request
 * @param success Success block for receiving success response
 * @param fail fail block for receiving failure response
 */
+ (void)patchWithUrl:(NSString *)url
            params:(NSDictionary *)params
           success:(ResponseSuccess)success
              fail:(ResponseFail)fail;
@end
