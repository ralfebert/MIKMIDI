//
//  MIKMIDIChannelVoiceCommand.m
//  MIDI Testbed
//
//  Created by Andrew Madsen on 6/2/13.
//  Copyright (c) 2013 Mixed In Key. All rights reserved.
//

#import "MIKMIDIChannelVoiceCommand.h"
#import "MIKMIDICommand_SubclassMethods.h"

@implementation MIKMIDIChannelVoiceCommand

+ (void)load { [super load]; [MIKMIDICommand registerSubclass:self]; }
+ (BOOL)supportsMIDICommandType:(MIKMIDICommandType)type
{
	NSArray *supportedTypes = @[@(MIKMIDICommandTypePolyphonicKeyPressure),
							 @(MIKMIDICommandTypeProgramChange),
							 @(MIKMIDICommandTypeChannelPressure),
							 @(MIKMIDICommandTypePitchWheelChange)];
	return [supportedTypes containsObject:@(type)];
}

+ (Class)immutableCounterpartClass; { return [MIKMIDIChannelVoiceCommand class]; }
+ (Class)mutableCounterpartClass; { return [MIKMutableMIDIChannelVoiceCommand class]; }

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ channel %d", [super description], self.channel];
}

#pragma mark - Properties

- (UInt8)channel
{
	if ([self.internalData length] < 1) return 0;
	UInt8 *data = (UInt8 *)[self.internalData bytes];
	return data[0] & 0x0F;
}

@end

@implementation MIKMutableMIDIChannelVoiceCommand

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ channel %d", [super description], self.channel];
}

#pragma mark - Properties

- (UInt8)channel
{
	if ([self.internalData length] < 1) return 0;
	UInt8 *data = (UInt8 *)[self.internalData bytes];
	return data[0] & 0x0F;
}

- (void)setChannel:(UInt8)channel
{
	if ([self.internalData length] < 2) [self.internalData increaseLengthBy:1-[self.internalData length]];
	
	UInt8 *data = (UInt8 *)[self.internalData bytes];
	data[0] |= (channel & 0x0F);
}

@end