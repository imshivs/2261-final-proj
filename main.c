//standard includes
#include <stdio.h>
#include <stdlib.h>
#include "myLib.h"
#include "text.h"

//mode4 images
#include "intro.h"
#include "menu.h"
#include "instructions.h"
#include "pause.h"
#include "win.h"
#include "lose.h"
#include "player.h"

//collision maps and tilemaps
#include "collisionmap.h"
#include "collisionmapTemp.h"
#include "clouds.h"
#include "kitchen.h"

//sprites
#include "sprites.h"

//state machines
#define STARTSCREEN 0
#define GAMESCREEN 1
#define LOSESCREEN 2
#define WINSCREEN 3
#define PAUSESCREEN 4
#define INSTRUCTSCREEN 5

//size of tilemap for play
#define MAPCOL 512
#define MAPROW 256

#define NUMCHEESE 10
#define TIME 2000
#define CHEATTIME 10000

//sound
typedef struct{
    unsigned char* data;
    int length;
    int frequency;
    int isPlaying;
    int loops;
    int duration;
}SOUND;

//sprites
typedef struct
{
    float row;
    int col;
    float bigRow;
    int bigCol;
    float rdel;
    int cdel;
    int width;
    int height;
    int aniCounter;
    int aniState;
    int prevAniState;
    int currFrame;
    int isJumping;
    int isEaten;
} MOVOBJ;

//sprites
MOVOBJ mouse;
MOVOBJ clock;
MOVOBJ cheese[NUMCHEESE];
MOVOBJ score[NUMCHEESE];

//global offset values
int hOff=0;
int vOff=0;

//sprite variable and methods
OBJ_ATTR shadowOAM[128];

void hideSprites();
void updateOAM();

// states used for mouseAniStates
enum {MOUSEFRONT, MOUSEBACK, MOUSERIGHT, MOUSELEFT, MOUSEIDLE};

unsigned int buttons;
unsigned int oldButtons;

int state = STARTSCREEN;
char buffer[41];

int cheeseCount;
int timer;
int cheat;

SOUND soundA;
SOUND soundB;
int vbCountA;
int vbCountB;


//method declarations
void splash();
void instruct();
void game();
void pause();
void win();
void lose();
void instruct();

//sound methods
void muteSound();
void unmuteSound();
void stopSounds();

void setupSounds();
void playSoundA( const unsigned char* sound, int length, int frequency, int isLooping);
void playSoundB( const unsigned char* sound, int length, int frequency, int isLooping);

void setupInterrupts();
void interruptHandler();

//main loop with state machine for game play
int main() {
    setupInterrupts();
    setupSounds();
    while(1) {
        switch(state) {
            case STARTSCREEN:
                splash();
                break;
            case INSTRUCTSCREEN:
                instruct();
                break;
            case GAMESCREEN:
                game();
                break;
            case PAUSESCREEN:
                pause();
                break;
            case WINSCREEN:
                win();
                break;
            case LOSESCREEN:
                lose();
                break;
        }
    }
    return 0;
}

//method for splash screen, which contains start and instructions options
void splash(){
    REG_DISPCTL = MODE4 | BG2_ENABLE;

    flipPage();
    loadPalette(menuPal);

    drawBackgroundImage4(menuBitmap);

    waitForVblank();
    flipPage();

    drawBackgroundImage4(menuBitmap);

    while(1){
    oldButtons = buttons;
	buttons = BUTTONS;

        if(BUTTON_PRESSED(BUTTON_START)){
            initialize();
            state = GAMESCREEN;
            return;
        }
        if(BUTTON_PRESSED(BUTTON_SELECT)){
            state = INSTRUCTSCREEN;
            return;
        }
     }
}

void instruct(){

    REG_DISPCTL = MODE4 | BG2_ENABLE;
    loadPalette(instructionsPal);

    drawBackgroundImage4(instructionsBitmap);

    waitForVblank();
    flipPage();
    while(1){
        oldButtons = buttons;
        buttons = BUTTONS;
        if(BUTTON_PRESSED(BUTTON_SELECT)){
            state = STARTSCREEN;
            return;
        }
        if(BUTTON_PRESSED(BUTTON_START)){
            initialize();
            state = GAMESCREEN;
            return;
        }
    }
}

