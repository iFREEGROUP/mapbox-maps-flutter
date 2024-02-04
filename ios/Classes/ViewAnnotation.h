// Autogenerated from Pigeon (v16.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>
#import "MapInterfaces.h"

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FLTAnnotatedFeatureType) {
  FLTAnnotatedFeatureTypeGEOMETRY = 0,
  FLTAnnotatedFeatureTypeANNOTATED_LAYER_FEATURE = 1,
};

/// Wrapper for FLTAnnotatedFeatureType to allow for nullability.
@interface FLTAnnotatedFeatureTypeBox : NSObject
@property(nonatomic, assign) FLTAnnotatedFeatureType value;
- (instancetype)initWithValue:(FLTAnnotatedFeatureType)value;
@end

typedef NS_ENUM(NSUInteger, FLTViewAnnotationAnchor) {
  FLTViewAnnotationAnchorCENTER = 0,
  FLTViewAnnotationAnchorTOP = 1,
  FLTViewAnnotationAnchorLEFT = 2,
  FLTViewAnnotationAnchorBOTTOM = 3,
  FLTViewAnnotationAnchorRIGHT = 4,
  FLTViewAnnotationAnchorTOP_LEFT = 5,
  FLTViewAnnotationAnchorBOTTOM_RIGHT = 6,
  FLTViewAnnotationAnchorTOP_RIGHT = 7,
  FLTViewAnnotationAnchorBOTTOM_LEFT = 8,
};

/// Wrapper for FLTViewAnnotationAnchor to allow for nullability.
@interface FLTViewAnnotationAnchorBox : NSObject
@property(nonatomic, assign) FLTViewAnnotationAnchor value;
- (instancetype)initWithValue:(FLTViewAnnotationAnchor)value;
@end

typedef NS_ENUM(NSUInteger, FLTViewAnnotationUpdateMode) {
  FLTViewAnnotationUpdateModeMAP_FIXED_DELAY = 0,
  FLTViewAnnotationUpdateModeMAP_SYNCHRONIZED = 1,
};

/// Wrapper for FLTViewAnnotationUpdateMode to allow for nullability.
@interface FLTViewAnnotationUpdateModeBox : NSObject
@property(nonatomic, assign) FLTViewAnnotationUpdateMode value;
- (instancetype)initWithValue:(FLTViewAnnotationUpdateMode)value;
@end

@class FLTAnnotatedFeature;
@class FLTViewAnnotationAnchorConfig;
@class FLTViewAnnotationOptions;
@class FLTAnnotatedLayerFeature;

@interface FLTAnnotatedFeature : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithValue:(id )value
    type:(FLTAnnotatedFeatureType)type;
@property(nonatomic, strong) id  value;
@property(nonatomic, assign) FLTAnnotatedFeatureType type;
@end

@interface FLTViewAnnotationAnchorConfig : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithAnchor:(FLTViewAnnotationAnchor)anchor
    offsetX:(double )offsetX
    offsetY:(double )offsetY;
@property(nonatomic, assign) FLTViewAnnotationAnchor anchor;
@property(nonatomic, assign) double  offsetX;
@property(nonatomic, assign) double  offsetY;
@end

@interface FLTViewAnnotationOptions : NSObject
+ (instancetype)makeWithAnnotatedFeature:(nullable FLTAnnotatedFeature *)annotatedFeature
    width:(nullable NSNumber *)width
    height:(nullable NSNumber *)height
    allowOverlap:(nullable NSNumber *)allowOverlap
    allowOverlapWithPuck:(nullable NSNumber *)allowOverlapWithPuck
    visible:(nullable NSNumber *)visible
    variableAnchors:(nullable NSArray<FLTViewAnnotationAnchorConfig *> *)variableAnchors
    selected:(nullable NSNumber *)selected
    ignoreCameraPadding:(nullable NSNumber *)ignoreCameraPadding;
