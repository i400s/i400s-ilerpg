      *-------------------------------------------------------------------------
      * Description  : Data Service program/procedures
      * Programmer   : Jonathan Wilson
      * Date Created : 30/07/2015
      *-------------------------------------------------------------------------
      /define SrvMod
      /include qincprsrc,StdHSpec

      *-------------------------------------------------------------------------
      *     [AU] Author
     FMTAUTHP   IF   E           K DISK    usropn
      *-------------------------------------------------------------------------
      *     [BL] Bibliographic
     FMTBIBLL1  IF   E           K DISK    usropn
     F                                     rename(MTBIBLF:MTBIBLF1)
     FMTBIBLL2  IF   E           K DISK    usropn
     F                                     rename(MTBIBLF:MTBIBLF2)
     FMTBIBLL3  IF   E           K DISK    usropn
     F                                     rename(MTBIBLF:MTBIBLF3)
     FMTBIBLL4  IF   E           K DISK    usropn
     F                                     rename(MTBIBLF:MTBIBLF4)
      *-------------------------------------------------------------------------
      * [IP] Imprint
     FMTIMPNP   IF   E           K DISK    usropn

      *
      *-------------------------------------------------------------------------
      * Global data and procedure specifications
      *-------------------------------------------------------------------------
      /include StdDSpec
      * Special define to remove "const" and make fields "reference" internally
      /define SrvDta_
      * Header file
      /include SrvDta_h

      /free
       // ----------------------------------------------------------------------
       // Procedure       : SRVDTA_GetAuthor
       // Description     : Get Author
       // Returns         :< IsFound
       // Parameter      >:< Author
       //                >:  Keys
       //                ?:  KeysType
       /define SRVDTA_GetAuthor
       /include SrvDta_H
       // ----------------------------------------------------------------------

       // test inputs
       if %parms < 2; // not enough parameters
            QmhSndPgmMsg('CPF24B4':
                         MsgFileQCPF:    // Message file
                         '':             // Message data
                         0:              // Length of message data
                         '*ESCAPE':      // Message type
                         '*':            // Call stack entry
                         1:              // Call stack count
                         '':             // Message key
                         x'00000000');   // API error DS
       endif;

       if %parms >= 3; // Keys type passed
            p_KeysType = %addr(KeysType); // Set pointer
            if p_KeysType <> *null;
                 if KeysType = '*ALLKEY';
                      p_KeysType = *null; // Unset pointer = '*ALLKEY'
                 else;
                      QmhSndPgmMsg('MSG2010':      // Keys type '&1' is invalid
                                   MsgFileLMMSGF:  // Message file
                                   keysType:       // Message data
                                   %len(KeysType): // Length of message data
                                   '*ESCAPE':      // Message type
                                   '*':            // Call stack entry
                                   1:              // Call stack count
                                   '':             // Message key
                                   x'00000000');   // API error DS
                 endif;
            endif;
       endif;

       // Parameters are valid, process request
       return GetAuthor(Author:
                        %addr(Keys):
                        p_KeysType);

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetAuthor
       // Description     : Get Author
       // Returns         :< IsFound
       // Parameter      >:< Author
       //                >:  Keys
       //                >:  KeysType
       /define GetAuthor
       /include SrvDta_H
       // ----------------------------------------------------------------------

       if OpenMTAUTHP;
            Select;
            when p_KeysType = *null; // Default '*ALLKEY'
                 setll (AuthorKeys.ISBN:
                        AuthorKeys.MARCTag:
                        AuthorKeys.Sequence) MTAUTHF;
                 reade (AuthorKeys.ISBN:
                        AuthorKeys.MARCTag:
                        AuthorKeys.Sequence) MTAUTHF;
                 if %eof(MTAUTHP);
                      return *off;
                 else;
                      clear Author;
                      Author(1).ISBN = AUISBN;
                      Author(1).MARCTag = AUTAGC;
                      Author(1).Sequence = AUSEQN;
                      Author(1).CreatedDTS = %timestamp(); // TODO
                      Author(1).ChangedDTS = %timestamp(); // TODO
                      dow not %eof(MTAUTHP);
                           Author(1).Name += AUAUTN;
                           reade (AuthorKeys.ISBN:
                                  AuthorKeys.MARCTag:
                                  AuthorKeys.Sequence) MTAUTHF;
                      enddo;
                      Author(2) = Author(1); // Make copies identical
                      return *on;
                 endif;
            other; // Problem, flag as no record found
                 return *off;
            endsl;
       endif;
      /end-free
     P                 E

      /free
       // -------------------------------------------------------------------------
       // Opens file and returns indicator showing success
       /define OpenMTAUTHP
       /include SrvDta_H
       // -------------------------------------------------------------------------
       If IsOpen;
            return IsOpen;
       else;
            monitor;
                 open MTAUTHP;
                 IsOpen = *on;
            on-error;
                 IsOpen = *off;
            endmon;
            return IsOpen;
       endif;
      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : SRVDTA_GetBibliographicFirst
       // Description     : Get Bibliographic data
       // Returns         :< IsFound
       // Parameter      >:< Data
       //                ?:  Keys
       //                ?:  Subset
       //                ?:  ReturnFmt
       //                ?:  Access
       /define SRVDTA_GetBibliographicFirst
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       // test inputs
       if %parms < 1
       or %parms > 5;
            QmhSndPgmMsg('MSG2001':      // Incorrect parm no's
                         MsgFileLMMSGF:  // Message file
                         '':             // Message data
                         0:              // Length of message data
                         '*ESCAPE':      // Message type
                         '*':            // Call stack entry
                         1:              // Call stack count
                         '':             // Message key
                         x'00000000');   // API error DS
       endif;

       if %parms >= 1; // Bibliographic data
            p_Data = %addr(Data);
       endif;

       if %parms >= 2; // Bibliographic keys
            p_Keys = %addr(Keys);
       endif;

       if %parms >= 3; // Subset
            p_Subset = %addr(Subset);
       endif;

       if %parms >= 4; // Return format
            p_ReturnFmt = %addr(ReturnFmt);
            select;
            when p_ReturnFmt <> *null
            and %scan(ReturnFmt:ReturnFmtOpts) = 0;
                 QmhSndPgmMsg('MSG2009':       // Invalid return format
                              MsgFileLMMSGF:   // Message file
                              ReturnFmt:       // Message data
                              %len(ReturnFmt): // Length of message data
                              '*ESCAPE':       // Message type
                              '*':             // Call stack entry
                              1:               // Call stack count
                              '':              // Message key
                              x'00000000');    // API error DS
            when p_ReturnFmt <> *null
            and %scan(ReturnFmt:ReturnFmtOpts) = 1;
                 p_ReturnFmt = *null; // Default option - *NONE
            endsl;
            if p_ReturnFmt <> *null
            and p_Data = *null;
                 QmhSndPgmMsg('MSG200A':       // Data return specified but no da
                              MsgFileLMMSGF:   // Message file
                              ReturnFmt:       // Message data
                              %len(ReturnFmt): // Length of message data
                              '*ESCAPE':       // Message type
                              '*':             // Call stack entry
                              1:               // Call stack count
                              '':              // Message key
                              x'00000000');    // API error DS

            endif;
       endif;

       if %parms >= 5; // Access
            p_Access = %addr(Access);
            select;
            when p_Access <> *null
            and %scan(%trimr(Access):AccessOpts) = 0;
                 QmhSndPgmMsg('MSG200B':      // Access type '&1' is invalid
                              MsgFileLMMSGF:  // Message file
                              Access:         // Message data
                              %len(Access):   // Length of message data
                              '*ESCAPE':      // Message type
                              '*':            // Call stack entry
                              1:              // Call stack count
                              '':             // Message key
                              x'00000000');   // API error DS
            when p_Access <> *null
            and %scan(%trimr(Access):AccessOpts) = 1;
                 p_Access = *null; // Use default = *NOKEYS
            endsl;
       endif;

       if p_Access = *null; // *NOKEYS
            p_Keys = *null; // Don't pass keys
       endif;

       // Parameters are valid, process request
       return GetBibliographicFirst(p_Data:
                                    p_Keys:
                                    p_Subset:
                                    p_ReturnFmt:
                                    p_Access);

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : SRVDTA_GetBibliographicNext
       // Description     : Get Bibliographic data
       // Returns         :< IsFound
       // Parameter      >:< Data
       //                >:  Keys
       //                ?:  Subset
       //                ?:  ReturnFmt
       //                ?:  Access
       /define SRVDTA_GetBibliographicNext
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       // test inputs
       if %parms < 2
       or %parms > 5;
            QmhSndPgmMsg('MSG2001':      // Incorrect parm no's
                         MsgFileLMMSGF:  // Message file
                         '':             // Message data
                         0:              // Length of message data
                         '*ESCAPE':      // Message type
                         '*':            // Call stack entry
                         1:              // Call stack count
                         '':             // Message key
                         x'00000000');   // API error DS
       endif;

       if %parms >= 1; // Bibliographic data
            p_Data = %addr(Data); // Set pointer
       endif;

       if %parms >= 2; // Bibliographic keys
            p_Keys = %addr(Keys); // Set pointer
       endif;

       if %parms >= 3; // Subset
            p_Subset = %addr(Subset);
       endif;

       if %parms >= 4; // Return format
            p_ReturnFmt = %addr(ReturnFmt);
            select;
            when p_ReturnFmt <> *null
            and %scan(%trimr(ReturnFmt):ReturnFmtOpts) = 0;
                 QmhSndPgmMsg('MSG2009':       // Invalid return format
                              MsgFileLMMSGF:   // Message file
                              ReturnFmt:       // Message data
                              %len(ReturnFmt): // Length of message data
                              '*ESCAPE':       // Message type
                              '*':             // Call stack entry
                              1:               // Call stack count
                              '':              // Message key
                              x'00000000');    // API error DS
            when p_ReturnFmt <> *null
            and %scan(%trimr(ReturnFmt):ReturnFmtOpts) = 1;
                 p_ReturnFmt = *null; // Default option - *NOKEYS
            endsl;
            if p_ReturnFmt <> *null
            and p_Data = *null;
                 QmhSndPgmMsg('MSG200A':       // Data return specified but no da
                              MsgFileLMMSGF:   // Message file
                              ReturnFmt:       // Message data
                              %len(ReturnFmt): // Length of message data
                              '*ESCAPE':       // Message type
                              '*':             // Call stack entry
                              1:               // Call stack count
                              '':              // Message key
                              x'00000000');    // API error DS

            endif;
       endif;

       if %parms >= 5; // Access
            p_Access = %addr(Access);
            select;
            when p_Access <> *null
            and %scan(%trimr(Access):AccessOpts) = 0;
                 QmhSndPgmMsg('MSG200B':      // Access type '&1' is invalid
                              MsgFileLMMSGF:  // Message file
                              Access:         // Message data
                              %len(Access):   // Length of message data
                              '*ESCAPE':      // Message type
                              '*':            // Call stack entry
                              1:              // Call stack count
                              '':             // Message key
                              x'00000000');   // API error DS
            when p_Access <> *null
            and %scan(%trimr(Access):AccessOpts) = 1;
                 p_Access = *null; // Use default = *BYKEYS
            endsl;
       endif;

       // Parameters are valid, process request
       return GetBibliographicNext(p_Data:
                                   p_Keys:
                                   p_Subset:
                                   p_ReturnFmt:
                                   p_Access);

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetBibliographicFirst
       // Description     : Get first bibligraphic data
       // Returns         :< IsFound
       // Parameter      >:< p_Data
       //                >:  p_Keys
       //                >:  p_Subset
       //                >:  p_ReturnFmt
       //                >:  p_Access
       /define GetBibliographicFirst
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       MTBIBLSubset.SupplierNo = 0;
       MTBIBLSubset.SearchKeyPfx = GetSearchKeyPfx('*ALL');
       MTBIBLSubset.ImprintPfx = GetImprintPfx(0);
       MTBIBLSubset.Deleted = '*';
       MTBIBLSubset.ISBN = *blanks;

       if p_Subset <> *null;
            MTBIBLSubset.SupplierNo = Subset.SupplierNo;
            MTBIBLSubset.SearchKeyPfx = GetSearchKeyPfx(Subset.SearchKey);
            MTBIBLSubset.ImprintPfx = GetImprintPfx(Subset.ImprintNo);
            MTBIBLSubset.Deleted = Subset.Deleted;
       endif;

       Record.BLISBN = MTBIBLSubset.ImprintPfx.Prefix;
       Record.BLSUPN = MTBIBLSubset.SupplierNo;
       Record.BLSKSN = MTBIBLSubset.SearchKeyPfx.Prefix;

       if p_Keys <> *null;
            Record.BLISBN = Keys.ISBN;
            Record.BLSUPN = Keys.SupplierNo;
            Record.BLSKSN = Keys.SearchKey;
       endif;

       Sequence = GetMTBIBLSequence(MTBIBLSubset);
       select;
       when Sequence = 1
       and not GetMTBIBLF1First(Record:
                                MTBIBLSubset:
                                '*first');
            return *off;
       when Sequence = 2
       and not GetMTBIBLF2First(Record:
                                MTBIBLSubset:
                                '*first');
            return *off;
       when Sequence = 3
       and not GetMTBIBLF3First(Record:
                                MTBIBLSubset:
                                '*first');
            return *off;
       when Sequence = 4
       and not GetMTBIBLF4First(Record:
                                MTBIBLSubset:
                                '*first');
            return *off;
       endsl;

       if p_Data = *null
       or p_ReturnFmt = *null;
            return *on;
       endif;

       // Setup keys for return
       Data.Keys.ISBN = Record.BLISBN;
       Data.Keys.SupplierNo = Record.BLSUPN;
       Data.Keys.SearchKey = Record.BLSKSN;

       if ReturnFmt = '*KEYSONLY';
            return *on;
       endif;

       if ReturnFmt = '*ALL';
            // Setup data for return
            Data.Record(1) = Record;
            Data.Record(2) = Data.Record(1);
            return *on;
       endif;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetBibliographicNext
       // Description     : Get next bibligraphic data
       // Returns         :< IsFound
       // Parameter      >:< p_Data
       //                >:  p_Keys
       //                >:  p_Subset
       //                >:  p_ReturnFmt
       //                >:  p_Access
       /define GetBibliographicNext
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       MTBIBLSubset.SupplierNo = 0;
       MTBIBLSubset.SearchKeyPfx = GetSearchKeyPfx('*ALL');
       MTBIBLSubset.ImprintPfx = GetImprintPfx(0);
       MTBIBLSubset.Deleted = '*';
       MTBIBLSubset.ISBN = *blanks;

       if p_Subset <> *null;
            MTBIBLSubset.SupplierNo = Subset.SupplierNo;
            MTBIBLSubset.SearchKeyPfx = GetSearchKeyPfx(Subset.SearchKey);
            MTBIBLSubset.ImprintPfx = GetImprintPfx(Subset.ImprintNo);
            MTBIBLSubset.Deleted = Subset.Deleted;
       endif;

       Record.BLISBN = MTBIBLSubset.ImprintPfx.Prefix;
       Record.BLSUPN = MTBIBLSubset.SupplierNo;
       Record.BLSKSN = MTBIBLSubset.SearchKeyPfx.Prefix;

       if p_Keys <> *null;
            Record.BLISBN = Keys.ISBN;
            Record.BLSUPN = Keys.SupplierNo;
            Record.BLSKSN = Keys.SearchKey;
       endif;

       Sequence = GetMTBIBLSequence(MTBIBLSubset);
       select;
       when Sequence = 1
       and not GetMTBIBLF1First(Record:
                                MTBIBLSubset:
                                '*next');
            return *off;
       when Sequence = 2
       and not GetMTBIBLF2First(Record:
                                MTBIBLSubset:
                                '*next');
            return *off;
       when Sequence = 3
       and not GetMTBIBLF3First(Record:
                                MTBIBLSubset:
                                '*next');
            return *off;
       when Sequence = 4
       and not GetMTBIBLF4First(Record:
                                MTBIBLSubset:
                                '*next');
            return *off;
       endsl;

       if p_Data = *null
       or p_ReturnFmt = *null;
            return *on;
       endif;

       // Setup keys for return
       Data.Keys.ISBN = Record.BLISBN;
       Data.Keys.SupplierNo = Record.BLSUPN;
       Data.Keys.SearchKey = Record.BLSKSN;

       if ReturnFmt = '*KEYSONLY';
            return *on;
       endif;

       if ReturnFmt = '*ALL';
            // Setup data for return
            Data.Record(1) = Record;
            Data.Record(2) = Data.Record(1);
            return *on;
       endif;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTBIBLF1First
       // Description     : Get MTBIBLF1 data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF1First
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       select;
       when GetAction = '*first';
            setll (MTBIBLF.BLISBN) MTBIBLF1;
       when GetAction = '*next';
            setgt (MTBIBLF.BLISBN) MTBIBLF1;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL1);
            read MTBIBLF1 MTBIBLF;
            if %eof(MTBIBLL1)
            or not CmpImprintPfx(Subset.ImprintPfx:
                                 MTBIBLF.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(Record:
                                Subset);
                 return *on;
            endif;
       enddo;
      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTBIBLF2First
       // Description     : Get MTBIBLF2 data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF2First
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       select;
       when GetAction = '*first';
            setll (MTBIBLF.BLSUPN:
                   MTBIBLF.BLSKSN:
                   MTBIBLF.BLISBN) MTBIBLF2;
       when GetAction = '*next';
            setgt (MTBIBLF.BLSUPN:
                   MTBIBLF.BLSKSN:
                   MTBIBLF.BLISBN) MTBIBLF2;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL2);
            reade (MTBIBLF.BLSUPN) MTBIBLF2 MTBIBLF;
            if %eof(MTBIBLL2)
            or not CmpSearchKeyPfx(Subset.SearchKeyPfx:
                                   MTBIBLF.BLSKSN)
            or not Subset.SearchKeyPfx.IsGeneric
            and not CmpImprintPfx(Subset.ImprintPfx:
                                  MTBIBLF.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(Record:
                                Subset);
                 return *on;
            endif;
       enddo;
      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTBIBLF3First
       // Description     : Get MTBIBLF3 data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF3First
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       select;
       when GetAction = '*first';
            setll (MTBIBLF.BLSKSN:
                   MTBIBLF.BLISBN) MTBIBLF3;
       when GetAction = '*next';
            setgt (MTBIBLF.BLSKSN:
                   MTBIBLF.BLISBN) MTBIBLF3;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL3);
            read  MTBIBLF3 MTBIBLF;
            if %eof(MTBIBLL3)
            or not CmpSearchKeyPfx(Subset.SearchKeyPfx:
                                   MTBIBLF.BLSKSN)
            or not Subset.SearchKeyPfx.IsGeneric
            and not CmpImprintPfx(Subset.ImprintPfx:
                                 MTBIBLF.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(Record:
                                Subset);
                 return *on;
            endif;
       enddo;
      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTBIBLF4First
       // Description     : Get MTBIBLF4 data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF4First
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       select;
       when GetAction = '*first';
            setll (MTBIBLF.BLSUPN:
                   MTBIBLF.BLISBN) MTBIBLF4;
       when GetAction = '*next';
            setgt (MTBIBLF.BLSUPN:
                   MTBIBLF.BLISBN) MTBIBLF4;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL4);
            reade (MTBIBLF.BLSUPN) MTBIBLF4 MTBIBLF;
            if %eof(MTBIBLL4)
            or not CmpImprintPfx(Subset.ImprintPfx:
                                 MTBIBLF.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(Record:
                                Subset);
                 return *on;
            endif;
       enddo;
      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : ChkMTBIBLIsValid
       // Description     : Check MTBIBL record is valid.
       // Returns         :< IsValid
       // Parameter      >:  Record
       //                >:  Subset
       /define ChkMTBIBLIsValid
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       If Subset.Deleted = 'N'
       and Record.BLDLTD <> *blanks
       or Subset.Deleted = 'Y'
       and Record.BLDLTD = *blanks;
            return *off;
       endif;

       if Subset.SupplierNo <> 0
       and Subset.SupplierNo <> Record.BLSUPN;
            return *off;
       endif;

       if not CmpSearchKeyPfx(Subset.SearchKeyPfx:
                              Record.BLSKSN);
            return *off;
       endif;

       if not CmpImprintPfx(Subset.ImprintPfx:
                              Record.BLISBN);
            return *off;
       endif;

       return *on; // Assume valid

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTBIBLSequence
       // Description     : Get Logical index based on subset.
       // Returns         :< Sequence
       // Parameter      >:  Subset
       /define GetMTBIBLSequence
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return 1;
       endif;

       if Subset.SupplierNo <> 0
       and %len(Subset.SearchKeyPfx.Prefix) <> 0;
            return 2;
       endif;

       if Subset.SupplierNo <> 0;
            return 4;
       endif;

       if %len(Subset.SearchKeyPfx.Prefix) <> 0;
            return 3;
       endif;

       return 1;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetSearchKeyPfx
       // Description     : Get formatted SearckKeyPfx
       // Returns         :< SearchKeyPfx
       // Parameter      >:  SearchKey
       /define GetSearchKeyPfx
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return SearchKeyPfx;
       endif;

       if SearchKey = '*BLANKS';
            SearchKeyPfx.Prefix = *BLANKS;
            SearchKeyPfx.IsGeneric = *off;
            return SearchKeyPfx;
       endif;

       if SearchKey = '*ALL';
            SearchKeyPfx.Prefix = '';
            SearchKeyPfx.IsGeneric = *on;
       endif;

       i = %scan('*':SearchKey);
       if i = 0;
            i = 10;
            SearchKeyPfx.IsGeneric = *off;
       else;
            i -= 1;
            SearchKeyPfx.IsGeneric = *on;
       endif;
       SearchKeyPfx.Prefix = %subst(SearchKey:1:i);
       return SearchKeyPfx;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : CmpSearchKeyPfx
       // Description     : Compare SearchKeyPfx
       // Returns         :< IsEqual
       // Parameter      >:  SearchKeyPfx
       //                >:  SearchKey
       /define CmpSearchKeyPfx
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if SearchKeyPfx.IsGeneric
       and %subst(SearchKey:1:
                  %len(SearchKeyPfx.Prefix)) = SearchKeyPfx.Prefix
       or SearchKey = SearchKeyPfx.Prefix;
            return *on;
       endif;

       return *off;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetImprintPfx
       // Description     : Get formatted ImprintPfx
       // Returns         :< ImprintPfx
       // Parameter      >:  ImprintNo
       /define GetImprintPfx
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return ImprintPfx;
       endif;

       ImprintPfx.IsGeneric = *on; // Always GENERIC*

       if ImprintNo <> IPIMPN; // Cache check, file rarely changes
            chain ImprintNo MTIMPNF;
            if not %found(MTIMPNP);
                 return ImprintPfx;
            endif;
       endif;

       ImprintPfx.Prefix = %trimr(IPISBP);
       return ImprintPfx;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : CmpImprintPfx
       // Description     : Compare ImprintPfx
       // Returns         :< IsEqual
       // Parameter      >:  ImprintPfx
       //                >:  ISBN
       /define CmpImprintPfx
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if ImprintPfx.IsGeneric
       and %subst(ISBN:1:
                  %len(ImprintPfx.Prefix)) = ImprintPfx.Prefix
       or ISBN = ImprintPfx.Prefix;
            return *on;
       endif;

       return *off;

      /end-free
     P                 E

      /free
       // -------------------------------------------------------------------------
       // Opens files, initialises globals, and returns status
       /define InzSrvPgm
       /include SrvDta_H
       // -------------------------------------------------------------------------
       If IsInitialised;
            return IsInitialised;
       endif;

       monitor;
            if not %open(MTBIBLL1);
                 open MTBIBLL1; // Bibliographic
            endif;
            if not %open(MTBIBLL2);
                 open MTBIBLL2; // Bibliographic
            endif;
            if not %open(MTBIBLL3);
                 open MTBIBLL3; // Bibliographic
            endif;
            if not %open(MTBIBLL4);
                 open MTBIBLL4; // Bibliographic
            endif;
            if not %open(MTIMPNP);
                 open MTIMPNP;  // Imprint
            endif;
       on-error;
            OpenError = *on;
       endmon;

       if not OpenError;
            IsInitialised = *on;
       endif;

       return IsInitialised;

      /end-free
     P                 E

