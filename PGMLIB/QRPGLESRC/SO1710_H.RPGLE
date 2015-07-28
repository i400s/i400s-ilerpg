      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Global definitions.
      *-------------------------------------------------------------------------
      *
      * Display file information data structure
     D D@INFD          DS
     D  ReturnKey            369    369
     D  D@ROCL               370    371B 0
     D  D@RRN                376    377B 0
     D  D@RRL                378    379B 0
     D  D@RRT                380    381B 0
     D  D@@@@                372    385
      *
     D Key_F1          C                   CONST(X'31')
     D Key_F2          C                   CONST(X'32')
     D Key_F3          C                   CONST(X'33')
     D Key_F4          C                   CONST(X'34')
     D Key_F5          C                   CONST(X'35')
     D Key_F6          C                   CONST(X'36')
     D Key_F7          C                   CONST(X'37')
     D Key_F8          C                   CONST(X'38')
     D Key_F9          C                   CONST(X'39')
     D Key_F10         C                   CONST(X'3A')
     D Key_F11         C                   CONST(X'3B')
     D Key_F12         C                   CONST(X'3C')
     D Key_F13         C                   CONST(X'B1')
     D Key_F14         C                   CONST(X'B2')
     D Key_F15         C                   CONST(X'B3')
     D Key_F16         C                   CONST(X'B4')
     D Key_F17         C                   CONST(X'B5')
     D Key_F18         C                   CONST(X'B6')
     D Key_F19         C                   CONST(X'B7')
     D Key_F20         C                   CONST(X'B8')
     D Key_F21         C                   CONST(X'B9')
     D Key_F22         C                   CONST(X'BA')
     D Key_F23         C                   CONST(X'BB')
     D Key_F24         C                   CONST(X'BC')
     D Key_Clear       C                   CONST(X'BD')
     D Key_Enter       C                   CONST(X'F1')
     D Key_Help        C                   CONST(X'F3')
     D Key_PageUp      C                   CONST(X'F4')
     D Key_PageDown    C                   CONST(X'F5')
     D RollDown        C                   CONST(X'F4')
     D RollUp          C                   CONST(X'F5')
     D Key_Print       C                   CONST(X'F6')
     D Key_RecBackSpc  C                   CONST(X'F8')
     D Key_AutoEnter   C                   CONST(X'3F')

     D SflRcd_Control...
     D                 C                   const('00')
     D SflRcd_Detail...
     D                 C                   const('10')
     D SflRcd_Blank...
     D                 C                   const('01')
     D SflRcd_NoRecords...
     D                 C                   const('11')

     D p_Indicators    s               *   inz(%addr(*in))
     D Indicators      ds            99    based(p_Indicators)
     D                                     qualified
     D  SflRcdType                    2A   overlay(Indicators:1)
     D   Dtl                          1N   overlay(SflRcdType:1)
      *
      * Program status data structure
     D                SDS
     D  S@PGM            *PROC
     D  S@USER               254    263
      *
      *
     D f1@sq           S              3I 0
      /endif


      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Procedure name: SO1710_GetListFileSequence
      * Purpose:        Determines which file is the correct one to be used
      *                   to present the work with list subfile.
      * Returns:        FileSequence
      * Parameter:      *NONE      => All parameters are global variables.
      *-------------------------------------------------------------------------
     D SO1710_GetListFileSequence...
     D                 PR                  like(f1@sq)
      /endif
      *-------------------------------------------------------------------------
      /if defined(SO1710_GetListFileSequence)
      /undefine SO1710_GetListFileSequence
     P SO1710_GetListFileSequence...
     P                 B
     D SO1710_GetListFileSequence...
     D                 PI                  like(f1@sq)
      /EOF
      /endif


      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Procedure name: SO1710_IndexBeforeListFile
      * Purpose:        Sets lower limit for ListFile.
      * Returns:        *NONE
      * Parameter:      *NONE      => All parameters are global variables.
      *-------------------------------------------------------------------------
     D SO1710_IndexBeforeListFile...
     D                 PR
      /endif
      *-------------------------------------------------------------------------
      /if defined(SO1710_IndexBeforeListFile)
      /undefine SO1710_IndexBeforeListfile
     P SO1710_IndexBeforeListFile...
     P                 B
     D SO1710_IndexBeforeListFile...
     D                 PI
     D FileSequence    S                   like(f1@sq)
      /EOF
      /endif


      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Procedure name: SO1710_IndexAfterListFile
      * Purpose:        Sets greater limit for ListFile.
      * Returns:        *NONE
      * Parameter:      *NONE      => All parameters are global variables.
      *-------------------------------------------------------------------------
     D SO1710_IndexAfterListFile...
     D                 PR
      /endif
      *-------------------------------------------------------------------------
      /if defined(SO1710_IndexAfterListFile)
      /undefine SO1710_IndexAfterListfile
     P SO1710_IndexAfterListFile...
     P                 B
     D SO1710_IndexAfterListFile...
     D                 PI
     D FileSequence    S                   Like(f1@sq)
      /EOF
      /endif


      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Procedure name: SO1710_ReadValidListFile
      * Purpose:        Reads ListFile and tests record validity.
      * Returns:        EndOfFile
      * Parameter:      *NONE      => All parameters are global variables.
      *-------------------------------------------------------------------------
     D SO1710_ReadValidListFile...
     D                 PR             1N
      /endif
      *-------------------------------------------------------------------------
      /if defined(SO1710_ReadValidListFile)
      /undefine SO1710_ReadValidListFile
     P SO1710_ReadValidListFile...
     P                 B
     D SO1710_ReadValidListFile...
     D                 PI             1N
     D FileSequence    S                   Like(f1@sq)
      /EOF
      /endif


      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Procedure name: SO1710_ReadPreviousValidListFile
      * Purpose:        Reads ListFile and tests record validity.
      * Returns:        EndOfFile
      * Parameter:      *NONE      => All parameters are global variables.
      *-------------------------------------------------------------------------
     D SO1710_ReadPreviousValidListFile...
     D                 PR             1N
      /endif
      *-------------------------------------------------------------------------
      /if defined(SO1710_ReadPreviousValidListFile)
      /undefine SO1710_ReadPreviousValidListFile
     P SO1710_ReadPreviousValidListFile...
     P                 B
     D SO1710_ReadPreviousValidListFile...
     D                 PI             1N
     D FileSequence    S                   Like(f1@sq)
      /EOF
      /endif

      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Procedure name: SO1710_ValidateListFile
      * Purpose:        Validates ListFile records according to subset tests.
      * Returns:        IsValid
      * Parameter:      *NONE      => All parameters are global variables.
      *-------------------------------------------------------------------------
     D SO1710_ValidateListFile...
     D                 PR             1N
      /endif
      *-------------------------------------------------------------------------
      /if defined(SO1710_ValidateListFile)
      /undefine SO1710_ValidateListFile
     P SO1710_ValidateListFile...
     P                 B
     D SO1710_ValidateListFile...
     D                 PI             1N
      /EOF
      /endif


      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Procedure name: SO1710_ValidateEOFListFile
      * Purpose:        Validates ListFile records according to subset tests
      *                   and decides if any potential further records would
      *                   always test false, in which case count as "EOF".
      * Returns:        EndOfFile
      * Parameter:      *NONE      => All parameters are global variables.
      *-------------------------------------------------------------------------
     D SO1710_ValidateEOFListFile...
     D                 PR             1N
      /endif
      *-------------------------------------------------------------------------
      /if defined(SO1710_ValidateEOFListFile)
      /undefine SO1710_ValidateEOFListFile
     P SO1710_ValidateEOFListFile...
     P                 B
     D SO1710_ValidateEOFListFile...
     D                 PI             1N
      /EOF
      /endif

      /define included_h
