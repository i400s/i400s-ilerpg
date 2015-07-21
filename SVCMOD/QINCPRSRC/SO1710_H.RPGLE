      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Global definitions.
      *-------------------------------------------------------------------------
     D f1@sq           S              3I 0
     D f1@eof          S              1N
     D f1@vr           S              1N
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
     D WK010C          S             10A
     D WK008C          S              8A
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
     D WK010C          S             10A
     D WK008C          S              8A
      /EOF
      /endif

      /define included_h
