//
//  ViewController.h
//  Sample
//
//  Created by savin on 13. 11. 14..
//  Copyright (c) 2013년 savin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOSCDController.h"
//#import "frmBixolonUPOS/UPOSPrinterController.h"

@interface ViewController_CashDrawer : UIViewController <UPOSDeviceControlDelegate>
{
    IBOutlet    UITableView     *_tblCashDrawerList;
    IBOutlet    UIView          *_subView;
    
    IBOutlet UISegmentedControl *_segOpenClose;
    IBOutlet UISegmentedControl *_segClaimRelease;
    IBOutlet UISegmentedControl *_segEnableDisable;
    
    
    IBOutlet UITextField        *_uiTextField_ResultCode;
    IBOutlet UITextField        *_uiTextField_ResultCodeExtended;
    IBOutlet UITextField        *_uiTextField_State;
    
    IBOutlet UITextField        *_uiTextField_ErrorLevel;
    IBOutlet UITextField        *_uiTextField_ErrorStation;
    IBOutlet UITextField        *_uiTextField_ErrorString;
    
    IBOutlet UITextView *_uiTextViewHistory;
    
    UPOSCDController            *_uposCDController;
    UPOSDevices                 *_deviceList;
    long                        _uposResult;
    
    NSArray                     *_subViewList;
    
}

//  Alert
- (void) message:(NSString *)message;
// Status Update
-(void) displayResult;


/********************************************************/
//  IBActions..
- (IBAction)changeSubViewValue:(UISegmentedControl *)sender;
- (IBAction)printerOpenClose:(UISegmentedControl *)sender;
- (IBAction)printerClaimRelease:(UISegmentedControl *)sender;
- (IBAction)printerEnableDisable:(UISegmentedControl *)sender;

- (IBAction)onGetStatus:(id)sender;



/***********************************************************/
//  Call to Method for Printer for SubViews Menu
- (IBAction)openDrawer:(id)sender;

@end
