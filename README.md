# Reordering in UICollectionView with self-sizing cells

`UICollectionView` has awesome drag-to-reorder support. But if you use self-sizing cells, at least as of iOS 11, during a drag operation it reverts all cells to its estimated cell size (defaults to 50 x 50). This is no fun.

This repo started out as an illustration of the issue. Then I found a way around it:

 - Keep one instance of your cell class around as a sizing cell
 - Configure it with your data, then ask it for its preferred size (`systemLayoutFittingSize`)
 - Return this size from `sizeForItemAtIndexPath`
 - Cache this information in a dictionary of `NSIndexPath` to `NSValue` so you don't have to continuously recalculate sizes (which gets expensive on non-trivial layouts).
