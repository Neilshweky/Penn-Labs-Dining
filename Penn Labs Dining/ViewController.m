//
//  ViewController.m
//  Penn Labs Dining
//
//  Created by Neil Shweky on 9/17/17.
//  Copyright © 2017 Neil Shweky. All rights reserved.
//

#import "ViewController.h"
#import "DiningArea.h"
#import "DiningCell.h"
@interface ViewController ()<UIWebViewDelegate>
{

    NSMutableDictionary *diningCells;
    NSTimer *timer;
    UIActivityIndicatorView *activityIndicator;
    UIView *visual;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scroll.userInteractionEnabled = YES;
    [self.view addSubview: scroll];
    
// UI for some loading that I decided I no longer need.
//    visual = [[UIView alloc] initWithFrame:self.view.frame];
//    NSLog(@"VIEW %@", NSStringFromCGRect(self.view.frame));
//    visual.backgroundColor = [UIColor colorWithWhite:0.10 alpha:0.75];
//    
//    CGFloat iWidth = 50;
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-iWidth/2, self.view.frame.size.height/2-iWidth/2, iWidth, iWidth)];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];

    //Configuring the Dining Cells and Areas

    diningCells = [NSMutableDictionary dictionary];

    NSDictionary *diningHallLinks = @{
                                      @"1920 Commons":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/1920-commons/",
                                      @"English House":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/kings-court-english-house/",
                                      @"Falk Kosher Dining":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/falk-dining-commons/",
                                      @"Houston Market":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/houston-market/",
                                      @"Mark's Café":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/marks-cafe/",
                                      @"Accenture Café":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/accenture-cafe/",
                                      @"Joe's Café":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/joes-cafe/",
                                      @"New College House":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/new-college-house/",
                                      @"McClelland Express":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/mcclelland/",
                                      @"Beefsteak":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/beefsteak/",
                                      @"1920 Gourmet Grocer":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/1920-gourmet-grocer/",
                                      @"Tortas Frontera at the ARCH":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/tortas-frontera-at-the-arch/",
                                      @"1920 Starbucks":@"http://university-of-pennsylvania.cafebonappetit.com/cafe/1920-starbucks/"};
    
    NSArray *diningHallNamesAndImageNames = @[@{@"1920 Commons": @"1920Commons.png"}, @{@"McClelland Express": @"mcclelland.jpg"}, @{@"New College House": @"nch.jpg"}, @{@"English House": @"kceh.jpg"}, @{@"Falk Kosher Dining" : @"hillel.jpg"}];
    
    UIView *diningView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [scroll addSubview:diningView];
    
    UILabel *diningLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, 30)];
    diningLabel.text = @"Dining Halls";
    diningLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    [diningView addSubview:diningLabel];
    
    CGFloat y = diningLabel.frame.size.height;
    
    for (NSDictionary *dic in diningHallNamesAndImageNames) {
        DiningArea *d = [[DiningArea alloc] init];
        d.name = [dic allKeys][0];
        d.type = @"Dining Hall";
        d.image = [UIImage imageNamed:[dic allValues][0]];
        d.url = diningHallLinks[d.name];
        
        DiningCell *cell = [DiningCell cellForDiningArea:d];
        [cell setY:y];
        [scroll insertSubview:cell atIndex:0];
        y+= cell.frame.size.height;
        [cell addTarget:self action:@selector(launchWebview:) forControlEvents:UIControlEventTouchUpInside];

        [diningCells setObject:cell forKey:d.name];
    }
    
    NSArray *retailHallNamesAndImageNames = @[@{@"Tortas Frontera at the ARCH": @"tortas.jpg"}, @{@"1920 Gourmet Grocer": @"gourmetgrocer.jpg"}, @{@"Houston Market": @"houston.jpg"}, @{@"Joe's Café": @"Penn.JoesCafe-Int5.72W.jpg"}, @{@"Mark's Café" : @"marks.png"}, @{@"1920 Starbucks" : @"starbucks.jpg"}, @{@"Beefsteak" : @"beefsteak.jpeg"}, @{@"Accenture Café" : @"marks.png"}];
    
    UIView *retailView = [[UIView alloc] initWithFrame:CGRectMake(0, y, self.view.frame.size.width, 40)];
    [scroll addSubview:retailView];
    
    y+= retailView.frame.size.height;
    
    UILabel *retailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, 30)];
    retailLabel.text = @"Retail Dining";
    retailLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    [retailView addSubview:retailLabel];
    
    
    for (NSDictionary *dic in retailHallNamesAndImageNames) {
        DiningArea *d = [[DiningArea alloc] init];
        d.name = [dic allKeys][0];
        d.type = @"Retail Hall";
        d.image = [UIImage imageNamed:[dic allValues][0]];
        d.url = diningHallLinks[d.name];

        DiningCell *cell = [DiningCell cellForDiningArea:d];
        [cell setY:y];
        [cell addTarget:self action:@selector(launchWebview:) forControlEvents:UIControlEventTouchUpInside];
        [scroll insertSubview:cell atIndex:0];
        y+= cell.frame.size.height;
        
        [diningCells setObject:cell forKey:d.name];

    }
    
    [self getTime];
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, y);
    


}