void win(){
    REG_DISPCTL = MODE4 | BG2_ENABLE;
    loadPalette(winPal);

    drawBackgroundImage4(winBitmap);
    sprintf(buffer,"Press START return to start screen");
    drawString4(55,20,buffer, WHITEINDEX);
    flipPage();
    while(1){
        oldButtons = buttons;
        buttons = BUTTONS;

        if(BUTTON_PRESSED(BUTTON_START)){
            state = STARTSCREEN;
            return;
        }
    }
}


void lose(){

    drawBackgroundImage4(loseBitmap);
    flipPage();
    while(1){
        oldButtons = buttons;
		buttons = BUTTONS;

        if(BUTTON_PRESSED(BUTTON_START)){
            state = STARTSCREEN;
            return;
        }

    }
}

void pause(){

    while(1){
        drawBackgroundImage4(pauseBitmap);
        flipPage();

        oldButtons = buttons;
        buttons = BUTTONS;

        if(BUTTON_PRESSED(BUTTON_START)){
            unmuteSound();
            state = GAMESCREEN;
            return;
        }
        if(BUTTON_PRESSED(BUTTON_SELECT)){
            state = STARTSCREEN;
            return;
        }
    }
}

//initialize the game play
void initialize() {

    cheeseCount = 0;
    timer = 0;
    cheat = 0;

    //initialize score cheeses
    int c;
    for(c = 0; c < NUMCHEESE; c++){
        score[c].width = 4;
        score[c].height = 4;
        score[c].bigRow = 0;
        score[c].bigCol = 0;
        score[c].row = 4 + 4*c;
        score[c].col = 4;
    }

    //initialize the clock
    clock.bigRow = 0;
    clock.bigCol = 230;
    clock.width = 8;
    clock.height = 8;
    clock.row = 0;
    clock.col = 230;



    //initialize mouse
    mouse.width = 16;
    mouse.height = 16;
    mouse.rdel = 1;
    mouse.cdel = 1;
    mouse.row = SCREENHEIGHT - mouse.height + 1 - 15;
    mouse.col = 1;
    mouse.aniCounter = 0;
    mouse.currFrame = 0;
    mouse.aniState = MOUSERIGHT;

    //initialize cheese

//  cheese[].bigRow = 475; //needs to be smaller than 256
//  cheese[].bigCol = 300; //needs to be smaller than 512

    //on the counter
    cheese[0].width = 8;
    cheese[0].height = 8;
    cheese[0].bigRow = 180;
    cheese[0].bigCol = 360;
    cheese[0].isEaten = 0;

    //on the counter
    cheese[1].width = 8;
    cheese[1].height = 8;
    cheese[1].bigRow = 160;
    cheese[1].bigCol = 410;
    cheese[1].isEaten = 0;

    //just not under table on right side
    cheese[2].width = 8;
    cheese[2].height = 8;
    cheese[2].bigRow = 200;
    cheese[2].bigCol = 200;
    cheese[2].isEaten = 0;

    //beginning-middle of window sill
    cheese[3].width = 8;
    cheese[3].height = 8;
    cheese[3].bigRow = 111;
    cheese[3].bigCol = 100;
    cheese[3].isEaten = 0;

    //right bottom corner of the window sill
    cheese[4].width = 8;
    cheese[4].height = 8;
    cheese[4].bigRow = 111;
    cheese[4].bigCol = 250;
    cheese[4].isEaten = 0;

    //under table
    cheese[5].width = 8;
    cheese[5].height = 8;
    cheese[5].bigRow = 200;
    cheese[5].bigCol = 80;
    cheese[5].isEaten = 0;

    //in the corner at the end of the screen
    cheese[6].width = 8;
    cheese[6].height = 8;
    cheese[6].bigRow = 235;
    cheese[6].bigCol = 500;
    cheese[6].isEaten = 0;

    //on the top of the top cabinets
    cheese[7].width = 8;
    cheese[7].height = 8;
    cheese[7].bigRow = 60;
    cheese[7].bigCol = 360;
    cheese[7].isEaten = 0;

    //on the top of the top cabinets
    cheese[8].width = 8;
    cheese[8].height = 8;
    cheese[8].bigRow = 100;
    cheese[8].bigCol = 400;
    cheese[8].isEaten = 0;

    //on the top of the top cabinets
    cheese[9].width = 8;
    cheese[9].height = 8;
    cheese[9].bigRow = 100;
    cheese[9].bigCol = 500;
    cheese[9].isEaten = 0;

    //initialize screen values
    vOff = MAPROW - SCREENHEIGHT;
    hOff = 0;
}

