//
//  IDScrollableTabBar.m
//  ScrollableTabBar
//
//  Created by bananadev.pro on 7/17/13.
//  Copyright (c) 2013 demo. All rights reserved.
//

#import "IDScrollableTabBar.h"

#define timerSpeed 0.01f
#define friction 80.f
#define speedFactor 0.01f

@interface IDScrollableTabBar(){
    NSTimer *_timer;
    UIImageView *_archImageView;
    UIImageView *_backImageView;
    UIImageView *_centerImageView;
    float _velocity;
    NSArray *_buttonsArray;
    UIView *_firstTouchView;
    UIView *_secondTouchView;
    CGPoint _touchBeganPoint;
    UIPanGestureRecognizer *_panRecognizer0;
    UIPanGestureRecognizer *_panRecognizer1;
    UIPanGestureRecognizer *_currentRecognizer;
    
    BOOL _isTapSelectionNeed;
    
    float _maxX;
    float _minX;
    float _itemWidth;
    float _itemHeight;
    float _ledge;
    
    BOOL _frameAnimation;
}
@property (nonatomic, readwrite) int selectedItem;
@property (nonatomic, strong) UIImageView *shadowImageViewRight;
@property (nonatomic, strong) UIImageView *shadowImageViewLeft;
@end
@implementation IDScrollableTabBar
-(void)dealloc{
    _firstTouchView = nil;
    _secondTouchView = nil;
    _archImageView = nil;
    _timer = nil;
    _buttonsArray = nil;
    _panRecognizer0 = nil;
    _panRecognizer1 = nil;
}
#pragma mark - customization
-(void)setShadowImageRight : (UIImage *)image{
    [self.shadowImageViewRight setImage:image];
    CGRect rect = self.shadowImageViewRight.frame;
    rect.origin.y = self.frame.size.height - image.size.height;
    rect.size.height = image.size.height;
    [self.shadowImageViewRight setFrame:rect];
}
-(void)setShadowImageLeft : (UIImage *)image{
    [self.shadowImageViewLeft setImage:image];
    CGRect rect = self.shadowImageViewLeft.frame;
    rect.origin.y = self.frame.size.height - image.size.height;
    rect.size.height = image.size.height;
    [self.shadowImageViewLeft setFrame:rect];
}
-(void)setResizeCoeff : (float) coeff{
    for (IDScrollableTabBarItem *item in _buttonsArray) {
        [item setResizeCoeff:coeff];
        [item setFrame:item.frame];
    }
}
-(void)setDividerImage : (UIImage *)image{
    for (IDScrollableTabBarItem *item in _buttonsArray) {
        [item.imgViewDivider setImage:image];
        CGRect rect = item.imgViewDivider.frame;
        rect.origin.y = self.frame.size.height - image.size.height;
        rect.size.height = image.size.height;
        float diff = (image.size.width - rect.size.width) / 2.f;
        rect.origin.x -= diff;
        rect.size.width = image.size.width;
        [item.imgViewDivider setFrame:rect];
    }
}
-(void)setItemsFont : (UIFont *) font textColor : (UIColor *)color{
    for (IDScrollableTabBarItem *item in _buttonsArray) {
        [item.label setFont:font];
        [item.label setTextColor:color];
    }
}
-(NSArray *)getItems{
    return _buttonsArray;
}
-(IDScrollableTabBarItem *)itemAtIndex : (int) index{
    IDScrollableTabBarItem *item = nil;
    if (index < [_buttonsArray count]) {
        item = [_buttonsArray objectAtIndex:index];
    }
    return item;
}
#pragma mark - Ititialization
-(void)setArchImage : (UIImage *)archImage centerImage : (UIImage *)centerImage backGroundImage : (UIImage *)backGroundImage{
    CGSize size;
    CGRect rect;
    if (archImage) {
        //change self height
        rect = self.frame;
        rect.size.height = archImage.size.height;
        [self setFrame:rect];
        
        
        _archImageView.hidden = NO;
        size = archImage.size;
        rect = _archImageView.frame;
        [_archImageView setImage:archImage];
        rect.size = size;
        rect.origin.x = self.frame.size.width / 2.f - rect.size.width / 2.f;
        rect.origin.y = 0;
        [_archImageView setFrame:rect];
        
        for (IDScrollableTabBarItem *item in _buttonsArray) {
            UIImageView *imgViewDivider = item.imgViewDivider;
            [imgViewDivider removeFromSuperview];
            [self insertSubview:item.imgViewDivider belowSubview:_centerImageView];
            ///////
            item.archWidth = rect.size.width;
            [item setFrame:item.frame];
        }
    }else{
        for (IDScrollableTabBarItem *item in _buttonsArray) {
            UIImageView *imgViewDivider = item.imgViewDivider;
            [imgViewDivider removeFromSuperview];
            [self insertSubview:item.imgViewDivider belowSubview:_archImageView];
        }
        _archImageView.hidden = YES;
        if (centerImage) {
            //change self height
            rect = self.frame;
            rect.size.height = centerImage.size.height;
            [self setFrame:rect];
        }
    }
    
    if (centerImage) {
        _centerImageView.hidden = NO;
        size = centerImage.size;
        rect = _centerImageView.frame;
        [_centerImageView setImage:centerImage];
        rect.size = size;
        rect.origin.x = self.frame.size.width / 2.f - rect.size.width / 2.f;
        rect.origin.y = self.frame.size.height - rect.size.height;
        [_centerImageView setFrame:rect];
    }else{
        _centerImageView.hidden = YES;
    }
    
    if (_archImageView.hidden && _centerImageView.hidden) {
        //change self height
        rect = self.frame;
        rect.size.height = backGroundImage.size.height;
        [self setFrame:rect];
    }
    [_backImageView setImage:backGroundImage];
    rect = _backImageView.frame;
    rect.origin.y = self.frame.size.height - backGroundImage.size.height > 0 ? self.frame.size.height - backGroundImage.size.height : 0;
    rect.size.height = backGroundImage.size.height;
    [_backImageView setFrame:rect];
    
    [self changeLedge];
    
    for (IDScrollableTabBarItem *item in _buttonsArray) {
        [item setFrame:item.frame];
    }
}
-(void)changeLedge{
    if (!_archImageView.hidden) {
        _ledge = _archImageView.image.size.height - _backImageView.image.size.height;
    }else if(!_centerImageView.hidden){
        _ledge = _centerImageView.image.size.height - _backImageView.image.size.height;
    }else{
        _ledge = 0.f;
    }
    
    if (_ledge >= self.frame.size.height) {
        _ledge = 0.f;
    }
    _itemHeight = self.frame.size.height - _ledge;
    for (IDScrollableTabBarItem *item in _buttonsArray) {
        CGRect rect = item.frame;
        rect.origin.y = _ledge;
        rect.size.height = _itemHeight;
        [item setFrame:rect];
        [item correctPositions];
    }
    CGRect rect = _firstTouchView.frame;
    rect.size.height = _ledge;
    rect.size.width = _archImageView.frame.size.width + 40.f;
    rect.origin.x = self.frame.size.width / 2.f - _archImageView.frame.size.width / 2.f - 20.f;
    [_firstTouchView setFrame:rect];
    
    rect = _secondTouchView.frame;
    rect.origin.y = _ledge;
    rect.size.height = self.frame.size.height - _ledge;
    [_secondTouchView setFrame:rect];
}
-(void)setFrame:(CGRect)frame{
    [self stopTimer];
    //block GestureRecognizers
    _frameAnimation = YES;
    //selectedItem
    CGPoint point = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    for (int u = 0; u < [_buttonsArray count]; u++) {
        UIView *view = [_buttonsArray objectAtIndex:u];
        if (CGRectContainsPoint(view.frame, point)) {
            if (_selectedItem != u) {
                _selectedItem = u;
                [self postActionToDelegate];
            }
            break;
        }
    }
    [super setFrame:frame];
    if ([_buttonsArray count] > 0) {
        IDScrollableTabBarItem *item = [_buttonsArray objectAtIndex:0];
        float itemWidth = item.frame.size.width;
        int leftCount = [_buttonsArray count] / 2.f - 0.5f;
        int rightCount = [_buttonsArray count] - leftCount - 1;
        _maxX = rightCount * itemWidth + frame.size.width / 2.f;
        _minX = - leftCount * itemWidth + frame.size.width / 2.f - itemWidth;
    }
    for (int i = 0; i < [_buttonsArray count]; i++) {
        IDScrollableTabBarItem *item = [_buttonsArray objectAtIndex:i];
        item.halfTabBarWidth = frame.size.width / 2.f;
    }
    //correctPositions
    if ([_buttonsArray count] > 0) {
        int leftCount = [_buttonsArray count] / 2.f - 0.5;
        int rightCount = [_buttonsArray count] - 1 - leftCount;
        for (int i = 0; i < [_buttonsArray count]; i++) {
            IDScrollableTabBarItem *item = [_buttonsArray objectAtIndex:i];
            CGRect rect = item.frame;
            if ((self.selectedItem - leftCount <= i && i <= self.selectedItem && self.selectedItem >= leftCount) || (self.selectedItem < leftCount && (self.selectedItem > i || self.selectedItem + rightCount < i))) {
                //left
                int diffIndex = abs(self.selectedItem - i);
                if (diffIndex > leftCount) {
                    diffIndex = [_buttonsArray count] - diffIndex;
                }
                rect.origin.x = frame.size.width / 2.f - rect.size.width / 2.f - (diffIndex) * rect.size.width;
            }else{
                //right
                int diffIndex = abs(self.selectedItem - i);
                if (diffIndex > rightCount) {
                    diffIndex = [_buttonsArray count] - diffIndex;
                }
                rect.origin.x = frame.size.width / 2.f + rect.size.width / 2.f + (diffIndex - 1) * rect.size.width;
                
            }
            [item setFrame:rect];
        }
    }
    self.userInteractionEnabled = YES;
    _currentRecognizer = nil;
    double delayInSeconds = 0.5;
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^(void){
        //enable GestureRecognizers
        _frameAnimation = NO;
    });
}
- (id)initWithFrame:(CGRect)frame itemWidth : (float) itemWidth items : (IDItem *)item, ...{
    
    UIImage *defaultBackGroundImage = [UIImage imageNamed:@"defaultBackground"];
    UIImage *defaultArchImage = [UIImage imageNamed:@"defaultArch"];
    frame.size.height = defaultArchImage.size.height;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSMutableArray *arrayItems = [[NSMutableArray alloc] init];
        va_list args;
        va_start(args,item);
        for (IDItem *arg = item; arg != nil; arg = va_arg(args, IDItem*))
        {
            [arrayItems addObject:arg];
        }
        va_end(args);
        _itemWidth = itemWidth;
        _ledge = defaultArchImage.size.height - defaultBackGroundImage.size.height;
        if (_ledge >= frame.size.height) {
            _ledge = 0.f;
        }
        _itemHeight = frame.size.height - _ledge;
        //defaults
        self.backgroundColor = [UIColor clearColor];
        _backImageView = [[UIImageView alloc] initWithImage:defaultBackGroundImage];
        CGRect rect = _backImageView.frame;
        rect.origin.y = self.frame.size.height - rect.size.height;
        [_backImageView setFrame:rect];
        _backImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_backImageView];
        self.clipsToBounds = YES;
        //center
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultCenter"]];
        rect = _centerImageView.frame;
        rect.origin.x = self.frame.size.width / 2.f - rect.size.width / 2.f;
        [_centerImageView setFrame:rect];
        _centerImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_centerImageView];
        //arch
        _archImageView = [[UIImageView alloc] initWithImage:defaultArchImage];
        rect = _archImageView.frame;
        rect.origin.x = frame.size.width / 2.f - rect.size.width / 2.f;
        [_archImageView setFrame:rect];
        _archImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_archImageView];
        //shadowImages
        UIImageView *imgViewLeft = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultShadowLeft"]];
        imgViewLeft.userInteractionEnabled = NO;
        rect = imgViewLeft.frame;
        rect.origin.y = self.frame.size.height - rect.size.height;
        [imgViewLeft setFrame:rect];
        imgViewLeft.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:imgViewLeft];
        self.shadowImageViewLeft = imgViewLeft;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultShadowRight"]];
        imgView.userInteractionEnabled = NO;
        rect = imgView.frame;
        rect.origin.x = self.frame.size.width - rect.size.width;
        rect.origin.y = self.frame.size.height - rect.size.height;
        [imgView setFrame:rect];
        imgView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:imgView];
        self.shadowImageViewRight = imgView;
        //by default - middle item
        _selectedItem = [arrayItems count] / 2.f - 0.5f;
        [self createButtons:arrayItems];
        [self createTouchAbleViews];
        _isTapSelectionNeed = YES;
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)createButtons : (NSArray *)arrayItems{
    //buttons
    float itemWidth;
    NSMutableArray *arrayButtonItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < [arrayItems count]; i++) {
        IDItem *dataItem = [arrayItems objectAtIndex:i];
        IDScrollableTabBarItem *item = [[IDScrollableTabBarItem alloc] initWithFrame:CGRectMake(0, 0, _itemWidth, _itemHeight) image:dataItem.image text:dataItem.text dividerImage:[UIImage imageNamed:@"defaultDivider"] halfTabBarWidth:self.frame.size.width / 2.f additionResizeCoeff:0.3f archWidth:_archImageView.frame.size.width];
        itemWidth = item.frame.size.width;
        int diffCount = i - _selectedItem;
        float middleDiff = item.frame.size.width / 2.f;
        if (diffCount <= 0) {
            middleDiff = - middleDiff;
        }else{
            diffCount -= 1;
        }
        CGRect rect = CGRectMake(self.frame.size.width / 2.f + diffCount * item.frame.size.width + middleDiff, _ledge, item.frame.size.width, _itemHeight);
        [item setFrame:rect];
        [self insertSubview:item belowSubview:_archImageView];
        [self insertSubview:item.imgViewDivider belowSubview:_centerImageView];
        [arrayButtonItems addObject:item];
        //correct divider
        rect = item.imgViewDivider.frame;
        rect.origin.y = self.frame.size.height - item.imgViewDivider.image.size.height;
        rect.size.height = item.imgViewDivider.image.size.height;
        float diff = (item.imgViewDivider.image.size.width - rect.size.width) / 2.f;
        rect.origin.x -= diff;
        rect.size.width = item.imgViewDivider.image.size.width;
        [item.imgViewDivider setFrame:rect];
    }
    _buttonsArray = [[NSArray alloc] initWithArray:arrayButtonItems];
    int leftCount = [_buttonsArray count] / 2.f - 0.5f;
    int rightCount = [_buttonsArray count] - leftCount - 1;
    _maxX = rightCount * itemWidth + self.frame.size.width / 2.f;
    _minX = - leftCount * itemWidth + self.frame.size.width / 2.f - itemWidth;
}
-(void)createTouchAbleViews{
    //          _________
    //         |firstView|
    //    _____|_________|_______
    //    |     secondView      |
    //    _______________________
    _firstTouchView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2.f - _archImageView.frame.size.width / 2.f - 20.f, 0, _archImageView.frame.size.width + 40.f, _ledge)];
    _firstTouchView.backgroundColor = [UIColor clearColor];
    _panRecognizer0 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    _panRecognizer0.maximumNumberOfTouches = 1;
    _panRecognizer0.delegate = self;
    [_firstTouchView addGestureRecognizer:_panRecognizer0];
    _firstTouchView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:_firstTouchView];
    _secondTouchView = [[UIView alloc] initWithFrame:CGRectMake(0, _ledge, self.frame.size.width, self.frame.size.height - _ledge)];
    _secondTouchView.backgroundColor = [UIColor clearColor];
    _panRecognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    _panRecognizer1.maximumNumberOfTouches = 1;
    _panRecognizer1.delegate = self;
    [_secondTouchView addGestureRecognizer:_panRecognizer1];
    _secondTouchView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_secondTouchView];
    //adding UITapGestureRecognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    tapRecognizer.delegate = self;
    [_secondTouchView addGestureRecognizer:tapRecognizer];
}
#pragma mark - NSTimer
-(void)startTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval: timerSpeed target: self
                                            selector:@selector(onTick:)
                                            userInfo: nil repeats:YES];
}
-(void)stopTimer{
    _velocity = 0.f;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)onTick:(NSTimer *)timer {
    int diff = _velocity * speedFactor;
    [self scrollViews:diff];
    if (_velocity > friction) {
        _velocity -= friction;
    }else if(_velocity < -friction){
        _velocity += friction;
    }else{
        [self stopTimer];
        [self animateToSelectionPosition];
    }
}
#pragma mark - scrollViews
-(void)scrollViews : (int)diff{
    for (UIView *view in _buttonsArray) {
        CGRect rect = view.frame;
        rect.origin.x += diff;
        [view setFrame:rect];
    }
    //check if item get out of bounds
    for (int i = 0; i < [_buttonsArray count]; i++) {
        UIView *view = [_buttonsArray objectAtIndex:i];
        CGRect rect = view.frame;
        if (rect.origin.x > _maxX) {
            rect.origin.x = _minX;
            [view setFrame:rect];
            [self correctToRightWithView:view AtIndex:i];
            break;
        }else if(rect.origin.x < _minX){
            rect.origin.x = _maxX;
            [view setFrame:rect];
            [self correctToLeftWithView:view AtIndex:i];
            break;
        }
    }
}
-(void)correctToRightWithView : (UIView *) correctView AtIndex : (int)index{
    //adjust views
    for (int i = index + 1; i < [_buttonsArray count]; i++) {
        UIView *view = [_buttonsArray objectAtIndex:i];
        CGRect rect = view.frame;
        rect.origin.x = correctView.frame.origin.x + (i - index) * correctView.frame.size.width;
        [view setFrame:rect];
    }
    for (int i = index - 1; i >= 0; i--) {
        UIView *view = [_buttonsArray objectAtIndex:i];
        CGRect rect = view.frame;
        rect.origin.x = _maxX - (index - i) * rect.size.width;
        [view setFrame:rect];
    }
}
-(void)correctToLeftWithView : (UIView *) correctView AtIndex : (int)index{
    //adjust views
    for (int i = index + 1; i < [_buttonsArray count]; i++) {
        UIView *view = [_buttonsArray objectAtIndex:i];
        CGRect rect = view.frame;
        rect.origin.x = _minX + (i - index) * rect.size.width;
        [view setFrame:rect];
    }
    for (int i = index - 1; i >= 0; i--) {
        UIView *view = [_buttonsArray objectAtIndex:i];
        CGRect rect = view.frame;
        rect.origin.x = correctView.frame.origin.x - (index - i) * rect.size.width;
        [view setFrame:rect];
    }
}
//animate to selected position
-(void)animateToSelectionPosition{
    if ([_buttonsArray count] > 0) {
        //find the distance
        int diff = ((UIView*)[_buttonsArray objectAtIndex:0]).frame.size.width / 2;
        for (int u = 0; u < [_buttonsArray count]; u++) {
            UIView *view = [_buttonsArray objectAtIndex:u];
            //view center
            float center = view.frame.origin.x + view.frame.size.width / 2;
            if (ABS(center - self.frame.size.width / 2) <= view.frame.size.width / 2 + 1) {
                diff = self.frame.size.width / 2 - center;
                break;
            }
        }
        //before the animation set view in correct positions
        for (IDScrollableTabBarItem *view in _buttonsArray) {
            CGRect rect = view.frame;
            rect.origin.x += diff;
            if (rect.origin.x > _maxX) {
                rect.origin.x = _minX;
                [view setFrame:rect];
            }else if(rect.origin.x < _minX){
                rect.origin.x = _maxX;
                [view setFrame:rect];
            }
        }
        self.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.2 delay: 0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
            for (UIView *view in _buttonsArray) {
                CGRect rect = view.frame;
                rect.origin.x += diff;
                [view setFrame:rect];
            }
        }completion:^(BOOL finished){
            self.userInteractionEnabled = YES;
            _isTapSelectionNeed = YES;
            /////
            CGPoint point = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
            for (int u = 0; u < [_buttonsArray count]; u++) {
                UIView *view = [_buttonsArray objectAtIndex:u];
                if (CGRectContainsPoint(view.frame, point)) {
                    if (_selectedItem != u) {
                        _selectedItem = u;
                        [self postActionToDelegate];
                    }
                    break;
                }
            }
        }];
    }
}
-(void)setSelectedItem:(int)selectedItem animated : (BOOL) animated{
    if (selectedItem < [_buttonsArray count]) {
        [self animateToSelectedItem:selectedItem animated:animated];
    }
}
-(void)animateToSelectedItem : (int) selectedItem animated : (BOOL)animated{
    BOOL needPost = YES;
    if (_selectedItem == selectedItem) {
        needPost = NO;
    }
    //find distance
    UIView *selectedView = [_buttonsArray objectAtIndex:selectedItem];
    UIView *currentView = [_buttonsArray objectAtIndex:_selectedItem];
    int diff = currentView.frame.origin.x - selectedView.frame.origin.x;
    _selectedItem = selectedItem;
    ////
    if (needPost) {
        [self postActionToDelegate];
    }
    //before the animation correct views
    for (IDScrollableTabBarItem *view in _buttonsArray) {
        CGRect rect = view.frame;
        rect.origin.x += diff;
        if (rect.origin.x > _maxX) {
            int itemCount = (rect.origin.x - _maxX) / rect.size.width;
            float distance = diff - itemCount * view.frame.size.width;
            rect.origin.x = _minX - distance + view.frame.size.width / 2;
            [view setFrame:rect];
        }else if(rect.origin.x < _minX){
            int itemCount = (_minX - rect.origin.x) / rect.size.width + 1;
            float distance = (-diff - itemCount * view.frame.size.width);
            rect.origin.x = _maxX + view.frame.size.width / 2 + distance;
            [view setFrame:rect];
        }
    }
    if (animated) {
        self.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.2 delay: 0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
            for (UIView *view in _buttonsArray) {
                CGRect rect = view.frame;
                rect.origin.x += diff;
                [view setFrame:rect];
            }
        }completion:^(BOOL finished){
            self.userInteractionEnabled = YES;
        }];
    }else{
        for (UIView *view in _buttonsArray) {
            CGRect rect = view.frame;
            rect.origin.x += diff;
            [view setFrame:rect];
        }
    }
}
#pragma mark - postAction
-(void)postActionToDelegate{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollTabBarAction:sender:)]) {
        [self.delegate scrollTabBarAction:[NSNumber numberWithInt:_selectedItem] sender:self];
    }
}
#pragma mark - getureRecognizers
-(void)panGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    if (_frameAnimation) {
        return;
    }
    if (_currentRecognizer != gestureRecognizer && _currentRecognizer) {
        return;
    }
    CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        _currentRecognizer = gestureRecognizer;
        _touchBeganPoint = location;
        [self stopTimer];
        return;
    }
    
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        _currentRecognizer = nil;
        if (ABS(velocity.x) > 100) {
            //speed
            _velocity = velocity.x;
            [self startTimer];
        }else{
            //there is no speed
            [self animateToSelectionPosition];
            return;
        }
    }
    
    int diff = location.x - _touchBeganPoint.x;
    _touchBeganPoint = location;
    [self scrollViews:diff];
}
- (void) tapGesture : (UIGestureRecognizer*) sender
{
    if (_isTapSelectionNeed) {
        //select needed item
        CGPoint location = [sender locationInView:sender.view];
        for (int u = 0; u < [_buttonsArray count]; u++) {
            UIView *view = [_buttonsArray objectAtIndex:u];
            if (CGRectContainsPoint(view.frame, location)) {
                //animate to selected item
                [self animateToSelectedItem:u animated:YES];
                break;
            }
        }
    }else{
        [self animateToSelectionPosition];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_velocity > 0.f) {
        _isTapSelectionNeed = NO;
    }
    [self stopTimer];
}
@end
