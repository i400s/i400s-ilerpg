      /if NOT defined(included_h)
      *-------------------------------------------------------------------------
      * Global definitions.
      *-------------------------------------------------------------------------
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

      /define included_h
