//
//  APIHandler.m
//  AFNetworking
//
//  Created by Jannatul Abeda on 2/18/16.
//  Copyright © 2016 Jannatul Abeda. All rights reserved.
//

#import "APIHandler.h"

@implementation APIHandler

/**
 * Create AFHTTPSessionManager
 * @param N/A
 * @return AFHTTPSessionManager object
 */
+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return manager;
}

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
               fail:(ResponseFail)fail {
    
    // Get session manager
    AFHTTPSessionManager *manager = [self manager];
    
    // Make post request
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

@end
