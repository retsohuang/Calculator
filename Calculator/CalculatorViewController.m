//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Retso on 7/20/12.
//  Copyright (c) 2012 KeyStoneTech. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()

@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userIsTypingDecimal;
@property (nonatomic) BOOL userIsPressedOperation;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userPressedHistory = _userPressedHistory;

@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize userIsTypingDecimal = _userIsTypingDecimal;
@synthesize userIsPressedOperation = _userIsPressedOperation;

@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
  if (!_brain) {
    _brain = [[CalculatorBrain alloc] init];
  }
  return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
  NSString *digit = [sender currentTitle];
  self.userIsPressedOperation = NO;
  NSString *displayText = [NSString stringWithFormat:@"%g",[[self.display.text stringByAppendingString:digit] doubleValue]];
  if (self.userIsInTheMiddleOfEnteringANumber) {
    if (self.userIsTypingDecimal) {
      self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else {
      self.display.text = displayText;
    }
  }
  else {
    if (self.userIsTypingDecimal) {
      self.display.text = [self.display.text stringByAppendingString:digit];;
    }
    else {
      self.display.text = [NSString stringWithFormat:@"%g",[digit doubleValue]];
    }
    self.userIsInTheMiddleOfEnteringANumber = YES;
  }
}
- (IBAction)enterPressed
{
  if (self.userIsInTheMiddleOfEnteringANumber) {
    [self updateCalculatorHistory:[NSString stringWithFormat:@"%g",[self.display.text doubleValue]]];
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userIsTypingDecimal = NO;
  }
}

- (IBAction)operationPressed:(UIButton *)sender
{
  if (self.userIsInTheMiddleOfEnteringANumber) {
    [self enterPressed];
  }
  self.userIsPressedOperation = YES;
  [self updateCalculatorHistory:[sender currentTitle]];
  NSString *operation = [sender currentTitle];
  double result = [self.brain performOperation:operation];
  self.display.text = [NSString stringWithFormat:@"%g", result];
}
- (IBAction)dotButtonPressed:(id)sender {
  if (!self.userIsTypingDecimal) {
    self.display.text = [self.display.text stringByAppendingString:@"."];
    self.userIsTypingDecimal = YES;
  }
}
- (IBAction)plusOrMinusChange {
  if (self.userIsInTheMiddleOfEnteringANumber) {
    if ([self.display.text doubleValue] < 0) {
      self.display.text = [NSString stringWithFormat:@"%g", fabs([self.display.text doubleValue])];
    }
    else {
      self.display.text = [@"-" stringByAppendingString:self.display.text];
    }
  }
}
- (IBAction)backspaceButtonPressed {
  if (!self.userIsPressedOperation && !self.userIsInTheMiddleOfEnteringANumber) {
    self.userPressedHistory.text = @"";
    for (NSString *operand in [self.brain removeLastOperandOnProgramStack]) {
      self.userPressedHistory.text = [self.userPressedHistory.text stringByAppendingFormat:@"%@ ",operand];
    }
  }
}

- (IBAction)clearButtonPressed:(id)sender {
  [self.brain clearProgramStack];
  self.userIsTypingDecimal = NO;
  self.userIsPressedOperation = NO;
  self.userIsInTheMiddleOfEnteringANumber = NO;
  self.display.text = @"0";
  self.userPressedHistory.text = @"";
}

- (void)updateCalculatorHistory:(NSString *)anOperatoinOrDigit
{
  NSString *newHistory = [NSString stringWithFormat:@"%@ ",anOperatoinOrDigit];
  newHistory = [self.userPressedHistory.text stringByAppendingString:newHistory];
  if (self.userIsPressedOperation) {
    NSRange range = [newHistory rangeOfString:@"="];
    if (range.location != NSNotFound) {
      newHistory = [newHistory stringByReplacingOccurrencesOfString:@"=" withString:@""];
    }
    newHistory = [newHistory stringByAppendingString:@"="];
  }
  else {
    newHistory = [newHistory stringByReplacingOccurrencesOfString:@"=" withString:@""];
  }
  self.userPressedHistory.text = newHistory;
}

- (void)viewDidUnload {
  [self setDisplay:nil];
  [self setUserPressedHistory:nil];
  [super viewDidUnload];
}
@end
