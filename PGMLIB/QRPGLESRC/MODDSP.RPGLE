     H nomain

      /include qincprsrc,moddsp

      *-------------------------------------------------------------------------
      * Procedure name: SflPageStatus
      * Purpose:        Returns a more descriptive SFLEND decorator showing
      *                   when a previous subfile page exists.
      * Returns:        SflPageStatus
      * Parameter:      SflRRN     => RRN of subfile record.
      * Parameter:      SflPag     => Size of a page of subfile records
      * Parameter:      EOF        => File EOF status
      *-------------------------------------------------------------------------
     P SflPageStatus   B                   EXPORT
     D SflPageStatus   PI             3A
     D  SflRRN                        5P 0 CONST
     D  SflPage                            LIKE(SflRRN)
     D                                     CONST
     D  EOF                           1N   CONST
      *-------------------------------------------------------------------------

      * Local fields
     D SflPageStatus   S              3A

      /free

        select;
          when %rem(SflRRN:SflPage) <> 0; // Not last record on subfile page.
                  clear SflPageStatus;
          when SflRRN > SflPage and not EOF;
                  SflPageStatus = '-/+';
          when not eof;
                  SflPageStatus = ' /+';
          when SflRRN > SflPage and EOF;
                  SflPageStatus = '-/ ';
          when SflRRN > SflPage;
                  SflPageStatus = '-/+';
          other;
                  SflPageStatus = ' / ';
        endsl;

        return SflPageStatus;

      /end-free

     P SflPageStatus   E

