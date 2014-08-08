@interface DOMHTMLImageElement : NSObject
@property (nonatomic, retain) NSURL *absoluteImageURL;
@end

@interface DOMNode : NSObject
- (id)_realNode;
@end

static NSURL *imageURL;

%hook UIWebDocumentView

- (SEL)_actionForLongPressOnElement:(id)element {
	if ([[element _realNode] isKindOfClass:%c(DOMHTMLImageElement)]) {
		DOMHTMLImageElement *elementNode = (DOMHTMLImageElement *)[element _realNode];
		imageURL = elementNode.absoluteImageURL;
	}
	return %orig;
}

- (void)_showImageSheet {
		NSArray *shareArray = [NSArray arrayWithObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]]];
		UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:shareArray applicationActivities:nil];
		[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:activityController animated:YES completion:nil];
		[activityController release];
}

%end