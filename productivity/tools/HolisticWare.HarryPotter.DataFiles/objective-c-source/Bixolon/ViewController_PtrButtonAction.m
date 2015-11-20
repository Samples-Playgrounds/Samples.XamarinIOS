//
//  ViewController_PtrButtonAction.m
//  sample
//
//  Created by savin on 13. 8. 7..
//  Copyright (c) 2013 savin. All rights reserved.
//

#define _USE_LINESPACE_ENTER 0

#ifdef _PRINTER_BUTTON_ACTIONS_


- (IBAction) buttonUp_PrintPDF:(id)sender
{
    NSLog(@" PrintPDF Button Up.");
    
    //Add 13
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Bixolon" ofType:@"pdf"];
    int nLevel = 1050;
    
    _pController.imageDitheringWithIgnoreWhite = YES;
    [_pController printPDF:path
                pageNumber: 1
                     width:-1
                      level:nLevel];
}

- (IBAction) buttonUp_PrintImage:(id)sender
{
    NSLog(@" PrintImage Button Up.");
    
	//Add 13
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"png"];
    int nLevel = 50;
    [_pController printBitmap:path width:BXL_WIDTH_FULL level: nLevel];
    
}

- (IBAction) buttonUp_GetStatus:(id)sender
{
    //Add 14
    if(BXL_SUCCESS==[_pController checkPrinter:BXL_MASK_ALL])
    {
        _uiPrinterName.text = _pController.target.modelStr;
        _uiFWVersion.text = _pController.target.versionStr;
        _uiMacAddress.text  = _pController.target.macAddress;
        _uiCoverStatus.text = (_pController.state&BXL_STS_COVEROPEN)?@"OPENED": @"CLOSED";
        _uiPaperStatus.text = (_pController.state&BXL_STS_PAPEREMPTY)?@"EMPTY": @"FILL";
        
        _uiBluetoothDeviceName.text = _pController.target.bluetoothDeviceName;
        
        switch(_pController.power)
        {
            case BXL_PWR_HIGH:
                _uiPowerStatus.text = @"HIGH";
                break;
            case BXL_PWR_MIDDLE:
                _uiPowerStatus.text = @"MIDDLE";
                break;
            case BXL_PWR_LOW:
                _uiPowerStatus.text = @"LOW";
                break;
            case BXL_PWR_SMALL:
                _uiPowerStatus.text = @"SMALL";
                break;
            case BXL_PWR_NOT:
                _uiPowerStatus.text = @"NOT";
                break;
        }
        
        
        NSString* strPrintText = [NSString stringWithFormat:@" printer Name : %@\r\n FWVersion:%@\r\n MacAddress : %@\r\n CoverStatus : %@\r\n PaperStatus : %@\r\n PowerStatus : %@\r\n", _uiPrinterName.text, _uiFWVersion.text, _uiMacAddress.text, _uiCoverStatus.text, _uiPaperStatus.text, _uiPowerStatus.text];
        
        [_pController printText:strPrintText];
    }
}


- (IBAction) buttonUp_DirectIO:(id)sender
{
    
    // Add 15
    //  Keyboard Hidden
    if ([_uiDirectIoInput isFirstResponder]) {
        [_uiDirectIoInput resignFirstResponder];
    }
    
    //  Data Create & string to hexa
    const char *buf = [[_uiDirectIoInput text] UTF8String];
    NSMutableData *sendData = [NSMutableData data];
    if (buf)
    {
        uint32_t len = strlen(buf);
        
        char singleNumberString[3] = {'\0', '\0', '\0'};
        uint32_t singleNumber = 0;
        for(uint32_t i = 0 ; i < len; i+=2)
        {
            if ( ((i+1) < len) && isxdigit(buf[i]) && (isxdigit(buf[i+1])) )
            {
                singleNumberString[0] = buf[i];
                singleNumberString[1] = buf[i + 1];
                sscanf(singleNumberString, "%x", &singleNumber);
                uint8_t tmp = (uint8_t)(singleNumber & 0x000000FF);
                [sendData appendBytes:(void *)(&tmp) length:1];
            }
            else
            {
                break;
            }
        }
        
    }
    
    //  Send
    [_pController directIO:sendData requiredSize:0 response:nil];
}

- (IBAction) buttonUp_PrintText:(id)sender
{
    NSLog(@" PrintText Button Up.");
    
//    //Add 11
//    [_pController printText:@"This is Printing Sample\r\n\r\n"];
//    
//    _pController.alignment = BXL_ALIGNMENT_CENTER;
//    _pController.attribute = BXL_FT_BOLD|BXL_FT_FONTB;
//    _pController.textSize = BXL_TS_1WIDTH|BXL_TS_1HEIGHT;
//    [_pController printText:@"This is Printing Sample2\r\n\r\n"];
//    
//    _pController.alignment = BXL_ALIGNMENT_LEFT;
//    _pController.attribute = BXL_FT_DEFAULT;
//    _pController.textSize = BXL_TS_0WIDTH|BXL_TS_0HEIGHT;
//    [_pController printText:@"This is Printing Sample2\r\n\r\n"];
//
//    
    _pController.textEncoding = 0x0C;     //Español Encoding
    _pController.characterSet = 16;       //WPC 1252 charaterset
    [_pController printText:@"Default\r\n"];
    [_pController printText:@"AÀáàâäæãå\r\nSŠšß\r\nEèéêë\r\nŸÿyûüùú\r\nÎîïíìôöòóœøõ\r\nÑñç\r\n"];
    [_pController printText:@"abcdefghijklmn\r\n"];
    [_pController printText:@"￥123$#@%^&*)#($*%(\r\n"];
    [_pController printText:@"=================================\r\n\r\n"];

    
}
- (IBAction) buttonUp_PrintBarcode:(id)sender
{
    NSLog(@" PrintBarcode Button Up.");
    
    //Add 12
    [_pController printBarcode:"123456789012"
                     symbology:BXL_BCS_EAN13
                         width:3
                        height:100];
}


- (IBAction) buttonUp_NextPrintPos:(id)sender
{
    NSLog(@" NextPrintPos Button Up.");
    //Add 16
	[_pController nextPrintPos];
    
}

- (IBAction) buttonUp_MSR:(UIButton*)sender
{
    if([_pController isConnected])
    {
        if([sender.titleLabel.text isEqualToString:@"MSR Ready"])
        {
            [_uiButtonMSR setTitle:@"MSR Cancel" forState:UIControlStateNormal];
            [_pController msrReadReady];
        }
        else
        {
            [_pController msrReadCancel];
            [_uiButtonMSR setTitle:@"MSR Ready" forState:UIControlStateNormal];
        }
    }
}



- (IBAction) buttonUp_Disconnect:(id)sender
{
    NSLog(@" Disconnect Button Up.");
    
    //Add 10
    [_pController disconnect];
    
    if( _pMyCustomTarget )
    {
        [_pMyCustomTarget release];
        _pMyCustomTarget = nil;
    }
}

#endif