//
//  AMSmoothAlertView.m
//  AMSmoothAlertViewDemo
//
//  Created by AMarliac on 2014-04-24.
//  Contributor: Everest Liu
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import "AMSmoothAlertView.h"



@implementation AMSmoothAlertView
{
//    UIView *alertView;
    AMBouncingView *circleView;
    UIImageView * bg;
    GPUImageiOSBlurFilter *_blurFilter;

}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type
{
    return [self initDropAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton andExtraButton:(BOOL)hasExtraButton forAlertType:(AlertType) type andColor:(UIColor*) color
{
    self = [super init];
    if (self) {
        // Initialization code
        _animationType = DropAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton andExtraButton:hasExtraButton forAlertType:type andColor:color];
    }
    return self;
}

- (id) initDropAlertNSAttributedWithTitle:(NSAttributedString*) title andText:(NSAttributedString*) text andCancelButton:(BOOL)hasCancelButton andExtraButton:(BOOL)hasExtraButton forAlertType:(AlertType) type andColor:(UIColor*) color andBigAlertView:(BOOL)hasBigAlertView
{
    self = [super init];
    if (self) {
        // Initialization code
        _animationType = DropAnimation;
        [self _initViewNSAttributedWithTitle:title andText:text andCancelButton:hasCancelButton andExtraButton:hasExtraButton forAlertType:type andColor:color andBigAlertView:hasBigAlertView];
    }
    return self;
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color
{
    self = [super init];
    if (self) {
        // Initialization code
        _animationType = DropAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}


- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type
{
    return [self initFadeAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color
{
    self = [super init];
    if (self) {
        // Initialization code
        _animationType = FadeInAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}

// init with completion blocks

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self.completionBlock = completionHandler;
    return [self initDropAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initDropAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self = [super init];
    if (self) {
        // Initialization code
        self.completionBlock = completionHandler;
        _animationType = DropAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}


- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self.completionBlock = completionHandler;
    return [self initFadeAlertWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:nil];
}

- (id) initFadeAlertWithTitle:(NSString*) title andText:(NSString*) text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType) type andColor:(UIColor*) color withCompletionHandler:(dismissAlertWithButton) completionHandler
{
    self = [super init];
    if (self) {
        // Initialization code
        self.completionBlock = completionHandler;
        _animationType = FadeInAnimation;
        [self _initViewWithTitle:title andText:text andCancelButton:hasCancelButton forAlertType:type andColor:color];
    }
    return self;
}

- (void) _initViewWithTitle:(NSString *)title andText:(NSString *)text andCancelButton:(BOOL)hasCancelButton andExtraButton:(BOOL)hasExtraButton forAlertType:(AlertType)type andColor:(UIColor*) color
{
    self.frame = [self screenFrame];
    self.opaque = YES;
    self.alpha = 1;

    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _blurFilter.blurRadiusInPixels = 2.0;

    bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];

    _alertView = [self alertPopupView:170];
    [self labelSetupWithTitle:title andText:text];
    [self buttonSetupForType:type withCancelButton: hasCancelButton withExtraButton: hasExtraButton andColor:color andBigAlertView:false];
    [self addSubview:_alertView];

    [self circleSetupForAlertType:type andColor:color];
}

- (void) _initViewWithTitle:(NSString *)title andText:(NSString *)text andCancelButton:(BOOL)hasCancelButton forAlertType:(AlertType)type andColor:(UIColor*) color
{
    self.frame = [self screenFrame];
    self.opaque = YES;
    self.alpha = 1;
    _extraButton = false;

    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _blurFilter.blurRadiusInPixels = 2.0;

    bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];

    _alertView = [self alertPopupView:170];

    [self labelSetupWithTitle:title andText:text];
    [self buttonSetupForType:type withCancelButton: hasCancelButton withExtraButton: _extraButton andColor:color andBigAlertView:false];
    [self addSubview:_alertView];

    [self circleSetupForAlertType:type andColor:color];
}

- (void) _initViewNSAttributedWithTitle:(NSAttributedString *)title andText:(NSAttributedString *)text andCancelButton:(BOOL)hasCancelButton andExtraButton:(BOOL)hasExtraButton forAlertType:(AlertType)type andColor:(UIColor*) color andBigAlertView: (BOOL) hasBigAlertView
{
    self.frame = [self screenFrame];
    self.opaque = YES;
    self.alpha = 1;

    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _blurFilter.blurRadiusInPixels = 2.0;

    bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];

    if (hasBigAlertView)
    {
        _alertView = [self alertPopupView:220];
    }
    else
    {
        _alertView = [self alertPopupView:170];
    }

    [self labelSetupNSAttributedWithTitle:title andText:text];

    [self buttonSetupForType:type withCancelButton: hasCancelButton withExtraButton: hasExtraButton andColor:color andBigAlertView:hasBigAlertView];

    [self addSubview:_alertView];

    [self circleSetupForAlertType:type andColor:color];
}

- (id) initDropAlertNSAttributedWithTitle:(NSAttributedString*)title andText:(NSAttributedString*)text andCancelButton:(BOOL)hasCancelButton andExtraButton:(BOOL)hasExtraButton forAlertType:(AlertType)type andColor:(UIColor*)color andViewHeight:(CGFloat)alertViewHeight
{
  self.frame = [self screenFrame];
  self.opaque = YES;
  self.alpha = 1;

  _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
  _blurFilter.blurRadiusInPixels = 2.0;

  bg = [[UIImageView alloc]initWithFrame:[self screenFrame]];

  _alertView = [self alertPopupView:alertViewHeight];

  [self labelSetupNSAttributedWithTitle:title andText:text];

  [self buttonSetupForType:type withCancelButton:hasCancelButton withExtraButton:hasExtraButton andColor:color andBigAlertView:NO];

  [self addSubview:_alertView];

  [self circleSetupForAlertType:type andColor:color];
}

- (UIView*) alertPopupView:(CGFloat)height
{
    UIView * alertSquare = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, height)];

    alertSquare.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
    alertSquare.center = CGPointMake([self screenFrame].size.width/2, -[self screenFrame].size.height/2);

    [alertSquare.layer setShadowColor:[UIColor blackColor].CGColor];
    [alertSquare.layer setShadowOpacity:0.4];
    [alertSquare.layer setShadowRadius:20.0f];
    [alertSquare.layer setShadowOffset:CGSizeMake(0.0, 0.0)];

    [self performScreenshotAndBlur];

    return alertSquare;
}

