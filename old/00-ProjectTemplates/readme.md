# Project Templates

## Xamarin Studio project templates

This projects are only for structure investigation like lifecycle etc...

## Application start
	
1. 	EntryPoint:    
	like in Console applications - static Main function of some class
	funstion: to launch AppDelegate derived class
	
	namespace Namespace		
	{
		public partial class Class
		{
			// This is the main entry point of the application.
			static void Main (string[] args)
			{
				// if you want to use a different Application Delegate class from "AppDelegate"
				// you can specify it here.
				UIApplication.Main (args, null, "AppDelegate");
			}
		}
	}
1.	AppDelegate inherited class     
	iOS - specific - actual entry point for iOS apps
	
	
	
## UI definition

UI is defined through

1. 	XIB files   
	XML files as serialized object graphs of UI Elements UIViews, UIViewCoontrolers
1.  Storyboards    

	<?xml version="1.0" encoding="UTF-8" standalone="no"?>
	<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="4451" systemVersion="13A461" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" initialViewController="vXZ-lx-hvc">
		<dependencies>
			<plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="3676" />
		</dependencies>
		<scenes>
			<!--class Prefix:identifier View Controller-->
			<scene sceneID="ufC-wZ-h7g">
				<objects>
					<viewController id="vXZ-lx-hvc" customClass="UniversalSingleViewViewController" sceneMemberID="viewController">
						<view key="view" contentMode="scaleToFill" id="kh9-bI-dsS">
							<rect key="frame" x="0.0" y="0.0" width="320" height="568" />
							<autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES" />
							<color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="calibratedWhite" />
						</view>
					</viewController>
					<placeholder placeholderIdentifier="IBFirstResponder" id="x5A-6p-PRh" sceneMemberID="firstResponder" />
				</objects>
			</scene>
		</scenes>
		<simulatedMetricsContainer key="defaultSimulatedMetrics">
			<simulatedStatusBarMetrics key="statusBar" />
			<simulatedOrientationMetrics key="orientation" />
			<simulatedScreenMetrics key="destination" type="retina4" />
		</simulatedMetricsContainer>
	</document>
