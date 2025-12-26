#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h >
#include <ctype.h >

FILE*infile;
FILE*outfile;

unsigned char var0,var1;
unsigned short Areg,Xreg,Yreg;
unsigned int insize,outsize;
unsigned char	buffer[8192];
unsigned char needA,needX,needY;
float cycles;
int bytes;

int main()
{
puts( "" );

   if ( !__argv[1] ) {
      puts( "No source file specified." );
      return 0;
   }
   
   if ( !__argv[2] ) {
      puts( "No destination file specified." );
      return 0;
   }  

	infile=fopen(__argv[1],"rb");

	
	/* get size of input file */
	fseek(infile, 0, SEEK_END);
	insize = (unsigned int) ftell(infile);
	fseek(infile, 0, SEEK_SET);
	if (insize > 8192) {return 0;}
	
	fread (buffer,1,insize,infile);	
	
	fclose(infile);	

	//outfile=fopen(__argv[2],"wb+");
	outfile=fopen(__argv[2],"w+");
	
	
	//Areg=buffer[0];
	//Xreg=0x8888;
	//Yreg=0x8888;
	//fprintf(outfile,"	LDA #");
	//fprintf(outfile,"%d \n",Areg);
	//fprintf(outfile,"	STA PPU_DATA\n");
	
	Areg=0x8888;
	Xreg=0x8888;
	Yreg=buffer[0];
	fprintf(outfile,"	LDY #");
	fprintf(outfile,"%d \n",Yreg);
	fprintf(outfile,"	STY PPU_DATA\n");
	
	//cycles=2+4+6;  // lda+sta+rts
	cycles=2+4; // lda + sta
	bytes = 5; // lda + sta
	
	unsigned int i,j;
	
	for (i=1;i<insize;i+=1) {
	var0=buffer[i];
	if (var0==Areg)
		{
		fprintf(outfile,"	STA PPU_DATA\n");
		goto read_next;
		}
	if (var0==Xreg)
		{
		fprintf(outfile,"	STX PPU_DATA\n");
		goto read_next;
		}
	if (var0==Yreg)
		{
		fprintf(outfile,"	STY PPU_DATA\n");
		goto read_next;
		}

		// search what reg to use A,X or Y :
		needA=0;
		needX=0;
		needY=0;
		for (j=i+1;j<insize;j+=1)
		{		
		var1=buffer[j];
		if (var1==Yreg) {needY=1; if ((needA+needX+needY)==2) {break;}  }
		if (var1==Areg) {needA=1; if ((needA+needX+needY)==2) {break;}  }
		if (var1==Xreg) {needX=1; if ((needA+needX+needY)==2) {break;}  }
		}
		cycles+=2; // 2 cycles for LDA
		
		if (needY==0)   {
		if (var0==(Yreg-1)) {	Yreg=var0; fprintf(outfile,"	DEY\n"); goto write_sty; bytes = bytes+1; } // DEY
		if (var0==(Yreg+1)) {	Yreg=var0; fprintf(outfile,"	INY\n"); goto write_sty; bytes = bytes+1; } // INY
		
		Yreg=var0;
	fprintf(outfile,"	LDY #");
	fprintf(outfile,"%d \n",Yreg);
	bytes = bytes+2;
write_sty:		
	fprintf(outfile,"	STY PPU_DATA\n");
		goto read_next;
		}		

		if (needA==0)	{
		if (var0==(Areg>>1)) {	Areg=var0; fprintf(outfile,"	LSR A\n"); goto write_sta; bytes = bytes+1; } // LSR
		if (var0==(Areg<<1)) {	Areg=var0; fprintf(outfile,"	ASL A\n"); goto write_sta; bytes = bytes+1; } // ASL
		
		Areg=var0;
	fprintf(outfile,"	LDA #");
	fprintf(outfile,"%d \n",Areg);
	bytes = bytes+2;
write_sta:		
	fprintf(outfile,"	STA PPU_DATA\n");
		goto read_next;
		}
		
		// if (needX==0)	{
		if (var0==(Xreg-1)) {	Xreg=var0; fprintf(outfile,"	DEX\n"); goto write_stx; bytes = bytes+1; } // DEX
		if (var0==(Xreg+1)) {	Xreg=var0; fprintf(outfile,"	INX\n"); goto write_stx; bytes = bytes+1; } // INX
		
		Xreg=var0;
	fprintf(outfile,"	LDX #");
	fprintf(outfile,"%d \n",Xreg);
	bytes = bytes+2;
write_stx:		
	fprintf(outfile,"	STX PPU_DATA\n");
		// goto read_next;
		// }

read_next:
	bytes = bytes+3;
	cycles+=4; // 4 cycles for STA
	}
	
	//fprintf(outfile," RTS\n");
	
	printf(" %.0f cycles ", cycles);
	printf("(%.2f scanlines)\n" , cycles/113.67);
	
	//outsize = (unsigned int) ftell(outfile);
	//cycles = (float) outsize/insize;
	
	printf(" %d bytes " , bytes);
	
	cycles = (float) bytes/insize;  // percent of original size
	printf("(%.0f%%) \n" , cycles*100); // percent of original size
	
	fclose(outfile);
	return 0;
}
