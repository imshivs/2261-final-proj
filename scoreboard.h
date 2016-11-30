
//{{BLOCK(scoreboard)

//======================================================================
//
//	scoreboard, 512x256@8, 
//	+ palette 256 entries, not compressed
//	+ 3 tiles (t reduced) not compressed
//	+ regular map (in SBBs), not compressed, 64x32 
//	Total size: 512 + 192 + 4096 = 4800
//
//	Time-stamp: 2014-04-22, 16:50:31
//	Exported by Cearn's GBA Image Transmogrifier, v0.8.3
//	( http://www.coranac.com/projects/#grit )
//
//======================================================================

#ifndef GRIT_SCOREBOARD_H
#define GRIT_SCOREBOARD_H

#define scoreboardTilesLen 192
extern const unsigned short scoreboardTiles[96];

#define scoreboardMapLen 4096
extern const unsigned short scoreboardMap[2048];

#define scoreboardPalLen 512
extern const unsigned short scoreboardPal[256];

#endif // GRIT_SCOREBOARD_H

//}}BLOCK(scoreboard)
