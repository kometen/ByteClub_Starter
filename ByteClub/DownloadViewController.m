//
//  DownloadViewController.m
//  ByteClub
//
//  Created by Claus Guttesen on 19/10/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()

@property (nonatomic, weak) IBOutlet UIProgressView *progress;
@property (nonatomic, weak) IBOutlet UIImageView *downloadView;
@property (nonatomic, weak) IBOutlet UILabel *label;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
