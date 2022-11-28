// Autogenerated from Pigeon (v4.2.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class Cat;

@interface Cat : NSObject
+ (instancetype)makeWithName:(nullable NSString *)name
    age:(nullable NSNumber *)age;
@property(nonatomic, copy, nullable) NSString * name;
@property(nonatomic, strong, nullable) NSNumber * age;
@end

/// The codec used by CatApi.
NSObject<FlutterMessageCodec> *CatApiGetCodec(void);

@protocol CatApi
/// @return `nil` only when `error != nil`.
- (nullable NSArray<Cat *> *)getCatsWithError:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void CatApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CatApi> *_Nullable api);

NS_ASSUME_NONNULL_END