void game() {
    REG_DISPCTL = MODE0 | BG0_ENABLE | SPRITE_ENABLE;
    //enable background
    REG_BG0CNT = CBB(0) | SBB(27) | BG_SIZE1 | COLOR256;

    loadPalette(kitchenPal);
    DMANow(3, kitchenTiles, &CHARBLOCKBASE[0], kitchenTilesLen/2);
    DMANow(3, kitchenMap, &SCREENBLOCKBASE[27], kitchenMapLen/2);

    //Import the mouse Tileset and Palette into their correct spaces in memory
    DMANow(3, spritesPal, SPRITE_PALETTE, 256);
    DMANow(3, spritesTiles, &CHARBLOCKBASE[4], spritesTilesLen/2);



    hideSprites();

    /*for mouse movement:
     * in collision map,
     * blue - allow mouse to move, but not to jump. i.e. mouse can move under table but not jump on it
     * red - allow mouse to fall from higher point, but not move any other way, i.e. moving off a window sill to floor
     * white - normal movement up and down, i.e. on the floor
     * black - no movement, except for jumping up
    */

    while(1) {
        // update button
        oldButtons = buttons;
        buttons = BUTTONS;
        timer++;

        //lose if cheese not collected within time frame

        if(timer > TIME){
            REG_DISPCTL = MODE4 | BG2_ENABLE;
            loadPalette(losePal);
            stopSounds();
            state = LOSESCREEN;
            return;
        }

        if(BUTTON_PRESSED(BUTTON_START)){
            REG_DISPCTL = MODE4 | BG2_ENABLE;
            loadPalette(pausePal);
            muteSound();
            state = PAUSESCREEN;
            return;
        }



        //Updates mouse's world position based on its row/col movement
        mouse.bigRow = mouse.row + vOff;
        mouse.bigCol = mouse.col + hOff;

        //update clock's global location
        clock.bigRow = clock.bigRow + vOff;
        clock.bigCol = clock.bigCol + hOff;

        //Updates the stationary cheese's row/col screen position based on its world position
        int c;
        for(c = 0; c < NUMCHEESE; c++){
            cheese[c].row = cheese[c].bigRow - vOff;
            cheese[c].col = cheese[c].bigCol - hOff;

            score[c].bigRow = score[c].bigRow + vOff;
            score[c].bigCol = score[c].bigCol + hOff;
        }

        //if the mouse is jumping, do some checks
        if (mouse.isJumping) {
            //gravity to stop the mouse from continually moving up
            mouse.rdel += 0.15;

            if (mouse.rdel > 2) {
                mouse.rdel = 2;
            }

            //if the mouse isn't on the ground, i.e. in mid jump
            if (mouse.rdel > 0) {
                //if the mouse is on (white) a navigable surface, stop the jump at ground and let mouse move around
                if ( mouse.bigRow > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == WHITE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == WHITE) ) {
                    mouse.isJumping = 0;
                    mouse.rdel = 0;
                //if the mouse is on (blue) an area where mouse can't jump from, stop the jump at ground and let mouse move around
                }else if ( mouse.bigRow > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == BLUE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == BLUE) ) {
                    mouse.isJumping = 0;
                    mouse.rdel = 0;
                //if the mouse is on (red) an area where mouse needs to fall, stop the jump at ground and let mouse move around
                }else if ( mouse.bigRow > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == RED) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == RED) ) {
                    mouse.isJumping = 0;
                    mouse.rdel = 0;
                }
                //let the mouse fall naturally and not suddenly
                if( vOff < (MAPROW-160) && (mouse.row > SCREENHEIGHT/2 - mouse.height/2) ){
                    vOff += mouse.rdel;
                }else{
                    mouse.row += mouse.rdel;
                }
                mouse.bigRow += mouse.rdel;
            }
            //keep the mouse within the bounds of the visible screen
            if((vOff > 0) && (mouse.row < SCREENHEIGHT/2 - mouse.height/2) ){
                vOff += mouse.rdel;
            }else{
                mouse.row += mouse.rdel;
            }
            mouse.bigRow += mouse.rdel;
        // mouse is not jumping
        } else {
            //if the mouse is on a red area, let it fall
            if ( mouse.bigRow < MAPROW - mouse.height &&
                    (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == RED) &&
                    (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == RED) ) {
                mouse.rdel += 0.15;
                if (mouse.rdel > 2) {
                    mouse.rdel = 2;
                }
                if( vOff < (MAPROW-160) && (mouse.row > SCREENHEIGHT/2 - mouse.height/2) ){
                    vOff += mouse.rdel;
                }else{
                    mouse.row += mouse.rdel;
                }
                mouse.bigRow += mouse.rdel;
            } else {
                mouse.rdel = 0;
            }
            //if the mouse is moving up, make sure it can based on collision map
            if(BUTTON_HELD(BUTTON_UP)) {
                mouse.aniState = MOUSEBACK;
                //if it's white, let mouse move
                if ( mouse.bigRow > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == WHITE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == WHITE) ) {
                    mouse.rdel = -1;
                    if((vOff > 0) && (mouse.row < SCREENHEIGHT/2 - mouse.height/2) ){
                        vOff += mouse.rdel;
                    }else{
                        mouse.row += mouse.rdel;
                    }
                    mouse.bigRow += mouse.rdel;
                //if it's blue, let mouse move (so it doesn't move if it's a red or black area)
                }else if ( mouse.bigRow > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == BLUE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == BLUE) ) {
                    mouse.rdel = -1;
                    if((vOff > 0) && (mouse.row < SCREENHEIGHT/2 - mouse.height/2) ){
                        vOff += mouse.rdel;
                    }else{
                        mouse.row += mouse.rdel;
                    }
                    mouse.bigRow += mouse.rdel;
                }
            }
        }

        //if mouse is moving down, make sure it can based on map
        if(BUTTON_HELD(BUTTON_DOWN)) {
            mouse.aniState = MOUSEFRONT;
            //allow movement on white surface
            if ( mouse.bigRow < MAPROW - mouse.height &&
                    (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height + ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == WHITE) &&
                    (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height + ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == WHITE) ) {
                mouse.rdel = 1;
                if( vOff < (MAPROW-160) && (mouse.row > SCREENHEIGHT/2 - mouse.height/2) ){
                    vOff += mouse.rdel;
                }else{
                    mouse.row += mouse.rdel;
                }
                mouse.bigRow += mouse.rdel;
            //allow movement on blue surface
            }else if ( mouse.bigRow < MAPROW - mouse.height &&
                    (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height + ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == BLUE) &&
                    (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height + ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == BLUE) ) {
                mouse.rdel = 1;
                if( vOff < (MAPROW-160) && (mouse.row > SCREENHEIGHT/2 - mouse.height/2) ){
                    vOff += mouse.rdel;
                }else{
                    mouse.row += mouse.rdel;
                }
                mouse.bigRow += mouse.rdel;
            }
        }

        //similar checks as above for left
        if(BUTTON_HELD(BUTTON_LEFT)) {
            mouse.aniState = MOUSELEFT;
            if(mouse.isJumping){
                mouse.cdel = -1;
                if ( (hOff > 0) && (mouse.col < SCREENWIDTH/2 - mouse.width/2) ) {
                    hOff += mouse.cdel;
                } else {
                    mouse.col += mouse.cdel;
                }
                mouse.bigCol += mouse.cdel;
            }else{
                if ( mouse.bigCol > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + 1, mouse.bigCol - mouse.cdel, MAPCOL)] == WHITE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height - 1, mouse.bigCol - mouse.cdel, MAPCOL)] == WHITE) ) {
                    mouse.cdel = -1;
                    if ( (hOff > 0) && (mouse.col < SCREENWIDTH/2 - mouse.width/2) ) {
                        hOff += mouse.cdel;
                    } else {
                        mouse.col += mouse.cdel;
                    }
                    mouse.bigCol += mouse.cdel;
                } else if ( mouse.bigCol > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + 1, mouse.bigCol - mouse.cdel, MAPCOL)] == RED) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height - 1, mouse.bigCol - mouse.cdel, MAPCOL)] == RED) ) {
                    mouse.cdel = -1;
                    if ( (hOff > 0) && (mouse.col < SCREENWIDTH/2 - mouse.width/2) ) {
                        hOff += mouse.cdel;
                    } else {
                        mouse.col += mouse.cdel;
                    }
                    mouse.bigCol += mouse.cdel;
                } else if ( mouse.bigCol > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + 1, mouse.bigCol - mouse.cdel, MAPCOL)] == BLUE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height - 1, mouse.bigCol - mouse.cdel, MAPCOL)] == BLUE) ) {
                    mouse.cdel = -1;
                    if ( (hOff > 0) && (mouse.col < SCREENWIDTH/2 - mouse.width/2) ) {
                        hOff += mouse.cdel;
                    } else {
                        mouse.col += mouse.cdel;
                    }
                    mouse.bigCol += mouse.cdel;
                }
            }
        }

        //similar checks as above for right
        if(BUTTON_HELD(BUTTON_RIGHT)) {
            mouse.aniState = MOUSERIGHT;
            if(mouse.isJumping){
                mouse.cdel = 1;
                if ( (hOff < MAPCOL - SCREENWIDTH) && (mouse.col > SCREENWIDTH/2 - mouse.width/2) ) {
                    hOff += mouse.cdel;
                } else {
                    mouse.col += mouse.cdel;
                }
                mouse.bigCol += mouse.cdel;
            }else{
                //normal right left motion on white spaces
                if ( mouse.bigCol < MAPCOL - mouse.width &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + 1, mouse.bigCol + mouse.width + mouse.cdel, MAPCOL)] == WHITE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height - 1, mouse.bigCol + mouse.width + mouse.cdel, MAPCOL)] == WHITE) ) {
                    mouse.cdel = 1;
                    if ( (hOff < MAPCOL - SCREENWIDTH) && (mouse.col > SCREENWIDTH/2 - mouse.width/2) ) {
                        hOff += mouse.cdel;
                    } else {
                        mouse.col += mouse.cdel;
                    }
                    mouse.bigCol += mouse.cdel;
                } else if ( mouse.bigCol < MAPCOL - mouse.width &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + 1, mouse.bigCol + mouse.width + mouse.cdel, MAPCOL)] == RED) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height - 1, mouse.bigCol + mouse.width + mouse.cdel, MAPCOL)] == RED) ) {
                    mouse.cdel = 1;
                    if ( (hOff < MAPCOL - SCREENWIDTH) && (mouse.col > SCREENWIDTH/2 - mouse.width/2) ) {
                        hOff += mouse.cdel;
                    } else {
                        mouse.col += mouse.cdel;
                    }
                    mouse.bigCol += mouse.cdel;
                } else if ( mouse.bigCol < MAPCOL - mouse.width &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + 1, mouse.bigCol + mouse.width + mouse.cdel, MAPCOL)] == BLUE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height - 1, mouse.bigCol + mouse.width + mouse.cdel, MAPCOL)] == BLUE) ) {
                    mouse.cdel = 1;
                    if ( (hOff < MAPCOL - SCREENWIDTH) && (mouse.col > SCREENWIDTH/2 - mouse.width/2) ) {
                        hOff += mouse.cdel;
                    } else {
                        mouse.col += mouse.cdel;
                    }
                    mouse.bigCol += mouse.cdel;
                }
            }
        }

        //enable jumping with button press, only if the mouse is not already jumping, so no double jumps
        if(BUTTON_PRESSED(BUTTON_A)) {
            if ( mouse.bigRow > 0 &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + 1, MAPCOL)] == WHITE) &&
                        (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) - ((int) mouse.rdel), mouse.bigCol + mouse.width - 1, MAPCOL)] == WHITE) ) {

                if (collisionmapTempBitmap[OFFSET(((int) mouse.bigRow) + mouse.height/2, mouse.bigCol + mouse.width/2, MAPCOL)] == WHITE) {
                    mouse.isJumping = 1;
                    mouse.rdel = -4;
                }
            }
        }


        //collision detection between mouse and cheese
        int a;
        for(a = 0; a < NUMCHEESE; a++){
            if(!cheese[a].isEaten){
                if ((mouse.bigCol < (cheese[a].bigCol + cheese[a].width)) &&
                        ((mouse.bigCol + mouse.width) > cheese[a].bigCol) &&
                        (mouse.bigRow < (cheese[a].bigRow + cheese[a].height)) &&
                        ((mouse.bigRow + mouse.height) > cheese[a].bigRow) ){
                    //set isEaten to true, to remove it from display
//                    while(1);
                    cheese[a].isEaten = 1;
                    cheeseCount++;
                }
            }
        }

        //check for a win
        if(cheeseCount == NUMCHEESE){
            REG_DISPCTL = MODE4 | BG2_ENABLE;
            loadPalette(winPal);
            stopSounds();
            state = WINSCREEN;
            return;
        }


        //pass in offsets to registers
        REG_BG0HOFS = hOff;
        REG_BG0VOFS = vOff;

        //update sprites, etc
        updateOAM();
        DMANow(3, shadowOAM, OAM, 128*4);
        waitForVblank();
    }
    return 0;
}

