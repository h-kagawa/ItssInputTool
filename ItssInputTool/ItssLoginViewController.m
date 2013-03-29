//
//  ItssLoginViewController.m
//  ItssInputTool
//
//  Created by 香川 浩之 on 2013/03/04.
//  Copyright (c) 2013年 香川 浩之. All rights reserved.
//

#import "ItssLoginViewController.h"
#import "CAS.h"

@interface ItssLoginViewController ()

@end

@implementation ItssLoginViewController
@synthesize textUserID;
@synthesize textPassword;
@synthesize delegate;
@synthesize isAuthenticated;
UIActivityIndicatorView *indicator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //スクリーンサイズ取得
    CGRect r = [[UIScreen mainScreen] bounds];
    CGFloat w = r.size.width;
    CGFloat h = r.size.height;

    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake((w-50)/2, (h-50)/2, 50.0, 50.0);
    indicator.color = [UIColor grayColor];
    [self.view addSubview:indicator];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(IBAction)textFieldUserIDNext:(id)sender{
    [textPassword becomeFirstResponder];
}

-(IBAction)textFieldPasswordDone:(id)sender{
    [sender resignFirstResponder];
    [self Login:nil];
}

-(IBAction)Login:(id)sender{
    [indicator startAnimating];
    [self performSelectorInBackground:@selector(authenticate) withObject:nil];
    [_resultMessage setText:@"Authenticating..."];
}


/*
 Attempt to authenticate and get a TGT from CAS server. Provide some static
 values for this test. Normally the username & password would come from user
 input and stored somewhere for use later.
 */
- (IBAction) authenticate {
	NSString *username = textUserID.text;
	NSString *password = textPassword.text;
	NSString *casServer = @"http://server.redfalcon.biz:8888";
	NSString *casRestletPath = @"/cas/v1/tickets/";
    
	// Authenticate and get TGT
    NSLog(@"Authenticating...");
	[[CAS client] initWithCasServer:casServer
                        restletPath:casRestletPath
                           username:username
                           password:password
                    authCallbackObj:self
               authCallbackSelector:@selector(authenticationDidFinishWithStatusCode:)];
}

/*
 Callback for CAS authentication. Receives the HTTP status code given
 by CAS server and delegates action off to appropriate method.
 */
- (void) authenticationDidFinishWithStatusCode:(NSNumber *)statusNumber {
	int statusCode = [statusNumber intValue];
    
	NSLog(@"Authentication Results: %i", statusCode);
    
	// Handle authentication success/failures here
	switch (statusCode) {
		case 201:
			[self authenticationSucceeded];
			break;
		case 400:
			[self authenticationFailed:@"Invalid credentials"];
			break;
		case 0:
			[self authenticationFailed:@"No connection available"];
			[self authenticationSucceeded];
			break;
		default:
			[self authenticationFailed:@"Encountered unknown status code"];
			break;
	}
    [indicator stopAnimating];
}

/*
 Do something if the authentication is successful
 */
- (void) authenticationSucceeded {
	NSLog(@"Authentication succeeded!");
	isAuthenticated = YES;
	//[_resultMessage setText:@"Authentication succeeded!"];
    [self.delegate itssLoginViewControllerDidLogin:self];
}

/*
 Do something if the authentication fails
 */
- (void) authenticationFailed:(NSString *)reason {
	NSString *message = [NSString stringWithFormat:@"Authentication failed: %@", reason];
	NSLog(@"%@", message);
	isAuthenticated = NO;
	[_resultMessage setText:message];
}

/*
 Get data from CAS protected service
 */
- (IBAction) sendRequest {
	if (!isAuthenticated) {
		[_resultMessage setText:@"Not authenticated - try to authenticate first!"];
		return;
	}
	// Service URL for testing data retrieval
	NSURL *casProtectedService = [NSURL URLWithString:@"http://host.example.com/service-request/"];
    
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:casProtectedService];
	[[CAS client] sendAsyncRequest:request callbackObj:self callbackSelector:@selector(requestDidFinishWithDetails:)];
}

/*
 Callback for async requests. Receives the returned data from the
 connection in a dictionary.
 */
- (void) requestDidFinishWithDetails:(NSMutableDictionary *)connDetails {
    
	// Check for an error
	NSError *error = [connDetails objectForKey:@"error"];
	if (error) {
		// Do something with the error
		NSLog(@"Error found");
		[_resultMessage setText:@"Error found"];
		return;
	}
    
	// Get the response
	NSURLResponse *response = [connDetails objectForKey:@"response"];
	if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        
		// Deal with the response status
		int responseCode = [(NSHTTPURLResponse *)response statusCode];
		switch (responseCode) {
			case 200:
				NSLog(@"Request returned successful");
				//NSString *responseBody = [[NSString alloc] initWithData:[connDetails objectForKey:@"data"]
				//											   encoding:NSUTF8StringEncoding];
				// Uncomment the following to log some details
				//NSLog(@"Response Headers: %@", [(NSHTTPURLResponse *)response allHeaderFields]);
				//NSLog(@"Response Body: %@", responseBody);
				[_resultMessage setText:@"Request successful!"];
				//[requestResultBody setText:responseBody];
				break;
			case 404:
				NSLog(@"Error: 404 not found");
				[_resultMessage setText:@"Error: 404 not found"];
				break;
			default: {
				NSString *msg = [NSString stringWithFormat:@"Don't know what to do with status code: %d", responseCode];
				NSLog(@"%@", msg);
				[_resultMessage setText:msg];
				break;
			}
		}
	}
}

/*
 Sends a request to the CAS server's logout URI
 */
- (IBAction) logout {
	if (!isAuthenticated) {
		[_resultMessage setText:@"Not authenticated - try to authenticate first!"];
		return;
	}
    
	[_resultMessage setText:@"This feature is not implemented yet"];
}

@end