- (void) show
{
	id<AMSmoothAlertViewDelegate> delegate = self.delegate;
	if ([delegate respondsToSelector:@selector(alertViewWillShow:)]) [delegate alertViewWillShow:self];

    switch (_animationType) {
        case DropAnimation:
            [self triggerDropAnimations];
            break;
        case FadeInAnimation:
            [self triggerFadeAnimations];
            break;

        default:
            break;
    }
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}

#pragma mark - Blur

-(void) performScreenshotAndBlur
{
    UIImage * image = [self convertViewToImage];
    UIImage *blurredSnapshotImage = [_blurFilter imageByFilteringImage:image];

    [bg setImage:blurredSnapshotImage];
    bg.alpha = 0.0;

    [self addSubview:bg];
}


#pragma mark - Items Setup

- (void) circleSetupForAlertType:(AlertType) type andColor:(UIColor*) color
{
    UIView * circleMask = [[UIView alloc]initWithFrame:CGRectMake([self screenFrame].size.width/2, (([self screenFrame].size.height/2)-_alertView.frame.size.height/2) , 60, 60)];
    circleView = [[AMBouncingView alloc]initSuccessCircleWithFrame:CGRectMake(0, 0, 0, 0) andImageSize:60 forAlertType:type andColor:color];

    _logoView = [[UIImageView alloc]initWithFrame:CGRectMake(circleMask.frame.size.width/2-30, circleMask.frame.size.height/2-30 , 0, 0)];

    switch (type) {
        case AlertSuccess:
            [_logoView setImage:[UIImage imageNamed:@"checkMark.png"]];
            break;
        case AlertFailure:
            [_logoView setImage:[UIImage imageNamed:@"crossMark.png"]];
            break;
        case AlertInfo:
            [_logoView setImage:[UIImage imageNamed:@"info.png"]];
            break;

        default:
            break;
    }
    _logoView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self addSubview:circleMask];
    [circleMask addSubview:circleView];
    [circleMask addSubview:_logoView];
}

