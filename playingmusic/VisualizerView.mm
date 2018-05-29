//
//  VisualizerView.m
//  playingmusic
//
//  Created by Ken Lu on 5/26/18.
//  Copyright © 2018 Ken Lu. All rights reserved.
//

#import "VisualizerView.h"
#import "MeterTable.h"
@implementation VisualizerView {
    CAEmitterLayer *emitterLayer;
    MeterTable meterTabler;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (Class)layerClass {
    return [CAEmitterLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.blackColor;
        emitterLayer = (CAEmitterLayer *)self.layer;
        
        
        CGFloat height = MAX(frame.size.width, frame.size.height);
        CGFloat width = MIN(frame.size.width, frame.size.height);
        emitterLayer.emitterPosition = CGPointMake(width/2, height/2);
        emitterLayer.emitterSize = CGSizeMake(width-80, 60);
        emitterLayer.emitterShape = kCAEmitterLayerRectangle;
        emitterLayer.renderMode = kCAEmitterLayerAdditive;
        
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        cell.name = @"cell";
//        cell.contents = (id)[[UIImage imageNamed:@"particle4u.png"] CGImage];
        
//        cell.color = [[UIColor colorWithRed:1.0f green:0.53f blue:0.0f alpha:0.8f] CGColor];
//        cell.redRange = 0.46f;
//        cell.greenRange = 0.49f;
//        cell.blueRange = 0.67f;
//        cell.alphaRange = 0.55f;
//
//        // 5
//        cell.redSpeed = 0.11f;
//        cell.greenSpeed = 0.07f;
//        cell.blueSpeed = -0.25f;
//        cell.alphaSpeed = 0.15f;
        
        
        CAEmitterCell *childCell = [CAEmitterCell emitterCell];
        childCell.name = @"childCell";
        childCell.lifetime = 1.0f / 60.0f;
        childCell.birthRate = 60.0f;
        childCell.velocity = 0.0f;
        
        childCell.contents = (id)[[UIImage imageNamed:@"particle4u.png"] CGImage];
        cell.emitterCells = @[childCell];
        
        cell.scale = 0.5f;
        cell.scaleRange = 0.5f;
        
        cell.lifetime = 1.0f;
        cell.lifetimeRange = .25f;
        cell.birthRate = 80;
        
        cell.velocity = 100.0f;
        cell.velocityRange = 350.0f;
        cell.emissionRange = M_PI * 2;
        
        emitterLayer.emitterCells = @[cell];
        
        CADisplayLink *dpLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [dpLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        
    }
    return self;
}

- (void)update {
    float scale = 0.5;
    if (_audioPlayer.playing) {
        [_audioPlayer updateMeters];
        float power = 0.0f;
        for (int i = 0; i < [_audioPlayer numberOfChannels]; i++) {
            power += [_audioPlayer averagePowerForChannel:i];
        }
        power /= [_audioPlayer numberOfChannels];
        float level = meterTabler.ValueAt(power);
        scale = level * 2.5;
    }
    [emitterLayer setValue:@(scale) forKeyPath:@"emitterCells.cell.emitterCells.childCell.scale"];
}

@end
