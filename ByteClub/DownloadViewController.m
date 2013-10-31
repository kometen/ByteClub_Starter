//
//  DownloadViewController.m
//  ByteClub
//
//  Created by Claus Guttesen on 19/10/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import "DownloadViewController.h"
#import "DBFile.h"

@interface DownloadViewController ()

@property (nonatomic, weak) IBOutlet UIProgressView *progress;
@property (nonatomic, weak) IBOutlet UIImageView *downloadedFileImageView;
@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *cancelButton;

@property (nonatomic, strong) NSString *path;

@end

@implementation DownloadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self downloadImage];
}

-(void)downloadImage
{
    NSLog(@"DownloadVC: %@", self.thumbnail.path);
    NSString *imageURL = @"http://www.freebsd.org/layout/images/beastie.png";
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            _downloadedFileImageView.image = downloadedImage;
        });
    }];
    
    [getImageTask resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel:(id)sender
{
    [self.delegate downloadViewControllerDidCancel:self];
}

@end
