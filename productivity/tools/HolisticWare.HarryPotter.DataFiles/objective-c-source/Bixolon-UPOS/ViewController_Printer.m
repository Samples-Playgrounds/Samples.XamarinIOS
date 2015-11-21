
//
//  ViewController.m
//  Sample
//
//  Created by savin on 13. 11. 14..
//  Copyright (c) 2013년 savin. All rights reserved.
//

#import "ViewController_Printer.h"
//#import "UPOSPrinterController.h"
#import "ViewController_PrinterSubViewEventHistory.h"
#import "ViewController_PrinterSubViewText.h"
#import "ViewController_PrinterSubViewBitmap.h"
#import "ViewController_PrinterSubViewBarcode.h"
@interface ViewController_Printer ()
{
    ViewController_PrinterSubViewEventHistory*   _subViewEventHistory;
    ViewController_PrinterSubViewText*           _subViewPrinter_Text;
    ViewController_PrinterSubViewBitmap*         _subViewPrinter_Bitmap;
    ViewController_PrinterSubViewBarcode*         _subViewPrinter_Barcode;
//    ViewController_SubView*   _subViewPrinter_Text;
}
@end

@implementation ViewController_Printer

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _uposPrinterController =   [UPOSPrinterController new];
    _uposPrinterController.delegate = self;
    _uposPrinterController.CharacterSet = 437;
    _deviceList =   [_uposPrinterController getRegisteredDevice];
    _historyEvents = @"";
    
//    NSLog(@"support Device List : %@", [_uposPrinterController getSupportDevices]);
    
    [_tblPrinterList reloadData];
    
    [self initialize_SubViews];
}

