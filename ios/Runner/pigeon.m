// Autogenerated from Pigeon (v4.2.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ?: [NSNull null]),
        @"message": (error.message ?: [NSNull null]),
        @"details": (error.details ?: [NSNull null]),
        };
  }
  return @{
      @"result": (result ?: [NSNull null]),
      @"error": errorDict,
      };
}
static id GetNullableObject(NSDictionary* dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}
static id GetNullableObjectAtIndex(NSArray* array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}


@interface Cat ()
+ (Cat *)fromMap:(NSDictionary *)dict;
+ (nullable Cat *)nullableFromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end

@implementation Cat
+ (instancetype)makeWithName:(nullable NSString *)name
    age:(nullable NSNumber *)age {
  Cat* pigeonResult = [[Cat alloc] init];
  pigeonResult.name = name;
  pigeonResult.age = age;
  return pigeonResult;
}
+ (Cat *)fromMap:(NSDictionary *)dict {
  Cat *pigeonResult = [[Cat alloc] init];
  pigeonResult.name = GetNullableObject(dict, @"name");
  pigeonResult.age = GetNullableObject(dict, @"age");
  return pigeonResult;
}
+ (nullable Cat *)nullableFromMap:(NSDictionary *)dict { return (dict) ? [Cat fromMap:dict] : nil; }
- (NSDictionary *)toMap {
  return @{
    @"name" : (self.name ?: [NSNull null]),
    @"age" : (self.age ?: [NSNull null]),
  };
}
@end

@interface CatApiCodecReader : FlutterStandardReader
@end
@implementation CatApiCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [Cat fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface CatApiCodecWriter : FlutterStandardWriter
@end
@implementation CatApiCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[Cat class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
@end

@interface CatApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation CatApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[CatApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[CatApiCodecReader alloc] initWithData:data];
}
@end


NSObject<FlutterMessageCodec> *CatApiGetCodec() {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    CatApiCodecReaderWriter *readerWriter = [[CatApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}

void CatApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<CatApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.CatApi.getCats"
        binaryMessenger:binaryMessenger
        codec:CatApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getCatsWithError:)], @"CatApi api (%@) doesn't respond to @selector(getCatsWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSArray<Cat *> *output = [api getCatsWithError:&error];
        callback(wrapResult(output, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
