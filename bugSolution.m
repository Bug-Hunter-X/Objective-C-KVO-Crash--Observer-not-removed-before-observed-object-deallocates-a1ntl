The solution involves using `removeObserver:`  method or a weak reference within the observer.

```objectivec
// Correct KVO setup using dealloc
@interface MyObserver : NSObject
@property (nonatomic, weak) MyObservedObject *observedObject; //Weak reference
@end

@implementation MyObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // ... Handle KVO change ...
}
-(void)dealloc{
  [self.observedObject removeObserver:self forKeyPath:@"myProperty"];
}
@end

@interface MyObservedObject : NSObject
@property (nonatomic, strong) NSString *myProperty;
@property (nonatomic, strong) MyObserver *observer;
@end

@implementation MyObservedObject

- (instancetype)init {
    self = [super init];
    if (self) {
      [self addObserver:self.observer forKeyPath:@"myProperty" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)dealloc{
  [self removeObserver:self.observer forKeyPath:@"myProperty"];
}

@end

```
This approach avoids the strong reference cycle and ensures the observer is always removed appropriately.