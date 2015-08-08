//
//  ViewController.m
//  logicalTests
//
//  Created by Sergiy Kostrykin on 8/8/15.
//  Copyright (c) 2015 Sergiy Kostrykin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *exampleString;
@property (weak, nonatomic) IBOutlet UILabel *foundedZeroBits;
@property (weak, nonatomic) IBOutlet UILabel *exampleArray;

@property (weak, nonatomic) IBOutlet UILabel *repeatingElements;
@end

@implementation ViewController
- (IBAction)startTaskOne:(UIButton *)sender {
    NSString *example = @"D";
    
    self.exampleString.text = [NSString stringWithFormat:@"Example string: %@",example];
    self.foundedZeroBits.text = [NSString stringWithFormat:@"Zero bits: %i",[self intCountZeroBits:example]];
}
- (IBAction)startTaskTwo:(UIButton *)sender {
    
    NSInteger m = 10;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableString *stringArray = [[NSMutableString alloc]init];
    for (int i=0; i < m; i++)
    {
        int element = arc4random() % 100 + 1;
        NSNumber* xWrapped = [NSNumber numberWithInt:element];
        [array addObject:xWrapped];
        [stringArray appendString:[NSString stringWithFormat: @" %@ ",xWrapped]];
    }
    self.exampleArray.text = stringArray;
    NSInteger result = [self repeatingElement:array];
    if (result == 0) {
        self.repeatingElements.text = [NSString stringWithFormat:@"Repeating elements not found."];
    } else {
        self.repeatingElements.text = [NSString stringWithFormat:@"Repeating elements: %ld",(long)result];
    }
}

-(NSInteger)repeatingElement: (NSArray *) array
{
    NSInteger result = 0;
    NSMutableArray *newArray = [[NSMutableArray alloc]initWithArray:array];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [newArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    for (int i = 0; i < [newArray count]-2; i++) {
        if ([newArray[i] integerValue] == [newArray[i+1] integerValue]){
            result = [newArray[i] integerValue];
            break;
        }
    }
    return result;
}


-(int)intCountZeroBits:(NSString*)string
{
    int flag=0;
    for(int i=0;i<=([string length]-1);i++)
    {
        unichar dexCode = [string characterAtIndex: i];
        int maxByte=128;
        while (maxByte>=1) {
            if(dexCode/maxByte==0){
                flag+=1;}
            else
            {
                if(dexCode%2==0) flag+=1;
                dexCode/=2;
            }
            maxByte/=2;
        }
        
    }
    return flag;
}



@end