- (void)dealloc
{
    [_uposPrinterController release];
    [_segOpenClose release];
    [_segClaimRelease release];
    [_segEnableDisable release];
    [_segFreezeEvents release];
    [_segPowerNotify release];
    [_segCartridgeNotify release];
    [_segAsyncMode release];
    
//    _subViewList
    
    for(id p in _subViewList)
    {
        [p release];
    }
    [_subViewList release];
    
    [_segChangeView release];
    [_uiTextField_ResultCode release];
    [_uiTextField_ResultCodeExtended release];
    [_uiTextField_State release];
    [_segTransactionMode release];
    [_uiTextField_ErrorLevel release];
    [_uiTextField_ErrorStation release];
    [_uiTextField_ErrorString release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initialize_SubViews
{
    //  _subView 들을 표시해주는 서브뷰 껍데기가 명확히 보이도록 테두리 삽입.
    _subView.layer.borderWidth = 1.0;
    _subView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    _subView.layer.cornerRadius= 8;
    
//    [_tabBar addSubview:_subView];
    
    // UIStoryboard 생성
    UIStoryboard *storyBoard;
    if(_IS_IPAD)
    {
        // UIStoryboard 생성
        storyBoard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    }
    else
    {
        // UIStoryboard 생성
        storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    }
    
    // 생성한 UIStoryboard에서  initial view controller를 가져온다.
    _subViewEventHistory = [storyBoard instantiateViewControllerWithIdentifier:@"View_SubViewEventHistory"];
    [_subViewEventHistory parent:self];
    _subViewPrinter_Text = [storyBoard instantiateViewControllerWithIdentifier:@"View_PrinterSubView_Text"];
    [_subViewPrinter_Text parent:self];
    
    _subViewPrinter_Bitmap =[storyBoard instantiateViewControllerWithIdentifier:@"View_PrinterSubView_Bitmap"];
    [_subViewPrinter_Bitmap parent:self];

    _subViewPrinter_Barcode =[storyBoard instantiateViewControllerWithIdentifier:@"View_PrinterSubView_Barcode"];
    [_subViewPrinter_Barcode parent:self];

    
    [_subViewEventHistory retain];
    [_subViewPrinter_Text retain];
    [_subViewPrinter_Bitmap retain];
    [_subViewPrinter_Barcode retain];
    
    _subViewList = [[NSArray alloc] initWithObjects:_subViewEventHistory.view, _subViewPrinter_Text.view, _subViewPrinter_Barcode.view, _subViewPrinter_Bitmap.view, nil];
    
//    UITabBarController* test;
//    test.viewControllers
    
    [self doChangeSubView:[_subViewList objectAtIndex:_segChangeView.selectedSegmentIndex]];
}

-(BOOL) doChangeSubView:(UIView*)view
{
    if(view == nil)
        return NO;
//    NSLog(@"userInteractionsEnabled : %d", _subView.userInteractionEnabled);
    [view setFrame:CGRectMake(0,0, _subView.frame.size.width, _subView.frame.size.height)];
    _subView.userInteractionEnabled = YES;
    [_subView addSubview:view];
    return YES;
}


//  Alert
- (void) message:(NSString *)message
{
//	UIAlertView	*aView	= [[UIAlertView alloc]
//						   initWithTitle:@"UPOS Sample"
//						   message:message
//						   delegate:nil
//						   cancelButtonTitle:NSLocalizedString(@"Confirm", @"")
//						   otherButtonTitles:nil];
//	//self.alertView	= aView;
//	[aView show];
//	[aView release];
	
}

-(NSString*) getStringForErrorLevel:(NSInteger)level
{
    switch (level) {
        case PTR_EL_NONE:
            return @"PTR_EL_NONE";
        case PTR_EL_RECOVERABLE:
            return @"PTR_EL_RECOVERABLE";
        case PTR_EL_FATAL:
            return @"PTR_EL_FATAL";
        default:
            return [NSString stringWithFormat:@"%ld", (long)level];
    }
}
-(NSString*) getStringForState:(NSInteger)State
{
    switch (State) {
        case OPOS_S_CLOSED:
            return @"OPOS_S_CLOSED";
        case OPOS_S_IDLE:
            return @"OPOS_S_IDLE";
        case OPOS_S_BUSY:
            return @"OPOS_S_BUSY";
        case OPOS_S_ERROR:
            return @"OPOS_S_ERROR";
        default:
            return [NSString stringWithFormat:@"%ld", (long)State];
    }
}
-(NSString*) getStringForErrorStation:(NSInteger)errorStation
{
    switch (errorStation) {
        case PTR_S_JOURNAL:
            return @"PTR_S_JOURNAL";
        case PTR_S_RECEIPT:
            return @"PTR_S_RECEIPT";
        case PTR_S_SLIP:
            return @"PTR_S_SLIP";
        default:
            return [NSString stringWithFormat:@"%ld", (long)errorStation];
    }
}

-(NSString*) getStringForExtendedResultCode:(NSInteger)ExtendedResultCode
{
    switch (ExtendedResultCode) {
            
        case OPOS_E_DEPRECATED:
            return @"OPOS_E_DEPRECATED";
            
        case OPOS_EPTR_COVER_OPEN:
            return @"OPOS_EPTR_COVER_OPEN";
            
        case OPOS_EPTR_REC_EMPTY:
            return @"OPOS_EPTR_REC_EMPTY";
            
        case OPOS_EPTR_TOOBIG:
            return @"OPOS_EPTR_TOOBIG";
            
        case OPOS_EPTR_BADFORMAT:
            return @"OPOS_EPTR_BADFORMAT";
            
        case OPOS_EPTR_REC_CARTRIDGE_REMOVED:
            return @"OPOS_EPTR_REC_CARTRIDGE_REMOVED";
            
        case OPOS_EPTR_REC_CARTRIDGE_EMPTY:
            return @"OPOS_EPTR_REC_CARTRIDGE_EMPTY";
            
        case OPOS_EPTR_REC_HEAD_CLEANING:
            return @"OPOS_EPTR_REC_HEAD_CLEANING";
        default:
            return [NSString stringWithFormat:@"%ld", (long)ExtendedResultCode];
    }
}
-(NSString*) getStringForResultCode:(NSInteger) ResultCode
{
    
    switch (ResultCode)
    {
        case OPOS_SUCCESS:
            return @"OPOS_SUCCESS";
            
        case OPOS_E_CLOSED:
            return @"OPOS_E_CLOSED";
            
        case OPOS_E_CLAIMED:
            return @"OPOS_E_CLAIMED";
            
        case OPOS_E_NOTCLAIMED:
            return @"OPOS_E_NOTCLAIMED";
            
        case OPOS_E_NOSERVICE:
            return @"OPOS_E_NOSERVICE";
            
        case OPOS_E_DISABLED:
            return @"OPOS_E_DISABLED";
            
        case OPOS_E_ILLEGAL:
            return @"OPOS_E_ILLEGAL";
            
        case OPOS_E_NOHARDWARE:
            return @"OPOS_E_NOHARDWARE";
            
        case OPOS_E_OFFLINE:
            return @"OPOS_E_OFFLINE";
            
        case OPOS_E_NOEXIST:
            return @"OPOS_E_NOEXIST";
            
        case OPOS_E_EXISTS:
            return @"OPOS_E_EXISTS";
            
        case OPOS_E_FAILURE:
            return @"OPOS_E_FAILURE";
            
        case OPOS_E_TIMEOUT:
            return @"OPOS_E_TIMEOUT";
            
        case OPOS_E_BUSY:
            return @"OPOS_E_BUSY";
            
        case OPOS_E_EXTENDED:
            return @"OPOS_E_EXTENDED";
            
        default:
            return [NSString stringWithFormat:@"%ld", (long)ResultCode];
    }
}

-(void) updateStringEventHistory : (NSString*) string
{
    if([_subViewEventHistory respondsToSelector:@selector(updateStringEventHistory:)])
    {
        [_subViewEventHistory performSelector:@selector(updateStringEventHistory:) withObject:string];
    }
}
-(void) displayResult
{
    // Status Update
    _segOpenClose.selectedSegmentIndex      = (_uposPrinterController.State == OPOS_S_CLOSED)?0:1;
    _segEnableDisable.selectedSegmentIndex  = (NSInteger)_uposPrinterController.DeviceEnabled;
    _segClaimRelease.selectedSegmentIndex   = _uposPrinterController.Claimed;
    
    _segFreezeEvents.selectedSegmentIndex   = _uposPrinterController.FreezeEvents;
    _segPowerNotify.selectedSegmentIndex    = _uposPrinterController.PowerNotify;
    _segCartridgeNotify.selectedSegmentIndex= _uposPrinterController.CartridgeNotify;
    _segAsyncMode.selectedSegmentIndex      = _uposPrinterController.AsyncMode;
//    
//    switch (_uposResult) {
//        case OPOS_SUCCESS:
//            [self message:@"SUCCESS"];
//            break;
//            
//        default:
//            [self message:@"FAIL"];
//            break;
//    }

    
    _uiTextField_ResultCode.text            = [self getStringForResultCode:_uposPrinterController.ResultCode];
    _uiTextField_ResultCodeExtended.text    = [self getStringForExtendedResultCode:_uposPrinterController.ResultCodeExtended];
    _uiTextField_State.text                 = [self getStringForState:_uposPrinterController.State];
    _uiTextField_ErrorLevel.text            = [self getStringForErrorLevel:_uposPrinterController.ErrorLevel];
    _uiTextField_ErrorStation.text          = [self getStringForErrorStation:_uposPrinterController.ErrorStation];
    _uiTextField_ErrorString.text           = _uposPrinterController.ErrorString;
}


//////////////////////////////////////////////////////////////////////////////////////
#pragma mark UPOS_EVENTS
- (void) DataEvent:(NSNumber *)Status
{
    NSLog(@"!!!!!!!!!!!!  (Printer) Data Event : %ld !!!!!!!!!!!", (long)Status.integerValue);
}

- (void)OutputCompleteEvent:(NSNumber*)OutputID
{
    NSLog(@"!!!!!!!!!!!!  Output Complete : %ld !!!!!!!!!!!", (long)OutputID.integerValue);
    NSString *message = [NSString stringWithFormat:@"[OutputCompleteEvent] outputID : %ld", (long)OutputID.integerValue];
    [self updateStringEventHistory:message];
}


- (void)ErrorEvent:(NSNumber*) ErrorCode
 ErrorCodeExtended:(NSNumber*) ErrorCodeExtended
        ErrorLocus:(NSNumber*) ErrorLocus
     ErrorResponse:(NSNumber*) ErrorResponse
{
    NSLog(@"!!!!!!!!!!!!  Error Event !!!!!!!!!!!");
    NSString *message = [NSString stringWithFormat:@"[ErrorEvent] ErrorCode:%ld / ErrorCodeExtended:%ld, ErrorLocus:%ld, ErrorResponse:%ld", (long)ErrorCode.integerValue, (long)ErrorCodeExtended.integerValue, (long)ErrorLocus.integerValue, (long)ErrorResponse.integerValue];
    [self updateStringEventHistory:message];
}

-(void)StatusUpdateEvent:(NSNumber*) Status
{
    NSLog(@"!!!!!!!!!!!!  StatusUpdateEvent : %ld !!!!!!!!!!!", (long)Status.integerValue);
    NSString *message;
    switch([Status integerValue])
    {
        case PTR_SUE_COVER_OPEN:
            [self message:@"Cover Opened"];
            message = [NSString stringWithFormat:@"[StatusUpdateEvent] Cover Open"];
            break;
        case PTR_SUE_COVER_OK:
            [self message:@"Cover OK"];
            message = [NSString stringWithFormat:@"[StatusUpdateEvent] Cover OK"];
            break;
        case PTR_SUE_REC_EMPTY:
            [self message:@"Paper Empty"];
            message = [NSString stringWithFormat:@"[StatusUpdateEvent] Paper Empty"];
            break;
        case PTR_SUE_REC_PAPEROK:
            [self message:@"Paper OK"];
            message = [NSString stringWithFormat:@"[StatusUpdateEvent] Paper OK"];
            break;
        case PTR_SUE_REC_NEAREMPTY:
            [self message:@"Paper Near end"];
            message = [NSString stringWithFormat:@"[StatusUpdateEvent] Paper Near End"];
            break;
            
        case OPOS_SUE_POWER_OFF:
        case OPOS_SUE_POWER_OFF_OFFLINE:
        case OPOS_SUE_POWER_OFFLINE:
            [self message:@"Device off or offLine"];
            message = [NSString stringWithFormat:@"[StatusUpdateEvent] Device off or offLine"];
            break;
            
        case OPOS_SUE_POWER_ONLINE:
            [self message:@"Device OnLine"];
            message = [NSString stringWithFormat:@"[StatusUpdateEvent] Device OnLine"];
            break;
        default:
            message = [NSString stringWithFormat:@"[StatusUpdateEvent] UNKNOWN"];
    }
    
    [self updateStringEventHistory:message];
    
}

#pragma mark -
//////////////////////////////////////////////////////////////////////////////////////
#pragma mark UITableView dataSource / delegate Methods
//////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[_deviceList getList] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section
{
    return @"";
}

- (UITableViewCell *)getCell:(UITableView *)_tableView
{
	static NSString	*reuseId	= @"DeviceCell";
	
    UITableViewCell	*cell	= [_tableView dequeueReusableCellWithIdentifier:reuseId];
	
	if( nil == cell )
	{
        cell    = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:nil];//reuseId];
        [cell autorelease];
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height = 35;
	return (height=35);
}


///////////////////////////////////////////////////////////////////////////////////
// 보여줄 Cell 생성
///////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)_tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell       = [self getCell:_tableView];
    
    
    if(_deviceList)
    {
        if(indexPath.row >= [[_deviceList getList] count])
        {
            return cell;
        }
        
        UPOSPrinter      *device  = [[_deviceList getList] objectAtIndex:indexPath.row];
        
        cell.textLabel.text  = device.modelName;  //[NSString stringWithFormat:@"%@ (%@)", device.modelName, device.address];
    }
    
	return cell;
}


///////////////////////////////////////////////////////////////////////////////////
// Printer가 선택되었다.
///////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"+ willSelectRowAtIndexPath\r\n");
//    NSLog(@"- willSelectRowAtIndexPath\r\n");
	return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"+ willDeselectRowAtIndexPath\r\n");
