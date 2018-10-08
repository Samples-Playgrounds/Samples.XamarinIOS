/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 */

#import "AEAnnouncementViewController.h"
#import "AEViewControllerUtil.h"

@implementation AEAnnouncementViewController

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Memory management
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (instancetype)initWithAnnouncement:(AEReachAnnouncement*)anAnnouncement
{
  self = [super init];
  if (self != nil)
  {
    self.announcement = anAnnouncement;
  }
  return self;
}

- (void)dealloc
{
  [self.announcement exitContent];
  self.announcement = nil;
  [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Abstract method implementation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (AEInteractiveContent*)content
{
  return self.announcement;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Actions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)action
{
  /* If actionUrl property is defined open corresponding URL */
  NSString* actionUrl = self.announcement.actionURL;
  if (actionUrl != nil)
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:actionUrl]];

  /* Acknowledge announcement and dismiss this controller */
  [self.announcement actionContent];
  [AEViewControllerUtil dismissViewController:self animated:YES];
}

@end
