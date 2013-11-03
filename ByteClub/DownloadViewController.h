//
//  DownloadViewController.h
//  ByteClub
//
//  Created by Claus Guttesen on 19/10/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownloadViewController;
@class DBFile;

@protocol DownloadViewControllerDelegate <NSObject>

-(void)downloadViewControllerDidCancel:(DownloadViewController *)controller;

@end

@interface DownloadViewController : UIViewController

@property (nonatomic, weak) id<DownloadViewControllerDelegate> delegate;
@property (nonatomic, strong) DBFile *myImage;
@property (nonatomic, strong) NSURLSession *session;

@end