- (void) labelSetupWithTitle:(NSString*) title andText:(NSString*) text
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    _titleLabel.center = CGPointMake(_alertView.frame.size.width/2, 45);
    _titleLabel.text = title;
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:20.0f];
    _titleLabel.textAlignment = NSTextAlignmentCenter;

    [_alertView addSubview:_titleLabel];


    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 60)];
    _textLabel.center = CGPointMake(_alertView.frame.size.width/2, 80);
    _textLabel.text = text;
    _textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _textLabel.numberOfLines = 0;
    [_alertView addSubview:_textLabel];

}

- (void) labelSetupNSAttributedWithTitle:(NSAttributedString*) title andText:(NSAttributedString*) text
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    _titleLabel.center = CGPointMake(_alertView.frame.size.width/2, 45);
    _titleLabel.attributedText = title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;

    [_alertView addSubview:_titleLabel];

    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 60)];
    _textLabel.center = CGPointMake(_alertView.frame.size.width/2, 80);
    _textLabel.attributedText = text;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _textLabel.numberOfLines = 0;
    [_alertView addSubview:_textLabel];
}

- (void) buttonSetupForType:(AlertType)type withCancelButton:(BOOL) hasCancelButton withExtraButton:(BOOL) hasExtraButton andColor:(UIColor*) color andBigAlertView: (BOOL) hasBigAlertView
{

    if (!hasBigAlertView && hasCancelButton && hasExtraButton)
    {
        CGRect frame = self.alertView.frame;
        frame.size.height += 70;
        self.alertView.frame = frame;

        //default button
        _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _defaultButton.center = CGPointMake((_alertView.frame.size.width/2), 130);

        //cancel button
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _cancelButton.center = CGPointMake((_alertView.frame.size.width/2), 170);
        _cancelButton.backgroundColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1];

        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        _cancelButton.titleLabel.textColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
		    [_cancelButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton.layer setCornerRadius:3.0f];

        //extra button
        _extraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _extraButton.center = CGPointMake((_alertView.frame.size.width/2), 210);
        _extraButton.backgroundColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1];

        [_extraButton setTitle:@"Extra" forState:UIControlStateNormal];
        _extraButton.titleLabel.textColor = [UIColor whiteColor];
        _extraButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
        [_extraButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_extraButton.layer setCornerRadius:3.0f];
    }
    else if (!hasBigAlertView && !hasCancelButton && hasExtraButton) // LongMessage
    {
        CGRect frame = self.alertView.frame;
        frame.size.height += 140;
        self.alertView.frame = frame;

        _textLabel.frame = CGRectMake(0, 0, 180, 160);
        //_textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 160)];
        _textLabel.center = CGPointMake(_alertView.frame.size.width/2, 140);

        //default button
        _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _defaultButton.center = CGPointMake((_alertView.frame.size.width/2), 240);

        //extra button
        _extraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _extraButton.center = CGPointMake((_alertView.frame.size.width/2), 280);
        _extraButton.backgroundColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1];

        [_extraButton setTitle:@"Extra" forState:UIControlStateNormal];
        _extraButton.titleLabel.textColor = [UIColor whiteColor];
        _extraButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
        [_extraButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_extraButton.layer setCornerRadius:3.0f];
    }
    else if(hasBigAlertView && !hasCancelButton && !hasExtraButton) //long message without extra buttons
    {
        CGRect frame = self.alertView.frame;
        frame.size.height += 60;
        self.alertView.frame = frame;

        _textLabel.frame = CGRectMake(0, 0, 180, 160);
        //_textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 160)];
        _textLabel.center = CGPointMake(_alertView.frame.size.width/2, 140);

        //default button
        _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _defaultButton.center = CGPointMake((_alertView.frame.size.width/2), 240);
    }
    else if (hasBigAlertView && hasCancelButton && !hasExtraButton) // LongMessage with cancel button but no extra button
    {
        CGRect frame = self.alertView.frame;
        frame.size.height += 90;
        self.alertView.frame = frame;

        _textLabel.frame = CGRectMake(0, 0, 180, 160);
        //_textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 160)];
        _textLabel.center = CGPointMake(_alertView.frame.size.width/2, 140);

        //default button
        _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _defaultButton.center = CGPointMake((_alertView.frame.size.width/2), 240);

        //cancel button
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _cancelButton.center = CGPointMake((_alertView.frame.size.width/2), 280);
        _cancelButton.titleLabel.textColor = [UIColor whiteColor];
        [_cancelButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (hasBigAlertView && !hasCancelButton && hasExtraButton) // LongMessage without cancel button but with extra button
    {
        CGRect frame = self.alertView.frame;
        frame.size.height += 90;
        self.alertView.frame = frame;

        _textLabel.frame = CGRectMake(0, 0, 180, 160);
        //_textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 160)];
        _textLabel.center = CGPointMake(_alertView.frame.size.width/2, 140);

        //default button
        _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _defaultButton.center = CGPointMake((_alertView.frame.size.width/2), 240);

        //cancel button
        _extraButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _extraButton.center = CGPointMake((_alertView.frame.size.width/2), 280);
        _extraButton.titleLabel.textColor = [UIColor whiteColor];
        [_extraButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (!hasBigAlertView && hasCancelButton)
    {
        //default button
        _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 84, 30)];
        _defaultButton.center = CGPointMake((_alertView.frame.size.width/4)+3, 130);

        //cancel button
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 84, 30)];
        _cancelButton.center = CGPointMake((_alertView.frame.size.width*3/4)-3, 130);
        _cancelButton.backgroundColor = [UIColor colorWithRed:0.792 green:0.792 blue:0.792 alpha:1];

        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        _cancelButton.titleLabel.textColor = [UIColor whiteColor];
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
        [_cancelButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton.layer setCornerRadius:3.0f];

    }
    else
    {
        _defaultButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
        _defaultButton.center = CGPointMake(_alertView.frame.size.width/2, 130);
    }

    [self setColorForButton:color onButton:_defaultButton withType:type];
    [self setColorForButton:color onButton:_cancelButton withType:type];
    [self setColorForButton:color onButton:_extraButton withType:type];

    //default button end setup
    [_defaultButton setTitle:@"OK !" forState:UIControlStateNormal];
    _defaultButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0f];
	  [_defaultButton addTarget:self action:@selector(handleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [_defaultButton.layer setCornerRadius:3.0f];

    [_alertView addSubview:_defaultButton];
    if (hasCancelButton)[_alertView addSubview:_cancelButton];
    if (hasExtraButton) [_alertView addSubview:_extraButton];

}


- (void) setColorForButton:(UIColor*) color onButton:(UIButton*) btn withType:(AlertType)type
{
    if (color)
    {
        btn.backgroundColor = color;
    }
    else
    {
        switch (type) {
            case AlertSuccess:
                btn.backgroundColor = GREENCOLOR;
                break;
            case AlertFailure:
                btn.backgroundColor = REDCOLOR;
                break;
            case AlertInfo:
                btn.backgroundColor = BLUECOLOR;
                break;

            default:
                break;
        }
    }

}

- (void) setTitleFont:(UIFont *)titleFont
{
    [_titleLabel setFont:titleFont];
}

- (void) setTextFont:(UIFont *)textFont
{
    [_textLabel setFont:textFont];
}

-(void) setTitleText:(NSString*) string
{
    _titleLabel.text = string;
}

-(void) setMessageText:(NSString*) string
{
    _textLabel.text = string;
}

#pragma mark - Animations

-(void) triggerDropAnimations
{

    NSMutableArray* animationBlocks = [NSMutableArray new];

    typedef void(^animationBlock)(BOOL);

    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };

    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            bg.alpha = 1.0;
        } completion: getNextAnimation()];
    }];

    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2)+_alertView.frame.size.height*0.1);
        } completion: getNextAnimation()];
    }];

    //block 3
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));
        } completion: getNextAnimation()];
    }];

    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        [self circleAnimation];
    }];

    // execute the first block in the queue
    getNextAnimation()(YES);
}



