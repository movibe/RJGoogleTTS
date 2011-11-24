//
//  RJGoogleTTS.m
//  iGod
//
//  Created by Rishabh Jain on 11/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RJGoogleTTS.h"

@implementation RJGoogleTTS
@synthesize delegate, downloadedData;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)convertTextToSpeech:(NSString *)searchString {
    NSString *search = [NSString stringWithFormat:@"http://translate.google.com/translate_tts?q=%@", searchString];
    search = [search stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"Search: %@", search);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:search]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [delegate sentAudioRequest];
    downloadedData = [[NSMutableData alloc] initWithLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[self.downloadedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.downloadedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Failure");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [delegate receivedAudio:self.downloadedData];
}

@end
