//
//  LoginViewController.m
//  XyralityTest
//
//  Created by Konstantin Efimenko on 10/18/16.
//  Copyright © 2016 Efimenko Ink. All rights reserved.
//

#import "LoginViewController.h"
#import "WorldsCollection.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    __weak IBOutlet UITextField *loginTextField;
    __weak IBOutlet UITextField *passwordTextField;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogInButtonPressed:(id)sender {
    [[WorldsCollection sharedInstance] loginWithLogin:loginTextField.text password:passwordTextField.text callback:^(NSError*error){
        if (error){
            NSLog(@"%@",error);
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
