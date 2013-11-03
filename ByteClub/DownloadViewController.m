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

@interface DownloadViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UIProgressView *progress;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
//@property (nonatomic, weak) IBOutlet UIImageView *downloadedFileImageView;
@property (nonatomic, weak) IBOutlet UILabel *filenameLabel;
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
    [self showImage];
//    [self downloadImage];
}

-(void)showImage
{
    _filenameLabel.text = [self.myImage.path lastPathComponent];
//    _downloadedFileImageView.image = self.myImage.thumbNail;
}

/*
-(void)downloadImage
{
//    NSString *imageURL = [NSString stringWithFormat:@"https://api-content.dropbox.com/1/files/%@%@", self.thumbnail.root, self.thumbnail.path];
    NSString *imageURL = @"http://www.freebsd.org/layout/images/beastie.png";
    NSLog(@"imageURL: %@", imageURL);
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            _downloadedFileImageView.image = self.myImage.thumbNail;
//            _downloadedFileImageView.image = downloadedImage;
        });
    }];
    
    [getImageTask resume];
}
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
