//
//  PlayingSetView.m
//  GraphicalCardGame
//
//  Created by Kim Minsu on 2013/05/10.
//  Copyright (c) 2013年 Kim Minsu. All rights reserved.
//

#import "PlayingSetView.h"
#import "PlayingCardSet.h"

@implementation PlayingSetView

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

- (CGFloat)faceCardScaleFactor {
    if(!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    return _faceCardScaleFactor;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:12.0];
    [roundedRect addClip];
    
    NSAttributedString *text = [self attributedContents];
    CGRect textBounds;
    CGSize textSize = [text size];
    textBounds.origin = CGPointMake(self.bounds.size.width/2-textSize.width/2,
                                    self.bounds.size.height/2-textSize.height/2);
    textBounds.size = textSize;
    
    if(self.faceUp) {
        [[[UIColor blackColor] colorWithAlphaComponent:0.2] setFill];
        UIRectFill(self.bounds);
    } else {
        [[UIColor whiteColor] setFill];
        UIRectFill(self.bounds);
    }
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    [text drawInRect:textBounds];
}

- (NSString *)contents {
    NSString *contents = @"";
    for(int i=1;i<=self.number;i++) {
        contents = [NSString stringWithFormat:@"%@%@",contents,self.symbol];
    }
    return contents;
}

- (NSMutableAttributedString *)attributedContents {
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:[self contents]];
    NSArray *shadings = [PlayingCardSet validShading];
    NSRange r = [[contents string] rangeOfString:[self contents]];
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[UIFont systemFontOfSize:self.bounds.size.width * 0.20] forKey:NSFontAttributeName];
    [attributes setObject:self.color forKey:NSForegroundColorAttributeName];
    if([self.shading isEqualToString:shadings[0]]) {
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
    } else if([self.shading isEqualToString:shadings[1]]) {
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        [attributes setObject:self.color forKey:NSStrokeColorAttributeName];
        [attributes setObject:[attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
                       forKey:NSForegroundColorAttributeName];
    } else if([self.shading isEqualToString:shadings[2]]) {
        [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    }
    [contents addAttributes:attributes range:r];
    return contents;
}

- (NSString *)numberAsString {
    return [PlayingCardSet numberStrings][self.number];
}

#pragma mark - setNeedsDisplay

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setNumber:(NSUInteger)number {
    _number = number;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading {
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSString *)symbol {
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

@end
