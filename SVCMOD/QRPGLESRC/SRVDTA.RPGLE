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
       // Procedure       : SRVDTA_GetBibliographic
       // Description     : Get Bibliographic data
       // Returns         :< IsFound
       // Parameter      >:< Data
       //                >:  Keys
       //                ?:  Subset
       //                ?:  ReturnFmt
       //                ?:  Access
       /define SRVDTA_GetBibliographic
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if %parms >= 1;
            p_Data = %addr(Data);
       endif;
       if %parms >= 2;
            p_Keys = %addr(Keys);
       endif;
       if %parms >= 3;
            p_Subset = %addr(Subset);
       endif;
       if %parms >= 4;
            p_ReturnFmt = %addr(ReturnFmt);
       endif;
       if %parms >= 5;
            p_Access = %addr(Access);
       endif;

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
                               p_ReturnFmt:
                               p_Access:
                               GetAction);

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

       if %parms >= 1;
            p_Data = %addr(Data);
       endif;
       if %parms >= 2;
            p_Keys = %addr(Keys);
       endif;
       if %parms >= 3;
            p_Subset = %addr(Subset);
       endif;
       if %parms >= 4;
            p_ReturnFmt = %addr(ReturnFmt);
       endif;
       if %parms >= 5;
            p_Access = %addr(Access);
       endif;

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
                               p_ReturnFmt:
                               p_Access:
                               GetAction);

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : SRVDTA_GetBibliographicLast
       // Description     : Get Bibliographic data
       // Returns         :< IsFound
       // Parameter      >:< Data
       //                ?:  Keys
       //                ?:  Subset
       //                ?:  ReturnFmt
       //                ?:  Access
       /define SRVDTA_GetBibliographicLast
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if %parms >= 1;
            p_Data = %addr(Data);
       endif;
       if %parms >= 2;
            p_Keys = %addr(Keys);
       endif;
       if %parms >= 3;
            p_Subset = %addr(Subset);
       endif;
       if %parms >= 4;
            p_ReturnFmt = %addr(ReturnFmt);
       endif;
       if %parms >= 5;
            p_Access = %addr(Access);
       endif;

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
                               p_ReturnFmt:
                               p_Access:
                               GetAction);

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

       if %parms >= 1;
            p_Data = %addr(Data);
       endif;
       if %parms >= 2;
            p_Keys = %addr(Keys);
       endif;
       if %parms >= 3;
            p_Subset = %addr(Subset);
       endif;
       if %parms >= 4;
            p_ReturnFmt = %addr(ReturnFmt);
       endif;
       if %parms >= 5;
            p_Access = %addr(Access);
       endif;

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
                               p_ReturnFmt:
                               p_Access:
                               GetAction);

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : SRVDTA_GetBibliographicPrevious
       // Description     : Get Bibliographic data
       // Returns         :< IsFound
       // Parameter      >:< Data
       //                >:  Keys
       //                ?:  Subset
       //                ?:  ReturnFmt
       //                ?:  Access
       /define SRVDTA_GetBibliographicPrevious
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if %parms >= 1;
            p_Data = %addr(Data);
       endif;
       if %parms >= 2;
            p_Keys = %addr(Keys);
       endif;
       if %parms >= 3;
            p_Subset = %addr(Subset);
       endif;
       if %parms >= 4;
            p_ReturnFmt = %addr(ReturnFmt);
       endif;
       if %parms >= 5;
            p_Access = %addr(Access);
       endif;

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
                               p_ReturnFmt:
                               p_Access:
                               GetAction);

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetBibliographic
       // Description     : Get Bibliographic data
       // Returns         :< IsFound
       // Parameter      >:< p_Data
       //                >:  p_Keys
       //                >:  p_Subset
       //                >:  p_ReturnFmt
       //                >:  p_Access
       //                >:  GetAction
       /define GetBibliographic
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       // test inputs
       if p_Data = *null
       or GetAction = '*unique' and p_Keys = *null
       or GetAction = '*next' and p_Keys = *null
       or GetAction = '*previous' and p_Keys = *null;
            QmhSndPgmMsg('MSG2001':      // Incorrect parm no's
                         MsgFileLMMSGF:  // Message file
                         '':             // Message data
                         0:              // Length of message data
                         '*ESCAPE':      // Message type
                         '*PGMBDY':      // Call stack entry
                         1:              // Call stack count
                         '':             // Message key
                         x'00000000');   // API error DS
       endif;

       if p_ReturnFmt <> *null;
            select;
            when %scan(ReturnFmt:ReturnFmtOpts) = 0;
                 QmhSndPgmMsg('MSG2009':       // Invalid return format
                              MsgFileLMMSGF:   // Message file
                              ReturnFmt:       // Message data
                              %len(ReturnFmt): // Length of message data
                              '*ESCAPE':       // Message type
                              '*PGMBDY':       // Call stack entry
                              1:               // Call stack count
                              '':              // Message key
                              x'00000000');    // API error DS
            when ReturnFmt = '*NONE';
                 p_ReturnFmt = *null; // Default - *NONE
            when ReturnFmt = '*KEYSONLY' and p_keys = *null
            or ReturnFmt = '*ALL' and p_keys = *null;
                 QmhSndPgmMsg('MSG200C':       // Key field not passed when &1
                              MsgFileLMMSGF:   // Message file
                              ReturnFmt:       // Message data
                              %len(ReturnFmt): // Length of message data
                              '*ESCAPE':       // Message type
                              '*PGMBDY':       // Call stack entry
                              1:               // Call stack count
                              '':              // Message key
                              x'00000000');    // API error DS

            endsl;
       endif;

       if p_access = *null;
            if GetAction <> '*first'
            and GetAction <> '*last';
                 AccessNo = 2; // *BYKEYS
            else;
                 AccessNo = 1; // *NOKEYS
            endif;
       else;
            AccessNo = %scan(Access:AccessOpts);
            if AccessNo > 0;
                 AccessNo = (AccessNo / 10) + 1; // Calculate "index" not offset
            endif;
            if AccessNo = 0 // Invalid
            or AccessNo = 1 and GetAction <> '*first'
                            and GetAction <> '*last';
                 QmhSndPgmMsg('MSG200B':      // Access type '&1' is invalid
                              MsgFileLMMSGF:  // Message file
                              Access:         // Message data
                              %len(Access):   // Length of message data
                              '*ESCAPE':      // Message type
                              '*PGMBDY':      // Call stack entry
                              1:              // Call stack count
                              '':             // Message key
                              x'00000000');   // API error DS
            endif;
       endif;

       // Initialise MTBIBLF specific subset - defaults.
       MTBIBLSubset.SupplierNo = 0;
       MTBIBLSubset.SearchKeyPfx = GetSearchKeyPfx('*ALL');
       MTBIBLSubset.ImprintPfx = GetImprintPfx(0);
       MTBIBLSubset.Deleted = '*';
       MTBIBLSubset.ISBN = *blanks;

       // Initialise MTBIBLF specific subset - passed subset.
       if p_Subset <> *null;
            MTBIBLSubset.SupplierNo = Subset.SupplierNo;
            MTBIBLSubset.SearchKeyPfx = GetSearchKeyPfx(Subset.SearchKey);
            MTBIBLSubset.ImprintPfx = GetImprintPfx(Subset.ImprintNo);
            MTBIBLSubset.Deleted = Subset.Deleted;
       endif;

       // Initialise MTBIBLF specific subset - key selection.
       if GetAction = '*unique';
            MTBIBLSubset.ISBN = Keys.ISBN;
       endif;

       // Setup keys, including alternative LF ones, for record access.
       Record.BLISBN = MTBIBLSubset.ImprintPfx.Prefix;
       Record.BLSUPN = MTBIBLSubset.SupplierNo;
       Record.BLSKSN = MTBIBLSubset.SearchKeyPfx.Prefix;

       // Generic* options need padding, otherwise file positioning
       //   is incorrect for *first and *last.
       select;
       when GetAction = '*first';
            if MTBIBLSubset.SearchKeyPfx.IsGeneric;
                 Record.BLSKSN = %trimr(Record.BLSKSN) + SKSNLo;
            endif;
            if MTBIBLSubset.ImprintPfx.IsGeneric;
                 Record.BLISBN = %trimr(Record.BLISBN) + ISBNLo;
            endif;
       when GetAction = '*last';
            if MTBIBLSubset.SearchKeyPfx.IsGeneric;
                 Record.BLSKSN = %trimr(Record.BLSKSN) + SKSNHi;
            endif;
            if MTBIBLSubset.ImprintPfx.IsGeneric;
                 Record.BLISBN = %trimr(Record.BLISBN) + ISBNHi;
            endif;
       endsl;

       // Replace keys if keys passed and *BYKEYS access.
       if p_Keys <> *null and AccessNo = 2;
            Record.BLISBN = Keys.ISBN;
            Record.BLSUPN = Keys.SupplierNo;
            Record.BLSKSN = Keys.SearchKey;
       endif;

       // Process request
       if not GetMTBIBLF(Record:
                         MTBIBLSubset:
                         GetAction);
            return *off;
       endif;

       if p_ReturnFmt = *null; // *NONE
            return *on;
       endif;

       // Update keys parameter.
       if ReturnFmt = '*KEYSONLY'
       or ReturnFmt = '*ALL';
            Keys.ISBN = Record.BLISBN;
            Keys.SupplierNo = Record.BLSUPN;
            Keys.SearchKey = Record.BLSKSN;
       endif;

       // Update keys within data, data structure
       if ReturnFmt = '*DATAKEYS'
       or ReturnFmt = '*DATAALL'
       or ReturnFmt = '*ALL';
            Data.Keys.ISBN = Record.BLISBN;
            Data.Keys.SupplierNo = Record.BLSUPN;
            Data.Keys.SearchKey = Record.BLSKSN;
       endif;

       // Update record formats within data structure
       if ReturnFmt = '*ALLDATA'
       or ReturnFmt = '*ALL';
            Data.Record(1) = Record;
            Data.Record(2) = Data.Record(1);
       endif;

       return *on;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTBIBLF
       // Description     : Get bibligraphic data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       Sequence = GetMTBIBLSequence(Subset);
       select;
       when Sequence = 1;
            return GetMTBIBLF1(Record:
                               Subset:
                               GetAction);
       when Sequence = 2;
            return GetMTBIBLF2(Record:
                               Subset:
                               GetAction);
       when Sequence = 3;
            return GetMTBIBLF3(Record:
                               Subset:
                               GetAction);
       when Sequence = 4;
            return GetMTBIBLF4(Record:
                               Subset:
                               GetAction);
       endsl;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTBIBLF1
       // Description     : Get MTBIBLF1 data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF1
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       select;
       when GetAction = '*first'
       or   GetAction = '*previous'
       or   GetAction = '*unique';
            setll (MTBIBLF.BLISBN) MTBIBLF1;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt (MTBIBLF.BLISBN) MTBIBLF1;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL1);
            if GetAction = '*first'
            or GetAction = '*next'
            or GetAction = '*unique';
                 read MTBIBLF1 MTBIBLF;
            else;
                 readp MTBIBLF1 MTBIBLF;
            endif;
            if %eof(MTBIBLL1)
            or not ChkISBN(Subset.ISBN:
                           MTBIBLF.BLISBN)
            or not ChkImprintPfx(Subset.ImprintPfx:
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
       // Procedure       : GetMTBIBLF2
       // Description     : Get MTBIBLF2 data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF2
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll (MTBIBLF.BLSUPN:
                   MTBIBLF.BLSKSN:
                   MTBIBLF.BLISBN) MTBIBLF2;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt (MTBIBLF.BLSUPN:
                   MTBIBLF.BLSKSN:
                   MTBIBLF.BLISBN) MTBIBLF2;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL2);
            if GetAction ='*first'
            or GetAction ='*next';
                 reade (MTBIBLF.BLSUPN) MTBIBLF2 MTBIBLF;
            else;
                 readpe (MTBIBLF.BLSUPN) MTBIBLF2 MTBIBLF;
            endif;
            if %eof(MTBIBLL2)
            or not ChkSearchKeyPfx(Subset.SearchKeyPfx:
                                   MTBIBLF.BLSKSN)
            or not Subset.SearchKeyPfx.IsGeneric
            and not ChkImprintPfx(Subset.ImprintPfx:
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
       // Procedure       : GetMTBIBLF3
       // Description     : Get MTBIBLF3 data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF3
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll (MTBIBLF.BLSKSN:
                   MTBIBLF.BLISBN) MTBIBLF3;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt (MTBIBLF.BLSKSN:
                   MTBIBLF.BLISBN) MTBIBLF3;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL3);
            if GetAction = '*first'
            or GetAction = '*next';
                 read  MTBIBLF3 MTBIBLF;
            else;
                 readp MTBIBLF3 MTBIBLF;
            endif;
            if %eof(MTBIBLL3)
            or not ChkSearchKeyPfx(Subset.SearchKeyPfx:
                                   MTBIBLF.BLSKSN)
            or not Subset.SearchKeyPfx.IsGeneric
            and not ChkImprintPfx(Subset.ImprintPfx:
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
       // Procedure       : GetMTBIBLF4
       // Description     : Get MTBIBLF4 data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF4
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll (MTBIBLF.BLSUPN:
                   MTBIBLF.BLISBN) MTBIBLF4;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt (MTBIBLF.BLSUPN:
                   MTBIBLF.BLISBN) MTBIBLF4;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL4);
            if GetAction = '*first'
            or GetAction = '*next';
                 reade (MTBIBLF.BLSUPN) MTBIBLF4 MTBIBLF;
            else;
                 readpe (MTBIBLF.BLSUPN) MTBIBLF4 MTBIBLF;
            endif;
            if %eof(MTBIBLL4)
            or not ChkImprintPfx(Subset.ImprintPfx:
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

       if not ChkISBN(Subset.ISBN:
                  Record.BLISBN);
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

       if not ChkSearchKeyPfx(Subset.SearchKeyPfx:
                              Record.BLSKSN);
            return *off;
       endif;

       if not ChkImprintPfx(Subset.ImprintPfx:
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

       if Subset.ISBN <> *blanks;
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
       // Procedure       : ChkSearchKeyPfx
       // Description     : Check SearchKeyPfx
       // Returns         :< IsValid
       // Parameter      >:  SearchKeyPfx
       //                >:  SearchKey
       /define ChkSearchKeyPfx
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

       ImprintPfx.IsGeneric = *on;

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
       // Procedure       : ChkImprintPfx
       // Description     : Check ImprintPfx
       // Returns         :< IsValid
       // Parameter      >:  ImprintPfx
       //                >:  ISBN
       /define ChkImprintPfx
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
       // ----------------------------------------------------------------------
       // Procedure       : ChkISBN
       // Description     : Check ISBN
       // Returns         :< IsValid
       // Parameter      >:  ISBN1
       //                >:  ISBN2
       /define ChkISBN
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if ISBN1 = *blanks
       or ISBN1 = ISBN2;
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

