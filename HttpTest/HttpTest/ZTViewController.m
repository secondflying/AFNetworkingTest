//
//  ZTViewController.m
//  HttpTest
//
//  Created by 赵飞 on 13-1-14.
//  Copyright (c) 2013年 赵飞. All rights reserved.
//

#import "ZTViewController.h"

#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFRestAPIClient.h"
#import "UIImageView+AFNetworking.h"

@interface ZTViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *menuImage;

@end

@implementation ZTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getJSONString:(id)sender {
    [[AFRestAPIClient sharedClient] getPath:@"restaurants" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"返回实体: %@", responseObject);
        NSLog(@"返回头: %@", [operation.response allHeaderFields]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误: %@", error);

    }];

}


- (IBAction)postForm:(id)sender {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (__bridge NSString *)CFStringCreateCopy( NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    
    //TODO 保存udid到NSUserDefaults，下次从NSUserDefaults里去，要不每次都不一样
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            result, @"udid",
                            @"2", @"ptype",
                            nil];

    [[AFRestAPIClient sharedClient] postPath:@"device" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"返回实体: %@", responseObject);
        NSLog(@"返回头: %@", [operation.response allHeaderFields] );

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误: %@", error);
    }];
    
}

- (IBAction)getImage:(id)sender {
    [self.menuImage setImageWithURL:[NSURL URLWithString:@"http://192.168.1.106:8080/MenuImages/1e53609b-0589-4c3a-8ade-53bf75eea588.jpg"]];

}


- (void)viewDidUnload {
    [self setMenuImage:nil];
    [super viewDidUnload];
}
@end
