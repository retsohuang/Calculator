//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Retso Huang on 8/1/12.
//  Copyright (c) 2012 retsohuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (void)clearProgramStack;
- (double)performOperation:(NSString *)operation;
- (NSArray *)removeLastOperandOnProgramStack;

@property (nonatomic, readonly) id program;
+ (double)runProgram:(id)program;
+ (NSString *)descriptionOfProgram:(id)program;
@end
