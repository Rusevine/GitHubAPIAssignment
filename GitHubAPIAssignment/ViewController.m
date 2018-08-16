//
//  ViewController.m
//  GitHubAPIAssignment
//
//  Created by Wiljay Flores on 2018-08-16.
//  Copyright © 2018 wiljay. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"

@interface ViewController () <UITableViewDataSource>
@property (nonatomic) NSMutableArray <Repo *> *repoNames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _repoNames = [@[] mutableCopy];
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/rusevine/repos"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
            if (error) {
                NSLog(@"error: %@", error.localizedDescription);
                return;
            }
            
            NSError *jsonError = nil;
            NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
            
            if (jsonError) {
           
                NSLog(@"jsonError: %@", jsonError.localizedDescription);
                return;
            }
        
            for (NSDictionary *repo in repos) {
                Repo *repository = [[Repo alloc] initWithRepo:repo];
                [self.repoNames addObject:repository];
            }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    }]; // 5
    
    [dataTask resume]; // 6
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repoNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.repoNames[indexPath.row].name;
    
    return cell;
}

@end
