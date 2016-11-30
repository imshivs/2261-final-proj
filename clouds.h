
//{{BLOCK(clouds)

//======================================================================
//
//	clouds, 512x256@8, 
//	+ palette 256 entries, not compressed
//	+ 245 tiles (t reduced) not compressed
//	+ regular map (in SBBs), not compressed, 64x32 
//	Total size: 512 + 15680 + 4096 = 20288
//
//	Time-stamp: 2014-04-22, 15:40:10
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_CLOUDS_H
#define GRIT_CLOUDS_H

#define cloudsTilesLen 15680
extern const unsigned short cloudsTiles[7840];

#define cloudsMapLen 4096
extern const unsigned short cloudsMap[2048];

#define cloudsPalLen 512
extern const unsigned short cloudsPal[256];

#endif // GRIT_CLOUDS_H

//}}BLOCK(clouds)
