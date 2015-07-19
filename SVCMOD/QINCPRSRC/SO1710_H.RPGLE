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
      /undefine SO1710_GetListSequence
     P SO1710_GetListFileSequence...
     P                 B
     D SO1710_GetListFileSequence...
     D                 PI                  like(f1@sq)
      /EOF
      /endif

      /define included_h
