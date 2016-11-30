#include "myLib.h"

unsigned short *videoBuffer = (u16 *)0x6000000;

unsigned short *frontBuffer = (u16 *)0x6000000;
unsigned short *backBuffer =  (u16 *)0x600A000;

DMA *dma = (DMA *)0x40000B0;

void setPixel3(int row, int col, unsigned short color)
{
	videoBuffer[OFFSET(row, col, SCREENWIDTH)] = color;
}

void drawRect3(int row, int col, int height, int width, unsigned short color)
{
	unsigned short c = color;
	
	int i;
	for(i = 0; i < height; i++)
	{
		DMANow(3, &c, &videoBuffer[OFFSET(row+i, col, SCREENWIDTH)], (width) | DMA_SOURCE_FIXED);
	}
}

void fillScreen3(unsigned short color)
{
	unsigned short c = color;

	DMANow(3, &c, videoBuffer, (240*160) | DMA_SOURCE_FIXED);
	
}

void setPixel4(int row, int col, unsigned char colorIndex)
{
	unsigned short pixels = videoBuffer[OFFSET(row, col/2, SCREENWIDTH/2)];

	if(col % 2 == 0) // even
	{
		pixels &= 0xFF << 8;
		videoBuffer[OFFSET(row, col/2, SCREENWIDTH/2)] = pixels | colorIndex;
	}
	else // odd
	{
		pixels &= 0xFF;
		videoBuffer[OFFSET(row, col/2, SCREENWIDTH/2)] = pixels | colorIndex << 8;
	}
}

void drawRect4(int row, int col, int height, int width, unsigned char colorIndex)
{
	
	unsigned short pixels = colorIndex << 8 | colorIndex;

	int r;
	for(r = 0; r < height; r++)
	{
		if(col % 2 == 0) // even starting col
		{
			DMANow(3, &pixels, &videoBuffer[OFFSET(row + r, col, SCREENWIDTH)/2], (width/2) | DMA_SOURCE_FIXED);	
			if(width % 2 == 1) // if width is odd
			{
				setPixel4(row+r, col+width - 1, colorIndex);
			}
		}
		else // old starting col
		{
			setPixel4(row+r, col, colorIndex);

			if(width % 2 == 1) // if width is odd
			{
				DMANow(3, &pixels, &videoBuffer[OFFSET(row + r, (col+1), SCREENWIDTH)/2], (width/2) | DMA_SOURCE_FIXED);
			}
			else  // width is even
			{
				DMANow(3, &pixels, &videoBuffer[OFFSET(row + r, (col+1), SCREENWIDTH)/2], ((width/2)-1) | DMA_SOURCE_FIXED);
				setPixel4(row+r, col+width - 1, colorIndex);
			}
		}
		
	}
	
}

void fillScreen4(unsigned char colorIndex)
{
	volatile unsigned short pixels = colorIndex << 8 | colorIndex;
	DMANow(3, &pixels, videoBuffer, ((240 * 160)/2) | DMA_SOURCE_FIXED);
}

void drawBackgroundImage4(const unsigned short* image)
{
    DMANow(3, image, videoBuffer,DMA_SOURCE_INCREMENT | 19200 );


}
void drawImage4(const unsigned short* image, int row, int col, int height, int width)
{

    int r;
	for(r=0; r<height; r++)
	{
		dma[3].src = image + OFFSET(r, 0, width)/2;
		dma[3].dst = videoBuffer + OFFSET(row+r, col, 240)/2;
		dma[3].cnt = (width/2) | DMA_ON | DMA_SOURCE_INCREMENT;
							
	}

}

void drawSubImage4(const unsigned short* sourceImage, int sourceRow, int sourceCol, int sourceWidth, 
				   int row, int col, int height, int width)
{
	// This function will be used to display a section of an image 
	// This function will be similar to drawImage4 except you will be doing a little more math
	//   in regards to the image source
    int r;
	for(r=0; r<height; r++)
	{
		dma[3].src = sourceImage + OFFSET(sourceRow+r, sourceCol, sourceWidth)/2;
		dma[3].dst = videoBuffer + OFFSET(row+r, col, 240)/2;
		dma[3].cnt = (width/2) | DMA_ON | DMA_SOURCE_INCREMENT;
							
	}
}

void loadPalette(const unsigned short* palette)
{
	// This function will load copy a palette to GBA's palette memory  
    dma[3].src = palette;
	dma[3].dst = PALETTE;
	dma[3].cnt = (256) | DMA_ON | DMA_SOURCE_INCREMENT;

    PALETTE[WHITEINDEX] = WHITE; 
    PALETTE[BLACKINDEX] = BLACK; 
    PALETTE[REDINDEX] = RED; 
}


void DMANow(int channel, void* source, void* destination, unsigned int control)
{
	dma[channel].src = source;
	dma[channel].dst = destination;
	dma[channel].cnt = DMA_ON | control;
}

void waitForVblank()
{
	while(SCANLINECOUNTER > 160);
	while(SCANLINECOUNTER < 160);
}



void flipPage()
{
    if(REG_DISPCTL & BUFFER2)
    {
        REG_DISPCTL &= ~BUFFER2;
        videoBuffer = backBuffer;
    }
    else
    {
        REG_DISPCTL |= BUFFER2;
        videoBuffer = frontBuffer;
    }
}

void drawBackgroundImage3(const unsigned short* image)
{
	// TODO COMPLETE THIS FUNCTION !!!!
	// This function will be very similar to the fillScreen4 function
	// This funciton will fill the entire screen with the image
	// the image has to be 240x160px
	// Instead of using a color you will use data from an image
    DMANow(3, image, videoBuffer, (240*160) | DMA_SOURCE_INCREMENT);
    // HINT: When you get to the count/control argument of DMANow,
    //       remember that your copying 16 bits (ie two pixels) at a
    //       time. How does this affect how many copies you need to make?

}