-(void) triggerFadeAnimations
{

    _alertView.alpha = 0;
    _alertView.center = CGPointMake([self screenFrame].size.width/2, ([self screenFrame].size.height/2));

    NSMutableArray* animationBlocks = [NSMutableArray new];

    typedef void(^animationBlock)(BOOL);

    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };

    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            bg.alpha = 1.0;
        } completion: getNextAnimation()];
    }];

    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _alertView.alpha = 1;
        } completion: getNextAnimation()];
    }];

    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        [self circleAnimation];
    }];

    // execute the first block in the queue
    getNextAnimation()(YES);

}

- (void) circleAnimation
{
    NSMutableArray* animationBlocks = [NSMutableArray new];

    typedef void(^animationBlock)(BOOL);

    // getNextAnimation
    // removes the first block in the queue and returns it
    animationBlock (^getNextAnimation)() = ^{
        animationBlock block = animationBlocks.count ? (animationBlock)[animationBlocks objectAtIndex:0] : nil;
        if (block){
            [animationBlocks removeObjectAtIndex:0];
            return block;
        }else{
            return ^(BOOL finished){};
        }
    };

    //block 1
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circleView.frame = [circleView newFrameWithWidth:85 andHeight:85];
            _logoView.frame = [self newFrameForView:_logoView withWidth:40 andHeight:40];
        } completion: getNextAnimation()];
    }];

    //block 2
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circleView.frame = [circleView newFrameWithWidth:50 andHeight:50];
            _logoView.frame = [self newFrameForView:_logoView withWidth:15 andHeight:15];
        } completion: getNextAnimation()];
    }];

    //block 3
    [animationBlocks addObject:^(BOOL finished){;
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            circleView.frame = [circleView newFrameWithWidth:60 andHeight:60];
            _logoView.frame = [self newFrameForView:_logoView withWidth:20 andHeight:20];
        } completion: getNextAnimation()];
    }];

    //add a block to our queue
    [animationBlocks addObject:^(BOOL finished){;
        self.isDisplayed = true;
		id<AMSmoothAlertViewDelegate> delegate = self.delegate;
		if ([delegate respondsToSelector:@selector(alertViewDidShow:)]) [delegate alertViewDidShow:self];
    }];

    // execute the first block in the queue
    getNextAnimation()(YES);
}


