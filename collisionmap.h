
//{{BLOCK(collisionmap)

//======================================================================
//
//	collisionmap, 512x256@8, 
//	+ palette 256 entries, not compressed
//	+ 4 tiles (t reduced) not compressed
//	+ regular map (in SBBs), not compressed, 64x32 
//	Total size: 512 + 256 + 4096 = 4864
//
//	Time-stamp: 2016-11-22, 01:23:32
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_COLLISIONMAP_H
#define GRIT_COLLISIONMAP_H

#define collisionmapTilesLen 256
extern const unsigned short collisionmapTiles[128];

#define collisionmapMapLen 4096
extern const unsigned short collisionmapMap[2048];

#define collisionmapPalLen 512
extern const unsigned short collisionmapPal[256];

#endif // GRIT_COLLISIONMAP_H

//}}BLOCK(collisionmap)
