//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Retso Huang on 8/1/12.
//  Copyright (c) 2012 retsohuang. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong, readwrite) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
  if (!_programStack) {
    _programStack = [[NSMutableArray alloc] init];
  }
  return _programStack;
}

- (void)pushOperand:(double)operand
{
  NSNumber *operandObject = [NSNumber numberWithDouble:operand];
  [self.programStack addObject:operandObject];
}

- (NSArray *)removeLastOperandOnProgramStack {
  [self.programStack removeLastObject];
  return [self.programStack copy];
}

- (double)performOperation:(NSString *)operation {
  
  [self.programStack addObject:operation];  //push operation into stack
  return [CalculatorBrain runProgram:self.program];
}

- (id)program
{
  return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
  return @"Implement this in Assignment 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
  double result = 0;
  
  id topOfStack = [stack lastObject];
  if (topOfStack) [stack removeLastObject];
  
  if ([topOfStack isKindOfClass:[NSNumber class]]) {
    result = [topOfStack doubleValue];
  }
  else if ([topOfStack isKindOfClass:[NSString class]]) {
    NSString *operation = topOfStack;
    if ([operation isEqualToString:@"+"]) {
      result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
    }
    else if ([operation isEqualToString:@"×"]) {
      result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
    }
    else if ([operation isEqualToString:@"−"]) {
      double subtrahend = [self popOperandOffStack:stack];
      result = [self popOperandOffStack:stack] - subtrahend;
    }
    else if ([operation isEqualToString:@"÷"]) {
      double divisor = [self popOperandOffStack:stack];
      if (divisor) result = [self popOperandOffStack:stack] / divisor;
    }
    else if ([operation isEqualToString:@"sin"]) {
      double sinValue = [self popOperandOffStack:stack];
      if (sinValue) result = sin(sinValue);
    }
    else if ([operation isEqualToString:@"cos"]) {
      double cosValue = [self popOperandOffStack:stack];
      if (cosValue) result = cos(cosValue);
    }
    else if ([operation isEqualToString:@"sqrt"]) {
      double square  = [self popOperandOffStack:stack];
      if (square) result = sqrt(square);
    }
    else if ([operation isEqualToString:@"log"]) {
      double logValue = [self popOperandOffStack:stack];
      if (logValue) result = log10(logValue);
    }
    else if ([operation isEqualToString:@"π"]) {
      result = M_PI;
    }
    else if ([operation isEqualToString:@"e"]) {
      result = M_E;
    }
  }
  return result;
}

+ (double)runProgram:(id)program
{
  NSMutableArray *stack;
  if ([program isKindOfClass:[NSArray class]]) {
    stack = [program mutableCopy];
  }
  return [self popOperandOffStack:stack];
}

- (void)clearProgramStack {
  [self.programStack removeAllObjects];
}

@end