- (void) dismissAlertView
{
	id<AMSmoothAlertViewDelegate> delegate = self.delegate;
	if ([delegate respondsToSelector:@selector(alertViewWillDismiss:)]) [delegate alertViewWillDismiss:self];
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         self.isDisplayed = false;
						 if ([delegate respondsToSelector:@selector(alertViewDidDismiss:)]) [delegate alertViewDidDismiss:self];
                     }];
}


#pragma mark - Miscellaneous

- (void) setCornerRadius:(float)cornerRadius
{
    [_alertView.layer setCornerRadius:cornerRadius];
}


- (CGRect) screenFrame
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect;
}


-(UIImage *)convertViewToImage
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}

- (CGRect) newFrameForView:(UIView*) uiview withWidth:(float) width andHeight:(float) height
{
    return CGRectMake(uiview.frame.origin.x + ((uiview.frame.size.width - width)/2),
                      uiview.frame.origin.y + ((uiview.frame.size.height - height)/2),
                      width,
                      height);
}

#pragma mark - Delegate Methods
- (void)handleButtonTouched:(id)sender {
	[self dismissAlertView];

	id<AMSmoothAlertViewDelegate> delegate = self.delegate;
	UIButton *button = (UIButton *) sender;
	if ([delegate respondsToSelector:@selector(alertView:didDismissWithButton:)]) {
		// Since there isn't a button index for the alertView, pass the button
		[delegate alertView:self didDismissWithButton:button];
	}

    if(self.completionBlock) {
        self.completionBlock(self, button);
    }
}

@end