//    NSLog(@"- willDeselectRowAtIndexPath\r\n");
	return indexPath;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"+ didSelectRowAtIndexPath\r\n");
//    Device* device  = [[_deviceList getList]" objectAtIndex:indexPath.row];
//    _labelName.text     = [NSString stringWithFormat:@"%@",device.modelName];
//    _labelLDN.text      = [NSString stringWithFormat:@"%@",device.ldn];
//    switch ([device.interfaceType intValue])
//    {
//        case 1: // Ethernet
//        case 2: // Wifi
//            _labelPort.text     = [NSString stringWithFormat:@"IP_%@:%@",device.address, device.port];
//            
//            break;
//        case 4: // BT
//            _labelPort.text     = [NSString stringWithFormat:@"BT_%@",device.address];
//            break;
//    }
//    //    _labelPort.text     = [NSString stringWithFormat:@"%@",device.port];
//    
//    NSLog(@"- didSelectRowAtIndexPath\r\n");
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"+ commitEditingStyle\r\n");
//    NSLog(@"- commitEditingStyle\r\n");
}

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"+ canEditRowAtIndexPath\r\n");
//    NSLog(@"- canEditRowAtIndexPath\r\n");
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"+ editingStyleForRowAtIndexPath\r\n");
//    NSLog(@"- editingStyleForRowAtIndexPath\r\n");
	return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView
willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"+ willBeginEditingRowAtIndexPath\r\n");
//    NSLog(@"- willBeginEditingRowAtIndexPath\r\n");
}

- (void)tableView:(UITableView *)tableView
didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"+ didEndEditingRowAtIndexPath\r\n");
//    NSLog(@"- didEndEditingRowAtIndexPath\r\n");
}
// (+)bixolon[2011.08.02] : End  tableView's Delegate


/********************************************************/
//  IBActions..
- (IBAction)changeSubViewValue:(UISegmentedControl *)sender
{
    if([_subViewList count] <= sender.selectedSegmentIndex)
        return;
    [self doChangeSubView:[_subViewList objectAtIndex:sender.selectedSegmentIndex]];
    
}

- (IBAction)printerOpenClose:(UISegmentedControl*)sender
{
    NSIndexPath*    indexPath = [_tblPrinterList indexPathForSelectedRow];
    UPOSPrinter* device  = [[_deviceList getList] objectAtIndex:indexPath.row];

    if(sender.selectedSegmentIndex == 0)
    {
        _uposResult = [_uposPrinterController close];
    }
    else
    {
        _uposResult = [_uposPrinterController open:device.modelName];
    }
//    [self displayResult:_uposResult];
    
    [self displayResult];
    
}
- (IBAction)printerClaimRelease:(UISegmentedControl*)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        _uposResult = [_uposPrinterController releaseDevice];
    }
    else
    {
        _uposResult = [_uposPrinterController claim:5000];
    }
    //    [self displayResult:_uposResult];
    
    [self displayResult];
}
- (IBAction)printerEnableDisable:(UISegmentedControl*)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        _uposPrinterController.DeviceEnabled = NO;
    }
    else
    {
        _uposPrinterController.DeviceEnabled = YES;
    }
    
    [self displayResult];
}


