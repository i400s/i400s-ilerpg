      *-------------------------------------------------------------------------
      * Procedure name: SflPageStatus
      * Purpose:        Returns a more descriptive SFLEND decorator showing
      *                   when a previous subfile page exists.
      * Returns:        SflPageStatus
      * Parameter:      SflRRN     => RRN of subfile record.
      * Parameter:      SflPag     => Size of a page of subfile records
      * Parameter:      EOF        => File EOF status
      *-------------------------------------------------------------------------
     D DspFmt_SflPageStatus...
     D                 PR             3A
     D  SflRRN                        5P 0 CONST
     D  SflPage                       5P 0 CONST
     D  EOF                           1N   CONST
