//
//  SFSDKIDPLoginRequestWithChallengeHandler.m
//  SalesforceSDKCore
//
//  Created by Brianna Birman on 4/18/23.
//  Copyright (c) 2023-present, salesforce.com, inc. All rights reserved.
// 
//  Redistribution and use of this software in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//  * Redistributions of source code must retain the above copyright notice, this list of conditions
//  and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list of
//  conditions and the following disclaimer in the documentation and/or other materials provided
//  with the distribution.
//  * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
//  endorse or promote products derived from this software without specific prior written
//  permission of salesforce.com, inc.
// 
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
//  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
//  WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "SFSDKIDPAuthCodeLoginRequestHandler.h"
#import "SFSDKIDPAuthCodeLoginRequestCommand.h"
#import "SFUserAccountManager+URLHandlers.h"

@implementation SFSDKIDPAuthCodeLoginRequestHandler

- (BOOL)canHandleRequest:(NSURL *)url options:(NSDictionary *)options {
    SFSDKIDPAuthCodeLoginRequestCommand *command = [[SFSDKIDPAuthCodeLoginRequestCommand alloc] init];
    return [command isAuthCommand:url];
}

- (BOOL)processRequest:(NSURL *)url options:(NSDictionary *)options {

    SFSDKIDPAuthCodeLoginRequestCommand *command = [[SFSDKIDPAuthCodeLoginRequestCommand alloc] init];
    [command fromRequestURL:url];

    [[SFUserAccountManager sharedInstance] handleIdpRequest:command sceneId:options[kSFIDPSceneIdKey] completion:nil failure:nil];
    return NO;

}

- (BOOL)processRequest:(NSURL *)url
               options:(NSDictionary *)options
            completion:(SFUserAccountManagerSuccessCallbackBlock)completionBlock
               failure:(SFUserAccountManagerFailureCallbackBlock)failureBlock {
    SFSDKIDPAuthCodeLoginRequestCommand *command = [[SFSDKIDPAuthCodeLoginRequestCommand alloc] init];
    [command fromRequestURL:url];

    [[SFUserAccountManager sharedInstance] handleIdpRequest:command sceneId:options[kSFIDPSceneIdKey] completion:completionBlock failure:failureBlock];
    return NO; // TODO why NO
    
}


@end
