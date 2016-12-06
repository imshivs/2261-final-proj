
//{{BLOCK(kitchen)

//======================================================================
//
//	kitchen, 512x256@8, 
//	+ palette 256 entries, not compressed
//	+ 205 tiles (t reduced) not compressed
//	+ regular map (in SBBs), not compressed, 64x32 
//	Total size: 512 + 13120 + 4096 = 17728
//
//	Time-stamp: 2016-12-05, 20:20:38
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_KITCHEN_H
#define GRIT_KITCHEN_H

#define kitchenTilesLen 13120
extern const unsigned short kitchenTiles[6560];

#define kitchenMapLen 4096
extern const unsigned short kitchenMap[2048];

#define kitchenPalLen 512
extern const unsigned short kitchenPal[256];

#endif // GRIT_KITCHEN_H

//}}BLOCK(kitchen)
