
//{{BLOCK(kitchen)

//======================================================================
//
//	kitchen, 512x256@8, 
//	+ palette 256 entries, not compressed
//	+ 18 tiles (t reduced) not compressed
//	+ regular map (in SBBs), not compressed, 64x32 
//	Total size: 512 + 1152 + 4096 = 5760
//
//	Time-stamp: 2016-11-22, 01:14:23
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_KITCHEN_H
#define GRIT_KITCHEN_H

#define kitchenTilesLen 1152
extern const unsigned short kitchenTiles[576];

#define kitchenMapLen 4096
extern const unsigned short kitchenMap[2048];

#define kitchenPalLen 512
extern const unsigned short kitchenPal[256];

#endif // GRIT_KITCHEN_H

//}}BLOCK(kitchen)
