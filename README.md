ShadowUtils
===========

This class category is best suited to create *fast* animated shadows.


## Example Usage

### Adding shadow to a layer

```
[aLayer addShadowWithcolor:[UIColor blackColor]
  					offset:(CGSize){-1.0f, -3.0f}
						radius:4.0f
					   opacity:.7f];
```

### Updating

```
- (void)layoutSubviews 
{
	[aLayer updateShadowPath];
}
```

### Removing

```
[aLayer removeShadow];
```

### Animating

```
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration 
{  	
	[aLayer animateShadowFrom:currentBounds
						   to:newBounds
					 duration:.3f];
}
```