@property(nonatomic, strong, nullable) FLTAnnotatedFeature * annotatedFeature;
@property(nonatomic, strong, nullable) NSNumber * width;
@property(nonatomic, strong, nullable) NSNumber * height;
@property(nonatomic, strong, nullable) NSNumber * allowOverlap;
@property(nonatomic, strong, nullable) NSNumber * allowOverlapWithPuck;
@property(nonatomic, strong, nullable) NSNumber * visible;
@property(nonatomic, copy, nullable) NSArray<FLTViewAnnotationAnchorConfig *> * variableAnchors;
@property(nonatomic, strong, nullable) NSNumber * selected;
@property(nonatomic, strong, nullable) NSNumber * ignoreCameraPadding;
@end

@interface FLTAnnotatedLayerFeature : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithLayerId:(NSString *)layerId
    featureId:(nullable NSString *)featureId;
@property(nonatomic, copy) NSString * layerId;
@property(nonatomic, copy, nullable) NSString * featureId;
@end

/// The codec used by FLTViewAnnotationManager.
NSObject<FlutterMessageCodec> *FLTViewAnnotationManagerGetCodec(void);

@protocol FLTViewAnnotationManager
- (void)addViewAnnotationData:(FlutterStandardTypedData *)data options:(FLTViewAnnotationOptions *)options completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)removeAllViewAnnotationsWithCompletion:(void (^)(FlutterError *_Nullable))completion;
- (void)removeViewAnnotationViewId:(NSInteger)viewId completion:(void (^)(FlutterError *_Nullable))completion;
- (void)updateViewAnnotationViewId:(NSInteger)viewId options:(FLTViewAnnotationOptions *)options data:(nullable FlutterStandardTypedData *)data completion:(void (^)(NSNumber *_Nullable, FlutterError *_Nullable))completion;
- (void)getViewAnnotationOptionsAnnotatedLayerFeature:(FLTAnnotatedLayerFeature *)annotatedLayerFeature completion:(void (^)(FLTViewAnnotationOptions *_Nullable, FlutterError *_Nullable))completion;
- (void)getViewAnnotationOptionsByViewIdViewId:(NSInteger)viewId completion:(void (^)(FLTViewAnnotationOptions *_Nullable, FlutterError *_Nullable))completion;
- (void)setViewAnnotationUpdateModeMode:(FLTViewAnnotationUpdateMode)mode completion:(void (^)(FlutterError *_Nullable))completion;
- (void)getViewAnnotationUpdateModeWithCompletion:(void (^)(FLTViewAnnotationUpdateModeBox *_Nullable, FlutterError *_Nullable))completion;
@end

extern void SetUpFLTViewAnnotationManager(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FLTViewAnnotationManager> *_Nullable api);

/// The codec used by FLTOnViewAnnotationUpdatedListener.
NSObject<FlutterMessageCodec> *FLTOnViewAnnotationUpdatedListenerGetCodec(void);

@interface FLTOnViewAnnotationUpdatedListener : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)onViewAnnotationPositionUpdatedViewId:(NSInteger)viewId leftTopCoordinate:(FLTScreenCoordinate *)leftTopCoordinate width:(double)width height:(double)height completion:(void (^)(FlutterError *_Nullable))completion;
- (void)onViewAnnotationAnchorCoordinateUpdatedViewId:(NSInteger)viewId anchorCoordinate:(nullable NSDictionary<NSString *, id> *)anchorCoordinate completion:(void (^)(FlutterError *_Nullable))completion;
- (void)onViewAnnotationAnchorUpdatedViewId:(NSInteger)viewId anchor:(FLTViewAnnotationAnchorConfig *)anchor completion:(void (^)(FlutterError *_Nullable))completion;
- (void)onViewAnnotationVisibilityUpdatedViewId:(NSInteger)viewId visible:(BOOL)visible completion:(void (^)(FlutterError *_Nullable))completion;
@end

/// The codec used by FLTOnViewAnnotationTapListener.
NSObject<FlutterMessageCodec> *FLTOnViewAnnotationTapListenerGetCodec(void);

@interface FLTOnViewAnnotationTapListener : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)onViewAnnotationClickViewId:(NSInteger)viewId completion:(void (^)(FlutterError *_Nullable))completion;
@end

NS_ASSUME_NONNULL_END