- (IBAction)eventFreeze:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        _uposPrinterController.FreezeEvents = NO;
    }
    else
    {
        _uposPrinterController.FreezeEvents = YES;
    }
    
    [self displayResult];
}

- (IBAction)powerNotifyOnOff:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        _uposPrinterController.FreezeEvents = NO;
    }
    else
    {
        _uposPrinterController.FreezeEvents = YES;
    }
    
    [self displayResult];
}

- (IBAction)cartridgeNotifyOnOff:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        _uposPrinterController.PowerNotify = OPOS_PN_DISABLED;
    }
    else
    {
        _uposPrinterController.FreezeEvents = OPOS_PN_ENABLED;
    }
    
    [self displayResult];
}

- (IBAction)asyncModeOnOff:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        _uposPrinterController.AsyncMode = NO;
    }
    else
    {
        _uposPrinterController.AsyncMode = YES;
    }
    
    [self displayResult];
}

- (IBAction)transactionONOff:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        [_uposPrinterController transactionPrint:PTR_S_RECEIPT control:PTR_TP_NORMAL];
    }
    else
    {
        [_uposPrinterController transactionPrint:PTR_S_RECEIPT control:PTR_TP_TRANSACTION];
    }
    
    [self displayResult];
}

- (IBAction)onGetStatus:(id)sender
{
//    _uposPrinterController State
    [self displayResult];
}


/***********************************************************/
//  Call to Method for Printer for SubViews Menu
-(void) checkHealth : (NSInteger) type
{
    [_uposPrinterController checkHealth:type];
    
    [self displayResult];

}
-(void) printNormal : (NSString*) string
{
    [_uposPrinterController printNormal:PTR_S_RECEIPT data:string];
    
    [self displayResult];
}

-(void) printBarcode :(NSString *) BarcodeData
            symbology:(NSInteger) Symbology
               height:(NSInteger)Height
                width:(NSInteger)Width
            alignment:(NSInteger)Alignment
          textPostion:(NSInteger)textPosition
{
    [_uposPrinterController printBarcode:PTR_S_RECEIPT data:BarcodeData symbology:Symbology height:Height width:Width alignment:Alignment textPostion:textPosition];
    
    [self displayResult];
}


-(void) printBitmap :(NSString *) fileName
{
    [_uposPrinterController printBitmap:PTR_S_RECEIPT fileName:fileName width:_uposPrinterController.RecLineWidth alignment:PTR_BM_CENTER];
    
    [self displayResult];
}


-(void) printBitmapWithImage :(UIImage *) image
{
    [_uposPrinterController printBitmap:PTR_S_RECEIPT image:image width:_uposPrinterController.RecLineWidth alignment:PTR_BM_CENTER];
    
    [self displayResult];
}

-(void) feed:(NSInteger) type
{
    [_uposPrinterController printNormal:PTR_S_RECEIPT data:@"\r\n"];
    
    [self displayResult];
}

-(void) cutPaper:(NSInteger)percentage
{
    [_uposPrinterController cutPaper:percentage];
    
    [self displayResult];
}


@end




















