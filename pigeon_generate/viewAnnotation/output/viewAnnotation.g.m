// Autogenerated from Pigeon (v16.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "viewAnnotation.g.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}

static FlutterError *createConnectionError(NSString *channelName) {
  return [FlutterError errorWithCode:@"channel-error" message:[NSString stringWithFormat:@"%@/%@/%@", @"Unable to establish connection on channel: '", channelName, @"'."] details:@""];
}

static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@implementation FLTAnnotatedFeatureTypeBox
- (instancetype)initWithValue:(FLTAnnotatedFeatureType)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

@implementation FLTViewAnnotationAnchorBox
- (instancetype)initWithValue:(FLTViewAnnotationAnchor)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

@implementation FLTViewAnnotationUpdateModeBox
- (instancetype)initWithValue:(FLTViewAnnotationUpdateMode)value {
  self = [super init];
  if (self) {
    _value = value;
  }
  return self;
}
@end

@interface FLTAnnotatedFeature ()
+ (FLTAnnotatedFeature *)fromList:(NSArray *)list;
+ (nullable FLTAnnotatedFeature *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTViewAnnotationAnchorConfig ()
+ (FLTViewAnnotationAnchorConfig *)fromList:(NSArray *)list;
+ (nullable FLTViewAnnotationAnchorConfig *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTViewAnnotationOptions ()
+ (FLTViewAnnotationOptions *)fromList:(NSArray *)list;
+ (nullable FLTViewAnnotationOptions *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTAnnotatedLayerFeature ()
+ (FLTAnnotatedLayerFeature *)fromList:(NSArray *)list;
+ (nullable FLTAnnotatedLayerFeature *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FLTScreenCoordinate ()
+ (FLTScreenCoordinate *)fromList:(NSArray *)list;
+ (nullable FLTScreenCoordinate *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation FLTAnnotatedFeature
+ (instancetype)makeWithValue:(id )value
    type:(FLTAnnotatedFeatureType)type {
  FLTAnnotatedFeature* pigeonResult = [[FLTAnnotatedFeature alloc] init];
  pigeonResult.value = value;
  pigeonResult.type = type;
  return pigeonResult;
}
+ (FLTAnnotatedFeature *)fromList:(NSArray *)list {
  FLTAnnotatedFeature *pigeonResult = [[FLTAnnotatedFeature alloc] init];
  pigeonResult.value = GetNullableObjectAtIndex(list, 0);
  pigeonResult.type = [GetNullableObjectAtIndex(list, 1) integerValue];
  return pigeonResult;
}
+ (nullable FLTAnnotatedFeature *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTAnnotatedFeature fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    self.value ?: [NSNull null],
    @(self.type),
  ];
}
@end

@implementation FLTViewAnnotationAnchorConfig
+ (instancetype)makeWithAnchor:(FLTViewAnnotationAnchor)anchor
    offsetX:(double )offsetX
    offsetY:(double )offsetY {
  FLTViewAnnotationAnchorConfig* pigeonResult = [[FLTViewAnnotationAnchorConfig alloc] init];
  pigeonResult.anchor = anchor;
  pigeonResult.offsetX = offsetX;
  pigeonResult.offsetY = offsetY;
  return pigeonResult;
}
+ (FLTViewAnnotationAnchorConfig *)fromList:(NSArray *)list {
  FLTViewAnnotationAnchorConfig *pigeonResult = [[FLTViewAnnotationAnchorConfig alloc] init];
  pigeonResult.anchor = [GetNullableObjectAtIndex(list, 0) integerValue];
  pigeonResult.offsetX = [GetNullableObjectAtIndex(list, 1) doubleValue];
  pigeonResult.offsetY = [GetNullableObjectAtIndex(list, 2) doubleValue];
  return pigeonResult;
}
+ (nullable FLTViewAnnotationAnchorConfig *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTViewAnnotationAnchorConfig fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    @(self.anchor),
    @(self.offsetX),
    @(self.offsetY),
  ];
}
@end

@implementation FLTViewAnnotationOptions
+ (instancetype)makeWithAnnotatedFeature:(nullable FLTAnnotatedFeature *)annotatedFeature
    width:(nullable NSNumber *)width
    height:(nullable NSNumber *)height
    allowOverlap:(nullable NSNumber *)allowOverlap
    allowOverlapWithPuck:(nullable NSNumber *)allowOverlapWithPuck
    visible:(nullable NSNumber *)visible
    variableAnchors:(nullable NSArray<FLTViewAnnotationAnchorConfig *> *)variableAnchors
    selected:(nullable NSNumber *)selected
    ignoreCameraPadding:(nullable NSNumber *)ignoreCameraPadding {
  FLTViewAnnotationOptions* pigeonResult = [[FLTViewAnnotationOptions alloc] init];
  pigeonResult.annotatedFeature = annotatedFeature;
  pigeonResult.width = width;
  pigeonResult.height = height;
  pigeonResult.allowOverlap = allowOverlap;
  pigeonResult.allowOverlapWithPuck = allowOverlapWithPuck;
  pigeonResult.visible = visible;
  pigeonResult.variableAnchors = variableAnchors;
  pigeonResult.selected = selected;
  pigeonResult.ignoreCameraPadding = ignoreCameraPadding;
  return pigeonResult;
}
+ (FLTViewAnnotationOptions *)fromList:(NSArray *)list {
  FLTViewAnnotationOptions *pigeonResult = [[FLTViewAnnotationOptions alloc] init];
  pigeonResult.annotatedFeature = [FLTAnnotatedFeature nullableFromList:(GetNullableObjectAtIndex(list, 0))];
  pigeonResult.width = GetNullableObjectAtIndex(list, 1);
  pigeonResult.height = GetNullableObjectAtIndex(list, 2);
  pigeonResult.allowOverlap = GetNullableObjectAtIndex(list, 3);
  pigeonResult.allowOverlapWithPuck = GetNullableObjectAtIndex(list, 4);
  pigeonResult.visible = GetNullableObjectAtIndex(list, 5);
  pigeonResult.variableAnchors = GetNullableObjectAtIndex(list, 6);
  pigeonResult.selected = GetNullableObjectAtIndex(list, 7);
  pigeonResult.ignoreCameraPadding = GetNullableObjectAtIndex(list, 8);
  return pigeonResult;
}
+ (nullable FLTViewAnnotationOptions *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTViewAnnotationOptions fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    (self.annotatedFeature ? [self.annotatedFeature toList] : [NSNull null]),
    self.width ?: [NSNull null],
    self.height ?: [NSNull null],
    self.allowOverlap ?: [NSNull null],
    self.allowOverlapWithPuck ?: [NSNull null],
    self.visible ?: [NSNull null],
    self.variableAnchors ?: [NSNull null],
    self.selected ?: [NSNull null],
    self.ignoreCameraPadding ?: [NSNull null],
  ];
}
@end

@implementation FLTAnnotatedLayerFeature
+ (instancetype)makeWithLayerId:(NSString *)layerId
    featureId:(nullable NSString *)featureId {
  FLTAnnotatedLayerFeature* pigeonResult = [[FLTAnnotatedLayerFeature alloc] init];
  pigeonResult.layerId = layerId;
  pigeonResult.featureId = featureId;
  return pigeonResult;
}
+ (FLTAnnotatedLayerFeature *)fromList:(NSArray *)list {
  FLTAnnotatedLayerFeature *pigeonResult = [[FLTAnnotatedLayerFeature alloc] init];
  pigeonResult.layerId = GetNullableObjectAtIndex(list, 0);
  pigeonResult.featureId = GetNullableObjectAtIndex(list, 1);
  return pigeonResult;
}
+ (nullable FLTAnnotatedLayerFeature *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTAnnotatedLayerFeature fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    self.layerId ?: [NSNull null],
    self.featureId ?: [NSNull null],
  ];
}
@end

@implementation FLTScreenCoordinate
+ (instancetype)makeWithX:(double )x
    y:(double )y {
  FLTScreenCoordinate* pigeonResult = [[FLTScreenCoordinate alloc] init];
  pigeonResult.x = x;
  pigeonResult.y = y;
  return pigeonResult;
}
+ (FLTScreenCoordinate *)fromList:(NSArray *)list {
  FLTScreenCoordinate *pigeonResult = [[FLTScreenCoordinate alloc] init];
  pigeonResult.x = [GetNullableObjectAtIndex(list, 0) doubleValue];
  pigeonResult.y = [GetNullableObjectAtIndex(list, 1) doubleValue];
  return pigeonResult;
}
+ (nullable FLTScreenCoordinate *)nullableFromList:(NSArray *)list {
  return (list) ? [FLTScreenCoordinate fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    @(self.x),
    @(self.y),
  ];
}
@end

@interface FLTViewAnnotationManagerCodecReader : FlutterStandardReader
@end
@implementation FLTViewAnnotationManagerCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128: 
      return [FLTAnnotatedFeature fromList:[self readValue]];
    case 129: 
      return [FLTAnnotatedLayerFeature fromList:[self readValue]];
    case 130: 
      return [FLTViewAnnotationAnchorConfig fromList:[self readValue]];
    case 131: 
      return [FLTViewAnnotationOptions fromList:[self readValue]];
    case 132: 
      return [FLTViewAnnotationOptions fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface FLTViewAnnotationManagerCodecWriter : FlutterStandardWriter
@end
@implementation FLTViewAnnotationManagerCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[FLTAnnotatedFeature class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTAnnotatedLayerFeature class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTViewAnnotationAnchorConfig class]]) {
    [self writeByte:130];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTViewAnnotationOptions class]]) {
    [self writeByte:131];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTViewAnnotationOptions class]]) {
    [self writeByte:132];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface FLTViewAnnotationManagerCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTViewAnnotationManagerCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTViewAnnotationManagerCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTViewAnnotationManagerCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTViewAnnotationManagerGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    FLTViewAnnotationManagerCodecReaderWriter *readerWriter = [[FLTViewAnnotationManagerCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void SetUpFLTViewAnnotationManager(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTViewAnnotationManager> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.addViewAnnotation"
        binaryMessenger:binaryMessenger
        codec:FLTViewAnnotationManagerGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(addViewAnnotationData:options:completion:)], @"FLTViewAnnotationManager api (%@) doesn't respond to @selector(addViewAnnotationData:options:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FlutterStandardTypedData *arg_data = GetNullableObjectAtIndex(args, 0);
        FLTViewAnnotationOptions *arg_options = GetNullableObjectAtIndex(args, 1);
        [api addViewAnnotationData:arg_data options:arg_options completion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.removeAllViewAnnotations"
        binaryMessenger:binaryMessenger
        codec:FLTViewAnnotationManagerGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(removeAllViewAnnotationsWithCompletion:)], @"FLTViewAnnotationManager api (%@) doesn't respond to @selector(removeAllViewAnnotationsWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api removeAllViewAnnotationsWithCompletion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.removeViewAnnotation"
        binaryMessenger:binaryMessenger
        codec:FLTViewAnnotationManagerGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(removeViewAnnotationViewId:completion:)], @"FLTViewAnnotationManager api (%@) doesn't respond to @selector(removeViewAnnotationViewId:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSInteger arg_viewId = [GetNullableObjectAtIndex(args, 0) integerValue];
        [api removeViewAnnotationViewId:arg_viewId completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.updateViewAnnotation"
        binaryMessenger:binaryMessenger
        codec:FLTViewAnnotationManagerGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(updateViewAnnotationViewId:options:data:completion:)], @"FLTViewAnnotationManager api (%@) doesn't respond to @selector(updateViewAnnotationViewId:options:data:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSInteger arg_viewId = [GetNullableObjectAtIndex(args, 0) integerValue];
        FLTViewAnnotationOptions *arg_options = GetNullableObjectAtIndex(args, 1);
        FlutterStandardTypedData *arg_data = GetNullableObjectAtIndex(args, 2);
        [api updateViewAnnotationViewId:arg_viewId options:arg_options data:arg_data completion:^(NSNumber *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationOptions"
        binaryMessenger:binaryMessenger
        codec:FLTViewAnnotationManagerGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getViewAnnotationOptionsAnnotatedLayerFeature:completion:)], @"FLTViewAnnotationManager api (%@) doesn't respond to @selector(getViewAnnotationOptionsAnnotatedLayerFeature:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTAnnotatedLayerFeature *arg_annotatedLayerFeature = GetNullableObjectAtIndex(args, 0);
        [api getViewAnnotationOptionsAnnotatedLayerFeature:arg_annotatedLayerFeature completion:^(FLTViewAnnotationOptions *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationOptionsByViewId"
        binaryMessenger:binaryMessenger
        codec:FLTViewAnnotationManagerGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getViewAnnotationOptionsByViewIdViewId:completion:)], @"FLTViewAnnotationManager api (%@) doesn't respond to @selector(getViewAnnotationOptionsByViewIdViewId:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSInteger arg_viewId = [GetNullableObjectAtIndex(args, 0) integerValue];
        [api getViewAnnotationOptionsByViewIdViewId:arg_viewId completion:^(FLTViewAnnotationOptions *_Nullable output, FlutterError *_Nullable error) {
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.setViewAnnotationUpdateMode"
        binaryMessenger:binaryMessenger
        codec:FLTViewAnnotationManagerGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setViewAnnotationUpdateModeMode:completion:)], @"FLTViewAnnotationManager api (%@) doesn't respond to @selector(setViewAnnotationUpdateModeMode:completion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FLTViewAnnotationUpdateMode arg_mode = [GetNullableObjectAtIndex(args, 0) integerValue];
        [api setViewAnnotationUpdateModeMode:arg_mode completion:^(FlutterError *_Nullable error) {
          callback(wrapResult(nil, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationUpdateMode"
        binaryMessenger:binaryMessenger
        codec:FLTViewAnnotationManagerGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getViewAnnotationUpdateModeWithCompletion:)], @"FLTViewAnnotationManager api (%@) doesn't respond to @selector(getViewAnnotationUpdateModeWithCompletion:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        [api getViewAnnotationUpdateModeWithCompletion:^(FLTFLTViewAnnotationUpdateModeBox *_Nullable enumValue, FlutterError *_Nullable error) {
          NSNumber *output = enumValue == nil ? nil : [NSNumber numberWithInteger:enumValue.value];
          callback(wrapResult(output, error));
        }];
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface FLTOnViewAnnotationUpdatedListenerCodecReader : FlutterStandardReader
@end
@implementation FLTOnViewAnnotationUpdatedListenerCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128: 
      return [FLTAnnotatedFeature fromList:[self readValue]];
    case 129: 
      return [FLTAnnotatedLayerFeature fromList:[self readValue]];
    case 130: 
      return [FLTScreenCoordinate fromList:[self readValue]];
    case 131: 
      return [FLTViewAnnotationAnchorConfig fromList:[self readValue]];
    case 132: 
      return [FLTViewAnnotationOptions fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface FLTOnViewAnnotationUpdatedListenerCodecWriter : FlutterStandardWriter
@end
@implementation FLTOnViewAnnotationUpdatedListenerCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[FLTAnnotatedFeature class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTAnnotatedLayerFeature class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTScreenCoordinate class]]) {
    [self writeByte:130];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTViewAnnotationAnchorConfig class]]) {
    [self writeByte:131];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FLTViewAnnotationOptions class]]) {
    [self writeByte:132];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface FLTOnViewAnnotationUpdatedListenerCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FLTOnViewAnnotationUpdatedListenerCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FLTOnViewAnnotationUpdatedListenerCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FLTOnViewAnnotationUpdatedListenerCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FLTOnViewAnnotationUpdatedListenerGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    FLTOnViewAnnotationUpdatedListenerCodecReaderWriter *readerWriter = [[FLTOnViewAnnotationUpdatedListenerCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

@interface FLTOnViewAnnotationUpdatedListener ()
@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation FLTOnViewAnnotationUpdatedListener

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)onViewAnnotationPositionUpdatedViewId:(NSInteger)arg_viewId leftTopCoordinate:(FLTScreenCoordinate *)arg_leftTopCoordinate width:(double)arg_width height:(double)arg_height completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = @"dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationPositionUpdated";
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:FLTOnViewAnnotationUpdatedListenerGetCodec()];
  [channel sendMessage:@[@(arg_viewId), arg_leftTopCoordinate ?: [NSNull null], @(arg_width), @(arg_height)] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onViewAnnotationAnchorCoordinateUpdatedViewId:(NSInteger)arg_viewId anchorCoordinate:(nullable NSDictionary<NSString *, id> *)arg_anchorCoordinate completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = @"dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorCoordinateUpdated";
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:FLTOnViewAnnotationUpdatedListenerGetCodec()];
  [channel sendMessage:@[@(arg_viewId), arg_anchorCoordinate ?: [NSNull null]] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onViewAnnotationAnchorUpdatedViewId:(NSInteger)arg_viewId anchor:(FLTViewAnnotationAnchorConfig *)arg_anchor completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = @"dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorUpdated";
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:FLTOnViewAnnotationUpdatedListenerGetCodec()];
  [channel sendMessage:@[@(arg_viewId), arg_anchor ?: [NSNull null]] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onViewAnnotationVisibilityUpdatedViewId:(NSInteger)arg_viewId visible:(BOOL)arg_visible completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = @"dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationVisibilityUpdated";
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:FLTOnViewAnnotationUpdatedListenerGetCodec()];
  [channel sendMessage:@[@(arg_viewId), @(arg_visible)] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
@end

NSObject<FlutterMessageCodec> *FLTOnViewAnnotationTapListenerGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

@interface FLTOnViewAnnotationTapListener ()
@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation FLTOnViewAnnotationTapListener

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)onViewAnnotationClickViewId:(NSInteger)arg_viewId completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = @"dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationTapListener.onViewAnnotationClick";
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:FLTOnViewAnnotationTapListenerGetCodec()];
  [channel sendMessage:@[@(arg_viewId)] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
@end

