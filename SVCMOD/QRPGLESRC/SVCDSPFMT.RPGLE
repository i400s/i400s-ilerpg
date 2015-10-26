      /define SvcMod
      /include qincprsrc,StdHSpec
      /include qincprsrc,SvcDspFmt

      *-------------------------------------------------------------------------
      * Procedure name: SflPageStatus
      * Purpose:        Returns a more descriptive SFLEND decorator showing
      *                   when a previous subfile page exists as well as the.
      *                   current pages SFLEND status.
      * Returns:        SflPageStatus
      * Parameter:      SflRRN     => RRN of subfile record.
      * Parameter:      SflPag     => Size of a page of subfile records
      * Parameter:      EOF        => File EOF status
      *-------------------------------------------------------------------------
     P DspFmt_SflPageStatus...
     P                 B                   EXPORT
     D DspFmt_SflPageStatus...
     D                 PI             3A
     D  SflRRN                        5P 0 CONST
     D  SflPage                            LIKE(SflRRN)
     D                                     CONST
     D  EOF                           1N   CONST
      *-------------------------------------------------------------------------

      * Local fields

      /free

        select;
          when %rem(SflRRN:SflPage) <> 0; // Not last record on subfile page.
                  return '   ';
          when SflRRN > SflPage and EOF;
                  return '-/ ';
          when SflRRN > SflPage;
                  return '-/+';
          when eof;
                  return ' / ';
          other;
                  return ' /+';
        endsl;

        eval *inlr =*on;
        return *blanks;

      /end-free

     P                 E