-(void) getTime{

    //Here is where the GET request happens.

    NSURL *url = [[NSURL alloc]initWithString:@"http://api.pennlabs.org/dining/venues"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSString *path = [location path];
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];\
        //The data is "Serialized" and converted to JSON in a dictionary key-value pair form.
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

        

            NSArray *venues = json[@"document"][@"venue"];
           
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
            
        
            for(NSDictionary *venue in venues){
            
                NSLog(@"%@", venue);
                
              
                
                NSString *name = venue[@"name"];
                DiningCell *cell = diningCells[name];
                cell.diningArea.url = venue[@"facilityURL"];

                for (NSDictionary *dateDic in venue[@"dateHours"]){
                    if ([dateDic [@"date"] isEqualToString:dateString]){
                        //UI stuff go on the main queue
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSString *timeString = [self timeStringFromArray:dateDic[@"meal"]];
                            cell.timeLabel.text = timeString;
                        });
                        break;
                            
                    }
                }

                
            
            }
            

        
    }];
    [task resume]; // to start the download task

}


//This is where I parse the data and convert the raw strings into usable dates
-(NSString *)timeStringFromArray: (NSArray *)array {

    NSMutableString *string = [NSMutableString string];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    for (NSDictionary *dic in array){
        
       
        NSString *open = dic [@"open"];
        NSDate *openDate = [dateFormat dateFromString:open];
        NSString *close = dic [@"close"];
        NSDate *closeDate = [dateFormat dateFromString:close];

        NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *openComponents = [calendar components:(NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:openDate];
        
        NSDateComponents *closeComponents = [calendar components:(NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:closeDate];

        
        [string appendFormat:@"%@-%@", [self stringForComponents:openComponents includeMeridian:array.count==1], [self stringForComponents:closeComponents includeMeridian:array.count==1]];
        
        [string appendString:@" | "];
        
        
    }
    
    string = [string substringToIndex:[string length] - 3].mutableCopy;
    
    return string;
    
}

//And here is where I parse those dates and turn them into the strings I want
-(NSString *) stringForComponents: (NSDateComponents *) components includeMeridian: (BOOL) m {

    NSInteger minutes = [components minute];
    NSInteger hours = [components hour];

    BOOL aM = YES;
    NSMutableString *string = [NSMutableString string];
    
    if (hours > 12){
        aM = NO;
        hours -= 12;
    }
    if (hours == 12) aM = NO;
    
    [string appendFormat:@"%li", (long)hours];
    
    if(minutes != 0){
        [string appendFormat:@":%li", (long)minutes];
    }
    
    if (m)[string appendFormat:@"%@", aM?@"a":@"p"];
    
    return (NSString *)string;
}

//And here is where I launch the webview.

/* Sorry for the extra code, I was trying to grab the links from the API when I realized
 * it would be much simpler to just hard code it all
 */

-(void)launchWebview: (DiningCell *) sender{
//A little fun I had with trying to work with observers (probably could have gotten it to work with time lol)
//    if (!sender.diningArea.url){
//
//        [self.view addSubview:visual];
//        [visual addSubview:activityIndicator];
//        [activityIndicator startAnimating];
//
//        [sender addObserver:self forKeyPath:@"diningArea.url" options:0 context:nil];
//        timer = [NSTimer scheduledTimerWithTimeInterval:10 repeats:NO block:^(NSTimer * _Nonnull timer) {
//           
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please Try Again" preferredStyle:UIAlertControllerStyleAlert];
//            
//            [self presentViewController:alert animated:YES completion:nil];
//            [sender removeObserver:sender forKeyPath:@"diningArea.url"];
//            
//        }];
//        return;
//        
//        
//    }
    
    UIViewController *webViewController = [[UIViewController alloc] init];

    UIWebView *webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:sender.diningArea.url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webview loadRequest:requestObj];
    webview.delegate=self;
    
    [webViewController.view addSubview: webview];
    
    [self.navigationController pushViewController: webViewController animated:YES];
}





//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString: @"diningArea.url"]) {
//
//        [timer invalidate];
//        [self launchWebview:object];
//        
//    }
//    else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
@end
