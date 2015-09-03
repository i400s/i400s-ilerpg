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
     F                                     rename(MTAUTHF:MTAUTHF)
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
       // Description     : Get Author data
       // Returns         :< IsFound
       // Parameter      >:< Data
       //                >:  Keys
       //                ?:  Subset
       /define SRVDTA_GetAuthor
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

       return GetAuthor(p_Data:
                        p_Keys:
                        p_Subset:
                        GetAction);

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

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
                               GetAction);

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : SRVDTA_GetBibliographicFirst
       // Description     : Get Bibliographic data
       // Returns         :< IsFound
       // Parameter      >:< Data
       //                ?:  Subset
       /define SRVDTA_GetBibliographicFirst
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if %parms >= 1;
            p_Data = %addr(Data);
       endif;

       // Keys never passed.

       if %parms >= 2;
            p_Subset = %addr(Subset);
       endif;

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
                               GetAction);

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : SRVDTA_GetBibliographicLast
       // Description     : Get Bibliographic data
       // Returns         :< IsFound
       // Parameter      >:< Data
       //                ?:  Subset
       /define SRVDTA_GetBibliographicLast
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if %parms >= 1;
            p_Data = %addr(Data);
       endif;

       // Keys never passed.

       if %parms >= 2;
            p_Subset = %addr(Subset);
       endif;

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
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

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
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

       return GetBibliographic(p_Data:
                               p_Keys:
                               p_Subset:
                               GetAction);

      /end-free
     P                 E

      * ------------------------------------------------------------------------
      * BEGIN Internal procedures
      * ------------------------------------------------------------------------

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetAuthor
       // Description     : Get Author data
       // Returns         :< IsFound
       // Parameter      >:< p_Data
       //                >:  p_Keys
       //                >:  p_Subset
       //                >:  GetAction
       /define GetAuthor
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       ChkGetParms(p_Data:
                   p_Keys:
                   p_Subset:
                   GetAction);

       // Initialise record specific subset - defaults.
       RecordSubset.ISBN = *blanks;
       RecordSubset.MARCTag = 0;
       RecordSubset.Sequence = 0;

       // Initialise record specific subset - passed subset.
       if p_Subset <> *null;
            RecordSubset.ISBN = Subset.ISBN;
            RecordSubset.MARCTag = Subset.MARCTag;
            RecordSubset.Sequence = Subset.Sequence;
       endif;

       // Initialise record specific subset - key selection.
       if GetAction = '*unique';
            RecordSubset.ISBN = Keys.ISBN;
            RecordSubset.MARCTag = Keys.MARCTag;
            RecordSubset.Sequence = Keys.Sequence;
       endif;

       // Setup keys, including alternative LF ones, for record access.
       RecordKeys.ISBN = RecordSubset.ISBN;
       RecordKeys.MARCTag = RecordSubset.MARCTag;
       RecordKeys.Sequence = RecordSubset.Sequence;

       // Generic* options need padding, otherwise file positioning
       //   is incorrect for *first and *last.
       select;
       when GetAction = '*first';
            // Nothing to do
       when GetAction = '*last';
            // Nothing to do
       endsl;

       // Replace keys if keys passed.
       if p_Keys <> *null;
            RecordKeys.ISBN = Keys.ISBN;
            RecordKeys.MARCTag = Keys.MARCTag;
            RecordKeys.Sequence = Keys.Sequence;
       endif;

       // Process request
       if not GetAuthorRecord(Record:
                              RecordKeys:
                              RecordSubset:
                              GetAction);
            return *off;
       endif;

       // Update keys within data, data structure
       Data.Keys.ISBN = Record.AUISBN;
       Data.Keys.MARCTag = Record.AUTAGC;
       Data.Keys.Sequence = Record.AUSEQN;

       // Update record formats within data structure
       Data.Record(1) = Record;
       Data.Record(2) = Data.Record(1);

       return *on;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetAuthorRecord
       // Description     : Get Author
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Keys
       //                >:  Subset
       //                >:  GetAction
       /define GetAuthorRecord
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       Sequence = GetMTAUTHSequence(Subset);
       select;
       when Sequence = 1;
            return GetMTAUTHF(Record:
                              Keys:
                              Subset:
                              GetAction);
       endsl;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTAUTHF
       // Description     : Get MTAUTHF data
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Keys
       //                >:  Subset
       //                >:  GetAction
       /define GetMTAUTHF
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       FileKeys.AUISBN = Keys.ISBN;
       FileKeys.AUTAGC = Keys.MARCTag;
       FileKeys.AUSEQN = Keys.Sequence;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous'
       or   GetAction = '*unique';
            setll %kds(FileKeys:3) MTAUTHF;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(FileKeys:3) MTAUTHF;
       other;
            return *off;
       endsl;
       dou %eof(MTAUTHP);
            if GetAction = '*first'
            or GetAction = '*next'
            or GetAction = '*unique';
                 read MTAUTHF FileRecord;
            else;
                 readp MTAUTHF FileRecord;
            endif;
            if %eof(MTAUTHP)
            or not ChkISBN(Subset.ISBN:FileRecord.AUISBN)
            or not ChkMARCTag(Subset.MARCTag:FileRecord.AUTAGC)
            or not ChkMARCsequence(Subset.Sequence:FileRecord.AUSEQN);
                 return *off;
            endif;
            if ChkMTAUTHIsValid(FileRecord:
                                Subset);
                 // Assemble data to return
                 FileKeys.AUISBN = FileRecord.AUISBN;
                 FileKeys.AUTAGC = FileRecord.AUTAGC;
                 FileKeys.AUSEQN = FileRecord.AUSEQN;
                 setll %kds(FileKeys:3) MTAUTHF;
                 reade %kds(FileKeys:3) MTAUTHF FileRecord;
                 Record.AUISBN = FileRecord.AUISBN;
                 Record.AUTAGC = FileRecord.AUTAGC;
                 Record.AUSEQN = FileRecord.AUSEQN;
                 Record.CreatedDTS = %timestamp(); // TODO
                 Record.ChangedDTS = %timestamp(); // TODO
                 dow not %eof(MTAUTHP);
                      Record.Name += FileRecord.AUAUTN;
                      reade %kds(FileKeys:3) MTAUTHF FileRecord;
                 enddo;
                 return *on;
            endif;
       enddo;
      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : ChkMTAUTHIsValid
       // Description     : Check MTAUTH record is valid.
       // Returns         :< IsValid
       // Parameter      >:  Record
       //                >:  Subset
       /define ChkMTAUTHIsValid
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if not ChkISBN(Subset.ISBN:Record.AUISBN);
            return *off;
       endif;

       If not ChkMARCTag(Subset.MARCTag:Record.AUTAGC);
            return *off;
       endif;

       if not ChkMARCSequence(Subset.Sequence:Record.AUSEQN);
            return *off;
       endif;

       return *on; // Assume valid

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetMTAUTHSequence
       // Description     : Get Logical index based on subset.
       // Returns         :< Sequence
       // Parameter      >:  Subset
       /define GetMTAUTHSequence
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return 1;
       endif;

       return 1;

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
       //                >:  GetAction
       /define GetBibliographic
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       ChkGetParms(p_Data:
                   p_Keys:
                   p_Subset:
                   GetAction);

       // Initialise record specific subset - defaults.
       RecordSubset.SupplierNo = 0;
       RecordSubset.SearchKeyPfx = GetSearchKeyPfx('*ALL');
       RecordSubset.ImprintPfx = GetImprintPfx(0);
       RecordSubset.Deleted = '*';
       RecordSubset.ISBN = *blanks;

       // Initialise record specific subset - passed subset.
       if p_Subset <> *null;
            RecordSubset.SupplierNo = Subset.SupplierNo;
            RecordSubset.SearchKeyPfx = GetSearchKeyPfx(Subset.SearchKey);
            RecordSubset.ImprintPfx = GetImprintPfx(Subset.ImprintNo);
            RecordSubset.Deleted = Subset.Deleted;
       endif;

       // Initialise record specific subset - key selection.
       if GetAction = '*unique';
            RecordSubset.ISBN = Keys.ISBN;
       endif;

       // Setup keys, including alternative LF ones, for record access.
       RecordKeys.ISBN = RecordSubset.ImprintPfx.Prefix;
       RecordKeys.SupplierNo = RecordSubset.SupplierNo;
       RecordKeys.SearchKey = RecordSubset.SearchKeyPfx.Prefix;

       // Generic* options need padding, otherwise file positioning
       //   is incorrect for *first and *last.
       select;
       when GetAction = '*first';
            if RecordSubset.SearchKeyPfx.IsGeneric;
                 RecordKeys.SearchKey = %trimr(RecordKeys.SearchKey) + SKSNLo;
            endif;
            if RecordSubset.ImprintPfx.IsGeneric;
                 RecordKeys.ISBN = %trimr(RecordKeys.ISBN) + ISBNLo;
            endif;
       when GetAction = '*last';
            if RecordSubset.SearchKeyPfx.IsGeneric;
                 RecordKeys.SearchKey = %trimr(RecordKeys.SearchKey) + SKSNHi;
            endif;
            if RecordSubset.ImprintPfx.IsGeneric;
                 Recordkeys.ISBN = %trimr(RecordKeys.ISBN) + ISBNHi;
            endif;
       endsl;

       // Replace keys if keys passed.
       if p_Keys <> *null;
            RecordKeys.ISBN = Keys.ISBN;
            RecordKeys.SupplierNo = Keys.SupplierNo;
            RecordKeys.SearchKey = Keys.SearchKey;
       endif;

       // Process request
       if not GetBibliographicRecord(Record:
                                     RecordKeys:
                                     RecordSubset:
                                     GetAction);
            return *off;
       endif;

       // Update keys within data, data structure
       Data.Keys.ISBN = Record.BLISBN;
       Data.Keys.SupplierNo = Record.BLSUPN;
       Data.Keys.SearchKey = Record.BLSKSN;

       // Update record formats within data structure
       Data.Record(1) = Record;
       Data.Record(2) = Data.Record(1);

       return *on;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : GetBibliographicRecord
       // Description     : Get bibligraphic record
       // Returns         :< IsFound
       // Parameter      >:< Record
       //                >:  Keys
       //                >:  Subset
       //                >:  GetAction
       /define GetBibliographicRecord
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       Sequence = GetMTBIBLSequence(Subset);
       select;
       when Sequence = 1;
            return GetMTBIBLF1(Record:
                               Keys:
                               Subset:
                               GetAction);
       when Sequence = 2;
            return GetMTBIBLF2(Record:
                               Keys:
                               Subset:
                               GetAction);
       when Sequence = 3;
            return GetMTBIBLF3(Record:
                               Keys:
                               Subset:
                               GetAction);
       when Sequence = 4;
            return GetMTBIBLF4(Record:
                               Keys:
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
       //                >:  Keys
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF1
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       FileKeys.BLISBN = Keys.ISBN;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous'
       or   GetAction = '*unique';
            setll %kds(FileKeys:1) MTBIBLF1;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(fileKeys:1) MTBIBLF1;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL1);
            if GetAction = '*first'
            or GetAction = '*next'
            or GetAction = '*unique';
                 read MTBIBLF1 FileRecord;
            else;
                 readp MTBIBLF1 FileRecord;
            endif;
            if %eof(MTBIBLL1)
            or not ChkISBN(Subset.ISBN:FileRecord.BLISBN)
            or not ChkImprintPfx(Subset.ImprintPfx:FileRecord.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(FileRecord:
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
       //                >:  Keys
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF2
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       FileKeys.BLSUPN = Keys.SupplierNo;
       FileKeys.BLSKSN = Keys.SearchKey;
       FileKeys.BLISBN = Keys.ISBN;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll %kds(FileKeys:3) MTBIBLF2;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(FileKeys:3) MTBIBLF2;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL2);
            if GetAction ='*first'
            or GetAction ='*next';
                 reade %kds(FileKeys:1) MTBIBLF2 FileRecord;
            else;
                 readpe %kds(FileKeys:1) MTBIBLF2 FileRecord;
            endif;
            if %eof(MTBIBLL2)
            or not ChkSearchKeyPfx(Subset.SearchKeyPfx:FileRecord.BLSKSN)
            or not Subset.SearchKeyPfx.IsGeneric
            and not ChkImprintPfx(Subset.ImprintPfx:FileRecord.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(FileRecord:
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
       //                >:  Keys
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF3
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       FileKeys.BLSKSN = Keys.SearchKey;
       FileKeys.BLISBN = Keys.ISBN;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll %kds(FileKeys:2) MTBIBLF3;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(FileKeys:2) MTBIBLF3;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL3);
            if GetAction = '*first'
            or GetAction = '*next';
                 read  MTBIBLF3 FileRecord;
            else;
                 readp MTBIBLF3 FileRecord;
            endif;
            if %eof(MTBIBLL3)
            or not ChkSearchKeyPfx(Subset.SearchKeyPfx:FileRecord.BLSKSN)
            or not Subset.SearchKeyPfx.IsGeneric
            and not ChkImprintPfx(Subset.ImprintPfx:FileRecord.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(FileRecord:
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
       //                >:  Keys
       //                >:  Subset
       //                >:  GetAction
       /define GetMTBIBLF4
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       p_MTBIBLF = %addr(Record);

       FileKeys.BLSUPN = Keys.SupplierNo;
       FileKeys.BLISBN = Keys.ISBN;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll %kds(FileKeys:2) MTBIBLF4;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(FileKeys:2) MTBIBLF4;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL4);
            if GetAction = '*first'
            or GetAction = '*next';
                 reade %kds(FileKeys:1) MTBIBLF4 FileRecord;
            else;
                 readpe %kds(FileKeys:1) MTBIBLF4 FileRecord;
            endif;
            if %eof(MTBIBLL4)
            or not ChkImprintPfx(Subset.ImprintPfx:FileRecord.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(FileRecord:
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

       if not ChkISBN(Subset.ISBN:Record.BLISBN);
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

       if not ChkSearchKeyPfx(Subset.SearchKeyPfx:Record.BLSKSN);
            return *off;
       endif;

       if not ChkImprintPfx(Subset.ImprintPfx:Record.BLISBN);
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
       // ----------------------------------------------------------------------
       // Procedure       : ChkMARCTag
       // Description     : Check MARC tag
       // Returns         :< IsValid
       // Parameter      >:  TAGC1
       //                >:  TAGC2
       /define ChkMARCTag
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if TAGC1 = *zero
       or TAGC1 = TAGC2;
            return *on;
       endif;

       return *off;

      /end-free
     P                 E

      /free
       // ----------------------------------------------------------------------
       // Procedure       : ChkMARCSequence
       // Description     : Check MARC sequence
       // Returns         :< IsValid
       // Parameter      >:  SEQN1
       //                >:  SEQN2
       /define ChkMARCSequence
       /include SrvDta_H
       // ----------------------------------------------------------------------
       if not InzSrvPgm;
            return *off;
       endif;

       if SEQN1 = *zero
       or SEQN1 = SEQN2;
            return *on;
       endif;

       return *off;

      /end-free
     P                 E


      /free
       // ----------------------------------------------------------------------
       // Procedure       : ChkGetParms
       // Description     : Check the parameters for the accesors are valid
       // Returns         :< IsValid
       // Parameter      >:< p_Data
       //                >:  p_Keys
       //                >:  p_Subset
       //                >:  GetAction
       /define ChkGetParms
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

       return *on;

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
            if not %open(MTAUTHP);
                 open MTAUTHP;  // Author
            endif;
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

