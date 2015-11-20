//
//  ViewController.m
//  sample
//
//  Created by savin on 13. 8. 7..
//  Copyright (c) 2013 savin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    //Add 3
    [self printerInitialize];
}

- (void) viewDidUnload
{
    [_uiTextFieldTrack3 release];
    _uiTextFieldTrack3 = nil;
    [_uiTextFieldTrack2 release];
    _uiTextFieldTrack2 = nil;
    [_uiTextFieldTrack1 release];
    _uiTextFieldTrack1 = nil;
    if( _pMyCustomTarget )
    {
        [_pMyCustomTarget release];
        _pMyCustomTarget = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//Add 4
-(void) printerInitialize
{
    _pController                = [BXPrinterController getInstance];
    
//    [_pController setLogLevel:0xffff password:5568];
    _pController.delegate       = self;
    _pController.lookupCount    = 5;
    _pController.AutoConnection = BXL_CONNECTIONMODE_NOAUTO;
    
    [_pController open];
    
    ////////
    
    _uiLabelSDKVersion.text = _pController.version;
    _uiLabelReleaseDate.text = _pController.releaseDate;
    
}


#define _PRINTER_BUTTON_ACTIONS_
#import "ViewController_PtrButtonAction.m"
#undef _PRINTER_BUTTON_ACTIONS_


//Add 5
#define _PRINTER_DELEGATE_ACTIONS_
#import "PrinterDelegate.m"
#undef _PRINTER_DELEGATE_ACTIONS_


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField  isFirstResponder])
        [textField resignFirstResponder];
    return YES;
}

- (IBAction) buttonUp_Lookup:(id)sender
{
    NSLog(@" Lookup / Targetting Button Up.");
    
    //Add 6
//    [_pController lookup];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//    @synchronized(self){_pController.target = nil;}
        [_pController lookup];
    });
}
- (IBAction) buttonUp_Connect:(id)sender
{
    NSLog(@" Connect Button Up.");
    
    if( _pMyCustomTarget )
    {
        [_pMyCustomTarget release];
        _pMyCustomTarget = nil;
    }
    
    if( [_uiTextFieldAddress.text length] > 3)
    {
        _pMyCustomTarget = [BXPrinter new];
        
        if( [_uiTextFieldAddress.text hasPrefix:@"IP_"])
        {
            _pMyCustomTarget.address = [_uiTextFieldAddress.text substringFromIndex:3];
            _pMyCustomTarget.port = 9100;
            _pMyCustomTarget.connectionClass = BXL_CONNECTIONCLASS_WIFI;
            
        }
        else
        {
            _pMyCustomTarget.macAddress = [_uiTextFieldAddress.text substringFromIndex:3];
            _pMyCustomTarget.connectionClass = BXL_CONNECTIONCLASS_BT;
        }
        _pController.target = _pMyCustomTarget;
        
        [_pController selectTarget];
    }
    
    //Add 9
    if( NO==[_pController connect] )
        NSLog(@"Connect Error");
}


- (void)dealloc
{
   [_uiLabelSDKVersion release];
   [_uiLabelReleaseDate release];
   
   [_uiMacAddress release];
   [_uiPrinterName release];
   [_uiFWVersion release];
   [_uiPaperStatus release];
   [_uiCoverStatus release];
   [_uiPowerStatus release];
   
    [_uiDirectIoInput release];
   
   [_uiTextFieldAddress release];
   [_uiButtonMSR release];
    [_uiTextFieldTrack1 release];
    [_uiTextFieldTrack2 release];
    [_uiTextFieldTrack3 release];
    [super dealloc];
}



@end