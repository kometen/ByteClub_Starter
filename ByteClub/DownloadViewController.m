//
//  DownloadViewController.m
//  ByteClub
//
//  Created by Claus Guttesen on 19/10/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import "DownloadViewController.h"
#import "PhotoCell.h"
#import "DBFile.h"
#import "Dropbox.h"

@interface DownloadViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLSessionDownloadDelegate>

@property (nonatomic, weak) IBOutlet UIProgressView *progress;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *filenameLabel;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *cancelButton;

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
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{@"Authorization": [Dropbox apiAuthorizationHeader]}];
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    _filenameLabel.text = [self.myImage.path lastPathComponent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource and UITableViewDelegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

// stackoverflow.com/questions/12551070/display-the-tableview-row-selected-in-nslog
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _messageLabel.text = @"Tap Tap";
    [self downloadImage];
}

-(void)downloadImage
{
    NSString *imageURL = [[NSString stringWithFormat:@"https://api-content.dropbox.com/1/files/%@%@", self.myImage.root, self.myImage.path] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSString *imageURL = @"http://www.freebsd.org/layout/images/beastie.png";
    NSLog(@"imageURL: %@", imageURL);
    NSURLSessionDownloadTask *getImageTask = [_session downloadTaskWithURL:[NSURL URLWithString:imageURL]];
    [getImageTask resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThumbnailCell";
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = selectionColor;
    
    cell.downloadableImage.image = self.myImage.thumbNail;
    
    // Configure the cell...
    return cell;
}

#pragma mark - NSURLSessionDownloadDelegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_progress setProgress:(double)totalBytesWritten / (double)totalBytesExpectedToWrite animated:YES];
    });
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"Image downloaded");
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

/*
- (IBAction)choosePhoto:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
*/

-(IBAction)cancel:(id)sender
{
    [self.delegate downloadViewControllerDidCancel:self];
}

@end
