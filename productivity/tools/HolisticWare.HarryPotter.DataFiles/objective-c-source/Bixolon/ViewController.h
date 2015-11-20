//
//  ViewController.h
//  sample
//
//  Created by savin on 13. 8. 7..
//  Copyright (c) 2013 savin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXPrinterController.h"

//Add 0
//  Add External Accessory
//  sample -> Build Phases -> Link Binary With Libraries ->
//  Add : [ExternalAccessory.framework]
//
//  Add Protocol
//  sample -> Info -> Add Row ->
//  Add : [supported exterßnal accessory protocols]
//  Value : com.custom.protocol

	
//Add 1
@interface ViewController : UIViewController<BXPrinterControlDelegate>
{
    //Add 2
    BXPrinterController*    _pController;
    IBOutlet    UILabel*    _uiLabelSDKVersion;
    IBOutlet    UILabel*    _uiLabelReleaseDate;
    
    IBOutlet    UILabel*    _uiMacAddress;
    IBOutlet    UILabel*    _uiPrinterName;
    IBOutlet    UILabel*    _uiFWVersion;
    IBOutlet    UILabel*    _uiPaperStatus;
    IBOutlet    UILabel*    _uiCoverStatus;
    IBOutlet    UILabel*    _uiPowerStatus;
    IBOutlet    UILabel*    _uiBluetoothDeviceName;
    
    IBOutlet    UITextField* _uiDirectIoInput;

    IBOutlet    UITextField *_uiTextFieldAddress;
    IBOutlet    UIButton    *_uiButtonMSR;
    IBOutlet    UITextField *_uiTextFieldTrack1;
    IBOutlet    UITextField *_uiTextFieldTrack2;
    IBOutlet    UITextField *_uiTextFieldTrack3;
    
    
    
    
    BXPrinter*              _pMyCustomTarget;
}
@end
