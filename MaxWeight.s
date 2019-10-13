@ BSS section
      .bss
z: .word
@ DATA SECTION
.data
data_start: .word 0x205A15E3 ;  #(0010 0000 0101 1010 0001 0101 1101 0011 – 13)
            .word 0x295468F2 ;  #(0010 1001 0101 0100 0110 1000 1111 0010 – 14)  
data_end:   .word 0x256C8700 ;  #(0010 0101 0110 1100 1000 0111 0000 0000 – 11)    

Output: NUM: .word 0x0;
        WEIGHT: .word 0x0; 
	   
@ TEXT section
    .text

.global _main


_main:


     LDR r4, =data_start   ; @get the address of data_start
     LDR r5, =data_end     ; @get the address of data_end
     MOV r1,#0;

load:     LDR r2, [r4]     ; @get value of each item in r2
	  LDR r6, [r4]     ; @get value of each item in r6

loop:			     @Implementation of Brian Kernighan’s Algorithm.
     sub r3,r2,#1;	     @Subract 1 from r2 and store it in r3 as n-1.
     AND r2,r2,r3	     @And r2 with r3 and store it in r2 ; n = n&(n-1)
     ADD r7,r7,#1;	     @Increment value in r7 ;it counts the number of high bits.
     cmp r2,#0               @Compare and exit the loop if the content in r2 is equal to 0; exit if n&(n-1) is equal to zero
     BNE loop                @ if R2 is not equal to 0 jump to the loop 

check: 
      CMP r7,r1;	      	
      MOVGT r8,r6;	      @Compare and store the NUM of Maximum Weight in r8
      CMP r7,r1;	      
      MOVGT r1,r7;	      @Compare and store the Weight of Maximum Weight in r7
      MOV r7,#0;	      @Reset r7
        
     
      CMP r4,r5               @Compare the address in r4 with data_end address in r5
      ADD r4,r4,#4	      @Increment address to fetch the next item
      BNE load                @ Jump to the load if it is not the data_end address
      B _exit                 @ else exit

 _exit: 
     	LDR r4, =NUM   ; @get the address of NUM
	str  r8,[r4]   ; @result is stored in NUM
     	LDR r4, =WEIGHT   ; @get the address of WEIGHT
	str  r1,[r4]   ; @result is stored in WEIGHT