//hide sprites
void hideSprites(){
    int i;
    for(i=0; i<128; i++)
    {
        shadowOAM[i].attr0 = ATTR0_HIDE;
    }
}

void updateOAM(){
    //update the mouse
    switch(mouse.aniState) {
        case MOUSELEFT:
            shadowOAM[0].attr0 = (ROWMASK&((int)(mouse.row-8))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[0].attr1 = (COLMASK&(mouse.col-8)) | ATTR1_SIZE32 | ATTR1_HFLIP;
            shadowOAM[0].attr2 = SPRITEOFFSET16(0,4*mouse.currFrame);
            break;
        case MOUSERIGHT:
            shadowOAM[0].attr0 = (ROWMASK&((int)(mouse.row-8))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[0].attr1 = (COLMASK&(mouse.col-8)) | ATTR1_SIZE32;
            shadowOAM[0].attr2 = SPRITEOFFSET16(0,4*mouse.currFrame);
            break;
        case MOUSEFRONT:
            shadowOAM[0].attr0 = (ROWMASK&((int)(mouse.row-8))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[0].attr1 = (COLMASK&(mouse.col-8)) | ATTR1_SIZE32 | ATTR1_VFLIP;
            shadowOAM[0].attr2 = SPRITEOFFSET16(0,8);
            break;
        case MOUSEBACK:
            shadowOAM[0].attr0 = (ROWMASK&((int)(mouse.row-8))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[0].attr1 = (COLMASK&(mouse.col-8)) | ATTR1_SIZE32;
            shadowOAM[0].attr2 = SPRITEOFFSET16(0,8);
            break;
    }

    //cheese slices
    int c;
    int scorePlacement = 0;
    for(c = 0; c < (NUMCHEESE); c++){
        //if the cheese is not eaten, display it, else don't
        if(!cheese[c].isEaten){
            shadowOAM[c+1].attr0 = (ROWMASK&((int)cheese[c].row)) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[c+1].attr1 = (COLMASK&((int)cheese[c].col)) | ATTR1_SIZE8;
            shadowOAM[c+1].attr2 = SPRITEOFFSET16(4*1,4*0);

            shadowOAM[c + 1 + NUMCHEESE].attr0 = (ROWMASK&((int)(0))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[c + 1 + NUMCHEESE].attr1 = (COLMASK&(scorePlacement + 4)) | ATTR1_SIZE8;
            shadowOAM[c + 1 + NUMCHEESE].attr2 = SPRITEOFFSET16(4,4);
        }else{
            shadowOAM[c+1].attr0 = ATTR0_HIDE;
            shadowOAM[c + 1 + NUMCHEESE].attr0 = ATTR0_HIDE;
        }
        scorePlacement = scorePlacement + 8;
    }

    //clock
    if(!cheat){
        if(timer < TIME/4){
            shadowOAM[21].attr0 = (ROWMASK&((int)(0))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[21].attr1 = (COLMASK&(220)) | ATTR1_SIZE32;
            shadowOAM[21].attr2 = SPRITEOFFSET16(4,8);
        }else if(timer < TIME/2){
            shadowOAM[21].attr0 = ATTR0_HIDE;

            shadowOAM[21].attr0 = (ROWMASK&((int)(0))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[21].attr1 = (COLMASK&(220)) | ATTR1_SIZE32;
            shadowOAM[21].attr2 = SPRITEOFFSET16(4,12);
        }else if(timer < (TIME*3)/4){
            shadowOAM[21].attr0 = ATTR0_HIDE;

            shadowOAM[21].attr0 = (ROWMASK&((int)(0))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[21].attr1 = (COLMASK&(220)) | ATTR1_SIZE32;
            shadowOAM[21].attr2 = SPRITEOFFSET16(4,16);
        }else{
            shadowOAM[21].attr0 = ATTR0_HIDE;

            shadowOAM[21].attr0 = (ROWMASK&((int)(0))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[21].attr1 = (COLMASK&(220)) | ATTR1_SIZE32;
            shadowOAM[21].attr2 = SPRITEOFFSET16(4,20);
        }
    }else{
            shadowOAM[21].attr0 = (ROWMASK&((int)(0))) | ATTR0_4BPP | ATTR0_SQUARE;
            shadowOAM[21].attr1 = (COLMASK&(220)) | ATTR1_SIZE32;
            shadowOAM[21].attr2 = SPRITEOFFSET16(4,8);
    }
}

void setupSounds()
{
    REG_SOUNDCNT_X = SND_ENABLED;

	REG_SOUNDCNT_H = SND_OUTPUT_RATIO_100 |
                        DSA_OUTPUT_RATIO_100 |
                        DSA_OUTPUT_TO_BOTH |
                        DSA_TIMER0 |
                        DSA_FIFO_RESET |
                        DSB_OUTPUT_RATIO_100 |
                        DSB_OUTPUT_TO_BOTH |
                        DSB_TIMER1 |
                        DSB_FIFO_RESET;

	REG_SOUNDCNT_L = 0;
}

void playSoundA( const unsigned char* sound, int length, int frequency, int isLooping) {

        dma[1].cnt = 0;
        vbCountA = 0;

        int interval = 16777216/frequency;

        DMANow(1, sound, REG_FIFO_A, DMA_DESTINATION_FIXED | DMA_AT_REFRESH | DMA_REPEAT | DMA_32);

        REG_TM0CNT = 0;

        REG_TM0D = -interval;
        REG_TM0CNT = TIMER_ON;

        /**
         * MODIFY THIS FUNCTION
         * Store the necessary variables into your SOUND struct here so that we may recall them later.
         */
        soundA.data = sound;
        soundA.length = length;
        soundA.frequency = frequency;
        soundA.isPlaying = 1;
        soundA.loops = isLooping;
        soundA.duration = ((60*length)/frequency) - ((length/frequency)*3) - 1;

}


void playSoundB( const unsigned char* sound, int length, int frequency, int isLooping) {

        dma[2].cnt = 0;
        vbCountB = 0;

        int interval = 16777216/frequency;

        DMANow(2, sound, REG_FIFO_B, DMA_DESTINATION_FIXED | DMA_AT_REFRESH | DMA_REPEAT | DMA_32);

        REG_TM1CNT = 0;

        REG_TM1D = -interval;
        REG_TM1CNT = TIMER_ON;

        /**
         * MODIFY THIS FUNCTION
         * Store the necessary variables into your SOUND struct here so that we may recall them later.
         */
        soundB.data = sound;
        soundB.length = length;
        soundB.frequency = frequency;
        soundB.isPlaying = 1;
        soundB.loops = isLooping;
        soundB.duration = ((60*length)/frequency) - ((length/frequency)*3) - 1;
}

void setupInterrupts()
{
	REG_IME = 0;
	REG_INTERRUPT = (unsigned int)interruptHandler;
	REG_IE |= INT_VBLANK;
	REG_DISPSTAT |= INT_VBLANK_ENABLE;
	REG_IME = 1;
}

void interruptHandler()
{
	REG_IME = 0;
	if(REG_IF & INT_VBLANK)
	{
                /**
                 * MODIFY THIS FUNCTION
                 * Place your code to loop and stop sounds here.
                 */
            vbCountA = vbCountA + 1;
            vbCountB = vbCountB + 1;

            if(vbCountA > soundA.duration){
                dma[1].cnt = 0;
                if(soundA.loops == 1){
                }
            };
            if(vbCountB > soundB.duration){
                dma[2].cnt = 0;
                if(soundB.loops == 1){
                }
            };
		REG_IF = INT_VBLANK;
	}
	REG_IME = 1;
}


void muteSound(){
        soundA.isPlaying = 0;
	soundB.isPlaying = 0;
	REG_TM0CNT = 0;
	REG_TM1CNT = 0;
}


void unmuteSound(){
	soundA.isPlaying = 1;
	soundB.isPlaying = 1;
	REG_TM0CNT = TIMER_ON;
	REG_TM1CNT = TIMER_ON;
}

void stopSounds(){
        dma[1].cnt = 0;
}