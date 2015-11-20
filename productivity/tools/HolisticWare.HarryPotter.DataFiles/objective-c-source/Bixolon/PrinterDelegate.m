//
//  ViewController.m
//  sample
//
//  Created by savin on 13. 8. 7..
//  Copyright (c) 2013 savin. All rights reserved.
//


#ifdef _PRINTER_DELEGATE_ACTIONS_

//////////////////////////////////////////////////////////////////////////////////////
// (+)sbson[2011.08.02] : Start  BXPrinterController's Delegate
//////////////////////////////////////////////////////////////////////////////////////
#pragma mark BXPrinterController delegate Methods
//////////////////////////////////////////////////////////////////////////////////////

- (void)message:(BXPrinterController *)controller
text:(NSString *)text
{
    NSLog(@"[Sample message] %@", text);

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"sample" message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}



-(void)didUpdateStatus:(BXPrinterController*) controller
status:(NSNumber*) status
{
    NSLog(@"didUpdateStatus");
}


- (void)msrArrived:(BXPrinterController *)controller
track:(NSNumber *)track
{
    NSLog(@"msrArrived");
    
    
    [_uiButtonMSR setTitle:@"MSR Ready" forState:UIControlStateNormal];

    NSData	*data = nil;
	if( [track intValue] & BXL_MSG_TRACK1 )
	{
		if( BXL_SUCCESS == [controller msrGetTrack:BXL_MSG_TRACK1 response:&data] )
		{
			_uiTextFieldTrack1.text	= [NSString stringWithFormat:@"%s", data.bytes];
		}
	}
	if( [track intValue] & BXL_MSG_TRACK2 )
	{
		if( BXL_SUCCESS == [controller msrGetTrack:BXL_MSG_TRACK2 response:&data] )
		{
			_uiTextFieldTrack2.text	= [NSString stringWithFormat:@"%s", data.bytes];
		}
	}
	if( [track intValue] & BXL_MSG_TRACK3 )
	{
		if( BXL_SUCCESS == [controller msrGetTrack:BXL_MSG_TRACK3 response:&data] )
		{
			_uiTextFieldTrack3.text	= [NSString stringWithFormat:@"%s", data.bytes];
		}
	}
}

- (void)msrTerminated:(BXPrinterController *)controller
{
    NSLog(@"msrTerminated");
}

- (void)willLookupPrinters:(BXPrinterController *)controller
{
    NSLog(@"willLookupPrinters");
    
}

- (void)didLookupPrinters:(BXPrinterController *)controller
{
    NSLog(@"didLookupPrinters");
    
    //Add 8
    [_pController selectTarget];
}

- (void)didFindPrinter:(BXPrinterController *)controller
printer:(BXPrinter *)printer
{
    NSLog(@"didFindPrinter \r\n    * target Name : %@    * target BDN : %@", printer.name, printer.bluetoothDeviceName);
    
    //Add 7
    _pController.target = printer;
}

- (void)willConnect:(BXPrinterController *)controller
printer:(BXPrinter *)printer
{
    NSLog(@"willConnect");
}

- (void)didConnect:(BXPrinterController *)controller
printer:(BXPrinter *)printer
{
    NSLog(@"didConnect");
    
    NSLog(@"=========== Information Printing Start  ===========\r\n");
    NSLog(@" * printer modelStr : %@ \r\n", printer.modelStr);
    NSLog(@" * printer address : %@ \r\n", printer.address);
    NSLog(@" * printer macAddress : %@ \r\n", printer.macAddress);
    NSLog(@"=========== Information Printing Finish ===========\r\n");
}

- (void)didNotConnect:(BXPrinterController *)controller
printer:(BXPrinter *)printer
withError:(NSError *)error
{
    NSLog(@"didNotConnect");
}

- (void)didDisconnect:(BXPrinterController *)controller
printer:(BXPrinter *)printer
{
    NSLog(@"didDisconnect");
}

- (void)didBeBrokenConnection:(BXPrinterController *)controller
printer:(BXPrinter *)printer
withError:(NSError *)error
{
    NSLog(@"didBeBrokenConnection");
}
#endif