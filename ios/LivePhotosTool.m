//
//  LivePhotosTool.m
//  MTPhotos
//
//  Created by 我们这一家 on 2022/9/12.
//

#import "LivePhotosTool.h"
#import "MTPhotos-Swift.h"
#import <Photos/Photos.h>


@implementation LivePhotosTool

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(extractResources:(NSArray<NSString *> *)photoURLs completion:(void (^)(NSString *, NSString *))completion)
{
  if (photoURLs.count <= 0) {
    return;
  }
  
  __block NSMutableArray *photoUrlStrs = [NSMutableArray new];
  [photoURLs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    NSURL *url = [NSURL URLWithString:obj];
    if (url) {
      [photoUrlStrs addObject:url];
    }
  }];
  
  [PHLivePhoto requestLivePhotoWithResourceFileURLs:photoUrlStrs placeholderImage:nil targetSize:CGSizeZero contentMode:PHImageContentModeDefault resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
    if (livePhoto) {
      [LivePhoto extractResourcesFrom:livePhoto completion:^(NSURL * _Nullable pairedImage, NSURL * _Nullable pairedVideo) {
        if (completion) {
          completion(pairedImage.absoluteString, pairedVideo.absoluteString);
        }
      }];
    }
  }];
}

RCT_EXPORT_METHOD(generate:(NSString *)imageStr videoURL:(NSString *)videoStr completion:(RCTResponseSenderBlock)callback)
{
  NSURL *imageUrl = [NSURL URLWithString:imageStr];
  NSURL *videoUrl = [NSURL URLWithString:videoStr];
  if (!imageUrl || !videoUrl) {
    return;
  }
  [LivePhoto generateFrom:imageUrl videoURL:videoUrl progress:^(CGFloat) {
    
  } completion:^(PHLivePhoto * _Nullable livePhoto, NSURL * _Nullable pairedImage, NSURL * _Nullable pairedVideo) {
    if (callback) {
      //completion(pairedImage.absoluteString, pairedVideo.absoluteString);
      callback(@[[NSNull null]]);
    }
  }];
}

@end
