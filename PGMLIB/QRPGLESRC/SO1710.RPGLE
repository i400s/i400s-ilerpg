      *_________________________________________________________________________
      * Description  : Standard Shell
      * Programmer   : Jonathan Wilson
      * Date Created : 31/03/1994
      *_________________________________________________________________________
      * Description  : Workwith Bibliographic data
      * System       : xxxxxxx
      * Programmer   : Jonathan Wilson
      * Date Created : 28/08/2014
      *_________________________________________________________________________
      * MODIFICATIONS
      *_________________________________________________________________________
      *
      * By           :
      * Date         :
      * Scan string  :
      * Description  :
      *_________________________________________________________________________
      * INDICATORS
      *_________________________________________________________________________
      *
      * 01   : *OFF=Control, *ON=Detail
      * 02-05: *VAR=Condition fields
      * 06   : *OFF=Allow option, *ON=Protect option
      * 07   : *OFF=Detail records to display, *ON=No detail records to display
      * 09-11: *VAR=Condition mode of operation
      * 12-14: *VAR=Condition function key text
      * 15   : *ON=RollDown
      * 16   : *ON=RollUp
      * 20   : *ON='Bottom', *OFF='More...'
      * 21   : *ON=Change record level
      * 22   : *ON=Show panel id information
      * 23   : *ON=VLDCMDKEY
      * 26   : *ON=SFLDSP, SFLDSPCTL *OFF=SFLCLR
      * 28   : *ON=SFLNXTCHG
      *      :
      * 98   : *ON=System error occured (ie. Call failed, file error, etc.)
      * 99   : *ON=Fail/Valid indicator (ie. Chain, lookup, etc.)
      *
      *-------------------------------------------------------------------------
      *
      /define DspFmt
      /include qincprsrc,StdHSpec
      *
      *-------------------------------------------------------------------------
      * Bibliographic record
      * - [BL] ISBN(PK)
     FMTBIBLL1  UF A E           K DISK    INFDS(IDF1R1)
     F                                     RENAME(MTBIBLF:DTAF1R1)
      *     [TI] Title
     FMTTITLP   UF A E           K DISK
     F                                     RENAME(MTTITLF:DTAF2R1)
      *     [AU] Author
     FMTAUTHP   UF A E           K DISK
     F                                     RENAME(MTAUTHF:DTAF3R1)
      *
      *-------------------------------------------------------------------------
      * - SUPN(AK), SKSN(AK), ISBN(PK)
     FMTBIBLL2  IF   E           K DISK
     F                                     RENAME(MTBIBLF:DTAF1R2)
      * - SKSN(AK), ISBN(PK)
     FMTBIBLL3  IF   E           K DISK
     F                                     RENAME(MTBIBLF:DTAF1R3)
      * - SUPN(AK), ISBN(PK)
     FMTBIBLL4  IF   E           K DISK
     F                                     RENAME(MTBIBLF:DTAF1R4)
      *
      *-------------------------------------------------------------------------
      * [ES] Supplier
     FMTSUPPP   IF   E           K DISK
      * [IP] Imprint
     FMTIMPNP   IF   E           K DISK
      * [MT] Marc code
     FMRCCDE    IF   E           K DISK
      * [BN] Binding type
     FBNDTYP    IF   E           K DISK
      *
      *-------------------------------------------------------------------------
      * Display file
     FSO1710D   CF   E             WORKSTN INFDS(D@INFD)
     F                                     SFILE(S1SFL01:D@RR1)
     F                                     SFILE(S1SFL02:D@RR1)
     F                                     SFILE(S2SFL02B:D@RR)
     F                                     SFILE(S2SFL02C:D@RR)
      *
      *-------------------------------------------------------------------------
      /include qincprsrc,svcdspfmt
      /define SO1710_WrkRcdBbl
      /include qincprsrc,EntPgmPrc
      /include SO1710_H
      *-------------------------------------------------------------------------
      *
      * PK='Primary key(s)' & '0=Control, 1=Detail'
     D PK              S             11    DIM(50)
      * AK='Alternative key(s),' including PK(s) & 'indicators/options'
     D AK              S             60    DIM(50) ASCEND
      * BO='Batched options,' used on 4=Delete screen
     D BO              S             60    DIM(50)
      * Overlays to C1#xx and D1#xx for ':' '.'
     D SKSW            S              3    DIM(10)
     D S2TI            S             11    DIM(51)
     D S2AU            S             11    DIM(51)
     D S2              S              6    DIM(51)
      *
      *
      *-------------------------------------------------------------------------
      * Data structure definitions
      *-------------------------------------------------------------------------
      *
      * Bibliographic record
     D F1DS          E DS                  OCCURS(4) EXTNAME(MTBIBLL1) INZ
      *  _Title file
     D TIDS          E DS                  EXTNAME(MTTITLP) INZ
     D D1FTTL          DS           540    OCCURS(2)
     D W1FTTL          DS           540
      *  _Author file
     D AUDS          E DS                  EXTNAME(MTAUTHP) INZ
     D D1FATN          DS           240    OCCURS(2)
     D W1FATN          DS           540
      *
     D F@DS            DS           500
      *
     D F1AK            DS                  OCCURS(5)
      * Primary file keys
     D  F1@CDI                 1      1    INZ
     D  F1ISBN                 2     11    INZ
     D  F1PK                   1     11
      * All additional keys, from alternative sequence files
     D  F1SUPN                12     18  0 INZ
     D  F1SKSN                19     28    INZ
      * Stored option/error indicators
     D  F1@IOP                29     60    INZ
      *
     D F@AK            DS            60
      *
      * File sequence 1
     D F1R1            DS
     D  R1@CDI                 1      1
     D  R1ISBN                 2     11    INZ
      * All additional keys, from alternative sequence files
     D  R1SKSN                12     21    INZ
     D  R1SUPN                22     28  0 INZ
      * Stored option/error indicators
     D  R1@IOP                29     60    INZ
      *
      * File sequence 2
     D F1R2            DS
     D  R2@CDI                 1      1
     D  R2SUPN                 2      8  0 INZ
     D  R2SKSN                 9     18    INZ
     D  R2ISBN                19     28    INZ
      * Stored option/error indicators
     D  R2@IOP                29     60    INZ
      *
      * File sequence 3
     D F1R3            DS
     D  R3@CDI                 1      1
     D  R3SKSN                 2     11    INZ
     D  R3ISBN                12     21    INZ
      * All additional keys, from alternative sequence files
     D  R3SUPN                22     28  0 INZ
      * Stored option/error indicators
     D  R3@IOP                29     60    INZ
      *
      * File sequence 4
     D F1R4            DS
     D  R4@CDI                 1      1
     D  R4SUPN                 2      8  0 INZ
     D  R4ISBN                 9     18    INZ
      * All additional keys, from alternative sequence files
     D  R4SKSN                19     28    INZ
      * Stored option/error indicators
     D  R4@IOP                29     60    INZ
      *
      * S1OPT = '7=Rename'
     D O1PK            DS
     D  O1@CDI                 1      1    INZ
     D  O1ISBN                 2     11    INZ
      *
      * File definition daa strutcures
      *   Supplier
     D ESDS          E DS                  EXTNAME(MTSUPPP) INZ
      *   Imprint
     D IPDS          E DS                  EXTNAME(MTIMPNP) INZ
      *   MARC code
     D MTDS          E DS                  EXTNAME(MRCCDE) INZ
      *   Binding
     D BNDS          E DS                  EXTNAME(BNDTYP) INZ
      *
      *
      *
      * Formatted option data structures
     D S1@IOP          DS                  INZ
     D  S10120                 1     20
     D  S1@CDI                 1      1    INZ('0')
     D  S1@NDI                 2      2    INZ('0')
     D  S1@VWI                 3      4    INZ('00')
     D  S1@R05                 5      5    INZ('0')
     D  S1@MDI                 6      8    INZ('000')
     D  S1@R09                 9      9    INZ('0')
     D  S1@OPI                10     19    INZ('0000000000')
     D  S1@R20                20     20    INZ('0')
     D  S18897                21     30    INZ('0000000000')
     D  S1OPT                 31     32
     D  S1OPTL                31     31
     D  S1OPTR                32     32
      *
      * File information data structures
     D IDF1R1          DS
     D  OPN@11                 9      9
     D  FNM@11                83     92
     D  FLB@11                93    102
     D  LOK@11               393    394B 0
     D  KST@11               401    465
      * Common format for 'Deleting record from &1/&2' status message
     D IDF@            DS
     D  F@FLIB                 1     10
     D  F@FNAM                11     20
     D  F@KEYS                21     84
      *
      * ':' or '.' for list panel 'subset' fields
     D                 DS
     D  C1                     1      9
     D                                     DIM(9)
     D  C1#01                  1      1
     D  C1#02                  2      2
     D  C1#03                  3      3
     D  C1#04                  4      4
     D  C1#05                  5      5
     D  C1#06                  6      6
     D  C1#07                  7      7
     D  C1#08                  8      8
     D  C1#09                  9      9
      *
      * ':' or '.' for edit panel(s)
     D                 DS
     D  D1                     1     40
     D                                     DIM(40)
     D  D1#01                  1      1
     D  D1#02                  2      2
     D  D1#03                  3      3
     D  D1#04                  4      4
     D  D1#05                  5      5
     D  D1#06                  6      6
     D  D1#07                  7      7
     D  D1#08                  8      8
     D  D1#09                  9      9
     D  D1#10                 10     10
     D  D1#11                 11     11
     D  D1#12                 12     12
     D  D1#13                 13     13
     D  D1#14                 14     14
     D  D1#15                 15     15
     D  D1#16                 16     16
     D  D1#17                 17     17
     D  D1#18                 18     18
     D  D1#19                 19     19
     D  D1#20                 20     20
     D  D1#21                 21     21
     D  D1#22                 22     22
     D  D1#23                 23     23
     D  D1#24                 24     24
     D  D1#25                 25     25
     D  D1#26                 26     26
     D  D1#27                 27     27
     D  D1#28                 28     28
     D  D1#29                 29     29
     D  D1#30                 30     30
     D  D1#31                 31     31
     D  D1#32                 32     32
     D  D1#33                 33     33
     D  D1#34                 34     34
     D  D1#35                 35     35
     D  D1#36                 36     36
     D  D1#37                 37     37
     D  D1#38                 38     38
     D  D1#39                 39     39
     D  D1#40                 40     40
      *
     D @MODE           DS
     D  @MDD                   1      2
     D  @MDS                   3      4
     D  @MSD                   5      6
     D  @MSS                   7      8
      *
      * Binary/packed decimal conversion data structures
     D PD0052          DS
     D  DC0052                 1      3P 2
     D PD0092          DS
     D  DC0092                 1      5P 2
     D PD0070          DS
     D  CD0070                 1      7P 0
     D BN002C          DS
     D  BD002C                 1      2B 0
     D BN004C          DS
     D  BD004C                 1      4B 0
      *
      * External perameters for calls
     D X@LOMD          DS                  INZ
     D  BZ0001                 1      4B 0 INZ(256)
     D X@PSC           DS                  INZ
     D  BZ0002                 1      4B 0
     D X@MK            DS                  INZ
     D  BZ0003                 1      4B 0
     D X@EC            DS                  INZ
     D  X@ECBP                 1      4B 0 INZ(272)
     D  X@ECBA                 5      8B 0
     D  X@MI                   9     15
     D  X@EC#1                16     16
     D  X@MDIT                17    272
     D I@EC            DS                  INZ
     D  I@ECBP                 1      4B 0 INZ(272)
     D  I@ECBA                 5      8B 0
     D  I@MI                   9     15
     D  I@EC#1                16     16
     D  I@MDIT                17    272
     D X@ID            DS                  INZ
     D  X@IDC                  1      1  0
     D  X@IDD                  2      7  0
     D  X@IDT                  8     13  0
     D  X@IDM                 14     14  0
     D X@OD            DS                  INZ
     D  X@ODC                  1      1  0
     D  X@OD1                  2      3  0
     D  X@OD2                  4      5  0
     D  X@OD3                  6      7  0
     D  X@ODD                  2      7  0
     D  X@ODT                  8     13  0
     D  X@ODU                 14     16  0
      *
      * Formated date/time stamp
     D @DT             DS                  INZ
     D  DT@Y                   1      4  0 INZ(0001)
     D  DT@F01                 5      5    INZ('-')
     D  DT@M                   6      7  0 INZ(01)
     D  DT@F02                 8      8    INZ('-')
     D  DT@D                   9     10  0 INZ(01)
     D  DT@F03                11     11    INZ('-')
     D  DT@H                  12     13  0
     D  DT@F04                14     14    INZ('.')
     D  DT@MI                 15     16  0
     D  DT@F05                17     17    INZ('.')
     D  DT@S                  18     19  0
     D  DT@F06                20     20    INZ('.')
     D  DT@U                  21     26  0
      *
      *
     D @RCB            DS            22    INZ
     D  @CT                    1      4B 0 INZ(1)
     D  @CI                    5      8B 0 INZ(0)
     D  @CC                    9     12B 0 INZ(0)
     D  @CR                   13     22
      *
      *
     D X@SID           DS           580
     D X@SOD           DS           580
     D W2FTTL          DS           580
      *
      *
     D S2KD            DS                  INZ
     D  S2KY                   1      6
     D  S2TAGC                 1      3  0
     D  S2SEQN                 4      6  0
     D  S2MSEQ                 7      7  0
     D  S2CI                   8      8
     D  S2NEF                  9      9
     D  S2I09                 10     10
     D  S2CHG                 11     11
      *
      * Local data area
     D #LDA            DS           256
      *
      * Constants
     D D@RR1M          C                   CONST(9)
     D D@RR1D          C                   CONST(13)
     D O1              C                   CONST(50)
     D O2              C                   CONST(50)
     D D@MVF1          C                   CONST(4)
     D C@PROW          C                   CONST(11)
     D C@PCOL          C                   CONST(2)
     D YES             C                   CONST('1')
     D NO              C                   CONST('0')
     D UP              C                   CONST('0')
     D DOWN            C                   CONST('1')
     D BOTTOM          C                   CONST('1')
     D MORE            C                   CONST('0')
     D #NRKEY          C                   CONST(1)
     D #INKEY          C                   CONST(2)
     D #LOKEY          C                   CONST(3)
     D #HIKEY          C                   CONST(4)
     D #CHKEY          C                   CONST(5)
     D #CRRCD          C                   CONST(1)
     D #ORRCD          C                   CONST(2)
     D #SCRCD          C                   CONST(3)
     D #UPRCD          C                   CONST(4)
     D C@PMFN          C                   CONST('LMMSGF    *LIBL     ')
     D C@SMFN          C                   CONST('QCPFMSG   *LIBL     ')
     D VLCHR           C                   CONST('BCDFGHJKLMNPQRSTVWXY-
     D                                     Z ')
     D VLCHRG          C                   CONST('BCDFGHJKLMNPQRSTVWXY-
     D                                     Z* ')
      *
      * *ENTRY, main program start
      *
      * The runtime automatically calls *INZSR here.
      ***C EXSR *INZSR. For documentation clarity only.
      *
      * Perform program 'checks'
     C                   EXSR      PR@PG
      *
      *
     C                   MOVE      'E@>C1'       KY@DIR
     C                   EXSR      PR@KY
      *
      * If all 'PK' keys passed setup key and call edit subroutine
      /free
       select;
         when e_ISBN <> '*ALL';
           S1OPT = e_CallerOpt;
           BLISBN = e_ISBN;
           exsr @EDT01;
         other;
           exsr @LST01;
       endsl;

       // End of main program.
       out #LDA;
       e_FunctionKey = I@FKY;
       *INLR = *ON;
       return;
      /end-free
      *
      *-------------------------------------------------------------------------
     C     @LST01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      '*ENT'        @FMT
      *
      *
B1   C     @FMT          DOWNE     *BLANKS
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
      *
      *
     C                   MOVE      'C1>V1'       KY@DIR
     C                   EXSR      PR@KY
      *
      *
     C                   MOVE      'V1>F1'       KY@DIR
     C                   EXSR      PR@KY
      *
      * Move values to LOKEY
     C                   MOVE      F1AK          F@AK
     C     #LOKEY        OCCUR     F1AK
     C                   MOVE      F@AK          F1AK
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
      *
      * Clear stored options.
     C                   EXSR      PI@AK
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
      *
      * Get for display
     C                   MOVE      *OFF          C1@CE
     C                   EXSR      VL@C1
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
     C     @FMT          OREQ      '*UPD'
      *
      * Clear subfile
     C                   MOVE      *ON           *IN02
     C                   WRITE     C1PNL01
      *
      *
     C     #CRRCD        OCCUR     F1DS

      /free
b3     select;
w3       when ReturnKey = RollUp;
b4         if D@MOB = BOTTOM;
             X@MI = 'CPD6A69';
      /end-free
     C                   CALL      'QMHSNDPM'    @SNDSM
      /free
             %occur(F1AK) = #LOKEY;
             SO1710_IndexBeforeListFile();
x4         else;
             %occur(F1AK) = #HIKEY;
           SO1710_IndexAfterListFile();
e4         endif;
w3       when ReturnKey = RollDown;
           %occur(F1AK) = #LOKEY;
           SO1710_IndexBeforeListFile();
b4         if SO1710_ReadPreviousValidListFile();
             X@MI = 'CPD6A66';
      /end-free
     C                   CALL      'QMHSNDPM'    @SNDSM
      /free
x4         else;
             // Read backwards a page of records
             D@RR1 = D@RR1M;
b5           dou SO1710_ReadPreviousValidListFile() or
                 D@RR1 = 1;
               D@RR1 -= 1;
e5           enddo;
b5           if D@RR1 > 1;
               %occur(F1AK) = #INKEY;
x5           else;
               // Else set the record found to the lowest key
               %occur(F1AK) = #LOKEY;
               KY@DIR = 'f?>F1';
               exsr PR@KY;
e5           endif;
e4         endif;
           // Reposition file pointer
           SO1710_IndexBeforeListFile();
           // Enter or refresh requested
w3       other;
           %occur(F1AK) = #LOKEY;
           SO1710_IndexBeforeListFile();
e3     endsl;

       // Perform first read for the subfile page
b3     if SO1710_ReadValidListFile();
         // No records found
         SO1710_IndexAfterListFile();
b4       if SO1710_ReadPreviousValidListFile();
           // Still no records found
           D@MOB = BOTTOM;
           %occur(F1AK) = #INKEY;
           F@AK = F1AK;
           %occur(F1AK) = #LOKEY;
           F1AK = F@AK;
x4       else;
           // records exist, set key
           %occur(F1AK) = #LOKEY;
           KY@DIR = 'f?>F1';
           exsr PR@KY;
e4       endif;
x3     else;
         // Records exists, set key
         %occur(F1AK) = #LOKEY;
         KY@DIR = 'f?>F1';
         exsr PR@KY;
e3     endif;
      /end-free
      *
      * Save key(s)
     C                   MOVE      F1AK          F@AK
     C     #CHKEY        OCCUR     F1AK
      *
      * Write input 'control' subfile
     C                   MOVE      *OFF          F1@CDI
     C                   EXSR      FM@S1F
     C     S1@WCR        IFEQ      *ON
     C                   WRITE     S1SFL01
     C                   ENDIF
      *
      * Restore key(s)
     C                   MOVE      F@AK          F1AK
     C                   MOVE      'F1>f?'       KY@DIR
     C                   EXSR      PR@KY
      *
      * Setup 'standard record' subfile
     C                   Z-ADD     0             D@RR1
      /free
       SO1710_IndexBeforeListFile();
       dow not SO1710_ReadValidListFile() and
           D@RR1 < D@RR1M;
      /end-free
      *
      * Format subfle record
     C                   MOVE      *ON           F1@CDI
     C                   EXSR      FM@S1F
      *
      * Write subfile record
     C                   ADD       1             D@RR1
     C                   WRITE     S1SFL01
      *
      * Save key values if last record on screen
B4   C     D@RR1         IFEQ      D@RR1M
     C     #UPRCD        OCCUR     F1DS
E4   C                   ENDIF
      *
      *
E3   C                   ENDDO
      *
      * If end of file show it
B3   C     F1@EOF        IFEQ      *ON
     C                   MOVE      BOTTOM        D@MOB
      *
      * Else save keys to HIKEY
X3   C                   ELSE
     C                   MOVE      MORE          D@MOB
     C     #CRRCD        OCCUR     F1DS
     C     #HIKEY        OCCUR     F1AK
     C                   MOVE      'f?>F1'       KY@DIR
     C                   EXSR      PR@KY
E3   C                   ENDIF
      *
      * End of create/update test
E2   C                   ENDIF
      *
      * Set/Reset display output
     C     #CHKEY        OCCUR     F1AK
     C                   MOVE      D@MOB         *IN25
      *
      * If error, position cursor to error
B2   C                   SELECT
W2   C     @FMT          WHENEQ    '*ERR'
     C                   CLEAR                   D@PROW
     C                   CLEAR                   D@PCOL
W2   C                   OTHER
      *
      * Otherwise position cursor to last cursor position
     C                   Z-ADD     C@PROW        D@PROW
     C                   Z-ADD     C@PCOL        D@PCOL
E2   C                   ENDSL
      *
      * Process display format
     C                   MOVEA     C10120        *IN(01)
     C                   MOVEA     C18897        *IN(88)
     C                   WRITE     C1PNL01
      *
     C                   WRITE     C1FTR01
     C                   WRITE     #ERRCTL
      *
     C                   READ      C1PNL01                                99
      *
      * Set/Reset display input
     C                   MOVE      *IN21         @CHG
     C                   MOVE      *IN22         @VCF
     C                   CLEAR                   I@FKY
     C                   CLEAR                   @FMT
B2   C                   SELECT
W2   C     *IN23         WHENEQ    *ON
     C                   MOVE      UP            @ROLL
     C                   MOVE      '*UPD'        @FMT
W2   C     *IN24         WHENEQ    *ON
     C                   MOVE      DOWN          @ROLL
     C                   MOVE      '*UPD'        @FMT
W2   C                   OTHER
     C                   CLEAR                   @ROLL
E2   C                   ENDSL
     C                   CALL      'QMHRMVPM'    @RMVPM
     C                   MOVEA     *ALL'0'       *IN(50)
     C     D@ROCL        DIV       256           D@PROW
     C                   MVR                     D@PCOL
      *
      * Validate the screen as a whole
     C                   EXSR      VL@C01
      *
      * Process entered option(s)
B3   C     @FMT          IFEQ      *BLANKS
     C     I@FKY         ANDEQ     *BLANKS
     C                   EXSR      PR@S1
E3   C                   ENDIF
      *
      * Panel has changed, redisplay
B3   C     @FMT          IFEQ      *BLANKS
     C     I@FKY         ANDEQ     *BLANKS
B4   C     @CHG          IFEQ      YES
     C                   MOVE      '*DSP'        @FMT
E4   C                   ENDIF
E3   C                   ENDIF
      *
      * End display format loop
E1   C                   ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     VL@C01        BEGSR
      *-------------------------------------------------------------------------
      *
      * Get and store options
     C                   MOVE      *OFF          S1DO
     C                   EXSR      VL@S01
      *
      * Test and validate display format
B1   C                   SELECT
      *
      * F3=Exit
W1   C     *INKC         WHENEQ    *ON
     C                   MOVE      'KC'          I@FKY
      *
      * F5=Refresh
W1   C     *INKE         WHENEQ    *ON
     C                   MOVE      'M1>C1'       KY@DIR
     C                   EXSR      PR@KY
     C                   MOVE      '*CRT'        @FMT
      *
      * F12=Cancel
W1   C     *INKL         WHENEQ    *ON
     C                   MOVE      'KL'          I@FKY
      *
      * Enter, RollDown, RollUp, F4, F6, F11, F16, F17
W1   C     @VCF          WHENNE    *ON
     C     @ROLL         OREQ      UP
     C     @ROLL         OREQ      DOWN
     C     *INKD         OREQ      *ON
     C     *INKF         OREQ      *ON
     C     *INKK         OREQ      *ON
     C     *INKQ         OREQ      *ON
     C     *INKR         OREQ      *ON
      *
      *
     C                   MOVE      *ALL'0'       C18897
     C                   MOVEA     C18897        *IN(88)
      *
      *
B2   C                   SELECT
W2   C     *INKD         WHENEQ    *ON
     C                   EXSR      @F4L01
B3   C                   SELECT
W3   C     X@ECBA        WHENNE    *ZERO
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
     C                   OTHER
     C                   MOVE      '*DSP'        @FMT
E3   C                   ENDSL
E2   C                   ENDSL
      *
      * Find first '1:Detail' option
     C                   Z-ADD     E1            AK@SQ
     C                   EXSR      PR@AK1
      *
      *
B2   C                   SELECT
W2   C     C1SKSN        WHENNE    M1SKSN
     C     C1SUPN        ORNE      M1SUPN
     C     C1IMPN        ORNE      M1IMPN
      *
      *
B3   C                   SELECT
      *
      * Cannot change list with options pending.
W3   C     AK@I          WHENEQ    *ON
     C                   MOVE      'MSG1833'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
B4   C     C1SKSN        IFNE      M1SKSN
     C                   MOVE      *ON           *IN97
E4   C                   ENDIF
B4   C     C1SUPN        IFNE      M1SUPN
     C                   MOVE      *ON           *IN96
E4   C                   ENDIF
B4   C     C1IMPN        IFNE      M1IMPN
     C                   MOVE      *ON           *IN95
E4   C                   ENDIF
     C                   MOVE      '*ERR'        @FMT
      *
      * You cannot change the list and press a function key.
W3   C     @VCF          WHENEQ    *ON
     C     @ROLL         ANDEQ     *BLANKS
     C                   MOVE      'MSG1834'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
B4   C     C1SKSN        IFNE      M1SKSN
     C                   MOVE      *ON           *IN97
E4   C                   ENDIF
B4   C     C1SUPN        IFNE      M1SUPN
     C                   MOVE      *ON           *IN96
E4   C                   ENDIF
B4   C     C1IMPN        IFNE      M1IMPN
     C                   MOVE      *ON           *IN95
E4   C                   ENDIF
     C                   MOVE      '*ERR'        @FMT
      *
      * You cannot change the list and press a roll key
W3   C     @ROLL         WHENNE    *BLANKS
     C                   MOVE      'MSG1837'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
B4   C     C1SKSN        IFNE      M1SKSN
     C                   MOVE      *ON           *IN97
E4   C                   ENDIF
B4   C     C1SUPN        IFNE      M1SUPN
     C                   MOVE      *ON           *IN96
E4   C                   ENDIF
B4   C     C1IMPN        IFNE      M1IMPN
     C                   MOVE      *ON           *IN95
E4   C                   ENDIF
     C                   MOVE      '*ERR'        @FMT
      *
      *
E3   C                   ENDSL
      *
      *
B3   C     @FMT          IFNE      '*ERR'
     C                   MOVE      '*ENT'        @FMT
E3   C                   ENDIF
      *
      * F17=Subset
W2   C     *INKR         WHENEQ    *ON
     C     AK@I          ANDEQ     *ON
      *
      * Function key is not allowed with options pending
     C                   MOVE      'MSG1836'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
      *
      * F17=Subset
W2   C     *INKR         WHENEQ    *ON
     C     AK@I          ANDEQ     *OFF
     C                   EXSR      @SBS01
B3   C     I@FKY         IFEQ      *BLANKS
     C                   MOVE      '*ENT'        @FMT
X3   C                   ELSE
     C                   MOVE      '*DSP'        @FMT
E3   C                   ENDIF
      *
      * F6=Create not allowed when record selection not entered.
W2   C     *INKF         WHENEQ    *ON
     C     *BLANKS       ANDNE     *BLANKS
     C                   MOVE      'MSG1899'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
      *
      *
E2   C                   ENDSL
      *
      *
     C                   MOVEA     *IN(88)       C18897
      *
      * Get and validate control
B2   C     @FMT          IFNE      '*ERR'
     C     I@FKY         ANDEQ     *BLANKS
     C                   MOVE      *ON           C1@CE
     C                   EXSR      VL@C1
E2   C                   ENDIF
      *
      * Get and validate options
B2   C     @FMT          IFNE      '*ERR'
     C     I@FKY         ANDEQ     *BLANKS
     C                   MOVE      *ON           S1DO
     C                   EXSR      VL@S01
E2   C                   ENDIF
      *
      *
B2   C                   SELECT
      *
      * F11=View x
W2   C     *INKK         WHENEQ    *ON
     C     @FMT          ANDNE     '*ERR'
     C                   ADD       1             F1V
B3   C     F1V           IFGT      2
     C                   Z-ADD     1             F1V
E3   C                   ENDIF
     C                   MOVE      '*RFD'        @FMT
      *
      * F16=Position to
W2   C     *INKQ         WHENEQ    *ON
     C     @FMT          ANDNE     '*ERR'
     C                   EXSR      @POS01
B3   C     I@FKY         IFEQ      *BLANKS
     C     #LOKEY        OCCUR     F1AK
     C                   MOVE      P1ISBN        F1ISBN
     C                   MOVE      '*UPD'        @FMT
X3   C                   ELSE
     C                   MOVE      '*DSP'        @FMT
E3   C                   ENDIF
      *
      *
E2   C                   ENDSL
      *
      * Function key not allowed
W1   C     @VCF          WHENEQ    *ON
     C                   MOVE      'CPD6A60'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   MOVE      '*ERR'        @FMT
      *
      * End process display
E1   C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     VL@C1         BEGSR
      *-------------------------------------------------------------------------
      *
      * Set all indicators off
     C                   MOVE      *ALL'0'       C10120
     C                   MOVEA     C10120        *IN(01)
      *
      *
     C     C1@CE         IFEQ      *OFF
     C                   MOVE      *ALL'0'       C18897
     C                   ENDIF
     C                   MOVEA     C18897        *IN(88)
      *
      *
     C                   MOVEA     *ALL'.'       C1
      /free
       if e_ShortName <> '*ALL';
         c1(01) =':';
         *in11 = *on;
       endif;
       if e_SupplierNumber <> *zero;
         c1(02) =':';
         *in12 = *on;
       endif;
       if e_ImprintNumber <> *zero;
         c1(03) =':';
         *in13 =*on;
       endif;
      /end-free
      *
      * Issue this is a subsetted list for tests not on SFLCTL
     C     C1@CE         IFEQ      *OFF
B2   C     C1DLTD        ANDNE     '*'
     C     C1DLTD        ANDNE     B1DLTD
     C                   MOVE      'MSG1830'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      C1DLTD        B1DLTD
E2   C                   ENDIF
      *
      * Validate SKSN
B1   C     C1@CE         IFEQ      *ON
     C     C1SKSN        ANDNE     '*ALL'
     C     C1SKSN        ANDNE     '*BLANKS'
      *
      *
     C     ' '           CHECK     C1SKSN        I
     C     ' '           CHECKR    C1SKSN        J
B2   C     I             IFEQ      1
     C     ' '           SCAN      C1SKSN:2      K
X2   C                   ELSE
     C                   Z-ADD     *ZERO         K
E2   C                   ENDIF
      *
      *
B2   C                   SELECT
W2   C     I             WHENEQ    *ZERO
     C                   MOVE      *ON           *IN97
     C                   MOVE      'MSG1843'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
W2   C     I             WHENGT    1
     C     K             ORNE      *ZERO
     C     K             ANDLT     J
     C                   MOVE      *ON           *IN97
     C                   MOVE      'MSG1844'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
      *
      *
W2   C                   OTHER
      *
      *
     C     '*'           SCAN      C1SKSN        I
      *
      *
B3   C                   SELECT
W3   C     I             WHENNE    *ZERO
     C     I             ANDLT     J
     C                   MOVE      *ON           *IN97
     C                   MOVE      'MSG1840'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
W3   C     I             WHENEQ    1
     C                   MOVE      *ON           *IN97
     C                   MOVE      'MSG1841'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
E3   C                   ENDSL
      *
      *
E2   C                   ENDSL
      *
      *
E1   C                   ENDIF
      *
      * Get supplier, error if not "...flagged as deleted"
     C                   MOVE      C1SUPN        ESUPN4
     C                   EXSR      @RTES
B1   C     C1@CE         IFEQ      *ON
     C     X@ECBA        ANDNE     *ZERO
     C     C1SUPN        ANDNE     *ZERO
     C     X@MI          ANDNE     'MSG1352'
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN96
     C                   MOVE      '*ERR'        @FMT
E1   C                   ENDIF
      *
      * Get imprint, error if not "...flagged as deleted"
     C                   MOVE      C1IMPN        IPIMPN
     C                   EXSR      @RTIP
     C                   MOVEL     IPIPNM        C1IPNM
B1   C     C1@CE         IFEQ      *ON
     C     X@ECBA        ANDNE     *ZERO
     C     C1IMPN        ANDNE     *ZERO
     C     X@MI          ANDNE     'MSG1561'
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT
E1   C                   ENDIF
      *
      * ViewX
B1   C                   SELECT
W1   C     F1V           WHENEQ    1
     C                   MOVEA     '00'          *IN(03)
W1   C     F1V           WHENEQ    2
     C                   MOVEA     '01'          *IN(03)
E1   C                   ENDSL
      *
      * ModeX
B1   C                   SELECT
W1   C     @MSD          WHENEQ    '*M'
     C                   MOVEA     '000'         *IN(06)
W1   C     @MSD          WHENEQ    '*V'
     C                   MOVEA     '001'         *IN(06)
W1   C     @MSD          WHENEQ    '*S'
     C                   MOVEA     '010'         *IN(06)
E1   C                   ENDSL
      *
      * Update M1 fields
B1   C     @FMT          IFNE      '*ERR'
     C     C1@CE         ANDEQ     *OFF
     C                   MOVE      'C1>M1'       KY@DIR
     C                   EXSR      PR@KY
E1   C                   ENDIF
      *
      *
     C                   MOVEA     *IN(01)       C10120
     C                   MOVEA     *IN(88)       C18897
      *
      *
     C                   MOVE      *OFF          C1@CE
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     VL@S01        BEGSR
      *-------------------------------------------------------------------------
      *
      * Read and process subfile records
     C                   READC     S1SFL01                                99
B1   C     *IN99         DOWEQ     *OFF
      *
      *
     C                   MOVE      *OFF          *IN21
      *
      * Validate subfile record
     C                   EXSR      VL@S1
B2   C                   SELECT
W2   C     X@ECBA        WHENNE    *ZERO
     C     S1DO          ANDEQ     *ON
     C                   MOVE      '*ERR'        @FMT
     C                   MOVE      *ON           *IN21
     C     S1DO          WHENEQ    *OFF
     C                   MOVE      *ON           *IN21
E2   C                   ENDSL
      *
      *
     C                   MOVE      *ON           @CHG
      *
      * Update subfile record
     C                   UPDATE    S1SFL01
      *
      * Get next subfile record
     C                   READC     S1SFL01                                99
E1   C                   ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     PR@S1         BEGSR
      *-------------------------------------------------------------------------
      *
      * F6=Create
W1   C     *INKF         IFEQ      *ON
      *
      * Keep creating until exit key pressed
B2   C     I@FKY         DOWEQ     *BLANKS
     C                   MOVE      'KF'          S1OPT
     C                   EXSR      @EDT01
E2   C                   ENDDO
      *
      *
     C                   MOVE      '*RFD'        @FMT
     C                   ENDIF
      *
      * Sequence options into display sequence
     C                   MOVE      'AK:AK'       KY@DIR
     C                   EXSR      PR@KY
      *
      *
     C                   Z-ADD     E1            S1S
      *
      *
B1   C     S1S           DOWLE     O1
     C     I@FKY         ANDEQ     *BLANKS
     C     S1@S1O        ANDEQ     *ON
      *
      *
     C     #CHKEY        OCCUR     F1AK
      *
      *
     C                   MOVEL     AK(S1S)       F1AK
     C                   MOVE      F1@IOP        S1@IOP
      *
      *
B2   C     S1OPT         IFNE      *LOVAL
      *
      *
     C                   MOVE      'F1>f?'       KY@DIR
     C                   EXSR      PR@KY
      *
      * Check if option has become invalid
     C                   EXSR      TS@F1O
      *
      * If option is in error and 'control', report error
B3   C                   SELECT
W3   C     X@ECBA        WHENNE    *ZERO
     C     F1@CDI        ANDEQ     *OFF
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ALL'1'       S18897
     C                   MOVE      S1@IOP        F1@IOP
     C                   MOVEL     F1AK          AK(S1S)
     C                   MOVE      '//'          I@FKY
      *
      * If option is in error and 'detail', remove from stack
W3   C     X@ECBA        WHENNE    *ZERO
     C     F1@CDI        ANDEQ     *ON
     C                   MOVE      *LOVAL        AK(S1S)
     C                   MOVE      *LOVAL        PK(S1S)
      *
      *
W3   C                   OTHER
      *
      * Process option
     C                   MOVE      *ON           S1@DO
     C                   EXSR      TS@S1O
      *
      * If Exit
B4   C     I@FKY         IFNE      *BLANKS
      *
      * Test validity of record to display if 'detail'
     C                   MOVEL     AK(S1S)       F1AK
B5   C     F1@CDI        IFEQ      *ON
     C                   MOVE      'F1>f?'       KY@DIR
     C                   EXSR      PR@KY
     C                   EXSR      TS@F1O
      /free
       if X@ECBA <> *zero and NOT SO1710_ValidateListFile();
         AK(S1S) = *loval;
         PK(S1S) = *loval;
       endif;
      /end-free
E5   C                   ENDIF
      *
      *
X4   C                   ELSE
     C                   MOVE      *LOVAL        AK(S1S)
     C                   MOVE      *LOVAL        PK(S1S)
      *
      *
E4   C                   ENDIF
      *
      * If exit key is not ' /' select, refresh full display
B4   C     I@FKY         IFNE      ' /'
     C                   MOVE      '*RFD'        @FMT
      *
      *
B5   C     I@FKY         IFNE      *BLANKS
      *
      * Find first '1:Detail' option
     C                   Z-ADD     E1            AK@SQ
     C                   EXSR      PR@AK1
      *
      * If '1:detail' found, use it to position to
B6   C     AK@I          IFEQ      *ON
     C     #LOKEY        OCCUR     F1AK
     C                   MOVE      AK(AK@SQ)     F1AK
E6   C                   ENDIF
      *
      *
E3   C                   ENDIF
      *
      *
E4   C                   ENDIF
      *
      *
E3   C                   ENDSL
      *
      *
E2   C                   ENDIF
      *
      *
     C                   ADD       1             S1S
      *
      *
E1   C                   ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     FM@S1F        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   OCCUR     F1AK          W1
     C     #CHKEY        OCCUR     F1AK
      *
      *
     C                   SELECT
     C     F1@CDI        WHENEQ    *OFF
     C                   MOVE      *HIVAL        O1PK
     C                   MOVE      *OFF          O1@CDI
     C                   MOVE      O1PK          F1PK
     C     F1@CDI        WHENEQ    *ON
     C                   MOVE      'f?>F1'       KY@DIR
     C                   EXSR      PR@KY
     C                   ENDSL
      *
      *
     C                   Z-ADD     E1            I
     C     F1PK          LOOKUP    PK(I)                                  99
B1   C                   SELECT
W1   C     F1@CDI        WHENEQ    *OFF
     C     *IN99         ANDEQ     *OFF
     C     #NRKEY        OCCUR     F1AK
     C                   MOVE      *OFF          F1@CDI
W1   C     F1@CDI        WHENEQ    *OFF
     C     *IN99         ANDEQ     *ON
     C                   MOVE      AK(I)         F1AK
     C                   MOVE      *OFF          F1@CDI
     C     F1@CDI        WHENEQ    *ON
     C     *IN99         ANDEQ     *ON
     C                   MOVE      AK(I)         F1AK
     C                   MOVE      *ON           F1@CDI
E1   C                   ENDSL
      *
      *
B1   C     F1@CDI        IFEQ      *OFF
     C                   MOVE      'F1>f?'       KY@DIR
     C                   EXSR      PR@KY
E1   C                   ENDIF
      *
      *
B1   C     *IN99         IFEQ      *ON
     C                   MOVE      F1@IOP        S1@IOP
     C                   MOVE      *ON           *IN21
X1   C                   ELSE
     C                   RESET                   S1@IOP
     C                   MOVE      *OFF          *IN21
E1   C                   ENDIF
      *
      *
     C     W1            OCCUR     F1AK
      *
      * Set all record conditioning indicators off
     C                   MOVE      *ALL'0'       S10120
     C                   MOVEA     S10120        *IN(01)
     C                   MOVE      *ALL'0'       S18897
     C                   MOVEA     S18897        *IN(88)
      *
      * 'Control' or 'detail'
     C                   MOVE      F1@CDI        *IN01
      *
      * '(no records to display)'
     C                   MOVE      F1@EOF        *IN02
      *
      *
     C                   MOVE      *ON           S1@WCR
      *
      * ViewX
B1   C                   SELECT
W1   C     F1V           WHENEQ    1
     C                   MOVEA     '00'          *IN(03)
W1   C     F1V           WHENEQ    2
     C                   MOVEA     '01'          *IN(03)
E1   C                   ENDSL
      *
      * ModeX
B1   C                   SELECT
W1   C     @MSD          WHENEQ    '*M'
     C                   MOVEA     '000'         *IN(06)
W1   C     @MSD          WHENEQ    '*V'
     C                   MOVEA     '001'         *IN(06)
W1   C     @MSD          WHENEQ    '*S'
     C                   MOVEA     '010'         *IN(06)
E1   C                   ENDSL
      *
      * Record is 'detail'
B1   C     F1@CDI        IFEQ      *ON
      *
      * Retreive title
     C                   MOVE      BLISBN        EISBN3
     C                   Z-ADD     130           TITAGC
     C                   CLEAR                   DSEQN0
     C                   CLEAR                   TIDSQN
     C                   EXSR      @RTTI
     C                   MOVEL     W1FTTL        S1FTTL
      *
      * Retreive author
     C                   MOVE      BLISBN        AUISBN
     C                   Z-ADD     100           AUTAGC
     C                   CLEAR                   AUSEQN
     C                   CLEAR                   AUDSQN
     C                   EXSR      @RTAU
     C                   MOVEL     W1FATN        S1FATN
      *
      * Deleted record status
     C                   CLEAR                   S1DLTD
B2   C     BLDLTD        IFNE      *BLANKS
     C                   MOVEL     '*DLT'        S1DLTD
E2   C                   ENDIF
      *
      *
E1   C                   ENDIF
      *
      * Save field display indicators
     C                   MOVEA     *IN(01)       S10120
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     VL@S1         BEGSR
      *-------------------------------------------------------------------------
      *
      *
B1   C     S1OPTL        IFEQ      *ZERO
     C                   CLEAR                   S1OPTL
E1   C                   ENDIF
B1   C     S1OPTL        IFEQ      *BLANKS
     C     S1OPTR        ANDEQ     *ZERO
     C                   CLEAR                   S1OPTR
E1   C                   ENDIF
B1   C     S1OPTR        IFEQ      *BLANKS
     C                   MOVE      S1OPTL        S1OPTR
     C                   CLEAR                   S1OPTL
E1   C                   ENDIF
      *
      * Reset error indicators
     C                   MOVE      *ALL'0'       S18897
     C                   MOVEA     S18897        *IN(88)
      *
      * Validate entered option
     C                   EXSR      TS@S1O
B1   C     X@ECBA        IFNE      *ZERO
B2   C     S1DO          IFEQ      *ON
     C                   MOVE      *ON           *IN97
     C                   CALL      'QMHSNDPM'    @SNDPM
E2   C                   ENDIF
      *
      *
X1   C                   ELSE
      *
      * Is 'control' record
     C                   SELECT
B2   C     S1@CDI        WHENEQ    *OFF
      *
      *
B3   C     S1OPT         IFEQ      *BLANKS
      *
      * Option must be entered when key fields are not empty.
B4   C     BLISBN        IFNE      *BLANKS
     C     S1DO          ANDEQ     *ON
      ***C           ......    ORNE *.....
      ***C           S1DO      ANDEQ*ON
     C                   MOVE      *ON           *IN97
     C                   MOVE      'MSG1525'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
E4   C                   ENDIF
      *
      *
X3   C                   ELSE
      *
      * If any key is blank, error
B4   C     BLISBN        IFEQ      *BLANKS
     C     S1DO          ANDEQ     *ON
      ***C           ......    OREQ *.....
      ***C           S1DO      ANDEQ*ON
     C                   MOVE      'MSG1524'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
      *
      *
B5   C     BLISBN        IFEQ      *BLANKS
     C                   MOVE      *ON           *IN96
E5   C                   ENDIF
      *
      *
X4   C                   ELSE
      *
      * Check file is valid
     C                   EXSR      TS@F1O
B5   C     X@ECBA        IFNE      *ZERO
     C     S1DO          ANDEQ     *ON
     C                   MOVE      *ON           *IN96
     C                   CALL      'QMHSNDPM'    @SNDPM
E5   C                   ENDIF
      *
      *
E4   C                   ENDIF
      *
      *
E3   C                   ENDIF
      *
      * Is 'data' record
X2   C     S1@CDI        WHENEQ    *ON
      *
      * Check file is valid
     C                   EXSR      TS@F1O
B3   C     X@ECBA        IFNE      *ZERO
     C     S1DO          ANDEQ     *ON
     C                   MOVE      *ON           *IN97
     C                   CALL      'QMHSNDPM'    @SNDPM
E3   C                   ENDIF
      *
      * Deleted record status
     C                   CLEAR                   S1DLTD
B3   C     BLDLTD        IFNE      *BLANKS
     C                   MOVEL     '*DLT'        S1DLTD
E3   C                   ENDIF
      *
      * End of control or detail test
E2   C                   ENDSL
      *
      *
E1   C                   ENDIF
      *
      *
     C                   OCCUR     F1AK          W1
     C     #CHKEY        OCCUR     F1AK
      *
      *
B1   C                   SELECT
W1   C     S1@CDI        WHENEQ    *OFF
     C     #NRKEY        OCCUR     F1AK
     C                   MOVE      F1AK          F@AK
     C     #CHKEY        OCCUR     F1AK
     C                   MOVE      *HIVAL        O1PK
     C                   MOVE      *OFF          O1@CDI
     C                   MOVE      O1PK          F1PK
W1   C     S1@CDI        WHENEQ    *ON
     C                   MOVE      'f?>F1'       KY@DIR
     C                   EXSR      PR@KY
     C                   ENDSL
      *
      *
     C                   MOVE      S1@CDI        F1@CDI
      *
      * Save details
     C                   Z-ADD     E1            I
     C     F1PK          LOOKUP    PK(I)                                  99
      *
      *
B1   C                   SELECT
      *
      * Update option
W1   C     *IN99         WHENEQ    *ON
     C     S1@CDI        ANDEQ     *OFF
     C     S1OPT         ANDNE     *BLANKS
     C     *IN99         OREQ      *ON
     C     S1@CDI        ANDEQ     *OFF
     C     F@AK          ANDNE     F1AK
     C     *IN99         OREQ      *ON
     C     S1@CDI        ANDEQ     *ON
     C     S1OPT         ANDNE     *BLANKS
      *
      *
     C                   MOVEA     *IN(88)       S18897
     C                   MOVE      S1@IOP        F1@IOP
     C                   MOVE      'f?>F1'       KY@DIR
     C                   EXSR      PR@KY
     C                   MOVE      F1AK          AK(I)
      *
      * Clear option
W1   C     *IN99         WHENEQ    *ON
      *
      *
     C                   MOVE      *LOVAL        PK(I)
     C                   MOVE      *LOVAL        AK(I)
      *
      * Save option
W1   C     S1@CDI        WHENEQ    *OFF
     C     S1OPT         ANDNE     *BLANKS
     C     S1@CDI        OREQ      *OFF
     C     F@AK          ANDNE     F1AK
     C     S1@CDI        OREQ      *ON
     C     S1OPT         ANDNE     *BLANKS
      *
      *
     C                   Z-ADD     E1            I
     C     *LOVAL        LOOKUP    PK(I)                                  99
B2   C     *IN99         IFEQ      *OFF
     C                   SUB       1             E1
     C                   Z-ADD     E1            I
E2   C                   ENDIF
B2   C     I             IFGT      *ZERO
B3   C     S1@CDI        IFEQ      *OFF
     C                   MOVE      O1PK          PK(I)
X3   C                   ELSE
     C                   MOVE      F1PK          PK(I)
E3   C                   ENDIF
     C                   MOVEA     *IN(88)       S18897
     C                   MOVE      S1@IOP        F1@IOP
     C                   MOVE      'f?>F1'       KY@DIR
     C                   EXSR      PR@KY
     C                   MOVE      F1AK          AK(I)
X2   C                   ELSE
     C                   Z-ADD     1             E1
B3   C     S1DO          IFEQ      *ON
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      *ON           *IN97
     C                   MOVE      'MSG1527'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   CLEAR                   S1OPT
     C                   MOVEA     *IN(88)       S18897
E3   C                   ENDIF
E2   C                   ENDIF
      *
      *
E1   C                   ENDSL
      *
      *
     C     W1            OCCUR     F1AK
      *
      * Set change flag if option is not "exitable"
B1   C     S1OPT         IFNE      ' /'
     C     S1OPT         ANDNE     '  '
     C     S1DO          ANDEQ     *ON
     C                   MOVE      *ON           @CHG
E1   C                   ENDIF
      *
      * Restore saved indicators
     C                   MOVEA     S10120        *IN(01)
      *
      * If an error has occured, show that the subroutine has failed
B1   C     S18897        IFNE      *ZEROS
     C                   MOVE      'MSG1526'     X@MI
     C                   Z-ADD     7             X@ECBA
E1   C                   ENDIF
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     TS@S1O        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      * '  '=No option
     C                   SELECT
     C     S1OPT         WHENEQ    '  '
      *
      * ' /'=Select
     C     S1OPT         WHENEQ    ' /'
     C     @MSD          ANDEQ     '*S'
     C     S1@DO         IFEQ      *ON
     C                   EXSR      @SLC01
     C                   ENDIF
      *
      * ' 1'=Create 'control'
     C     S1OPT         WHENEQ    ' 1'
     C     @MSD          ANDEQ     '*M'
     C     S1@CDI        ANDEQ     *OFF
     C     S1@DO         IFEQ      *ON
     C                   EXSR      @EDT01
     C                   ENDIF
      *
      * ' 1'=Create 'detail'
     C     S1OPT         WHENEQ    ' 1'
     C     @MSD          ANDEQ     '*M'
     C     S1@CDI        ANDEQ     *ON
     C                   MOVE      'MSG1551'     X@MI
     C                   Z-ADD     7             X@ECBA
      *
      * ' 2'=Change
     C     S1OPT         WHENEQ    ' 2'
     C     @MSD          ANDEQ     '*M'
     C                   SELECT
     C     S1@DO         WHENEQ    *ON
     C                   EXSR      @EDT01
     C                   ENDSL
      *
      * ' 3'=Copy
     C     S1OPT         WHENEQ    ' 3'
     C     @MSD          ANDEQ     '*M'
     C     S1@DO         IFEQ      *ON
     C                   EXSR      @EDT01
     C                   ENDIF
      *
      * ' 4'=Delete
     C     S1OPT         WHENEQ    ' 4'
     C     @MSD          ANDEQ     '*M'
     C     S1@DO         IFEQ      *ON
     C                   EXSR      @CND01
     C                   ENDIF
      *
      * ' 5'=View
     C     S1OPT         WHENEQ    ' 5'
     C                   SELECT
     C     S1@DO         WHENEQ    *ON
     C                   EXSR      @EDT01
     C                   ENDSL
      *
      * ' 6'=Print
      ***C           S1OPT     WHEQ ' 6'
      ***C           S1@DO     IFEQ *ON
      ***C                     EXSR @PRT01
      ***C                     ENDIF
      *
      * ' 7'=Rename
     C     S1OPT         WHENEQ    ' 7'
     C     @MSD          ANDEQ     '*M'
     C     S1@DO         IFEQ      *ON
     C                   EXSR      @EDT01
     C                   ENDIF
      *
      *     =Invalid option
     C                   OTHER
     C                   MOVE      'CPD6A7C'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   ENDSL
      *
      * Turn off 'action this option'
     C                   MOVE      *OFF          S1@DO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @SLC01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      'f?>E@'       KY@DIR
     C                   EXSR      PR@KY
     C                   MOVE      ' /'          I@FKY
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @F4L01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      *
B1   C                   SELECT
      *
      * List panel
W1   C     D@CRCD        WHENEQ    'C1PNL01'
      *
      *
B2   C                   SELECT
      *
      * _Search key short name
W2   C     D@CFLD        WHENEQ    'C1SKSN'
     C     C1(01)        ANDNE     ':'
     C                   EXSR      @SSS01
B3   C     I@FKY         IFEQ      *BLANKS
     C                   MOVE      C1SSGT        C1SKSN
E3   C                   ENDIF
      *
      * _Supplier no.
W2   C     D@CFLD        WHENEQ    'C1SUPN'
     C     C1(02)        ANDNE     ':'
     C                   CALL      'SO1730'      SO1730                 98
B3   C                   SELECT
W3   C     *IN98         WHENEQ    *ON
     C                   MOVE      *ON           *IN96
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1838'     X@MI
W3   C     I@FKY         WHENEQ    *BLANKS
     C                   MOVE      X@SUPN        C1SUPN
E3   C                   ENDSL
      *
      * _Imprint no.
W2   C     D@CFLD        WHENEQ    'C1IMPN'
     C     C1(03)        ANDNE     ':'
     C                   CALL      'SO1710'      SO1710                 98
B3   C                   SELECT
W3   C     *IN98         WHENEQ    *ON
     C                   MOVE      *ON           *IN95
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1838'     X@MI
W3   C     I@FKY         WHENEQ    *BLANKS
     C                   MOVE      X@SUPN        C1IMPN
E3   C                   ENDSL
      *
      * _Cursor location is invalid for F4=List
W2   C                   OTHER
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1839'     X@MI
E2   C                   ENDSL
      *
      * Subfile 'control' record
W1   C     D@CRCD        WHENEQ    'S1SFL01'
      ***C           D@SCRR    ANDEQ1
      *
      * No fields are valid, force to '..location is invalid...'
B2   C                   SELECT
W2   C     D@CFLD        WHENNE    D@CFLD
      *
      * _Cursor location is invalid for F4=List
W2   C                   OTHER
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1839'     X@MI
E2   C                   ENDSL
      *
      * Edit panel
W1   C     D@CRCD        WHENEQ    'D1PNL01'
      *
      *
B2   C                   SELECT
      *
      * _Supplier no.
W2   C     D@CFLD        WHENEQ    'BLSUPN'
     C     D1(03)        ANDNE     ':'
     C                   CALL      'SO1730'      SO1730                 98
B3   C                   SELECT
W3   C     *IN98         WHENEQ    *ON
     C                   MOVE      *ON           *IN96
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1838'     X@MI
W3   C     I@FKY         WHENEQ    *BLANKS
     C                   MOVE      X@SUPN        C1SUPN
E3   C                   ENDSL
      *
      * _Imprint no.
W2   C     D@CFLD        WHENEQ    'BLIMPN'
     C     D1(04)        ANDNE     ':'
     C                   CALL      'SO1710'      SO1710                 98
B3   C                   SELECT
W3   C     *IN98         WHENEQ    *ON
     C                   MOVE      *ON           *IN95
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1838'     X@MI
W3   C     I@FKY         WHENEQ    *BLANKS
     C                   MOVE      X@SUPN        C1IMPN
E3   C                   ENDSL
      *
      * _Cursor location is invalid for F4=List
W2   C                   OTHER
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1839'     X@MI
E2   C                   ENDSL
      *
      * Cursor location is invalid for F4=List
W1   C                   OTHER
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1839'     X@MI
E1   C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     PR@KY         BEGSR
      *-------------------------------------------------------------------------
      *
      * Find F1 file access sequence
      /free
       f1@sq = SO1710_GetListFileSequence;
      /end-free
      *
      *
B1   C                   SELECT
      *
      *
W1   C     KY@DIR        WHENEQ    'E@>C1'
      /free
       C1SKSN = e_Shortname;
       C1SUPN = e_SupplierNumber;
       C1IMPN = e_ImprintNumber;
       C1DLTD = e_DeletedStatus;
      /end-free
      *
      *
W1   C     KY@DIR        WHENEQ    'C1>V1'
      *
B2   C                   SELECT
W2   C     C1SKSN        WHENEQ    '*ALL'
     C                   MOVE      *BLANKS       V1SKSN
W2   C     C1SKSN        WHENEQ    '*BLANKS'
     C                   MOVE      *BLANKS       V1SKSN
W2   C                   OTHER
     C     ' *'          CHECKR    C1SKSN        I                        99
B3   C     *IN99         IFEQ      *ON
     C     I             SUBST(P)  C1SKSN:1      V1SKSN
X3   C                   ELSE
     C                   MOVE      C1SKSN        V1SKSN
E3   C                   ENDIF
E2   C                   ENDSL
      *
     C                   MOVE      C1SUPN        V1SUPN
      *
     C                   MOVE      C1IMPN        V1IMPN
     C                   MOVE      V1IMPN        IPIMPN
     C                   EXSR      @RTIP
     C                   MOVE      IPISBP        V1ISBP
      *
B2   C                   SELECT
W2   C     C1DLTD        WHENEQ    '*'
     C                   MOVE      *BLANKS       V1DLTD
W2   C     C1DLTD        WHENEQ    'O'
     C                   MOVE      '*'           V1DLTD
W2   C     C1DLTD        WHENEQ    'N'
     C                   MOVE      *BLANKS       V1DLTD
E2   C                   ENDSL
      *
      *
W1   C     KY@DIR        WHENEQ    'V1>F1'
      *
     C     #NRKEY        OCCUR     F1AK
     C                   CLEAR                   F1AK
     C                   MOVE      V1SKSN        F1SKSN
     C                   MOVE      V1SUPN        F1SUPN
     C     #INKEY        OCCUR     F1AK
     C                   MOVE      V1SKSN        F1SKSN
     C                   MOVE      V1SUPN        F1SUPN
     C                   MOVEL(P)  V1ISBP        F1ISBN
      *
      *
W1   C     KY@DIR        WHENEQ    'C1>M1'
     C                   MOVE      C1SKSN        M1SKSN
     C                   MOVE      C1SUPN        M1SUPN
     C                   MOVE      C1IMPN        M1IMPN
     C                   MOVE      C1DLTD        M1DLTD
      *
      *
W1   C     KY@DIR        WHENEQ    'M1>C1'
     C                   MOVE      M1SKSN        C1SKSN
     C                   MOVE      M1SUPN        C1SUPN
     C                   MOVE      M1IMPN        C1IMPN
     C                   MOVE      M1DLTD        C1DLTD
      *
      * Code values here for defaults if required.
W1   C     KY@DIR        WHENEQ    'V1>f?'
     C                   MOVE      V1SUPN        BLSUPN
     C                   MOVE      V1IMPN        BLIMPN
      *
      *
      /free
       when KY@DIR = 'f?>E@';
         e_ISBN = BLISBN;
      /end-free
      *
      *
W1   C     KY@DIR        WHENEQ    'F1>f?'
      *
      *   Primary (unique) keys
     C                   MOVE      F1ISBN        BLISBN
      *   Secondary/Alternative sequence keys
     C                   MOVE      F1SUPN        BLSUPN
     C                   MOVE      F1SKSN        BLSKSN
      *
      *
W1   C     KY@DIR        WHENEQ    'f?>F1'
      *
      *   Primary (unique) keys
     C                   MOVE      BLISBN        F1ISBN
      *   Secondary/Alternative sequence keys
     C                   MOVE      BLSUPN        F1SUPN
     C                   MOVE      BLSKSN        F1SKSN
      *
      *
W1   C     KY@DIR        WHENEQ    'AK:AK'
      *
      *
B2   C     E1            DO        O1            I
      *
      *
B3   C     AK(I)         IFEQ      *LOVAL
     C                   MOVE      *LOVAL        PK(I)
X3   C                   ELSE
     C                   MOVE      AK(I)         F1AK
      *
      * File sequence 1
B4   C                   SELECT
W4   C     F1@SQ         WHENEQ    1
     C                   MOVE      F1@CDI        R1@CDI
     C                   MOVE      F1@IOP        R1@IOP
      *
     C                   MOVE      F1ISBN        R1ISBN
     C                   MOVE      F1SKSN        R1SKSN
     C                   MOVE      F1SUPN        R1SUPN
      *
     C                   MOVE      F1R1          AK(I)
      *
      *   File sequence 2
W4   C     F1@SQ         WHENEQ    2
     C                   MOVE      F1@CDI        R2@CDI
     C                   MOVE      F1@IOP        R2@IOP
      *
     C                   MOVE      F1SUPN        R2SUPN
     C                   MOVE      F1SKSN        R2SKSN
     C                   MOVE      F1ISBN        R2ISBN
      *
     C                   MOVE      F1R2          AK(I)
      *
      *   File sequence 3
W4   C     F1@SQ         WHENEQ    3
     C                   MOVE      F1@CDI        R3@CDI
     C                   MOVE      F1@IOP        R3@IOP
      *
     C                   MOVE      F1SKSN        R3SKSN
     C                   MOVE      F1ISBN        R3ISBN
     C                   MOVE      F1SUPN        R3SUPN
      *
     C                   MOVE      F1R3          AK(I)
      *
      *   File sequence 4
W4   C     F1@SQ         WHENEQ    4
     C                   MOVE      F1@CDI        R4@CDI
     C                   MOVE      F1@IOP        R4@IOP
      *
     C                   MOVE      F1SUPN        R4SUPN
     C                   MOVE      F1ISBN        R4ISBN
     C                   MOVE      F1SKSN        R4SKSN
      *
     C                   MOVE      F1R4          AK(I)
      *
      *
E4   C                   ENDSL
      *
      *
E3   C                   ENDIF
      *
      *
E2   C                   ENDDO
      *
      * Sort array
     C                   SORTA     AK
      *
      *
B2   C     E1            DO        O1            I
      *
      *
B3   C     AK(I)         IFEQ      *LOVAL
     C                   MOVE      *LOVAL        PK(I)
X3   C                   ELSE
      *
      *   File sequence 1
B4   C                   SELECT
W4   C     F1@SQ         WHENEQ    1
     C                   MOVE      AK(I)         F1R1
     C                   MOVE      R1@CDI        F1@CDI
     C                   MOVE      R1@IOP        F1@IOP
      *
     C                   MOVE      R1ISBN        F1ISBN
     C                   MOVE      R1SUPN        F1SUPN
     C                   MOVE      R1SKSN        F1SKSN
      *
      *
      *   File sequence 2
W4   C     F1@SQ         WHENEQ    2
     C                   MOVE      AK(I)         F1R2
     C                   MOVE      R2@CDI        F1@CDI
     C                   MOVE      R2@IOP        F1@IOP
      *
     C                   MOVE      R2SUPN        F1SUPN
     C                   MOVE      R2SKSN        F1SKSN
     C                   MOVE      R2ISBN        F1ISBN
      *
      *   File sequence 3
W4   C     F1@SQ         WHENEQ    3
     C                   MOVE      AK(I)         F1R3
     C                   MOVE      R3@CDI        F1@CDI
     C                   MOVE      R3@IOP        F1@IOP
      *
     C                   MOVE      R3SKSN        F1SKSN
     C                   MOVE      R3ISBN        F1ISBN
     C                   MOVE      R3SUPN        F1SUPN
      *
      *   File sequence 4
W4   C     F1@SQ         WHENEQ    4
     C                   MOVE      AK(I)         F1R4
     C                   MOVE      R4@CDI        F1@CDI
     C                   MOVE      R4@IOP        F1@IOP
      *
     C                   MOVE      R4SUPN        F1SUPN
     C                   MOVE      R4ISBN        F1ISBN
     C                   MOVE      R4SKSN        F1SKSN
      *
      *
E4   C                   ENDSL
      *
      *
     C                   MOVE      F1AK          AK(I)
      *
      *
B4   C     F1@CDI        IFEQ      *OFF
     C                   MOVE      *HIVAL        O1PK
     C                   MOVE      *OFF          O1@CDI
     C                   MOVE      O1PK          F1PK
E4   C                   ENDIF
     C                   MOVE      F1PK          PK(I)
      *
      *
E3   C                   ENDIF
      *
      *
E2   C                   ENDDO
      *
      * Find first non blank
     C     *LOVAL        LOOKUP    AK(E1)                             99
     C                   MOVE      *IN99         S1@S1O
B2   C     S1@S1O        IFEQ      *OFF
     C                   Z-ADD     O1            E1
E2   C                   ENDIF
      *
      *
W1   C                   OTHER
      *
      *
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1847'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
      *
      *
E1   C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @EDT01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      '*ENT'        @FMT
      *
      * Do while exit not requested
B1   C     @FMT          DOWNE     *BLANKS
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
      *
      * Retrieve file(s)
     C                   EXSR      @RTP00
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
      *
      * Get for display
     C                   EXSR      @VLP00
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
     C     @FMT          OREQ      '*UPD'
      *
      *
B3   C     @ROLL         IFNE      *BLANKS
     C                   EXSR      @RLPR
E3   C                   ENDIF
      *
      *
E2   C                   ENDIF
      *
      *
B2    ***C                     SELEC
W2    ***C           @FMT      WHEQ '*ERR'
     C                   CLEAR                   D@PROW
     C                   CLEAR                   D@PCOL
      ***C           D1#02     WHEQ ':'
      ***C           D@VPF1    ANDEQQ1
      ***C                     Z-ADD7         D@PROW
      ***C                     Z-ADD33        D@PROW
W2    ***C                     OTHER
      ***C                     Z-ADD11        D@PROW
      ***C                     Z-ADD33        D@PCOL
E2    ***C                     ENDSL
      *
      * Process display format
     C                   MOVEA     P00#01        *IN(01)
     C                   WRITE     D1HDR00
      *
      *
     C     D@VPF1        IFLT      D@MVF1
     C                   MOVE      MORE          *IN25
     C                   ELSE
     C                   MOVE      BOTTOM        *IN25
     C                   ENDIF
     C                   WRITE     D1FTR00
      *
      *
     C                   WRITE     #ERRCTL
      *
      *
B2   C                   SELECT
W2   C     D@VPF1        WHENEQ    1
      *
     C                   MOVEA     P01A60        *IN(60)
     C                   WRITE     D1PNL01A
      *
      *
     C     D@VPF1        WHENEQ    2
      *
     C                   MOVEA     P02D60        *IN(60)
     C                   WRITE     D1PNL02D
     C                   MOVEA     P02C60        *IN(60)
     C                   WRITE     C2PNL02C
     C                   MOVEA     P02B60        *IN(60)
     C                   WRITE     C2PNL02B
     C                   MOVEA     P02A60        *IN(60)
     C                   WRITE     D1PNL02A
      *
      * Multiple formats with DSPATR(PC) need the first one with
      *   an error to be the last one output to the display for
      *   it, the DSPATR(PC), to work correctly.
B3   C                   SELECT
W3   C     D@SE02        WHENEQ    2.2
     C                   MOVEA     P02B60        *IN(60)
     C                   WRITE     C2PNL02B
W3   C     D@SE02        WHENEQ    2.3
     C                   MOVEA     P02C60        *IN(60)
     C                   WRITE     C2PNL02C
W3   C     D@SE02        WHENEQ    2.4
     C                   MOVEA     P02D60        *IN(60)
     C                   WRITE     D1PNL02D
E3   C                   ENDSL
      *
      *
E2   C                   ENDSL
      *
      *
     C                   MOVE      NO            @CHG
     C                   READ      D1HDR00                                99
      *
      *
B2   C                   SELECT
W2   C     D@VPF1        WHENEQ    1
     C                   READ      D1PNL01A                               99
B3   C     *IN21         IFEQ      YES
     C                   MOVE      YES           @CHG
E3   C                   ENDIF
      *
      *
     C     D@VPF1        WHENEQ    2
     C                   READ      D1PNL02A                               99
B3   C     *IN21         IFEQ      YES
     C                   MOVE      YES           @CHG
E3   C                   ENDIF
     C                   READ      C2PNL02B                               99
B3   C     *IN21         IFEQ      YES
     C                   MOVE      YES           @CHG
E3   C                   ENDIF
     C                   READ      C2PNL02C                               99
B3   C     *IN21         IFEQ      YES
     C                   MOVE      YES           @CHG
E3   C                   ENDIF
     C                   READ      D1PNL02D                               99
B3   C     *IN21         IFEQ      YES
     C                   MOVE      YES           @CHG
E3   C                   ENDIF
      *
      *
E2   C                   ENDSL
      *
      *
     C     D@ROCL        DIV       256           D@PROW
     C                   MVR                     D@PCOL
      *
      * Set/Reset display format
     C                   MOVE      *IN22         @VCF
     C                   CLEAR                   I@FKY
     C                   CLEAR                   @FMT
B2   C                   SELECT
W2   C     *IN23         WHENEQ    *ON
     C                   MOVE      UP            @ROLL
     C                   MOVE      '*UPD'        @FMT
W2   C     *IN24         WHENEQ    *ON
     C                   MOVE      DOWN          @ROLL
     C                   MOVE      '*UPD'        @FMT
W2   C                   OTHER
     C                   CLEAR                   @ROLL
E2   C                   ENDSL
      *
      *
      ***C           @ROLL     IFEQ *BLANKS
      ***C           @ROLL     ORNE *BLANKS
      ***C           @VOR      ANDEQ*ON
     C                   CALL      'QMHRMVPM'    @RMVPM
      ***C                     ENDIF
      *
      * Test and validate display format
B2   C                   SELECT
      *
      * F3=Exit
W2   C     *INKC         WHENEQ    *ON
     C                   MOVE      'KC'          I@FKY
      *
      * F5=Refresh
W2   C     *INKE         WHENEQ    *ON
     C                   MOVE      '*CRT'        @FMT
      *
      * F12=Cancel
W2   C     *INKL         WHENEQ    *ON
      *
      * Display formats in decending order until last, then exit
B3   C     D@VPF1        IFGT      1
     C                   SUB       1             D@VPF1
     C                   MOVE      '*DSP'        @FMT
X3   C                   ELSE
     C                   MOVE      'KL'          I@FKY
E3   C                   ENDIF
      *
      * Enter, RollUp, RollDown, F4=List
W2   C     @VCF          WHENNE    *ON
     C     @ROLL         OREQ      UP
     C     @ROLL         OREQ      DOWN
     C     *INKD         OREQ      *ON
      *
      *
B3   C                   SELECT
W3   C     *INKD         WHENEQ    *ON
     C                   EXSR      @F4L01
B4   C                   SELECT
W4   C     X@ECBA        WHENNE    *ZERO
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
W4   C                   OTHER
     C                   MOVE      '*DSP'        @FMT
E4   C                   ENDSL
E3   C                   ENDSL
      *
      *
     C     @ROLL         IFEQ      *BLANKS
     C     @ROLL         ORNE      *BLANKS
     C     @VOR          ANDEQ     *ON
      *
      *
     C                   MOVE      *ON           D1DO
     C                   EXSR      @VLP00
      *
      *
     C                   ENDIF
      *
      * Details are valid
B3   C     @FMT          IFEQ      *BLANKS
      *
      * 'Details are valid, press Enter to confirm' message
B4   C     @CHG          IFEQ      YES
     C                   MOVE      'MSG1532'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*DSP'        @FMT
X4   C                   ELSE
      *
      * Perform updates
     C                   MOVE      *ON           F1@COC
     C                   EXSR      @UPF1
B5   C     X@ECBA        IFNE      *ZERO
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT
X5   C                   ELSE
E5   C                   ENDIF
      *
      *
E4   C                   ENDIF
      *
      *
E3   C                   ENDIF
      *
      * Invalid function key
W2   C                   OTHER
     C                   MOVE      'CPD6A60'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   MOVE      '*ERR'        @FMT
      *
      *
E2   C                   ENDSL
      *
      *
E1   C                   ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @RLPR         BEGSR
      *-------------------------------------------------------------------------
      *
      *
B1   C                   SELECT
W1   C     D@CRCD        WHENEQ    'C2PNL02B'
     C     D@CRCD        OREQ      'S2SFL02B'
B2   C     @ROLL         IFEQ      UP
     C     S1OPT         ANDNE     ' 5'
     C     P02BRR        ANDLT     50
     C                   Z-ADD     P02BRR        D@RR
     C     D@RR          CHAIN     S2SFL02B                           99
B3   C     S2TAGC        IFNE      *ZERO
     C     P02BRR        ADD       1             P02BRN
     C                   Z-ADD     4             D@PTF
     C                   EXSR      @FBF2
     C                   CLEAR                   @ROLL
     C                   Z-ADD     2.2           D@SE02
E3   C                   ENDIF
E2   C                   ENDIF
      *
      *
W1   C     D@CRCD        WHENEQ    'S2PNL02C'
     C     D@CRCD        OREQ      'S2SFL02C'
B2   C     @ROLL         IFEQ      UP
     C     S1OPT         ANDNE     ' 5'
     C     P02CRR        ANDLT     50
     C                   Z-ADD     P02CRR        D@RR
     C     D@RR          CHAIN     S2SFL02C                           99
      ***C                   ENDIF
B3   C     S2TAGC        IFNE      *ZERO
     C     P02CRR        ADD       1             P02CRN
     C                   Z-ADD     2             D@PTF
     C                   EXSR      @FBF3
     C                   CLEAR                   @ROLL
     C                   Z-ADD     2.3           D@SE02
E3   C                   ENDIF
E2   C                   ENDIF
      *
      *
E1   C                   ENDSL
      *
      * Already at bottom of area
B1   C                   SELECT
W1   C     @ROLL         WHENEQ    UP
B2   C     D@VPF1        IFGE      D@MVF1
     C                   MOVE      'CPD6A69'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   Z-ADD     D@MVF1        D@VPF1
X2   C                   ELSE
     C                   ADD       1             D@VPF1
E2   C                   ENDIF
      *
      * Already at top of area
W1   C     @ROLL         WHENEQ    DOWN
B2   C     D@VPF1        IFEQ      1
     C                   MOVE      'CPD6A66'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
X2   C                   ELSE
     C                   SUB       1             D@VPF1
E2   C                   ENDIF
E1   C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @RTP00        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      *ZEROS        P00#01
     C                   MOVEA     P00#01        *IN(01)
     C                   MOVE      *ZEROS        P00#88
     C                   MOVEA     P00#88        *IN(88)
      *
      * Setup mode, F6=Create
B1   C                   SELECT
W1   C     S1OPT         WHENEQ    'KF'
     C                   MOVE      *OFF          *IN01
     C                   MOVE      *OFF          *IN02
     C                   MOVEA     *ALL'.'       D1
      *
      * 1=Create
W1   C     S1OPT         WHENEQ    ' 1'
     C                   MOVE      *ON           *IN01
     C                   MOVE      *OFF          *IN02
     C                   MOVEA     *ALL'.'       D1
     C                   MOVE      ':'           D1(01)
      *
      * 2=Change
W1   C     S1OPT         WHENEQ    ' 2'
     C                   MOVE      *ON           *IN01
     C                   MOVE      *OFF          *IN02
     C                   MOVEA     *ALL'.'       D1
     C                   MOVE      ':'           D1(01)
      *
      * 3=Copy
W1   C     S1OPT         WHENEQ    ' 3'
     C                   MOVE      *OFF          *IN01
     C                   MOVE      *OFF          *IN02
     C                   MOVEA     *ALL'.'       D1
      *
      * 5=View
W1   C     S1OPT         WHENEQ    ' 5'
     C                   MOVE      *ON           *IN01
     C                   MOVE      *ON           *IN02
     C                   MOVEA     *ALL':'       D1
      *
      * 7=Rename
W1   C     S1OPT         WHENEQ    ' 7'
     C                   MOVE      *OFF          *IN01
     C                   MOVE      *ON           *IN02
     C                   MOVEA     *ALL':'       D1
     C                   MOVE      '.'           D1(01)
      *
      *
E1   C                   ENDSL
      *
      *
     C                   EXSR      RT@F1
B1   C     X@ECBA        IFNE      *ZERO
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT
     C                   MOVE      *ON           *IN01
     C                   MOVE      *ON           *IN02
     C                   MOVEA     *ALL':'       D1
E1   C                   ENDIF
      *
      *
     C                   MOVEA     *IN(01)       P00#01
     C                   MOVEA     *IN(88)       P00#88
      *
      *
     C                   Z-ADD     1             D@VPF1
      *
      * Get all titles
     C                   EXSR      RT@F2
      *
      * Get all authors.
     C                   EXSR      RT@F3
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VLP00        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   D@SE00
      *
      *---
      *
     C                   CLEAR                   D@SE01
     C                   CLEAR                   @FMT01
      *
      *
     C                   EXSR      @VP01A
B1   C     @FMT01        IFEQ      '*ERR'
     C     D@SE01        ANDEQ     *ZERO
     C                   Z-ADD     1.1           D@SE01
     C                   MOVE      @FMT01        @FMT
E1   C                   ENDIF
      *
      *
     C     D@SE00        IFEQ      *ZERO
     C                   Z-ADD     D@SE01        D@SE00
     C                   ENDIF
      *
      *---
      *
     C                   CLEAR                   D@SE02
     C                   CLEAR                   @FMT02
      *
      *
     C                   EXSR      @VP02A
B1   C     @FMT02        IFEQ      '*ERR'
     C     D@SE02        ANDEQ     *ZERO
     C                   Z-ADD     2.1           D@SE02
     C                   MOVE      @FMT02        @FMT
E1   C                   ENDIF
      *
      *
     C                   EXSR      @VP02B
B1   C     @FMT02        IFEQ      '*ERR'
     C     D@SE02        ANDEQ     *ZERO
     C                   Z-ADD     2.2           D@SE02
     C                   MOVE      @FMT02        @FMT
E1   C                   ENDIF
      *
      *
     C                   EXSR      @VP02C
B1   C     @FMT02        IFEQ      '*ERR'
     C     D@SE02        ANDEQ     *ZERO
     C                   Z-ADD     2.3           D@SE02
     C                   MOVE      @FMT02        @FMT
E1   C                   ENDIF
      *
      *
     C                   EXSR      @VP02D
B1   C     @FMT02        IFEQ      '*ERR'
     C     D@SE02        ANDEQ     *ZERO
     C                   Z-ADD     2.4           D@SE02
     C                   MOVE      @FMT02        @FMT
E1   C                   ENDIF
      *
      *
     C     D@SE00        IFEQ      *ZERO
     C                   Z-ADD     D@SE02        D@SE00
     C                   ENDIF
      *
      *---
      *
     C     D@SE00        IFNE      *ZERO
     C                   Z-ADD     D@SE00        D@VPF1
     C                   ENDIF
      *
      *
     C                   MOVE      *OFF          D1DO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VP01A        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      *ZEROS        P01A60
     C                   MOVEA     P01A60        *IN(60)
      *
      * Special as @RTP00 does some pre-validation.
     C                   MOVEA     P00#88        *IN(88)
      *
      *
B1   C     BLISBN        IFEQ      *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(01)        ANDEQ     '.'
     C                   MOVE      'MSG1546'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT01
X1   C                   ELSE
      *
      *
     C                   MOVE      *ON           F1@COC
     C                   EXSR      RT@F1
B2   C     X@ECBA        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT01
     C                   MOVE      *ON           *IN01
     C                   MOVE      *ON           *IN02
     C                   MOVEA     *ALL':'       D1
E2   C                   ENDIF
      *
      *
     C                   MOVEA     *IN(60)       P01A60
     C                   MOVEL(P)  F1DS          F@DS
     C                   MOVE      *ON           F1@TE
     C                   EXSR      TS@F1O
B2   C     X@ECBA        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C     D1(01)        ANDEQ     '.'
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT01
E2   C                   ENDIF
     C                   MOVEL(P)  F@DS          F1DS
      *
      *
E1   C                   ENDIF
      *
      *
B1   C     BLDLTD        IFNE      *BLANKS
     C                   MOVE      '*Dlt'        D1DLTD
X1   C                   ELSE
     C                   CLEAR                   D1DLTD
E1   C                   ENDIF
      *
      * Get supplier
     C                   MOVE      BLSUPN        ESUPN4
     C                   EXSR      @RTES
B1   C     X@ECBA        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C     D1(02)        ANDEQ     '.'
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN96
     C                   MOVE      '*ERR'        @FMT01
E1   C                   ENDIF
      *
      * Get imprint
     C                   MOVE      BLIMPN        IPIMPN
     C                   EXSR      @RTIP
B1   C     X@ECBA        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C     D1(03)        ANDEQ     '.'
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT01
E1   C                   ENDIF
      *
      * 130-Title
B1   C     D1FTTL        IFEQ      *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(04)        ANDEQ     '.'
     C                   MOVE      'MSG1567'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN94
     C                   MOVE      '*ERR'        @FMT01
E1   C                   ENDIF
      *
      * 130-Title continuation indicator
B1   C     D1CI01        IFNE      '*'
     C     D1CI01        ANDNE     '.'
     C     D1DO          ANDEQ     *ON
     C     D1(05)        ANDEQ     '.'
     C                   MOVE      'MSG1566'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN93
     C                   MOVE      '*ERR'        @FMT01
E1   C                   ENDIF
      *
      * Get binding
     C                   MOVE      BLBIND        BNBIND
     C                   EXSR      @RTBN
B1   C     X@ECBA        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C     D1(06)        ANDEQ     '.'
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN92
     C                   MOVE      '*ERR'        @FMT01
E1   C                   ENDIF
      *
      * 100-Author
B1   C     D1FATN        IFEQ      *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(07)        ANDEQ     '.'
     C                   MOVE      'MSG1568'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN91
     C                   MOVE      '*ERR'        @FMT01
E1   C                   ENDIF
      *
      * 100-Author continuation indicator
B1   C     D1CI02        IFNE      '*'
     C     D1CI02        ANDNE     '.'
     C     D1DO          ANDEQ     *ON
     C     D1(08)        ANDEQ     '.'
     C                   MOVE      'MSG1566'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN90
     C                   MOVE      '*ERR'        @FMT01
E1   C                   ENDIF
      *
      *
     C                   MOVEA     *IN(60)       P01A60
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VP02A        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      *ZEROS        P02A60
     C                   MOVEA     P02A60        *IN(60)
      *
      * Published date
      ***C
      *
      * Reprint date
      ***C
     C     D1RPDT        IFNE      *BLANKS
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT02
     C                   ENDIF
      *
      *
     C                   MOVEA     *IN(60)       P02A60
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VP02B        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      *ZEROS        P02B60
     C                   MOVEA     P02B60        *IN(60)
      *
      *
     C                   MOVEA     *IN(60)       P02B60
      *
      * Title(s)
     C                   EXSR      @VS02B
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VS02B        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   P02BSR
      *
      *
     C                   READC     S2SFL02B                               21
      *
      * If records changed, force "header file" into changed state.
     C     *IN21         IFEQ      *ON
     C                   MOVEL(P)  '*CURRENT'    X@IDF
     C                   EXSR      @DTDTS
     C                   MOVE      @DT           BLEDTS
     C                   ENDIF
      *
      *
B1   C     *IN21         DOWEQ     *OFF
     C                   MOVEA     S02B01        *IN(01)
     C                   MOVE      *ZEROS        S02B80
     C                   MOVEA     S02B80        *IN(80)
      *
      *
     C                   MOVE      *ON           S2CHG
      *
      * If no MARC tag, all fields must be empty
B2   C     S2TAGC        IFEQ      *ZERO
      *
      *
B3   C     S2SEQN        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C                   MOVE      'MSG1569'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN96
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      *
B3   C     S2FTTL        IFNE      *BLANKS
     C     S2FTTL        ANDNE     '*BLANK'
     C     D1DO          ANDEQ     *ON
     C     D1(11)        ANDEQ     '.'
     C                   MOVE      'MSG1570'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      *
B3   C     S2CI          IFNE      *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(12)        ANDEQ     '.'
     C                   MOVE      'MSG1571'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN94
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      *
X2   C                   ELSE
      *
      * MARC tag
     C                   MOVE      S2TAGC        MTTAGC
     C                   EXSR      @RTMT
B3   C     X@ECBA        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      * MARC tag is not a valid 'Title' tag
B3   C     MTTGTP        IFNE      'TI'
     C     D1DO          ANDEQ     *ON
     C                   MOVE      'MSG1574'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      * Sequence must be zero when tag is non repeatable.
B3   C     MTTGIR        IFNE      'Y'
     C     S2SEQN        ANDNE     *ZERO
     C     D1DO          ANDEQ     *ON
     C     *IN10         ANDEQ     *OFF
     C                   MOVE      'MSG1573'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN96
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      * Title
B3   C                   SELECT
W3   C     S2FTTL        WHENEQ    *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(11)        ANDEQ     '.'
     C     *IN10         ANDEQ     *OFF
     C                   MOVE      'MSG1567'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT02
      *
      * Title
W3   C     S2FTTL        WHENEQ    *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(11)        ANDEQ     '.'
     C                   MOVE      'MSG1572'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDSL
      *
      * Title continuation indicator
B3   C     S2CI          IFNE      '*'
     C     S2CI          ANDNE     '.'
     C     D1DO          ANDEQ     *ON
     C     D1(12)        ANDEQ     '.'
     C                   MOVE      'MSG1566'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN94
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      *
E2   C                   ENDIF
      *
      *
      *
      *
     C                   MOVEA     *IN(80)       S02B80
B2   C     S02B80        IFNE      *ZEROS
     C                   MOVE      *OFF          *IN(09)
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *OFF          S2NEF
     C                   MOVE      *ON           *IN(21)
B3   C     P02BSR        IFEQ      *ZERO
     C                   Z-ADD     D@RR          P02BSR
E3   C                   ENDIF
X2   C                   ELSE
      *
      *
     C     D@RR          DIV       P02BSP        I
     C                   MVR                     I
B3   C     I             IFLE      1
     C                   MOVE      *ON           *IN09
E3   C                   ENDIF
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *ON           S2NEF
      *
      *
E2   C                   ENDIF
      *
      *
     C                   MOVEA     *IN(01)       S02B01
     C                   UPDATE    S2SFL02B
      *
      *
     C                   Z-ADD     D@RR          I
     C                   MOVE      S2KD          S2TI(I)
     C                   MOVE      YES           @CHG
      *
      *
     C                   READC     S2SFL02B                               21
E1   C                   ENDDO
      *
      *
B1   C     P02BSR        IFEQ      *ZERO
      *
      * Setup from PNL01A
     C                   CLEAR                   S2KD
     C                   Z-ADD     130           S2TAGC
     C                   MOVE      D1CI01        S2CI
      *
      *
     C                   CLEAR                   S2
     C                   CLEAR                   I
     C                   Z-ADD     50            E2
B2   C     I             DOUEQ     P02BRR
      ***C                     ADD  1         I
      *
      *
     C     I             IFGT      *ZERO
     C                   MOVE      S2TI(I)       S2KD
     C                   ENDIF
B3   C     S2TAGC        IFNE      *ZERO
      *
      *
     C                   Z-ADD     E2            J
     C     S2KY          LOOKUP    S2(J)                                  99
B4   C                   SELECT
W4   C     *IN99         WHENEQ    *ON
      *
      *
W4   C     *IN99         WHENEQ    *OFF
      *
      *
     C                   SUB       1             E2
     C                   Z-ADD     E2            J
     C                   MOVE      S2KY          S2(J)
      *
      *
E4   C                   ENDSL
      *
      *
     C                   MOVE      *OFF          *IN99
     C                   MOVE      S2CI          T1CI
      *
      *
     C     I             ADD       1             K
B4   C     K             DOWLE     P02BRR
     C     *IN99         ANDEQ     *OFF
     C                   MOVE      S2TI(K)       S2KD
B5   C                   SELECT
W5   C     T1CI          WHENEQ    '.'
     C     S2KY          ANDEQ     S2(J)
     C     S2CI          ANDEQ     '*'
     C                   MOVE      *ON           *IN99
W5   C     T1CI          WHENEQ    '*'
     C     S2KY          ANDEQ     S2(J)
     C                   MOVE      *ON           *IN99
E5   C                   ENDSL
     C                   ADD       1             K
E4   C                   ENDDO
      *
      *
B4   C     *IN99         IFEQ      *OFF
     C     T1CI          ANDEQ     '.'
     C     *IN99         OREQ      *ON
     C     T1CI          ANDEQ     '*'
      *
      *
B4   C                   SELECT
W4   C     T1CI          WHENEQ    '.'
     C                   MOVE      'MSG1589'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
W4   C     T1CI          WHENEQ    '*'
     C                   MOVE      'MSG1588'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
E4   C                   ENDSL
      *
      *
B5   C                   SELECT
W5   C     I             WHENEQ    *ZERO
      *
      * Process error indicators for PNL01A
     C                   MOVEA     P01A60        *IN(60)
     C                   MOVE      *ON           *IN93
     C                   MOVE      '*ERR'        @FMT02
     C                   MOVEA     *IN(60)       P01A60
     C     1.1           IFLT      D@SE01
     C     D@SE01        OREQ      *ZERO
     C                   Z-ADD     1.1           D@SE01
     C                   ENDIF
     C     1.1           IFLT      D@SE00
     C     D@SE00        OREQ      *ZERO
     C                   Z-ADD     1.1           D@SE00
     C                   ENDIF
      *
      * Process error indicators for PNL02C
W5   C     I             WHENGT    *ZERO
      *
      *
     C     I             CHAIN     S2SFL02B                           99
     C                   MOVEA     S02B01        *IN(01)
     C                   MOVEA     S02B80        *IN(80)
      *
      *
     C                   MOVE      *ON           *IN94
     C                   MOVE      '*ERR'        @FMT02
      *
      *
     C                   MOVEA     *IN(80)       S02B80
     C                   MOVE      *ON           *IN(21)
B6   C     P02BSR        IFEQ      *ZERO
     C                   Z-ADD     I             P02BSR
E6   C                   ENDIF
      *
      *
     C                   MOVE      *OFF          *IN(09)
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *OFF          S2NEF
     C                   MOVEA     *IN(01)       S02B01
     C                   UPDATE    S2SFL02B
      *
      *
     C                   MOVE      S2KD          S2TI(I)
      *
      *
     C                   MOVE      YES           @CHG
      *
      *
     C                   Z-ADD     I             T1I
      ***C                     EXSR @I902C
     C                   Z-ADD     T1I           I
      *
      *
E5   C                   ENDSL
      *
      *
E4   C                   ENDIF
      *
      *
E3   C                   ENDIF
      *
      *
     C                   ADD       1             I
E2   C                   ENDDO
      *
      *
E1   C                   ENDIF
      *
      *
B1   C     P02BSR        IFNE      *ZERO
     C                   Z-ADD     P02BSR        P02BRN
X1   C                   ELSE
B2   C     P02BSC        IFLE      P02BRR
     C                   Z-ADD     P02BSC        P02BRN
E2   C                   ENDIF
B2   C     P02BRN        IFEQ      *ZERO
     C                   Z-ADD     1             P02BRN
E2   C                   ENDIF
E1   C                   ENDIF
      *
      *
     C                   ENDSR
      *
      *
      *-------------------------------------------------------------------------
     C     @VP02C        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      *ZEROS        P02C60
     C                   MOVEA     P02C60        *IN(60)
      *
      *
     C                   MOVEA     *IN(60)       P02C60
      *
      * Author(s)
     C                   EXSR      @VS02C
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VS02C        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   P02CSR
      *
      *
     C                   READC     S2SFL02C                               21
      *
      * If records changed, force "header file" into changed state.
     C     *IN21         IFEQ      *ON
     C                   MOVEL(P)  '*CURRENT'    X@IDF
     C                   EXSR      @DTDTS
     C                   MOVE      @DT           BLEDTS
     C                   ENDIF
      *
      *
B1   C     *IN21         DOWEQ     *OFF
     C                   MOVEA     S02C01        *IN(01)
     C                   MOVE      *ZEROS        S02C80
     C                   MOVEA     S02C80        *IN(80)
      *
      *
     C                   MOVE      *ON           S2CHG
      *
      * If no MARC tag, all fields must be empty
B2   C     S2TAGC        IFEQ      *ZERO
      *
      *
B3   C     S2SEQN        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C                   MOVE      'MSG1569'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN96
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      *
B3   C     S2FATN        IFNE      *BLANKS
     C     S2FATN        ANDNE     '*BLANK'
     C     D1DO          ANDEQ     *ON
     C     D1(11)        ANDEQ     '.'
     C                   MOVE      'MSG1575'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      *
B3   C     S2CI          IFNE      *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(12)        ANDEQ     '.'
     C                   MOVE      'MSG1571'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN94
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      *
X2   C                   ELSE
      *
      * MARC tag
     C                   MOVE      S2TAGC        MTTAGC
     C                   EXSR      @RTMT
B3   C     X@ECBA        IFNE      *ZERO
     C     D1DO          ANDEQ     *ON
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      * MARC tag is not a valid 'Author' tag
B3   C     MTTGTP        IFNE      'AU'
     C     D1DO          ANDEQ     *ON
     C                   MOVE      'MSG1576'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      * Sequence must be zero when tag is non repeatable.
B3   C     MTTGIR        IFNE      'Y'
     C     S2SEQN        ANDNE     *ZERO
     C     D1DO          ANDEQ     *ON
     C     *IN10         ANDEQ     *OFF
     C                   MOVE      'MSG1573'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN96
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      * Author
B3   C                   SELECT
W3   C     S2FATN        WHENEQ    *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(11)        ANDEQ     '.'
     C     *IN10         ANDEQ     *OFF
     C                   MOVE      'MSG1568'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT02
      *
      * Author
W3   C     S2FATN        WHENEQ    *BLANKS
     C     D1DO          ANDEQ     *ON
     C     D1(11)        ANDEQ     '.'
     C                   MOVE      'MSG1577'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN95
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDSL
      *
      * Author continuation indicator
B3   C     S2CI          IFNE      '*'
     C     S2CI          ANDNE     '.'
     C     D1DO          ANDEQ     *ON
     C     D1(12)        ANDEQ     '.'
     C                   MOVE      'MSG1566'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN94
     C                   MOVE      '*ERR'        @FMT02
E3   C                   ENDIF
      *
      *
E2   C                   ENDIF
      *
      *
     C                   MOVEA     *IN(80)       S02C80
B2   C     S02C80        IFNE      *ZEROS
     C                   MOVE      *OFF          *IN09
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *OFF          S2NEF
     C                   MOVE      *ON           *IN(21)
B3   C     P02CSR        IFEQ      *ZERO
     C                   Z-ADD     D@RR          P02CSR
E3   C                   ENDIF
X2   C                   ELSE
      *
      *
     C     D@RR          DIV       P02CSP        I
     C                   MVR                     I
B3   C     I             IFLE      1
     C                   MOVE      *ON           *IN09
E3   C                   ENDIF
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *ON           S2NEF
      *
      *
E2   C                   ENDIF
      *
      *
     C                   MOVEA     *IN(01)       S02C01
     C                   UPDATE    S2SFL02C
      *
      *
     C                   Z-ADD     D@RR          I
     C                   MOVE      S2KD          S2AU(I)
     C                   MOVE      YES           @CHG
      *
      *
     C                   MOVE      *OFF          @NSU
     C                   EXSR      @I902C
      *
      *
     C                   READC     S2SFL02C                               21
E1   C                   ENDDO
      *
      *
B1   C     P02CSR        IFEQ      *ZERO
      *
      * Setup from PNL01A
     C                   CLEAR                   S2KD
     C                   Z-ADD     100           S2TAGC
     C                   MOVE      D1CI02        S2CI
      *
      *
     C                   CLEAR                   S2
     C                   CLEAR                   I
     C                   Z-ADD     50            E2
B2   C     I             DOUGT     P02CRR
      ***C                     ADD  1         I
      *
      *
     C     I             IFGT      *ZERO
     C                   MOVE      S2AU(I)       S2KD
     C                   ENDIF
B3   C     S2TAGC        IFNE      *ZERO
      *
      *
     C                   Z-ADD     E2            J
     C     S2KY          LOOKUP    S2(J)                                  99
B4   C                   SELECT
W4   C     *IN99         WHENEQ    *ON
      *
      *
W4   C     *IN99         WHENEQ    *OFF
      *
      *
     C                   SUB       1             E2
     C                   Z-ADD     E2            J
     C                   MOVE      S2KY          S2(J)
      *
      *
E4   C                   ENDSL
      *
      *
     C                   MOVE      *OFF          *IN99
     C                   MOVE      S2CI          T1CI
      *
      *
     C     I             ADD       1             K
B4   C     K             DOWLE     P02CRR
     C     *IN99         ANDEQ     *OFF
     C                   MOVE      S2AU(K)       S2KD
B5   C                   SELECT
W5   C     T1CI          WHENEQ    '.'
     C     S2KY          ANDEQ     S2(J)
     C     S2CI          ANDEQ     '*'
     C                   MOVE      *ON           *IN99
W5   C     T1CI          WHENEQ    '*'
     C     S2KY          ANDEQ     S2(J)
     C                   MOVE      *ON           *IN99
E5   C                   ENDSL
     C                   ADD       1             K
E4   C                   ENDDO
      *
      *
B4   C     *IN99         IFEQ      *OFF
     C     T1CI          ANDEQ     '.'
     C     *IN99         OREQ      *ON
     C     T1CI          ANDEQ     '*'
      *
      *
B5   C                   SELECT
W5   C     T1CI          WHENEQ    '.'
     C                   MOVE      'MSG1589'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
W5   C     T1CI          WHENEQ    '*'
     C                   MOVE      'MSG1588'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
E5   C                   ENDSL
      *
      *
B5   C                   SELECT
W5   C     I             WHENEQ    *ZERO
      *
      * Process error indicators for PNL01A
     C                   MOVEA     P01A60        *IN(60)
     C                   MOVE      *ON           *IN90
     C                   MOVE      '*ERR'        @FMT02
     C                   MOVEA     *IN(60)       P01A60
     C     1.1           IFLT      D@SE01
     C     D@SE01        OREQ      *ZERO
     C                   Z-ADD     1.1           D@SE01
     C                   ENDIF
     C     1.1           IFLT      D@SE00
     C     D@SE00        OREQ      *ZERO
     C                   Z-ADD     1.1           D@SE00
     C                   ENDIF
      *
      * Process error indicators for PNL02C
W5   C     I             WHENGT    *ZERO
      *
      *
     C     I             CHAIN     S2SFL02C                           99
     C                   MOVEA     S02C01        *IN(01)
     C                   MOVEA     S02C80        *IN(80)
      *
      *
     C                   MOVE      *ON           *IN94
     C                   MOVE      '*ERR'        @FMT02
      *
      *
     C                   MOVEA     *IN(80)       S02C80
     C                   MOVE      *ON           *IN(21)
B6   C     P02CSR        IFEQ      *ZERO
     C                   Z-ADD     I             P02CSR
E6   C                   ENDIF
      *
      *
     C                   MOVE      *OFF          *IN(09)
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *OFF          S2NEF
     C                   MOVEA     *IN(01)       S02C01
      *
      *
     C                   UPDATE    S2SFL02C
      *
      *
     C                   MOVE      S2KD          S2AU(I)
      *
      *
     C                   MOVE      YES           @CHG
      *
      *
     C                   Z-ADD     I             T1I
     C                   MOVE      *ON           @NSU
     C                   EXSR      @I902C
     C                   Z-ADD     T1I           I
      *
      *
E5   C                   ENDSL
      *
      *
E4   C                   ENDIF
      *
      *
E3   C                   ENDIF
      *
      *
     C                   ADD       1             I
E2   C                   ENDDO
      *
      *
E1   C                   ENDIF
      *
      *
B1   C     P02CSR        IFNE      *ZERO
     C                   Z-ADD     P02CSR        P02CRN
X1   C                   ELSE
B2   C     P02CSC        IFLE      P02CRR
     C                   Z-ADD     P02CSC        P02CRN
E2   C                   ENDIF
B2   C     P02CRN        IFEQ      *ZERO
     C                   Z-ADD     1             P02CRN
E2   C                   ENDIF
E1   C                   ENDIF
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @I902C        BEGSR
      *-------------------------------------------------------------------------
      *
      * Adjust *in09=(PC) for first record on page...
     C                   Z-ADD     D@RR          T2I
      *
      * Calculate "last" record on subfile "page" for current record.
     C     D@RR          DIV       P02CSP        I
     C                   MVR                     I
B2   C     I             IFNE      *ZERO
     C     P02CSP        SUB       I             I
E2   C                   ENDIF
     C     D@RR          ADD       I             J                              'last'
      *
      * Calculate "first" record on subfile "page" for current record.
     C     J             SUB       P02CSP        I
     C     I             ADD       1             I                              'first'
      *
      *
      *
      * Read array backwards, from "last" to "first+1" subfile on "page."
      *   Test NEF for each record.
     C                   MOVE      *OFF          *IN99
B2   C     J             DOULT     I
     C                   MOVE      S2AU(J)       S2KD
B3   C     S2NEF         IFEQ      *OFF
     C                   MOVE      *ON           *IN99
E3   C                   ENDIF
     C                   SUB       1             J
E2   C                   ENDDO
      *
      *
     C                   MOVE      S2AU(I)       S2KD
      *
      * Make status of *IN09 reflect (no)errors found on page.
B2   C     *IN99         IFEQ      *ON
     C     S2I09         ANDEQ     *ON
     C     *IN99         OREQ      *OFF
     C     S2I09         ANDEQ     *OFF
      *
      *
     C     I             CHAIN     S2SFL02C                           21
     C                   MOVEA     S02C01        *IN(01)
     C                   MOVEA     S02C80        *IN(80)
     C     S02C80        IFNE      *ZEROS
     C                   MOVE      *ON           *IN21
     C                   ENDIF
B3   C     *IN99         IFEQ      *ON
     C                   MOVE      *OFF          *IN09
X3   C                   ELSE
     C                   MOVE      *ON           *IN09
E3   C                   ENDIF
     C                   MOVE      *IN09         S2I09
     C                   MOVEA     *IN(01)       S02C01
     C                   UPDATE    S2SFL02C
     C                   MOVE      S2KD          S2AU(I)
      *
      * Refresh original record processed, so its not re-read.
B3   C     T2I           IFNE      I
     C     @NSU          ANDEQ     *OFF
     C     T2I           CHAIN     S2SFL02C                           21
B4   C     *IN21         IFEQ      *OFF
     C                   MOVEA     S02C01        *IN(01)
     C                   MOVEA     S02C80        *IN(80)
B5   C     S02C80        IFNE      *ZEROS
     C                   MOVE      *ON           *IN(21)
E5   C                   ENDIF
     C                   UPDATE    S2SFL02C
E4   C                   ENDIF
E3   C                   ENDIF
      *
      *
E2   C                   ENDIF
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VP02D        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      *ZEROS        P02D60
     C                   MOVEA     P02D60        *IN(60)
      *
      *
     C     D1RPDD        IFNE      *BLANKS
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT02
     C                   ENDIF
      *
      *
     C                   MOVEA     *IN(60)       P02D60
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     RT@F2         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      *
     C                   CLEAR                   D1FTTL
     C                   CLEAR                   D1CI01
      *
      *
     C                   MOVE      *ON           *IN03
     C                   Z-ADD     1             P02BSP
     C                   Z-ADD     1             P02BSC
     C                   WRITE     C2PNL02B
      *
      *
     C                   CLEAR                   D@RR
      ***C                     CLEARTI@RR
     C                   CLEAR                   J
      *
      *
     C                   MOVE      BLISBN        EISBN3
     C                   CLEAR                   TITAGC
     C                   CLEAR                   DSEQN0
     C                   CLEAR                   TIDSQN
      *
      *
B1   C     TI@EOF        DOUEQ     *ON
      *
      *
     C                   MOVEA     D1(11)        WK002C            2
     C                   CLEAR                   S2SFL02B
     C                   MOVEA     WK002C        D1(11)
      *
      *
     C                   MOVE      *ZEROS        S02B01
     C                   MOVEA     S02B01        *IN(01)
     C                   MOVE      *ZEROS        S02B80
     C                   MOVEA     S02B80        *IN(80)
      *
      *
     C     1             SUBST     P00#01:2      *IN(02)
      *
      *
     C                   EXSR      @RTTI
      *
      * If first part of 130=Main entry, uniform title
     C                   SELECT
B2   C     X@ECBA        WHENEQ    *ZERO
W2   C     F2TAGC        ANDEQ     130
     C     F2SEQN        ANDEQ     0
     C     F2DSQN        ANDEQ     0
      *
      *
     C     1             OCCUR     D1FTTL
     C                   MOVEL     W1FTTL        D1FTTL
     C     2             OCCUR     D1FTTL
     C                   MOVEL     W1FTTL        D1FTTL
     C                   MOVE      TI@CI         D1CI01
      *
      *
W2   C     X@ECBA        WHENEQ    *ZERO
      *
      *
     C                   MOVE      *ON           *IN(10)
      *
      *
     C                   Z-ADD     F2TAGC        S2TAGC
     C                   Z-ADD     F2SEQN        S2SEQN
     C                   MOVEL     W1FTTL        S2FTTL
     C                   MOVE      TI@CI         S2CI
      *
      *
     C                   MOVE      F2TAGC        MTTAGC
     C                   EXSR      @RTMT
      *
      *
     C                   ADD       1             D@RR
     C     D@RR          DIV       P02BSP        J
     C                   MVR                     J
     C                   SELECT
     C     J             WHENNE    *ZERO
     C                   CLEAR                   S2EOF
     C     TI@EOF        WHENEQ    *OFF
     C     D@RR          ANDGT     P02BSP
     C                   MOVE      '-/+'         S2EOF
     C     TI@EOF        WHENEQ    *OFF
     C                   MOVE      ' /+'         S2EOF
     C     D@RR          WHENGT    1
     C     S1OPT         ANDEQ     ' 5'
     C     TI@EOF        ANDEQ     *ON
     C                   MOVE      '-/ '         S2EOF
     C     D@RR          WHENGT    P02BSP
     C     S1OPT         ANDNE     ' 5'
     C                   MOVE      '-/+'         S2EOF
     C     S1OPT         WHENNE    ' 5'
     C                   MOVE      ' /+'         S2EOF
     C                   OTHER
     C                   MOVE      ' / '         S2EOF
     C                   ENDSL
      *
      *
     C     D@RR          DIV       P02BSP        K
     C                   MVR                     K
     C     K             IFLE      1
     C                   MOVE      *ON           *IN09
     C                   ENDIF
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *ON           S2NEF
      *
      *
     C                   MOVEA     *IN(01)       S02B01
     C                   MOVEA     *IN(80)       S02B80
     C                   WRITE     S2SFL02B
      *
      *
     C                   Z-ADD     D@RR          K
     C                   MOVE      S2KD          S2TI(K)
      *
      *
E2   C                   ENDSL
      *
      *
E1   C                   ENDDO
      *
      *
     C                   Z-ADD     D@RR          P02BRR
      *
      *
     C                   EXSR      @FBF2
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @FBF2         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   Z-ADD     D@RR          I
      *
      *
B1   C                   SELECT
W1   C     S1OPT         WHENNE    ' 5'
     C                   ADD       3             I
W1   C     I             WHENEQ    *ZERO
     C                   Z-ADD     1             I
E1   C                   ENDSL
      *
      *
     C     I             DIV       P02BSP        J
     C                   MVR                     J
      *
      * If J is not zero then "some" more records must be added to fill.
     C     J             IFNE      *ZERO
     C     1             SUB       J             J
     C     I             ADD       J             I
     C                   ENDIF
      *
      *
     C     I             IFGT      50
     C                   Z-ADD     50            I
     C                   ENDIF
      *
      *
     C     D@RR          DOWLT     I
      *
      *
     C                   MOVEA     D1(11)        WK002C            2
     C                   CLEAR                   S2SFL02B
     C                   MOVEA     WK002C        D1(11)
      *
      *
     C                   MOVE      *ZEROS        S02B01
     C                   MOVEA     S02B01        *IN(01)
     C                   MOVE      *ZEROS        S02B80
     C                   MOVEA     S02B80        *IN(80)
      *
      *
     C     1             SUBST     P00#01:2      *IN(02)
      *
      *
     C                   ADD       1             D@RR
     C     D@RR          IFEQ      I
     C                   MOVE      *ON           TI@EOF
     C                   ELSE
     C                   MOVE      *OFF          TI@EOF
     C                   ENDIF
     C     D@RR          DIV       P02BSP        J
     C                   MVR                     J
     C                   SELECT
     C     J             WHENNE    *ZERO
     C                   CLEAR                   S2EOF
     C     TI@EOF        WHENEQ    *OFF
     C     D@RR          ANDGT     P02BSP
     C                   MOVE      '-/+'         S2EOF
     C     TI@EOF        WHENEQ    *OFF
     C                   MOVE      ' /+'         S2EOF
     C     D@RR          WHENGT    P02BSP
     C     TI@EOF        ANDEQ     *ON
     C                   MOVE      '-/ '         S2EOF
     C     D@RR          WHENGT    P02BSP
     C                   MOVE      '-/+'         S2EOF
     C                   OTHER
     C                   MOVE      ' / '         S2EOF
     C                   ENDSL
      *
      *
     C     D@RR          DIV       P02BSP        K
     C                   MVR                     K
     C     K             IFLE      1
     C                   MOVE      *ON           *IN09
     C                   ENDIF
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *ON           S2NEF
      *
      *
     C                   MOVEA     *IN(01)       S02B01
     C                   MOVEA     *IN(80)       S02B80
     C                   WRITE     S2SFL02B
      *
      *
     C                   Z-ADD     D@RR          K
     C                   MOVE      S2KD          S2TI(K)
      *
      *
     C                   ENDDO
      *
      *
     C                   Z-ADD     D@RR          P02BRR
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     RT@F3         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      *
     C                   CLEAR                   D1FATN
     C                   CLEAR                   D1CI02
      *
      *
     C                   MOVE      *ON           *IN03
     C                   Z-ADD     2             P02CSP
     C                   Z-ADD     1             P02CSC
     C                   WRITE     C2PNL02C
      *
      *
     C                   CLEAR                   D@RR
      ***C                     CLEARAU@RR
     C                   CLEAR                   J
      *
      *
     C                   MOVE      BLISBN        AUISBN
     C                   CLEAR                   AUTAGC
     C                   CLEAR                   AUSEQN
     C                   CLEAR                   AUDSQN
      *
      *
B1   C     AU@EOF        DOUEQ     *ON
      *
      *
     C                   MOVEA     D1(13)        WK002C            2
     C                   CLEAR                   S2SFL02C
     C                   MOVEA     WK002C        D1(13)
      *
      *
     C                   MOVE      *ZEROS        S02C01
     C                   MOVEA     S02C01        *IN(01)
     C                   MOVE      *ZEROS        S02C80
     C                   MOVEA     S02C80        *IN(80)
      *
      *
     C     1             SUBST     P00#01:2      *IN(02)
      *
      *
     C                   EXSR      @RTAU
      *
      * If first part of 100=Main entry, personal name
B2   C                   SELECT
W2   C     X@ECBA        WHENEQ    *ZERO
     C     F3TAGC        ANDEQ     100
     C     F3SEQN        ANDEQ     0
     C     F3DSQN        ANDEQ     0
      *
      *
     C     1             OCCUR     D1FATN
     C                   MOVEL     W1FATN        D1FATN
     C     2             OCCUR     D1FATN
     C                   MOVEL     W1FATN        D1FATN
     C                   MOVE      AU@CI         D1CI02
      *
      *
W2   C     X@ECBA        WHENEQ    *ZERO
      *
      *
     C                   MOVE      *ON           *IN(10)
      *
      *
     C                   Z-ADD     F3TAGC        S2TAGC
     C                   Z-ADD     F3SEQN        S2SEQN
     C                   MOVEL     W1FATN        S2FATN
     C                   MOVE      AU@CI         S2CI
      *
      *
     C                   MOVE      F3TAGC        MTTAGC
     C                   EXSR      @RTMT
      *
      *
     C                   ADD       1             D@RR
      *
      *
      /free
       s2eof = DspFmt_SflPageStatus(D@RR:P02CSP:AU@EOF);
      /end-free
      *
      *
     C     D@RR          DIV       P02CSP        K
     C                   MVR                     K
     C     K             IFLE      1
     C                   MOVE      *ON           *IN09
     C                   ENDIF
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *ON           S2NEF
      *
      *
     C                   MOVEA     *IN(01)       S02C01
     C                   MOVEA     *IN(80)       S02C80
     C                   WRITE     S2SFL02C
      *
      *
     C                   Z-ADD     D@RR          K
     C                   MOVE      S2KD          S2AU(K)
      *
      *
E2   C                   ENDSL
      *
      *
E1   C                   ENDDO
      *
      *
     C                   Z-ADD     D@RR          P02CRR
     C     S1OPT         IFNE      ' 5'
     C                   Z-ADD     2             D@PTF
     C                   ENDIF
      *
      *
     C                   EXSR      @FBF3
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @FBF3         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   Z-ADD     D@RR          I
      *
      *
     C                   MOVE      *OFF          *IN99
B1   C     I             IFEQ      *ZERO
     C                   Z-ADD     P02CSP        I
X1   C                   ELSE
      *
      *
     C     I             DIV       P02CSP        J
     C                   MVR                     J
      *
      * If J is not zero then "some" more records must be added to fill.
B2   C     J             IFNE      *ZERO
     C     P02CSP        SUB       J             J
     C     I             ADD       J             I
      *
      *
X2   C                   ELSE
     C                   MOVE      *ON           *IN99
E2   C                   ENDIF
E1   C                   ENDIF
      *
      *
     C     D@PTF         MULT      P02CSP        J
     C     I             ADD       J             J
      *
      *
B1   C     J             IFGT      50
     C                   Z-ADD     50            J
E1   C                   ENDIF
      *
      * Adjust current "last record" to reflect more records added.
B1   C     *IN99         IFEQ      *ON
     C     J             ANDGT     I
     C     I             CHAIN     S2SFL02C                           99
B2   C     *IN99         IFEQ      *OFF
     C                   MOVEA     S02C01        *IN(01)
     C                   MOVEA     S02C80        *IN(80)
     C                   MOVE      *ON           *IN21
     C                   MOVE      '-/+'         S2EOF
     C                   UPDATE    S2SFL02C
E2   C                   ENDIF
E1   C                   ENDIF
      *
      *
     C                   Z-ADD     J             I
      *
      *
     C     D@RR          DOWLT     I
      *
      *
     C                   MOVEA     D1(13)        WK002C            2
     C                   CLEAR                   S2SFL02C
     C                   MOVEA     WK002C        D1(13)
      *
      *
     C                   MOVE      *ZEROS        S02C01
     C                   MOVEA     S02C01        *IN(01)
     C                   MOVE      *ZEROS        S02C80
     C                   MOVEA     S02C80        *IN(80)
      *
      *
     C     1             SUBST     P00#01:2      *IN(02)
      *
      *
     C                   ADD       1             D@RR
     C     D@RR          IFEQ      I
     C                   MOVE      *ON           AU@EOF
     C                   ELSE
     C                   MOVE      *OFF          AU@EOF
     C                   ENDIF
     C     D@RR          DIV       P02CSP        J
     C                   MVR                     J
      *
      *
      /free
       s2eof = DspFmt_SflPageStatus(D@RR:P02CSP:AU@EOF);
      /end-free
      *
      *
     C     D@RR          DIV       P02CSP        K
     C                   MVR                     K
     C     K             IFLE      1
     C                   MOVE      *ON           *IN09
     C                   ENDIF
     C                   MOVE      *IN09         S2I09
     C                   MOVE      *ON           S2NEF
      *
      *
     C                   MOVEA     *IN(01)       S02C01
     C                   MOVEA     *IN(80)       S02C80
     C                   WRITE     S2SFL02C
      *
      *
     C                   Z-ADD     D@RR          K
     C                   MOVE      S2KD          S2AU(K)
      *
      *
     C                   ENDDO
      *
      *
     C                   CLEAR                   D@PTF
      *
      *
     C                   Z-ADD     D@RR          P02CRR
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @RTTI         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      *
     C     TIKEY1        SETLL     DTAF2R1
     C     TIKEY2        READE(N)  DTAF2R1                                99
     C                   MOVE      *IN99         TI@EOF
      *
      *
B1   C     TI@EOF        IFEQ      *ON
      *
      * No Title data found.
     C                   MOVE      'MSG1811'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   CLEAR                   TIDS
E1   C                   ENDIF
      *
      *
B1   C     TITAGC        IFEQ      130
     C     DSEQN0        ANDEQ     0
     C     TIDSQN        ANDEQ     0
     C                   Z-ADD     18            TI@LTS
X1   C                   ELSE
     C                   Z-ADD     8             TI@LTS
E1   C                   ENDIF
      *
      *
     C                   Z-ADD     0             I
     C                   Z-ADD     0             J
     C                   Z-ADD     TITAGC        F2TAGC
     C                   Z-ADD     DSEQN0        F2SEQN
     C                   Z-ADD     TIDSQN        F2DSQN
     C                   CLEAR                   W1FTTL
B1   C     TI@EOF        DOWEQ     *OFF
     C     TITAGC        ANDEQ     F2TAGC
     C     DSEQN0        ANDEQ     F2SEQN
     C     J             ANDLT     TI@LTS
      *
      *
     C                   ADD       1             J
      *
      *
     C     W1FTTL        CAT       DTITL0:I      W1FTTL
      *
      *
     C     ' '           CHECKR    DTITL0        I
     C     30            SUB       I             I
      *
      *
     C     TIKEY2        READE(N)  DTAF2R1                                99
     C                   MOVE      *IN99         TI@EOF
      *
      *
E1   C                   ENDDO
      *
      *
B1   C                   SELECT
W1   C     TI@EOF        WHENEQ    *ON
     C                   MOVE      '*'           TI@CI
W1   C     TI@EOF        WHENEQ    *OFF
     C     TITAGC        ANDEQ     F2TAGC
     C     DSEQN0        ANDEQ     F2SEQN
     C                   MOVE      '.'           TI@CI
W1   C                   OTHER
     C                   MOVE      '*'           TI@CI
E1   C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @RTAU         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      *
     C     AUKEY1        SETLL     DTAF3R1
     C     AUKEY2        READE(N)  DTAF3R1                                99
     C                   MOVE      *IN99         AU@EOF
      *
      *
     C     AU@EOF        IFEQ      *ON
      *
      * No Author(s) details found for bibliographic record
     C                   MOVE      'MSG1810'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   CLEAR                   AUDS
     C                   ENDIF
      *
      *
     C                   Z-ADD     8             AU@LTS
     C                   CLEAR                   W1FATN
      *
      *
     C                   Z-ADD     0             I
     C                   Z-ADD     0             J
     C                   Z-ADD     AUTAGC        F3TAGC
     C                   Z-ADD     AUSEQN        F3SEQN
     C     AU@EOF        DOWEQ     *OFF
     C     AUTAGC        ANDEQ     F3TAGC
     C     AUSEQN        ANDEQ     F3SEQN
     C     J             ANDLT     AU@LTS
      *
      *
     C                   ADD       1             J
      *
      *
     C     W1FATN        CAT       AUAUTN:I      W1FATN
      *
      *
     C     ' '           CHECKR    AUAUTN        I
     C     30            SUB       I             I
      *
      *
     C     AUKEY2        READE(N)  DTAF3R1                                99
     C                   MOVE      *IN99         AU@EOF
      *
      *
     C                   ENDDO
      *
      *
B1   C                   SELECT
W1   C     AU@EOF        WHENEQ    *ON
     C                   MOVE      '*'           AU@CI
W1   C     AU@EOF        WHENEQ    *OFF
     C     AUTAGC        ANDEQ     F3TAGC
     C     AUSEQN        ANDEQ     F3SEQN
     C                   MOVE      '.'           AU@CI
W1   C                   OTHER
     C                   MOVE      '*'           AU@CI
E1   C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     TS@F1O        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      * Lock for update
     C     F1@LRU        IFEQ      *ON
     C     F1KEY1        CHAIN     DTAF1R1                            99
      * Get no lock
     C                   ELSE
     C     F1KEY1        CHAIN(N)  DTAF1R1                            99
     C                   ENDIF
     C                   MOVE      *IN99         F1@NRF
      *
      * Option is 1=Create, F6=Create, 3=Copy(exists), 7=Rename(exists)
B1   C                   SELECT
W1   C     S1OPT         WHENEQ    ' 1'
     C     S1OPT         OREQ      'KF'
     C     S1OPT         OREQ      ' 3'
     C     F1@TE         ANDEQ     *ON
     C     S1OPT         OREQ      ' 7'
     C     F1@TE         ANDEQ     *ON
      *
      *
B2   C                   SELECT
W2   C     F1@NRF        WHENEQ    *OFF
      *
      * Record already exists
B3   C     BLDLTD        IFEQ      *BLANKS
     C                   MOVE      'MSG1860'     X@MI
     C                   Z-ADD     7             X@ECBA
X3   C                   ELSE
      *
      * Record exists but is flagged as deleted
     C                   MOVE      'MSG1861'     X@MI
     C                   Z-ADD     7             X@ECBA
E3   C                   ENDIF
E2   C                   ENDSL
      *
      * Else option is, 2=Change, 3=Copy, 4=Delete, 5=View, 7=Rename
     C     S1OPT         WHENNE    *BLANKS
      *
      * Record does not exist
B2   C                   SELECT
W2   C     F1@NRF        WHENEQ    *ON
     C                   MOVE      'MSG1862'     X@MI
     C                   Z-ADD     7             X@ECBA
      *
      * Record is deleted
W2   C     BLDLTD        WHENNE    *BLANKS
     C     S1OPT         ANDNE     ' 5'
     C     BLDLTD        ORNE      *BLANKS
     C     S1OPT         ANDEQ     ' 5'
     C     F1@TE         ANDEQ     *ON
     C                   MOVE      'MSG1375'     X@MI
     C                   Z-ADD     7             X@ECBA
      *
      *
E2   C                   ENDSL
      *
      *
E1   C                   ENDSL
      *
      *
     C                   MOVE      *OFF          F1@TE
     C                   MOVE      *OFF          F1@LRU
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     RT@F1         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      * Current record
     C     #CRRCD        OCCUR     F1DS
      *
      *
B1   C     S1OPT         IFEQ      'KF'
     C     #INKEY        OCCUR     F1AK
E1   C                   ENDIF
      *
      *
     C                   MOVE      'F1>f?'       KY@DIR
     C                   EXSR      PR@KY
     C     #CHKEY        OCCUR     F1AK
      *
      *
     C     *NOKEY        CLEAR                   DTAF1R1
      *
      * Transfer, if any, default values.
     C                   MOVE      'V1>f?'       KY@DIR
     C                   EXSR      PR@KY
      *
      *
     C                   EXSR      TS@F1O
     C     X@ECBA        IFNE      *ZERO
     C                   MOVE      X@EC          I@EC
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      I@EC          X@EC
     C                   ENDIF
      *
      *
     C                   MOVEL(P)  F1DS          F@DS
      *
      * Original record
     C     #ORRCD        OCCUR     F1DS
      *
      *
     C                   SELECT
      *
      * Record has changed since last retrieval
     C     F1@COC        WHENEQ    *ON
     C     F1DS          ANDNE     F@DS
     C                   MOVE      *ON           F1@COC
     C                   MOVE      'MSG1842'     X@MI
     C                   Z-ADD     7             X@ECBA
      *
      *
     C     F1@COC        WHENEQ    *ON
     C     F1DS          ANDEQ     F@DS
     C                   MOVE      *OFF          F1@COC
      *
      *
     C                   OTHER
     C                   MOVE      *OFF          F1@COC
      *
      * Set original record
     C                   MOVEL(P)  F@DS          F1DS
      *
      * Update record
     C     #UPRCD        OCCUR     F1DS
     C                   MOVEL(P)  F@DS          F1DS
      *
      * Screen display record
     C     #SCRCD        OCCUR     F1DS
     C                   MOVEL(P)  F@DS          F1DS
      *
      * Perform mandatory conversions
      ***C           ......    IFNE *ZEROS
      ***C                     RESETX@ID
      ***C                     MOVEL......    X@ID
      ***C                     CALL 'QWCCVTDT'@CVTFD
      ***C                     MOVELX@OD      .....
      ***C                     ENDIF
      *
      * Save before fields
      ***C                     MOVE ......    B1....
      *
      * Set display fields that cannot have the same name (lists)
      ***C                     MOVE ......    ...,01
      *
      *
     C                   ENDSL
      *
      * Screen display record
     C     #SCRCD        OCCUR     F1DS
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @UPF1         BEGSR
      *-------------------------------------------------------------------------
      *
      * Processing updates
     C     S1OPT         IFNE      ' 5'
     C                   MOVE      'EXM0002'     X@MI
     C                   Z-ADD     27            X@ECBA
     C                   MOVEL(P)  '*EXT'        X@PMQ
     C                   MOVEL(P)  '*STATUS'     X@MT
     C                   MOVE      FNM@11        F@FNAM
     C                   MOVE      FLB@11        F@FLIB
     C                   MOVEL     IDF@          X@MDIT
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   RESET                   X@PMQ
     C                   RESET                   X@MT
     C                   ENDIF
      *
      *
     C                   CLEAR                   X@ECBA
      *
      *
     C                   MOVE      *ON           F1@LRU
     C                   EXSR      RT@F1
      *
      *
B1   C                   SELECT
      *
      * If error has occured and record found
W1   C     X@ECBA        WHENNE    *ZERO
     C     F1@NRF        ANDEQ     *OFF
      *
      * Release the record lock.
     C     F1KEY1        SETLL     DTAF1R1
      *
      * If error
W1   C     X@ECBA        WHENNE    *ZERO
      *
      * If no error has occured
W1   C                   OTHER
      *
      * Replace the file fields that cannot have the same name
      ***C                     Z-ADD....,01   ......
      *
      *
     C                   MOVEL(P)  F1DS          F@DS
     C     #UPRCD        OCCUR     F1DS
     C                   MOVEL(P)  F@DS          F1DS
      *
      * Peform mandatory conversions, ie dates
      ***C           ......    IFNE *ZERO
      ***C                     RESETX@ID
      ***C                     MOVEL......    X@ID
      ***C                     CALL 'QWCCVTDT'@CVTDT
      ***C                     MOVELX@OD      ......
      ***C                     ENDIF
      *
      *
B2   C                   SELECT
      * Create record if create option requested
      *
W2   C     S1OPT         WHENEQ    ' 1'
     C     S1OPT         OREQ      'KF'
     C     S1OPT         OREQ      ' 3'
      *
      * Set creation information
     C                   MOVE      S@USER        BLCUSR
     C                   MOVE      S@PGM         BLCPGM
     C                   MOVEL(P)  '*CURRENT'    X@IDF
     C                   EXSR      @DTDTS
     C                   MOVE      @DT           BLCDTS
     C                   MOVE      S@USER        BLEUSR
     C                   MOVE      S@PGM         BLEPGM
     C                   MOVE      @DT           BLEDTS
      *
      *
     C                   WRITE     DTAF1R1                              98
B3   C     *IN98         IFEQ      *ON
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1848'     X@MI
E3   C                   ENDIF
      *
      * Option is ' 4' delete
W2   C     S1OPT         WHENEQ    ' 4'
      *
      *
     C     #UPRCD        OCCUR     F1DS
      *
      * Perform real delete
      ***C           F1KEY1    DELETDTAF1R1              99
      *
      * Perform delete via flag
     C                   MOVE      S@USER        BLEUSR
     C                   MOVE      S@PGM         BLEPGM
     C                   MOVEL     '*CURRENT'    X@IDF
     C                   EXSR      @DTDTS
     C                   MOVE      @DT           BLEDTS
     C                   MOVE      '*'           BLDLTD
     C                   UPDATE    DTAF1R1
      *
      * Option is not view
W2   C     S1OPT         WHENNE    ' 5'
      *
      *
     C     #ORRCD        OCCUR     F1DS
     C                   MOVEL(P)  F1DS          F@DS
     C     #UPRCD        OCCUR     F1DS
      *
      * If original record and update record differ
B3   C     F1DS          IFNE      F@DS
      *
      * Refresh record edit information
     C                   MOVE      S@USER        BLEUSR
     C                   MOVE      S@PGM         BLEPGM
     C                   MOVEL(P)  '*CURRENT'    X@IDF
     C                   EXSR      @DTDTS
     C                   MOVE      @DT           BLEDTS
      *
      * Update file
     C                   UPDATE    DTAF1R1                              98
B4   C     *IN98         IFEQ      *ON
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1848'     X@MI
E4   C                   ENDIF
      *
      *
E3   C                   ENDIF
      *
      *
E2   C                   ENDSL
      *
      *
     C     X@ECBA        IFEQ      *ZERO
     C     S1OPT         ANDNE     ' 5'
     C                   EXSR      UP@F2
     C                   ENDIF
      *
      *
     C     X@ECBA        IFEQ      *ZERO
     C     S1OPT         ANDNE     ' 5'
     C                   EXSR      UP@F3
     C                   ENDIF
      *
      *
      /free
       select;
         when S1OPT = ' 5';    // do nothing
         when e_CallerCommits; // do nothing
         when X@ECBA = *ZERO;
           commit;
         other;
           rolbk;
       endsl;
      /end-free
      *
      *
E1   C                   ENDSL
      *
      * Set back to screen
     C     #SCRCD        OCCUR     F1DS
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     UP@F2         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      *
      *
      * Processing updates
      ***C                     Z-ADD1         I1
      *
      *
      ***C                     MOVE BLISBN    EISBN3
      ***C                     Z-ADD'T'       GTLTP0
      ***C                     Z-ADDI1        DSEQN0
      ***C                     CLEARI2
      ***C                     CLEARI
      ***C                     MOVE *OFF      F2@EOF
      ***C           TIKEY3    SETLLDTAF2R1
      ***C                     READ DTAF2R1                9899
      ***C           F2@EOF    DOWEQ*OFF
      ***C           *IN98     ANDNE*ON
      *
      *
      ***C           *IN99     IFNE *ON
      ***C                     DELETDTAF2R1
      ***C           TIKEY3    READEDTAF2R1                9899
      ***C                     ENDIF
      *
      *
      ***C           *IN98     IFNE *ON
      ***C           I         MULT 30        J
      ***C                     ADD  1         J
      ***C           J         IFGT 580
      ***C                     MOVE *ON       F2@EOF
      ***C                     ELSE
      ***C                     SUBSTD1FTTL:J  DTITL0    P
      ***C                     ADD  1         I
      ***C           DTITL0    IFNE *BLANKS
      ***C                     ADD  1         I2
      ***C                     MOVE I2        TIDSQN
      ***C                     WRITEDTAF2R1                98
      ***C                     ENDIF
      ***C                     ENDIF
      ***C                     ENDIF
      *
      *
      ***C           *IN98     IFEQ *ON
      ***C                     Z-ADD7         X@ECBA
      ***C                     MOVE 'MSG1902' X@MI
      ***C                     ENDIF
      *
      *
      *
      *
      ***C                     ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @UPTI         BEGSR
      *-------------------------------------------------------------------------
      *
     C                   UPDATE    DTAF2R1                              98
     C                   WRITE     DTAF2R1                              98
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     UP@F3         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @UPAU         BEGSR
      *-------------------------------------------------------------------------
      *
     C                   UPDATE    DTAF3R1                              98
     C                   WRITE     DTAF3R1                              98
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @CND01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      '*ENT'        @FMT
      *
      * Do until exit requested
B1   C     @FMT          DOWNE     *BLANKS
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
      *
      *
     C     #CRRCD        OCCUR     F1DS
      *
      *
     C                   CLEAR                   BO
     C                   Z-ADD     E1            I
     C                   Z-ADD     0             E2
      *
      * Move all 4=Delete from list to confirm delete
B3   C     E2            DOWLT     O2
     C     I             ANDLE     O1
     C                   MOVE      AK(I)         F1AK
     C                   MOVE      F1@IOP        S1@IOP
B4   C     S1OPT         IFEQ      ' 4'
     C                   ADD       1             E2
     C                   MOVE      F1AK          BO(E2)
E4   C                   ENDIF
     C                   ADD       1             I
E3   C                   ENDDO
      *
      *
     C                   Z-ADD     1             I1
     C                   Z-ADD     1             O2I1
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
      *
      *
     C                   Z-ADD     O2I1          I1
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
      *
      * Get for display
     C                   EXSR      VL@C1
      *
      *
E2   C                   ENDIF
      *
      *
B2   C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
     C     @FMT          OREQ      '*UPD'
      *
      * Clear subfile
     C                   MOVE      *ON           *IN02
     C                   WRITE     C1PNL02
     C                   MOVE      *OFF          @CHG
      *
      * RollUp/PageDown
B3   C                   SELECT
W3   C     @ROLL         WHENEQ    UP
      *
      * Already at bottom of area
B4   C     D@MOB         IFEQ      BOTTOM
     C                   MOVE      'CPD6A69'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   Z-ADD     O2I1          I1
X4   C                   ELSE
     C                   Z-ADD     I1            O2I1
E4   C                   ENDIF
      *
      * RollDown/PageUp
W3   C     @ROLL         WHENEQ    DOWN
      *
      * Already at top of area
     C     O2I1          SUB       D@RR1D        I1
     C                   SUB       1             I1
B4   C     I1            IFLE      0
     C                   MOVE      'CPD6A66'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   Z-ADD     1             I1
E4   C                   ENDIF
     C                   Z-ADD     I1            O2I1
      *
      * Enter or refresh requested
W3   C                   OTHER
      *
      *
E3   C                   ENDSL
      *
      *
     C                   MOVE      *OFF          @NVR              1
     C                   Z-ADD     *ZERO         D@RR1
B3   C     D@RR1         DOWLE     D@RR1D
     C     I1            ANDLE     E2
     C     E2            ANDGT     *ZERO
      *
      * Get data record
     C                   CLEAR                   S1SFL02
     C                   MOVE      BO(I1)        F1AK
     C                   MOVE      'F1>f?'       KY@DIR
     C                   EXSR      PR@KY
     C                   EXSR      TS@F1O
      *
      * If valid record
B4   C     X@ECBA        IFEQ      *ZERO
      *
      * Format subfile record as 'detail'
     C                   MOVE      *ON           F1@CDI
     C                   MOVE      *OFF          F1@EOF
     C                   EXSR      FM@S1F
      *
      * Write subfile record
     C                   ADD       1             D@RR1
     C                   WRITE     S1SFL02
      *
      *
     C                   ADD       1             I1
      *
      * Else record cannot be displayed
X4   C                   ELSE
      *
      *
     C                   MOVE      *ON           @NVR
      *
      * Find and remove record from original store
     C                   MOVE      BO(I1)        F1AK
     C                   Z-ADD     E1            I
     C     F1PK          LOOKUP    PK(I)                                  99
B5   C     *IN99         IFEQ      *ON
     C                   MOVE      *LOVAL        PK(I)
     C                   MOVE      *LOVAL        AK(I)
      *
      * Move elements down a row
     C                   Z-ADD     I1            J
B6   C     J             DOWLE     E2
     C     J             ADD       1             I
     C     I             IFLE      O2
     C                   MOVE      BO(I)         BO(J)
     C                   MOVE      *LOVAL        BO(I)
     C                   ELSE
     C                   MOVE      *LOVAL        BO(J)
     C                   ENDIF
     C                   ADD       1             J
E6   C                   ENDDO
      *
      * Reduce elements stored by 1
     C                   SUB       1             E2
      *
      * If number of elements is less than first line to display
B6   C     E2            IFLT      O2I1
      *
      * Reset first line to display and element index
     C                   Z-ADD     E2            O2I1
     C                   Z-ADD     E2            I1
E6   C                   ENDIF
      *
      *
E5   C                   ENDIF
      *
      *
E4   C                   ENDIF
      *
      *
E3   C                   ENDDO
      *
      *
     C     @NVR          IFEQ      *ON
     C                   MOVE      'MSG1863'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   ENDIF
      *
      * If no records to display
B3   C     E2            IFLE      *ZERO
      *
      * Format subfile as '(No records to display)'
     C                   MOVE      *OFF          *IN01
     C                   MOVE      *ON           *IN02
     C                   WRITE     S1SFL02
E3   C                   ENDIF
      *
      * If end of file show it
B3   C     I1            IFGT      E2
     C     E2            OREQ      *ZERO
     C                   MOVE      BOTTOM        D@MOB
     C                   Z-ADD     O2I1          I1
X3   C                   ELSE
     C                   MOVE      MORE          D@MOB
E3   C                   ENDIF
      *
      * End of create/update test
E2   C                   ENDIF
      *
      * Set/Reset display output
     C                   MOVE      D@MOB         *IN25
      *
      * Process display format
     C                   WRITE     #ERRCTL
     C                   WRITE     C1FTR02
     C                   MOVE      *OFF          *IN02
     C                   WRITE     C1PNL02
     C                   READ      C1PNL02                                99
     C                   MOVE      *OFF          @CHG
     C                   MOVE      *IN22         @VCF
      *
      * Set/Reset display input
     C                   CLEAR                   I@FKY
     C                   CLEAR                   @FMT
     C                   SELECT
     C     *IN23         WHENEQ    *ON
     C                   MOVE      UP            @ROLL
     C                   MOVE      '*UPD'        @FMT
     C     *IN24         WHENEQ    *ON
     C                   MOVE      DOWN          @ROLL
     C                   MOVE      '*UPD'        @FMT
     C                   OTHER
     C                   CLEAR                   @ROLL
     C                   ENDSL
     C                   CALL      'QMHRMVPM'    @RMVPM
      *
      * Test and validate display format
     C                   SELECT
      *
      * F3=Exit
     C     *INKC         WHENEQ    *ON
     C                   MOVE      'KC'          I@FKY
      *
      * F5=Refresh
     C     *INKE         WHENEQ    *ON
     C                   MOVE      '*CRT'        @FMT
      *
      * F12=Cancel
     C     *INKL         WHENEQ    *ON
     C                   MOVE      'KL'          I@FKY
      *
      *   =Enter or RollDown or Rollup
     C     @VCF          WHENNE    *ON
     C     @ROLL         OREQ      UP
     C     @ROLL         OREQ      DOWN
      *
      * Panel has changed, Redisplay
     C     @FMT          IFEQ      *BLANKS
     C     @CHG          IFEQ      YES
     C                   MOVE      '*DSP'        @FMT
      *
      * Process entered option(s) if allowed
     C                   ELSE
      *
      * For all stored 4=Delete, delete record
     C     1             DO        E2            I
     C                   MOVE      BO(I)         F1AK
     C                   MOVE      'F1>f?'       KY@DIR
     C                   EXSR      PR@KY
     C                   MOVE      *OFF          F1@COC
     C                   EXSR      @UPF1
      *
      * Find 4=Delete in original store and remove it
     C                   Z-ADD     E1            J
     C     F1PK          LOOKUP    PK(J)                                  99
     C     *IN99         IFEQ      *ON
     C                   MOVE      *LOVAL        PK(J)
     C                   MOVE      *LOVAL        AK(J)
     C                   ENDIF
     C                   ENDDO
      *
      *
     C                   ENDIF
      *
      *
     C                   ENDIF
      *
      * Invalid function key
     C                   OTHER
     C                   MOVE      'CPD6A60'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   MOVE      '*ERR'        @FMT
      *
      * End process display
     C                   ENDSL
      *
      * End of display loop
     C                   ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @SSS01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      '*ENT'        @FMT
      *
      *
     C     @FMT          DOWNE     *BLANKS
      *
      *
     C     @FMT          IFEQ      '*ENT'
      *
      *
     C                   WRITE     SSSWDWW1
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
      *
      * Get for display
     C                   EXSR      @VST01
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
     C     @FMT          OREQ      '*UPD'
      *
      *
     C                   SELECT
     C     @ROLL         WHENEQ    UP
     C                   MOVE      'CPD6A69'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
      *
      *
     C     @ROLL         WHENEQ    DOWN
     C                   MOVE      'CPD6A66'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   ENDSL
      *
      *
     C                   ENDIF
      *
      *
     C                   WRITE     SSSPNLC1
     C                   WRITE     SSSPNLD1
     C                   READ      SSSPNLD1                               99
      *
      *
     C                   MOVE      *IN21         @CHG
     C                   MOVE      *IN22         @VCF
     C                   CLEAR                   I@FKY
     C                   CLEAR                   @FMT
      *
      *
     C                   SELECT
     C     *IN23         WHENEQ    *ON
     C                   MOVE      UP            @ROLL
     C                   MOVE      '*UPD'        @FMT
     C     *IN24         WHENEQ    *ON
     C                   MOVE      DOWN          @ROLL
     C                   MOVE      '*UPD'        @FMT
     C                   OTHER
     C                   CLEAR                   @ROLL
     C                   ENDSL
     C                   CALL      'QMHRMVPM'    @RMVPM
     C                   MOVEA     *ALL'0'       *IN(50)
      *
      *
     C                   SELECT
      *
      *
     C     *INKC         WHENEQ    *ON
     C                   MOVE      'KC'          I@FKY
      *
      *
     C     *INKE         WHENEQ    *ON
     C                   MOVE      '*CRT'        @FMT
      *
      *
     C     *INKL         WHENEQ    *ON
     C                   MOVE      'KL'          I@FKY
      *
      *
     C     @VCF          WHENNE    *ON
     C     @ROLL         OREQ      UP
     C     @ROLL         OREQ      DOWN
      *
      *
     C                   MOVE      *ON           D1DO
     C                   EXSR      @VST01
      *
      *
     C     @FMT          IFEQ      *BLANKS
      *
      * Details are valid, press Enter to confirm
     C     @CHG          IFEQ      YES
     C                   MOVE      'MSG1532'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*DSP'        @FMT
     C                   ENDIF
      *
      *
     C                   ENDIF
      *
      *
     C                   OTHER
     C                   MOVE      'CPD6A60'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   MOVE      '*ERR'        @FMT
      *
      *
     C                   ENDSL
      *
      *
     C                   ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VST01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      *OFF          *IN97
      *
      *
B1   C     D1DO          IFEQ      *ON
      *
      *
     C                   MOVE      *ALLX'00'     @CR
     C                   MOVEL(P)  C1SSFN        X@SID
     C                   CLEAR                   C2SSFN
     C                   CLEAR                   C3SSFN
     C                   CLEAR                   SKSW
      *
      *
     C     ' '           CHECKR    C1SSFN        C1SSSQ
     C                   Z-ADD     C1SSSQ        BD004C
     C                   MOVE      BN004C        X@LOD
     C                   CALL      'QLGCNVCS'    @CNVCS                 98
B2   C     X@SOD         IFNE      '*ALL'
     C     X@SOD         ANDNE     '*BLANKS'
     C     '*'           SCAN      X@SID         I                        99
     C     *IN99         IFEQ      *ON
B2   C     I             ANDLT     580
     C                   ADD       1             I
     C     ' '           CHECK     X@SID:I       J                        99
B3   C     *IN99         IFEQ      *ON
     C                   MOVE      *ON           *IN97
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1840'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*ERR'        @FMT
E3   C                   ENDIF
E2   C                   ENDIF
B2   C     C1SSSQ        IFNE      *ZERO
     C     X@ECBA        ANDEQ     *ZERO
     C     C1SSSQ        SUBST(P)  X@SOD:1       C2SSFN
     C                   MOVEL(P)  X@SOD         W2FTTL
     C                   Z-ADD     1             I
     C                   CLEAR                   X@SID
B3   C     *IN99         DOUEQ     *OFF
     C     VLCHR         CHECK     X@SOD:I       I                        99
     C     I             SUB       1             J
B4   C     J             IFGT      *ZERO
     C     J             SUBST(P)  X@SOD:1       X@SID
     C     ' '           CHECKR    X@SID         K
     C     J             SUB       K             K
X4   C                   ELSE
     C                   CLEAR                   X@SID
     C                   Z-ADD     *ZERO         K
E4   C                   ENDIF
     C     I             ADD       1             J
B4   C     *IN99         IFEQ      *ON
     C     J             ANDLE     580
     C     580           SUB       J             I
     C     I             SUBST(P)  X@SOD:J       X@SOD
     C     X@SID         CAT(P)    X@SOD:K       X@SOD
     C     J             SUB       1             I
E4   C                   ENDIF
E3   C                   ENDDO
B3   C     X@SOD         IFEQ      *BLANKS
     C                   MOVEL(P)  W2FTTL        X@SOD
E3   C                   ENDIF
     C                   MOVEL(P)  X@SOD         C3SSFN
     C                   Z-ADD     1             I
     C     ' '           CHECK     X@SOD:1       J
B3   C     I             DOWLE     10
     C     J             ANDNE     *ZERO
     C     ' '           SCAN      X@SOD:J       K
B4   C     K             IFNE      *ZERO
     C     K             SUB       J             K
     C     K             SUBST(P)  X@SOD:J       SKSW(I)
E4   C                   ENDIF
     C     J             ADD       K             K
     C     ' '           CHECK     X@SOD:K       J
     C                   ADD       1             I
E3   C                   ENDDO
B3   C     I             IFGT      3
     C     SKSW(1)       ANDEQ     'TH'
     C                   CLEAR                   SKSW(1)
E3   C                   ENDIF
     C                   MOVEA(P)  SKSW          C4SSFN
     C                   CLEAR                   C1SSGT
B3   C     1             DO        10            I
     C     C1SSGT        CAT(P)    SKSW(I):0     C1SSGT
E3   C                   ENDDO
     C     ' *'          CHECKR    W2FTTL        I                        99
B3   C     *IN99         IFEQ      *ON
     C     I             SUBST(P)  W2FTTL:1      W2FTTL
E3   C                   ENDIF
     C     ' '           CHECKR    C1SSGT        J
B3   C     I             IFGT      *ZERO
B4   C     J             IFEQ      10
     C                   MOVE      '*'           C1SSGT
X4   C                   ELSE
     C                   CAT       '*':0         C1SSGT
E4   C                   ENDIF
E3   C                   ENDIF
      *
      *
E2   C                   ENDIF
      *
      *
     C                   ELSE
     C                   MOVEL(P)  X@SOD         C1SSGT
     C                   MOVEL(P)  X@SOD         C1SSFN
      *
      *
E2   C                   ENDIF
      *
      *
E1   C                   ENDIF
      *
      *
     C                   MOVE      *OFF          D1DO
      *
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @POS01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      '*ENT'        @FMT
      *
      *
     C     @FMT          DOWNE     *BLANKS
      *
      *
     C     @FMT          IFEQ      '*ENT'
      *
      *
     C                   WRITE     POSWDWW1
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
      *
      *
     C                   MOVE      *BLANKS       P1ISBN
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
      *
      * Get for display
     C                   EXSR      @VLL01
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
     C     @FMT          OREQ      '*UPD'
      *
      *
     C                   SELECT
     C     @ROLL         WHENEQ    UP
     C                   MOVE      'CPD6A69'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
      *
      *
     C     @ROLL         WHENEQ    DOWN
     C                   MOVE      'CPD6A66'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   ENDSL
      *
      *
     C                   ENDIF
      *
      *
     C                   WRITE     POSPNLC1
     C                   WRITE     POSPNLD1
     C                   READ      POSPNLD1                               99
      *
      *
     C                   MOVE      *IN21         @CHG
     C                   MOVE      *IN22         @VCF
     C                   CLEAR                   I@FKY
     C                   CLEAR                   @FMT
      *
      *
     C                   SELECT
     C     *IN23         WHENEQ    *ON
     C                   MOVE      UP            @ROLL
     C                   MOVE      '*UPD'        @FMT
     C     *IN24         WHENEQ    *ON
     C                   MOVE      DOWN          @ROLL
     C                   MOVE      '*UPD'        @FMT
     C                   OTHER
     C                   CLEAR                   @ROLL
     C                   ENDSL
     C                   CALL      'QMHRMVPM'    @RMVPM
     C                   MOVEA     *ALL'0'       *IN(50)
      *
      *
     C                   SELECT
      *
      *
     C     *INKC         WHENEQ    *ON
     C                   MOVE      'KC'          I@FKY
      *
      *
     C     *INKE         WHENEQ    *ON
     C                   MOVE      '*CRT'        @FMT
      *
      *
     C     *INKL         WHENEQ    *ON
     C                   MOVE      'KL'          I@FKY
      *
      *
     C     @VCF          WHENNE    *ON
     C     @ROLL         OREQ      UP
     C     @ROLL         OREQ      DOWN
      *
      *
     C                   MOVE      *ON           D1DO
     C                   EXSR      @VLL01
      *
      *
     C     @FMT          IFEQ      *BLANKS
      *
      * Details are valid, press Enter to confirm
     C     @CHG          IFEQ      YES
     C                   MOVE      'MSG1532'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*DSP'        @FMT
     C                   ELSE
      *
      *
     C                   SELECT
     C     P1ISBN        WHENEQ    '*TOP'
     C                   MOVE      *LOVAL        P1ISBN
     C     P1ISBN        WHENEQ    '*BOT'
     C                   MOVE      *HIVAL        P1ISBN
     C                   ENDSL
      *
      *
     C                   ENDIF
      *
      *
     C                   ENDIF
      *
      *
     C                   OTHER
     C                   MOVE      'CPD6A60'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   MOVE      '*ERR'        @FMT
      *
      *
     C                   ENDSL
      *
      *
     C                   ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VLL01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      *OFF          D1DO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @SBS01        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVE      '*ENT'        @FMT
      *
      *
     C     @FMT          DOWNE     *BLANKS
      *
      *
     C     @FMT          IFEQ      '*ENT'
      *
      *
     C                   WRITE     SBSWDWW1
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
      *
      * Get for display
     C                   EXSR      @VSS01
      *
      *
     C                   ENDIF
      *
      *
     C     @FMT          IFEQ      '*ENT'
     C     @FMT          OREQ      '*CRT'
     C     @FMT          OREQ      '*RFD'
     C     @FMT          OREQ      '*UPD'
      *
      *
     C                   SELECT
     C     @ROLL         WHENEQ    UP
     C                   MOVE      'CPD6A69'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
      *
      *
     C     @ROLL         WHENEQ    DOWN
     C                   MOVE      'CPD6A66'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   ENDSL
      *
      *
     C                   ENDIF
      *
      *
     C                   WRITE     SBSPNLC1
     C                   WRITE     SBSPNLD1
     C                   READ      SBSPNLD1                               99
      *
      *
     C                   MOVE      *IN21         @CHG
     C                   MOVE      *IN22         @VCF
     C                   CLEAR                   I@FKY
     C                   CLEAR                   @FMT
      *
      *
     C                   SELECT
     C     *IN23         WHENEQ    *ON
     C                   MOVE      UP            @ROLL
     C                   MOVE      '*UPD'        @FMT
     C     *IN24         WHENEQ    *ON
     C                   MOVE      DOWN          @ROLL
     C                   MOVE      '*UPD'        @FMT
     C                   OTHER
     C                   CLEAR                   @ROLL
     C                   ENDSL
     C                   CALL      'QMHRMVPM'    @RMVPM
     C                   MOVEA     *ALL'0'       *IN(50)
      *
      *
     C                   SELECT
      *
      *
     C     *INKC         WHENEQ    *ON
     C                   MOVE      'KC'          I@FKY
      *
      *
     C     *INKE         WHENEQ    *ON
     C                   MOVE      '*CRT'        @FMT
      *
      *
     C     *INKL         WHENEQ    *ON
     C                   MOVE      'KL'          I@FKY
      *
      *
     C     @VCF          WHENNE    *ON
     C     @ROLL         OREQ      UP
     C     @ROLL         OREQ      DOWN
      *
      *
     C                   MOVE      *ON           D1DO
     C                   EXSR      @VSS01
      *
      *
     C     @FMT          IFEQ      *BLANKS
      *
      * Details are valid, press Enter to continue
     C     @CHG          IFEQ      YES
     C                   MOVE      'MSG1532'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      '*DSP'        @FMT
     C                   ELSE
      *
      *
     C                   ENDIF
      *
      *
     C                   ENDIF
      *
      *
     C                   OTHER
     C                   MOVE      'CPD6A60'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDSM
     C                   MOVE      '*ERR'        @FMT
      *
      *
     C                   ENDSL
      *
      *
     C                   ENDDO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @VSS01        BEGSR
      *-------------------------------------------------------------------------
      *
      * Invalid option for show deleted records
     C     C1DLTD        IFNE      '*'
     C     C1DLTD        ANDNE     'N'
     C     C1DLTD        ANDNE     'O'
     C     D1DO          ANDEQ     *ON
     C                   MOVE      'MSG1835'     X@MI
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   MOVE      *ON           *IN97
     C                   MOVE      '*ERR'        @FMT
     C                   ENDIF
      *
      *
     C                   MOVE      *OFF          D1DO
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @RTES         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
     C     ESKEY1        CHAIN     MTSUPPF                            99
      *
      * Invalid supplier
     C                   SELECT
     C     *IN99         WHENEQ    *ON
     C                   MOVE      'MSG1351'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   CLEAR                   ESDS
      *
      * Supplier is flagged as deleted
     C     *IN99         WHENEQ    *OFF
     C     ESDLTD        ANDNE     *BLANKS
     C                   MOVE      'MSG1352'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @RTIP         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
     C     IPKEY1        CHAIN     MTIMPNF                            99
      *
      * Invalid imprint
     C                   SELECT
     C     *IN99         WHENEQ    *ON
     C                   MOVE      'MSG1560'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   CLEAR                   IPDS
      *
      * Imprint is flagged as deleted
     C     *IN99         WHENEQ    *OFF
     C     IPDLTD        ANDNE     *BLANKS
     C                   MOVE      'MSG1561'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @RTMT         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
     C     MTKEY1        CHAIN     MRCCDEF                            99
      *
      * Invalid MARC code
     C                   SELECT
     C     *IN99         WHENEQ    *ON
     C                   MOVE      'MSG1562'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   CLEAR                   MTDS
      *
      * MARC code is flaged as deleted
     C     *IN99         WHENEQ    *OFF
     C     MTDLTD        ANDNE     *BLANKS
     C                   MOVE      'MSG1563'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @RTBN         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   CLEAR                   X@ECBA
     C     BNKEY1        CHAIN     BNDTYPF                            99
      *
      * Invalid binding type.
     C                   SELECT
     C     *IN99         WHENEQ    *ON
     C                   MOVE      'MSG1564'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   CLEAR                   BNDS
      *
      * Binding type is flagged as deleted.
     C     *IN99         WHENEQ    *OFF
     C     MTDLTD        ANDNE     *BLANKS
     C                   MOVE      'MSG1565'     X@MI
     C                   Z-ADD     7             X@ECBA
     C                   ENDSL
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     PI@AK         BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   Z-ADD     O1            E1
     C                   MOVE      *LOVAL        AK
     C                   MOVE      *LOVAL        PK
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     PR@AK1        BEGSR
      *-------------------------------------------------------------------------
      *
      * Save F1AK
     C                   MOVE      F1AK          F@AK
     C                   Z-ADD     *ZERO         X@ECBA
      *
      * Find '1:Detail' options
     C                   MOVE      *LOVAL        F1AK
     C                   MOVE      *ON           F1@CDI
     C     F1AK          LOOKUP    AK(AK@SQ)                          99
     C                   MOVE      *IN99         AK@I
      *
      * No '1:Detail' options found.
B1   C     AK@I          IFEQ      *OFF
     C                   MOVE      F@AK          F1AK
     C                   Z-ADD     7             X@ECBA
     C                   MOVE      'MSG1846'     X@MI
E1   C                   ENDIF
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @DTDTS        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C                   MOVEL(P)  '*YMD'        X@ODF
     C                   CALL      'QWCCVTDT'    @CVTDT
      *
      *
     C                   RESET                   @DT
      *
      *
     C     X@ECBA        IFEQ      *ZERO
     C     X@ODC         ADD       19            DT@Y                           00CC
     C                   MULT      100           DT@Y                           CC00
     C                   ADD       X@OD1         DT@Y                           CCYY
     C                   Z-ADD     X@OD2         DT@M                           CCYYMM
     C                   Z-ADD     X@OD3         DT@D                           CCYYMMDD
     C     X@ODT         DIV       10000         DT@H                           CCYYMMDDHH
     C     X@ODT         DIV       100           DT@MI                          CCYYMMDDHHMM
     C                   Z-ADD     X@ODT         DT@S                           CCYYMMDDHHMMSS
     C     X@ODU         MULT      1000          DT@U                           CCYYMMDDHHMMSSUUUUUU
     C                   ENDIF
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     @DTSDT        BEGSR
      *-------------------------------------------------------------------------
      *
      *
     C     DT@Y          DIV       100           WK0020            2 0
     C                   MVR                     X@OD1                          .YY
     C     WK0020        SUB       19            X@ODC                          CYY
     C                   Z-ADD     DT@M          X@OD2                          CCYYMM
     C                   Z-ADD     DT@D          X@OD3                          CCYYMMDD
     C     DT@H          MULT      10000         WK0060            6 0
     C                   Z-ADD     WK0060        X@ODT                          HH
     C     DT@MI         MULT      100           WK0060
     C                   ADD       WK0060        X@ODT                          HHMM
     C                   ADD       DT@S          X@ODT                          HHMMSS
     C                   Z-ADD     DT@U          X@ODU                          UUUUUU
      *
      *
     C                   MOVEL     X@OD          X@ID
      *
      *
     C                   MOVEL(P)  '*YMD'        X@IDF
     C                   CALL      'QWCCVTDT'    @CVTDT
     C     X@ECBA        IFNE      *ZERO
     C                   RESET                   X@OD
     C                   ENDIF
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     PR@PG         BEGSR
      *-------------------------------------------------------------------------
      *
      * Prevent length errors being missed causing hard to find bugs.
     C                   Z-ADD     *ZERO         X@ECBA
     C                   MOVE      'MSD1001'     X@MI
      *
      * Always test
     C                   MOVE      *HIVAL        F1PK
     C                   MOVE      *HIVAL        PK(1)
     C     F1PK          IFNE      PK(1)
     C                   MOVE      *ON           *IN99
     C                   MOVEL(P)  '*DIAG'       X@MT
     C                   MOVEL(P)  'F1PK    '    F@FNAM
     C                   MOVEL(P)  'PK,1    '    F@FLIB
     C                   MOVEL     IDF@          X@MDIT
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   RESET                   X@MT
     C                   ENDIF
     C                   RESET                   F1PK
     C                   RESET                   PK(1)
      *
      * Always test
     C                   MOVE      *HIVAL        F1PK
     C                   MOVE      *HIVAL        O1PK
     C     F1PK          IFNE      O1PK
     C                   MOVE      *ON           *IN99
     C                   MOVEL(P)  '*DIAG'       X@MT
     C                   MOVEL(P)  'F1PK    '    F@FNAM
     C                   MOVEL(P)  'O1PK    '    F@FLIB
     C                   MOVEL     IDF@          X@MDIT
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   RESET                   X@MT
     C                   ENDIF
     C                   RESET                   F1PK
     C                   RESET                   O1PK
      *
      * Always test
     C                   MOVE      *HIVAL        F1AK
     C                   MOVE      *HIVAL        F@AK
     C     F1AK          IFNE      F@AK
     C                   MOVE      *ON           *IN99
     C                   MOVEL(P)  '*DIAG'       X@MT
     C                   MOVEL(P)  'F1AK    '    F@FNAM
     C                   MOVEL(P)  'F@AK    '    F@FLIB
     C                   MOVEL     IDF@          X@MDIT
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   RESET                   X@MT
     C                   ENDIF
     C                   RESET                   F1AK
     C                   RESET                   F@AK
      *
      * Always test
     C                   MOVE      *HIVAL        AK(1)
     C                   MOVE      *HIVAL        BO(1)
     C     AK(1)         IFNE      BO(1)
     C                   MOVE      *ON           *IN99
     C                   MOVEL(P)  '*DIAG'       X@MT
     C                   MOVEL(P)  'AK,1    '    F@FNAM
     C                   MOVEL(P)  'BO,1    '    F@FLIB
     C                   MOVEL     IDF@          X@MDIT
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   RESET                   X@MT
     C                   ENDIF
     C                   RESET                   AK(1)
     C                   RESET                   BO(1)
      *
      * Always test
     C                   MOVE      *HIVAL        F1AK
     C                   MOVE      *HIVAL        AK(1)
     C     F1AK          IFNE      AK(1)
     C                   MOVE      *ON           *IN99
     C                   MOVEL(P)  '*DIAG'       X@MT
     C                   MOVEL(P)  'F1AK    '    F@FNAM
     C                   MOVEL(P)  'AK,1    '    F@FLIB
     C                   MOVEL     IDF@          X@MDIT
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   RESET                   X@MT
     C                   ENDIF
     C                   RESET                   F1AK
     C                   RESET                   AK(1)
      *
      * Always test
     C                   MOVE      *HIVAL        F1AK
     C                   MOVE      *HIVAL        F1R1
     C     F1AK          IFNE      F1R1
     C                   MOVE      *ON           *IN99
     C                   MOVEL(P)  '*DIAG'       X@MT
     C                   MOVEL(P)  'F1AK    '    F@FNAM
     C                   MOVEL(P)  'F1R1    '    F@FLIB
     C                   MOVEL     IDF@          X@MDIT
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   RESET                   X@MT
     C                   ENDIF
     C                   RESET                   F1AK
     C                   RESET                   F1R1
      *
      * Always test
     C                   MOVE      *HIVAL        F1@IOP
     C                   MOVE      *HIVAL        S1@IOP
     C     F1@IOP        IFNE      S1@IOP
     C                   MOVE      *ON           *IN99
     C                   MOVEL(P)  '*DIAG'       X@MT
     C                   MOVEL(P)  'F1@IOP  '    F@FNAM
     C                   MOVEL(P)  'S1@IOP  '    F@FLIB
     C                   MOVEL     IDF@          X@MDIT
     C                   CALL      'QMHSNDPM'    @SNDPM
     C                   RESET                   X@MT
     C                   ENDIF
     C                   RESET                   F1@IOP
     C                   RESET                   S1@IOP
      *
      *
     C     *IN99         IFEQ      *ON
     C                   MOVE      'MSC1001'     X@MI
     C                   MOVEL(P)  '*ESCAPE'     X@MT
     C                   Z-ADD     1             BZ0002
     C                   CALL      'QMHSNDPM'    @SNDPM                 98
     C                   ENDIF
      *
      *
     C                   ENDSR
      *
      *-------------------------------------------------------------------------
     C     *INZSR        BEGSR
      *-------------------------------------------------------------------------
      *
      * Set mode
      /free
       select;
         when e_CallerOpt = ' 5';
           @MODE = '*V99*V99';
         when e_CallerOpt = 'F4';
           @MODE = '*S99*S99';
         other;
           @MODE = '*M99*M99';
       endsl;
      /end-free
      *
      *
     C                   MOVE      I@FKY         I@FKY             2
      *
      *
     C     *LIKE         DEFINE    *IN           D@MOB
     C     *LIKE         DEFINE    *IN           @CHG
     C     *LIKE         DEFINE    S@PGM         X@PGM
     C                   MOVE      *BLANKS       @FMT              4
     C     *LIKE         DEFINE    @FMT          @FMT01
     C     *LIKE         DEFINE    @FMT          @FMT02
     C                   MOVE      @ROLL         @ROLL             1
     C     *LIKE         DEFINE    *IN           @VCF
     C                   MOVE      *BLANKS       KY@DIR            5
     C                   MOVEL     '*'           PGMQ
     C     *DTAARA       DEFINE    *LDA          #LDA
     C                   IN        #LDA
      *
      *
     C     *LIKE         DEFINE    C1SKSN        M1SKSN
     C     *LIKE         DEFINE    C1SUPN        M1SUPN
     C     *LIKE         DEFINE    C1IMPN        M1IMPN
     C     *LIKE         DEFINE    C1DLTD        M1DLTD
      *
      *
     C     *LIKE         DEFINE    BLSKSN        V1SKSN
     C     *LIKE         DEFINE    BLSUPN        V1SUPN
     C     *LIKE         DEFINE    BLIMPN        V1IMPN
     C     *LIKE         DEFINE    IPISBP        V1ISBP
     C     *LIKE         DEFINE    BLDLTD        V1DLTD
      *
      *
     C     *LIKE         DEFINE    C1DLTD        B1DLTD
      *
      *
     C                   MOVE      FLB@11        VCOID
      *
      *
     C                   Z-ADD     0             D@RR1             4 0
     C     *LIKE         DEFINE    D@RR1         D@RR
     C                   Z-ADD     0             I                 5 0
     C     *LIKE         DEFINE    I             J
     C     *LIKE         DEFINE    I             K
     C     *LIKE         DEFINE    *IN           F1@TE
     C     *LIKE         DEFINE    *IN           F1@NRF
     C     *LIKE         DEFINE    *IN           F1@RHC
     C     *LIKE         DEFINE    *IN           F1@COC
     C     *LIKE         DEFINE    *IN           F1@LRU
      *
     C     *LIKE         DEFINE    *IN           D1DO
     C     *LIKE         DEFINE    I             D@VPF1
     C                   Z-ADD     0             D@SE00            2 1
     C     *LIKE         DEFINE    D@SE00        D@SE01
     C     *LIKE         DEFINE    D@SE00        D@SE02
      *
     C     *LIKE         DEFINE    *IN           C1@CE
      *
     C     *LIKE         DEFINE    I             E1
     C     *LIKE         DEFINE    *IN           S1@DO
     C     *LIKE         DEFINE    *IN           S1DO
     C     *LIKE         DEFINE    *IN           S1@WCR
     C     *LIKE         DEFINE    I             S1S
     C     *LIKE         DEFINE    *IN           S1@S1O
     C     *LIKE         DEFINE    I             F1V
     C                   Z-ADD     1             F1V
      *
     C     *LIKE         DEFINE    I             I1
     C     *LIKE         DEFINE    I             O2I1
     C     *LIKE         DEFINE    I             E2
     C     *LIKE         DEFINE    I             W1
     C     *LIKE         DEFINE    I             W2
     C     *LIKE         DEFINE    I             W3
     C     *LIKE         DEFINE    I             I2
      *
     C     *LIKE         DEFINE    *IN           AK@I
     C     *LIKE         DEFINE    I             AK@SQ
      *
     C     *LIKE         DEFINE    *IN           TI@EOF
     C     *LIKE         DEFINE    TITAGC        F2TAGC
     C     *LIKE         DEFINE    DSEQN0        F2SEQN
     C     *LIKE         DEFINE    TIDSQN        F2DSQN
     C     *LIKE         DEFINE    D1CI01        TI@CI
     C     *LIKE         DEFINE    I             TI@LTS
      *
     C     *LIKE         DEFINE    *IN           AU@EOF
     C     *LIKE         DEFINE    AUTAGC        F3TAGC
     C     *LIKE         DEFINE    AUSEQN        F3SEQN
     C     *LIKE         DEFINE    AUDSQN        F3DSQN
     C     *LIKE         DEFINE    D1CI02        AU@CI
     C     *LIKE         DEFINE    I             AU@LTS
      *
      *
     C     *LIKE         DEFINE    *IN           PG@PCK
      *
      *
     C     *LIKE         DEFINE    *IN           @NSU
     C     *LIKE         DEFINE    *IN           @VOR
     C                   MOVE      *OFF          @VOR
      *
      *
      ***C           *LIKE     DEFN I1        P.
      ***C           *LIKE     DEFN I1        I.
      ***C           *LIKE     DEFN W3        W.
      *
      *
     C     *LIKE         DEFINE    S1OPT         X@OPT
     C     *LIKE         DEFINE    I@FKY         X@FKEY
      *
      *
     C     *LIKE         DEFINE    S2CI          T1CI
     C     *LIKE         DEFINE    I             T1I
     C     *LIKE         DEFINE    I             T2I
     C     *LIKE         DEFINE    I             D@PTF
      *
      *
     C     *LIKE         DEFINE    KST@11        F1@KEY
      *
      *
     C     *LIKE         DEFINE    BLISBN        X@ISBN
     C                   MOVE      X@EFLG        X@EFLG            1
     C     @M11IS        PLIST
     C                   PARM                    X@ISBN
     C                   PARM                    X@EFLG
      *
      *
     C     *LIKE         DEFINE    C1SUPN        X@SUPN
     C     SO1730        PLIST
     C                   PARM      S@PGM         X@PGM
     C                   PARM      'F4'          X@OPT
     C     I@FKY         PARM      *BLANKS       X@FKEY
     C                   PARM      *ZERO         X@SUPN
     C     I@EC          PARM                    X@EC
      *
      *
     C     *LIKE         DEFINE    C1SKSN        X@SKSN
     C     *LIKE         DEFINE    C1IMPN        X@IMPN
     C     *LIKE         DEFINE    C1DLTD        X@DLTD
     C     SO1710        PLIST
     C                   PARM      S@PGM         X@PGM
     C                   PARM      'F4'          X@OPT
     C     I@FKY         PARM      *BLANKS       X@FKEY
     C                   PARM      *BLANKS       X@SKSN
     C                   PARM      *ZERO         X@SUPN
     C                   PARM      *ZERO         X@IMPN
     C                   PARM      'Y'           X@DLTD
     C                   PARM      *BLANKS       X@ISBN
     C     I@EC          PARM                    X@EC
      *
      *
     C     F1KEY1        KLIST
     C                   KFLD                    BLISBN
     C     F1R1K1        KLIST
     C                   KFLD                    F1ISBN
     C     F1R2K1        KLIST
     C                   KFLD                    F1SUPN
     C                   KFLD                    F1SKSN
     C                   KFLD                    F1ISBN
     C     F1R2K2        KLIST
     C                   KFLD                    F1SUPN
     C     F1R3K1        KLIST
     C                   KFLD                    F1SKSN
     C                   KFLD                    F1ISBN
     C     F1R4K1        KLIST
     C                   KFLD                    F1SUPN
     C                   KFLD                    F1ISBN
     C     F1R4K2        KLIST
     C                   KFLD                    F1SUPN
      *
      *
     C     ESKEY1        KLIST
     C                   KFLD                    ESUPN4
      *
      *
     C     IPKEY1        KLIST
     C                   KFLD                    IPIMPN
      *
      *
     C     MTKEY1        KLIST
     C                   KFLD                    MTTAGC
      *
      *
     C     BNKEY1        KLIST
     C                   KFLD                    BNBIND
      *
      *
     C     TIKEY1        KLIST
     C                   KFLD                    EISBN3
     C                   KFLD                    TITAGC
     C                   KFLD                    DSEQN0
     C                   KFLD                    TIDSQN
     C     TIKEY2        KLIST
     C                   KFLD                    EISBN3
     C     TIKEY3        KLIST
     C                   KFLD                    EISBN3
     C                   KFLD                    TITAGC
     C                   KFLD                    DSEQN0
      *
      *
     C     AUKEY1        KLIST
     C                   KFLD                    AUISBN
     C                   KFLD                    AUTAGC
     C                   KFLD                    AUSEQN
     C                   KFLD                    AUDSQN
     C     AUKEY2        KLIST
     C                   KFLD                    AUISBN
     C     AUKEY3        KLIST
     C                   KFLD                    AUISBN
     C                   KFLD                    AUTAGC
     C                   KFLD                    AUSEQN
      *
      *
     C     @SNDPM        PLIST
     C                   PARM                    X@MI              7
     C                   PARM      C@PMFN        X@QMFN           20
     C                   PARM                    X@MDIT          256
     C                   PARM                    X@LOMD
     C                   PARM                    X@MT             10
     C                   PARM                    X@PMQ            10
     C                   PARM                    X@PSC
     C                   PARM                    X@MK
     C                   PARM                    X@EC
      *
      *
     C     @SNDSM        PLIST
     C                   PARM                    X@MI
     C                   PARM      C@SMFN        X@QMFN
     C                   PARM                    X@MDIT
     C                   PARM                    X@LOMD
     C                   PARM                    X@MT
     C                   PARM                    X@PMQ
     C                   PARM                    X@PSC
     C                   PARM                    X@MK
     C                   PARM                    X@EC
      *
      *
     C                   MOVEL(P)  '*DIAG   '    X@MT
     C                   MOVEL(P)  '*'           X@PMQ
      *
      *
     C     @CVTDT        PLIST
     C                   PARM                    X@IDF            10
     C                   PARM                    X@ID
     C                   PARM                    X@ODF            10
     C                   PARM                    X@OD
     C                   PARM                    X@EC
      *
      *
     C     @CVTFD        PLIST
     C                   PARM      '*YYMD'       X@IDF
     C                   PARM                    X@ID
     C                   PARM      '*JOB'        X@ODF
     C                   PARM                    X@OD
     C                   PARM                    X@EC
      *
      *
     C     @CVTDD        PLIST
     C                   PARM      '*JOB'        X@IDF
     C                   PARM                    X@ID
     C                   PARM      '*YYMD'       X@ODF
     C                   PARM                    X@OD
     C                   PARM                    X@EC
      *
      *
     C     @CNVCS        PLIST
     C                   PARM      @RCB          X@RCB            22
     C                   PARM                    X@SID
     C                   PARM                    X@SOD
     C                   PARM                    X@LOD             4
     C                   PARM                    X@EC
      *
      *
     C     @RMVPM        PLIST
     C                   PARM      '*'           X@PMQ
     C                   PARM                    X@PSC
     C                   PARM      *BLANKS       X@MKTR            4
     C                   PARM      '*ALL    '    X@MTR            10
     C                   PARM                    X@EC
      *
      *
     C                   ENDSR
      /free
       // -------------------------------------------------------------------------
       /define SO1710_GetListFileSequence
       /include SO1710_H
       // -------------------------------------------------------------------------
       select;
         when C1SUPN <> *zero and C1SKSN <> '*ALL';
           return 2;
         when C1SUPN <> *zero;
           return 4;
         when C1SKSN <> '*ALL';
           return 3;
         other;
           return 1;
       endsl;
      /end-free
     P                 E

      /free
       // -------------------------------------------------------------------------
       /define SO1710_IndexBeforeListFile
       /include SO1710_H
       // -------------------------------------------------------------------------
       FileSequence=SO1710_GetListFileSequence();
       select;
         when FileSequence = 1;
           setll F1R1K1 DTAF1R1;
         when FileSequence = 2;
           setll F1R2K1 DTAF1R2;
         when FileSequence = 3;
           setll F1R3K1 DTAF1R3;
         when FileSequence = 4;
           setll F1R4K1 DTAF1R4;
       endsl;
      /end-free
     P                 E

      /free
       // -------------------------------------------------------------------------
       /define SO1710_IndexAfterListFile
       /include SO1710_H
       // -------------------------------------------------------------------------
       FileSequence=SO1710_GetListFileSequence();
       select;
         when FileSequence = 1;
           setgt F1R1K1 DTAF1R1;
         when FileSequence = 2;
           setgt F1R2K1 DTAF1R2;
         when FileSequence = 3;
           setgt F1R3K1 DTAF1R3;
         when FileSequence = 4;
           setgt F1R4K1 DTAF1R4;
       endsl;
      /end-free
     P                 E

      /free
       // -------------------------------------------------------------------------
       /define SO1710_ReadValidListFile
       /include SO1710_H
       // -------------------------------------------------------------------------
       f1@sq = SO1710_GetListFileSequence();
       dou SO1710_ValidateListFile();
         select;
           when f1@sq = 1;
             read(n) DTAF1R1;
           when f1@sq = 2;
             reade(n) F1R2K2 DTAF1R2;
           when f1@sq = 3;
             read(n) DTAF1R3;
           when f1@sq = 4;
             reade(n) F1R4K2 DTAF1R4;
         endsl;
         F1@EOF = %eof;
         if F1@EOF;
           return *on;
         else;
           F1@EOF = SO1710_ValidateEOFListFile();
           return F1@EOF;
         endif;
       enddo;
       return *off;
      /end-free
     P                 E

      /free
       // -------------------------------------------------------------------------
       /define SO1710_ReadPreviousValidListFile
       /include SO1710_H
       // -------------------------------------------------------------------------
       f1@sq = SO1710_GetListFileSequence();
       dou SO1710_ValidateListFile;
         select;
           when f1@sq = 1;
             readp(n) DTAF1R1;
           when f1@sq = 2;
             readpe(n) F1R2K2 DTAF1R2;
           when f1@sq = 3;
             readp(n) DTAF1R3;
           when f1@sq = 4;
             readpe(n) F1R4K2 DTAF1R4;
         endsl;
         F1@EOF = %eof;
         if F1@EOF;
           return *on;
         else;
           F1@EOF = SO1710_ValidateEOFListFile();
           return F1@EOF;
         endif;
       enddo;
       return *off;
      /end-free
     P                 E

      /free
       // -------------------------------------------------------------------------
       /define SO1710_ValidateListFile
       /include SO1710_H
       // -------------------------------------------------------------------------
       select;
         when C1DLTD <> '*' and V1DLTD <> BLDLTD;
           return *off;
       endsl;

       select;
         when C1SKSN = '*BLANKS' and V1SKSN <> BLSKSN;
             return *off;
         when C1SKSN <> '*ALL';
           i = %scan('*' : C1SKSN);
           if i = *zero;
             i = 10;
           else;
             i -= 1;
           endif;
           if V1SKSN <> %subst(BLSKSN:1:i);
             return *off;
           endif;
       endsl;

       select;
         when C1SUPN <> *zero and V1SUPN <> BLSUPN;
           return *off;
       endsl;
       select;
         when C1IMPN <> *zero;
           i = %checkr(' ':V1ISBP);
           if i = *zero;
             i = 8;
           endif;
           if V1ISBP <> %subst(BLISBN:1:i);
             return  *off;
           endif;
       endsl;

       return *on;
      /end-free
     P                 E
      /free
       // -------------------------------------------------------------------------
       /define SO1710_ValidateEOFListFile
       /include SO1710_H
       // WARNING: The program makes some assumptions that the logical file
       //            selected matches these tests - in order sequence.
       //          EOF test should not be performed on out of sequence records.
       // -------------------------------------------------------------------------
       select;
         when C1SKSN = '*BLANKS' and V1SKSN <> BLSKSN;
           return *on;
         when C1SKSN <> '*ALL';
           i = %scan('*':C1SKSN);
           if i = *zero;
             i = 10;
           else;
             i -= 1;
           endif;
           if V1SKSN <> %subst(BLSKSN:1:i);
             return *on;
           endif;
       endsl;

       select;
         when C1SUPN  <> *zero and V1SUPN <> BLSUPN;
           return *on;
       endsl;

       select;
         when C1IMPN <> *ZERO;
           i = %checkr(' ':V1ISBP);
           if i = *zero;
             i = 8;
           ENDIF;
           if V1ISBP <> %subst(BLISBN:1:i);
             return *on;
           endif;
       endsl;

       return *off;
      /end-free
     P                 E
