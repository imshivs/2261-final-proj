# 1 "myLib.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "myLib.c"
# 1 "myLib.h" 1
typedef unsigned short u16;
# 63 "myLib.h"
typedef struct { u16 tileimg[8192]; } charblock;
typedef struct { u16 tilemap[1024]; } screenblock;





extern unsigned short *videoBuffer;

extern unsigned short *buffer1;
extern unsigned short *buffer2;


void setPixel3(int row, int col,volatile unsigned short color);
void drawRect3(int row, int col, int height, int width,volatile unsigned short color);
void fillScreen3(volatile unsigned short color);
void drawImage3(const unsigned short* image, int row, int col, int height, int width);
void drawBackgroundImage3(const unsigned short* image);



void setPixel4(int row, int col,volatile unsigned char colorIndex);
void drawRect4(int row, int col, int height, int width,volatile unsigned char colorIndex);
void drawImage4(const unsigned short* image, int row, int col, int height, int width);
void fillScreen4(volatile unsigned char color);
void loadPalette(const unsigned short* palette);
void drawSubImage4(const unsigned short* sourceImage, int sourceRow, int sourceCol, int sourceWidth,
       int row, int col, int height, int width);
void shoot();
void drawBullets();
void updateBullets();

void updateEnemies();
void win();
void lose();
void pause();
void instructions();


void splash();
void drawBackgroundImage4();
void enemyShoot(int enemy);

void drawPlayer();
void initialize();
void drawEnemies();

void waitForVblank();
void flipPage();
# 132 "myLib.h"
extern unsigned int oldButtons;
extern unsigned int buttons;
# 142 "myLib.h"
void DMANow(int channel, void* source, void* destination, unsigned int control);






typedef volatile struct
{
        volatile const void *src;
        volatile void *dst;
        volatile unsigned int cnt;
} DMA;

extern DMA *dma;
# 297 "myLib.h"
typedef struct{
    unsigned short attr0;
    unsigned short attr1;
    unsigned short attr2;
    unsigned short fill;
}OBJ_ATTR;

typedef struct {
    int row;
    int col;
} Sprite;
# 2 "myLib.c" 2

unsigned short *videoBuffer = (u16 *)0x6000000;

unsigned short *frontBuffer = (u16 *)0x6000000;
unsigned short *backBuffer = (u16 *)0x600A000;

DMA *dma = (DMA *)0x40000B0;

void setPixel3(int row, int col, unsigned short color)
{
 videoBuffer[((row)*(240)+(col))] = color;
}

void drawRect3(int row, int col, int height, int width, unsigned short color)
{
 unsigned short c = color;

 int i;
 for(i = 0; i < height; i++)
 {
  DMANow(3, &c, &videoBuffer[((row+i)*(240)+(col))], (width) | (2 << 23));
 }
}

void fillScreen3(unsigned short color)
{
 unsigned short c = color;

 DMANow(3, &c, videoBuffer, (240*160) | (2 << 23));

}

void setPixel4(int row, int col, unsigned char colorIndex)
{
 unsigned short pixels = videoBuffer[((row)*(240/2)+(col/2))];

 if(col % 2 == 0)
 {
  pixels &= 0xFF << 8;
  videoBuffer[((row)*(240/2)+(col/2))] = pixels | colorIndex;
 }
 else
 {
  pixels &= 0xFF;
  videoBuffer[((row)*(240/2)+(col/2))] = pixels | colorIndex << 8;
 }
}

void drawRect4(int row, int col, int height, int width, unsigned char colorIndex)
{

 unsigned short pixels = colorIndex << 8 | colorIndex;

 int r;
 for(r = 0; r < height; r++)
 {
  if(col % 2 == 0)
  {
   DMANow(3, &pixels, &videoBuffer[((row + r)*(240)+(col))/2], (width/2) | (2 << 23));
   if(width % 2 == 1)
   {
    setPixel4(row+r, col+width - 1, colorIndex);
   }
  }
  else
  {
   setPixel4(row+r, col, colorIndex);

   if(width % 2 == 1)
   {
    DMANow(3, &pixels, &videoBuffer[((row + r)*(240)+((col+1)))/2], (width/2) | (2 << 23));
   }
   else
   {
    DMANow(3, &pixels, &videoBuffer[((row + r)*(240)+((col+1)))/2], ((width/2)-1) | (2 << 23));
    setPixel4(row+r, col+width - 1, colorIndex);
   }
  }

 }

}

void fillScreen4(unsigned char colorIndex)
{
 volatile unsigned short pixels = colorIndex << 8 | colorIndex;
 DMANow(3, &pixels, videoBuffer, ((240 * 160)/2) | (2 << 23));
}

void drawBackgroundImage4(const unsigned short* image)
{
    DMANow(3, image, videoBuffer,(0 << 23) | 19200 );


}
void drawImage4(const unsigned short* image, int row, int col, int height, int width)
{

    int r;
 for(r=0; r<height; r++)
 {
  dma[3].src = image + ((r)*(width)+(0))/2;
  dma[3].dst = videoBuffer + ((row+r)*(240)+(col))/2;
  dma[3].cnt = (width/2) | (1 << 31) | (0 << 23);

 }

}

void drawSubImage4(const unsigned short* sourceImage, int sourceRow, int sourceCol, int sourceWidth,
       int row, int col, int height, int width)
{



    int r;
 for(r=0; r<height; r++)
 {
  dma[3].src = sourceImage + ((sourceRow+r)*(sourceWidth)+(sourceCol))/2;
  dma[3].dst = videoBuffer + ((row+r)*(240)+(col))/2;
  dma[3].cnt = (width/2) | (1 << 31) | (0 << 23);

 }
}

void loadPalette(const unsigned short* palette)
{

    dma[3].src = palette;
 dma[3].dst = ((u16 *)0x5000000);
 dma[3].cnt = (256) | (1 << 31) | (0 << 23);

    ((u16 *)0x5000000)[250] = ((31) | (31)<<5 | (31)<<10);
    ((u16 *)0x5000000)[251] = 0;
    ((u16 *)0x5000000)[252] = ((31) | (0)<<5 | (0)<<10);
}


void DMANow(int channel, void* source, void* destination, unsigned int control)
{
 dma[channel].src = source;
 dma[channel].dst = destination;
 dma[channel].cnt = (1 << 31) | control;
}

void waitForVblank()
{
 while(*(volatile u16 *)0x4000006 > 160);
 while(*(volatile u16 *)0x4000006 < 160);
}



void flipPage()
{
    if(*(unsigned short *)0x4000000 & (1<<4))
    {
        *(unsigned short *)0x4000000 &= ~(1<<4);
        videoBuffer = backBuffer;
    }
    else
    {
        *(unsigned short *)0x4000000 |= (1<<4);
        videoBuffer = frontBuffer;
    }
}

void drawBackgroundImage3(const unsigned short* image)
{





    DMANow(3, image, videoBuffer, (240*160) | (0 << 23));




}
