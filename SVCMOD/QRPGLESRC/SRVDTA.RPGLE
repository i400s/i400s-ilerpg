      *-------------------------------------------------------------------------
      * Description  : Data Service program/procedures
      * Programmer   : Jonathan Wilson
      * Date Created : 30/07/2015
      *-------------------------------------------------------------------------
      /define SrvMod
      /include qincprsrc,StdHSpec

      *-------------------------------------------------------------------------
      * [AU] Author
     FMTAUTHP   IF   E           K DISK    usropn
     F                                     rename(MTAUTHF:MTAUTHF)
      *-------------------------------------------------------------------------
      * [BL] Bibliographic
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
      *-------------------------------------------------------------------------

      *-------------------------------------------------------------------------
      * Global data and procedure specifications
      *-------------------------------------------------------------------------
      /include StdDSpec
      * Special define used to include code only used within this program.
      /define SrvDta_
      * Header file
      /include SrvDta_h

      *-------------------------------------------------------------------------
      * Procedure       : SRVDTA_GetAuthor
      * Description     : Get Author data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
     P SRVDTA_GetAuthor...
     P                 B                   export
     D SRVDTA_GetAuthor...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*unique')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetAuthorFirst
      * Description     : Get Author data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetAuthorFirst
      *-------------------------------------------------------------------------
     P SRVDTA_GetAuthorFirst...
     P                 B                   export
     D SRVDTA_GetAuthorFirst...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Author)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetAuthorFirst
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*first')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetAuthorFirst
      *-------------------------------------------------------------------------
      /free
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

       return GetAuthor(p_Data:
                        p_Keys:
                        p_Subset:
                        GetAction);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetAuthorFirst
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetAuthorLast
      * Description     : Get Author data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetAuthorLast
      *-------------------------------------------------------------------------
     P SRVDTA_GetAuthorLast...
     P                 B                   export
     D SRVDTA_GetAuthorLast...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Author)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetAuthorLast
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*last')
      *----------------------------------------------------------------------
      * Program code    : SRVDTA_GetAuthorLast
      *-------------------------------------------------------------------------
      /free
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

       return GetAuthor(p_Data:
                        p_Keys:
                        p_Subset:
                        GetAction);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetAuthorLast
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetAuthorNext
      * Description     : Get Author data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetAuthorNext
      *-------------------------------------------------------------------------
     P SRVDTA_GetAuthorNext...
     P                 B                   export
     D SRVDTA_GetAuthorNext...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetAuthorNext
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*next')
      *----------------------------------------------------------------------
      * Program code    : SRVDTA_GetAuthorNext
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetAuthorNext
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetAuthorPrevious
      * Description     : Get Author data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetAuthorPrevious
      *-------------------------------------------------------------------------
     P SRVDTA_GetAuthorPrevious...
     P                 B                   export
     D SRVDTA_GetAuthorPrevious...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetAuthorPrevious
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*previous')
      *----------------------------------------------------------------------
      * Program code    : SRVDTA_GetAuthorPrevious
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetAuthorPrevious
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetBibliographic
      * Description     : Get Bibliographic data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *----------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographic...
     P                 B                   export
     D SRVDTA_GetBibliographic...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*unique')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetBibliographicFirst
      * Description     : Get Bibliographic data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicFirst...
     P                 B                   export
     D SRVDTA_GetBibliographicFirst...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*first')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetBibliographicLast
      * Description     : Get Bibliographic data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicLast...
     P                 B                   export
     D SRVDTA_GetBibliographicLast...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*last')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetBibliographicNext
      * Description     : Get Bibliographic data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicNext...
     P                 B                   export
     D SRVDTA_GetBibliographicNext...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*next')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetBibliographicPrevious
      * Description     : Get Bibliographic data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicPrevious...
     P                 B                   export
     D SRVDTA_GetBibliographicPrevious...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*previous')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------

      **************************************************************************
      * BEGIN Internal procedures
      **************************************************************************

      *----------------------------------------------------------------------
      * Procedure       : GetAuthor
      * Description     : Get Author data
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetAuthor
      *-------------------------------------------------------------------------
     P GetAuthor...
     P                 B
     D GetAuthor...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetAuthor
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Author)
     D                                     based(p_Data)
     D Record          DS                  likeds(t_AuthorRecord)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetAuthor
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       ChkGetParms(p_Data:
                   p_Keys:
                   p_Subset:
                   GetAction);

       // Process request
       if not GetAuthorRecord(Record:
                              p_Keys:
                              p_Subset:
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
      *-------------------------------------------------------------------------
      * END Procedure   : GetAuthor
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetAuthorRecord
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetAuthorRecord
      *-------------------------------------------------------------------------
     P GetAuthorRecord...
     P                 B
     D GetAuthorRecord...
     D                 PI                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetAuthorRecord
      *-------------------------------------------------------------------------
     D Subset          DS                  likeds(t_AuthorSubset)
     D                                     based(p_Subset)
     D Sequence        S              3I 0
     D RecordSubset    DS                  likeds(t_MTAUTHSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetAuthorRecord
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

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

       Sequence = GetMTAUTHSequence(RecordSubset:GetAction);

       select;
       when Sequence = 1;
            return GetMTAUTHF(Record:
                              p_Keys:
                              RecordSubset:
                              GetAction);
       endsl;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetAuthorRecord
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTAUTHF
      * Description     : Get MTAUTHF data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTAUTHF
      *-------------------------------------------------------------------------
     P GetMTAUTHF...
     P                 B
     D GetMTAUTHF...
     D                 PI                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTAUTHSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTAUTHF
      *-------------------------------------------------------------------------
     D Keys            DS                  likeds(t_AuthorKeys)
     D                                     based(p_keys)
     D ISBNHi          S             10A   inz(*allx'FF')
     D FileRecord      DS                  likerec(MTAUTHF:*input)
     D                                     inz
     D FileKeys        DS                  likerec(MTAUTHF:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTAUTHF
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Initialise record specific subset - key selection.
       if GetAction = '*unique';
            Subset.ISBN = Keys.ISBN;
            Subset.MARCTag = Keys.MARCTag;
            Subset.Sequence = Keys.Sequence;
       endif;

       // Setup keys for record access.
       FileKeys.AUISBN = Subset.ISBN;
       FileKeys.AUTAGC = Subset.MARCTag;
       FileKeys.AUSEQN = Subset.Sequence;

       // Generic* options need padding, otherwise file positioning
       //   is incorrect for *last processing.
       if GetAction = '*last';
            FileKeys.AUISBN = %trimr(FileKeys.AUISBN) + ISBNHi;
            if FileKeys.AUTAGC = 0;
                 FileKeys.AUTAGC = *hival;
            endif;
            if FileKeys.AUSEQN = 0;
                 FileKeys.AUSEQN = *hival;
            endif;
       endif;

       // Replace keys if keys passed.
       if p_Keys <> *null;
            FileKeys.AUISBN = Keys.ISBN;
            FileKeys.AUTAGC = Keys.MARCTag;
            FileKeys.AUSEQN = Keys.Sequence;
       endif;

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
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTAUTHF
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkMTAUTHIsValid
      * Description     : Check MTAUTH record is valid.
      * Returns         :< IsValid
      * Parameter      >:  Record
      *                >:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
     P ChkMTAUTHIsValid...
     P                 B
     D ChkMTAUTHIsValid...
     D                 PI              N
     D  Record                             likerec(MTAUTHF:*input)
     D  Subset                             likeds(t_MTAUTHSubset)
      *-------------------------------------------------------------------------
      * Local Variables : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : ChkMTAUTHUsValid
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTAUTHSequence
      * Description     : Get Logical index based on subset.
      * Returns         :< Sequence
      * Parameter      >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTAUTHSequence
      *-------------------------------------------------------------------------
     P GetMTAUTHSequence...
     P                 B
     D GetMTAUTHSequence...
     D                 PI             3I 0
     D  Subset                             likeds(t_MTAUTHSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTAUTHSequence
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : GetMTAUTHSequence
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return 1;
       endif;

       if GetAction = '*unique';
            return 1;
       endif;

       return 1;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTAUTHSequence
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetBibliographic
      * Description     : Get Bibliographic data
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetBibliographic
      *-------------------------------------------------------------------------
     P GetBibliographic...
     P                 B
     D GetBibliographic...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetBibliographic
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Bibliographic)
     D                                     based(p_Data)
     D Record          DS                  likeds(t_BibliographicRecord)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetBibliographic
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       ChkGetParms(p_Data:
                   p_Keys:
                   p_Subset:
                   GetAction);

       // Process request
       if not GetBibliographicRecord(Record:
                                     p_Keys:
                                     p_Subset:
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
      *-------------------------------------------------------------------------
      * END Procedure   : GetBibliographic
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetBibliographicRecord
      * Description     : Get bibligraphic record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetBibliographicRecord
      *-------------------------------------------------------------------------
     P GetBibliographicRecord...
     P                 B
     D GetBibliographicRecord...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetBibliographicRecord
      *-------------------------------------------------------------------------
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     based(p_Subset)
     D Sequence        S              3I 0
     D RecordSubset    DS                  likeds(t_MTBIBLSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetBibliographicRecord
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;


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

       Sequence = GetMTBIBLSequence(RecordSubset:GetAction);
       select;
       when Sequence = 1;
            return GetMTBIBLF1(Record:
                               p_Keys:
                               RecordSubset:
                               GetAction);
       when Sequence = 2;
            return GetMTBIBLF2(Record:
                               p_Keys:
                               RecordSubset:
                               GetAction);
       when Sequence = 3;
            return GetMTBIBLF3(Record:
                               p_Keys:
                               RecordSubset:
                               GetAction);
       when Sequence = 4;
            return GetMTBIBLF4(Record:
                               p_Keys:
                               RecordSubset:
                               GetAction);
       endsl;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetBibliographicRecord
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTBIBLF1
      * Description     : Get MTBIBLF1 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF1
      *-------------------------------------------------------------------------
     P GetMTBIBLF1...
     P                 B
     D GetMTBIBLF1...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF1
      *-------------------------------------------------------------------------
     D Keys            DS                  likeds(t_BibliographicKeys)
     D                                     based(p_keys)
     D ISBNHi          S             10A   inz(*allx'FF')
     D FileRecord      DS                  likerec(MTBIBLF1:*input)
     D                                     based(p_MTBIBLF)
     D FileKeys        DS                  likerec(MTBIBLF1:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLF1
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Initialise record specific subset - key selection.
       if GetAction = '*unique';
            Subset.ISBN = Keys.ISBN;
       endif;

       // Setup keys for record access.
       FileKeys.BLISBN = Subset.ImprintPfx.Prefix;

       // Generic* options need padding, otherwise file positioning
       //   is incorrect for *last processing.
       if GetAction = '*last';
            FileKeys.BLISBN = %trimr(FileKeys.BLISBN) + ISBNHi;
       endif;

       // Replace keys if keys passed.
       if p_Keys <> *null;
            FileKeys.BLISBN = Keys.ISBN;
       endif;

       p_MTBIBLF = %addr(Record);

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
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLF1
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTBIBLF2
      * Description     : Get MTBIBLF2 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF2
      *-------------------------------------------------------------------------
     P GetMTBIBLF2...
     P                 B
     D GetMTBIBLF2...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF2
      *-------------------------------------------------------------------------
     D Keys            DS                  likeds(t_BibliographicKeys)
     D                                     based(p_keys)
     D SKSNHi          S             10A   inz(*allx'FF')
     D ISBNHi          S             10A   inz(*allx'FF')
     D FileRecord      DS                  likerec(MTBIBLF2:*input)
     D                                     based(p_MTBIBLF)
     D FileKeys        DS                  likerec(MTBIBLF2:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLF2
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       FileKeys.BLSUPN = Subset.SupplierNo;
       FileKeys.BLSKSN = Subset.SearchKeyPfx.Prefix;
       FileKeys.BLISBN = Subset.ImprintPfx.Prefix;

       // Generic* options need padding, otherwise file positioning
       //   is incorrect for *last processing.
       if GetAction = '*last';
            if Subset.SearchKeyPfx.IsGeneric;
                 FileKeys.BLSKSN = %trimr(FileKeys.BLSKSN) + SKSNHi;
            endif;
            FileKeys.BLISBN = %trimr(FileKeys.BLISBN) + ISBNHi;
       endif;

       // Replace keys if keys passed.
       if p_Keys <> *null;
            FileKeys.BLSUPN = Keys.SupplierNo;
            FileKeys.BLSKSN = Keys.SearchKey;
            FileKeys.BLISBN = Keys.ISBN;
       endif;

       p_MTBIBLF = %addr(Record);

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
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLF2
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTBIBLF3
      * Description     : Get MTBIBLF3 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF3
      *-------------------------------------------------------------------------
     P GetMTBIBLF3...
     P                 B
     D GetMTBIBLF3...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF3
      *-------------------------------------------------------------------------
     D Keys            DS                  likeds(t_BibliographicKeys)
     D                                     based(p_keys)
     D SKSNHi          S             10A   inz(*allx'FF')
     D ISBNHi          S             10A   inz(*allx'FF')
     D FileRecord      DS                  likerec(MTBIBLF3:*input)
     D                                     based(p_MTBIBLF)
     D FileKeys        DS                  likerec(MTBIBLF3:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLF3
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       FileKeys.BLSKSN = Subset.SearchKeyPfx.Prefix;
       FileKeys.BLISBN = Subset.ImprintPfx.Prefix;

       // Generic* options need padding, otherwise file positioning
       //   is incorrect for *last processing.
       if GetAction = '*last';
            if Subset.SearchKeyPfx.IsGeneric;
                 FileKeys.BLSKSN = %trimr(FileKeys.BLSKSN) + SKSNHi;
            endif;
            FileKeys.BLISBN = %trimr(FileKeys.BLISBN) + ISBNHi;
       endif;

       // Replace keys if keys passed.
       if p_Keys <> *null;
            FileKeys.BLSKSN = Keys.SearchKey;
            FileKeys.BLISBN = Keys.ISBN;
       endif;

       p_MTBIBLF = %addr(Record);

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
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLF3
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTBIBLF4
      * Description     : Get MTBIBLF4 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF4
      *-------------------------------------------------------------------------
     P GetMTBIBLF4...
     P                 B
     D GetMTBIBLF4...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF4
      *-------------------------------------------------------------------------
     D Keys            DS                  likeds(t_BibliographicKeys)
     D                                     based(p_keys)
     D ISBNHi          S             10A   inz(*allx'FF')
     D FileRecord      DS                  likerec(MTBIBLF4:*input)
     D                                     based(p_MTBIBLF)
     D FileKeys        DS                  likerec(MTBIBLF4:*key)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLF4
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       FileKeys.BLSUPN = Subset.SupplierNo;
       FileKeys.BLISBN = Subset.ImprintPfx.Prefix;

       // Generic* options need padding, otherwise file positioning
       //   is incorrect for *last processing.
       if GetAction = '*last';
            FileKeys.BLISBN = %trimr(FileKeys.BLISBN) + ISBNHi;
       endif;

       // Replace keys if keys passed.
       if p_Keys <> *null;
            FileKeys.BLSUPN = Keys.SupplierNo;
            FileKeys.BLISBN = Keys.ISBN;
       endif;

       p_MTBIBLF = %addr(Record);

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
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLF4
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkMTBIBLIsValid
      * Description     : Check MTBIBL record is valid.
      * Returns         :< IsValid
      * Parameter      >:  Record
      *                >:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
     P ChkMTBIBLIsValid...
     P                 B
     D ChkMTBIBLIsValid...
     D                 PI              N
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
      *-------------------------------------------------------------------------
      * Local Variables : ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLIsValid
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTBIBLSequence
      * Description     : Get Logical index based on subset.
      * Returns         :< Sequence
      * Parameter      >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLSequence
      *-------------------------------------------------------------------------
     P GetMTBIBLSequence...
     P                 B
     D GetMTBIBLSequence...
     D                 PI             3I 0
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return 1;
       endif;

       if GetAction = '*unique';
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
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLSequence
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetSearchKeyPfx
      * Description     : Get formatted SearckKeyPfx
      * Returns         :< SearchKeyPfx
      * Parameter      >:  SearchKey
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetSearchKeyPfx
      *-------------------------------------------------------------------------
     P GetSearchKeyPfx...
     P                 B
     D GetSearchKeyPfx...
     D                 PI                  likeds(t_SearchKeyPfx)
     D  SearchKey                    10    const
      *-------------------------------------------------------------------------
      * Local Variables : GetSearchKeyPfx
      *-------------------------------------------------------------------------
     D SearchKeyPfx    DS                  likeds(t_SearchKeyPfx)
     D                                     inz
     D i               S              3I 0
      *-------------------------------------------------------------------------
      * Program code    : GetSearchKeyPfx
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : GetSearchKeyPfx
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkSearchKeyPfx
      * Description     : Check SearchKeyPfx
      * Returns         :< IsValid
      * Parameter      >:  SearchKeyPfx
      *                >:  SearchKey
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkSearchKeyPfx
      *-------------------------------------------------------------------------
     P ChkSearchKeyPfx...
     P                 B
     D ChkSearchKeyPfx...
     D                 PI              N
     D  SearchKeyPfx                       likeds(t_SearchKeyPfx)
     D  SearchKey                    10
      *-------------------------------------------------------------------------
      * Local Variables : ChkSearchKeyPfx
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkSearchKeyPfx
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : ChkSearckKeyPfx
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetImprintPfx
      * Description     : Get formatted ImprintPfx
      * Returns         :< ImprintPfx
      * Parameter      >:  ImprintNo
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetImprintPfx
      *-------------------------------------------------------------------------
     P GetImprintPfx...
     P                 B
     D GetImprintPfx...
     D                 PI                  likeds(t_ImprintPfx)
     D  ImprintNo                     8P 0 const
      *-------------------------------------------------------------------------
      * Local Variables : GetImprintPfx
      *-------------------------------------------------------------------------
     D ImprintPfx      DS                  likeds(t_ImprintPfx)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetImprintPfx
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : GetImprintPfx
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkImprintPfx
      * Description     : Check ImprintPfx
      * Returns         :< IsValid
      * Parameter      >:  ImprintPfx
      *                >:  ISBN
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkImprintPfx
      *-------------------------------------------------------------------------
     P ChkImprintPfx...
     P                 B
     D ChkImprintPfx...
     D                 PI              N
     D  ImprintPfx                         likeds(t_imprintPfx)
     D  ISBN                         10
      *-------------------------------------------------------------------------
      * Local Variables : ChkImprintPfx
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkImprintPfx
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : ChkImprintPfx
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkISBN
      * Description     : Check ISBN
      * Returns         :< IsValid
      * Parameter      >:  ISBN1
      *                >:  ISBN2
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkISBN
      *-------------------------------------------------------------------------
     P ChkISBN...
     P                 B
     D ChkISBN...
     D                 PI              N
     D  ISBN1                        10
     D  ISBN2                        10
      *-------------------------------------------------------------------------
      * Local Variables : ChkISBN
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkISBN
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : ChkISBN
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkMARCTag
      * Description     : Check MARC tag
      * Returns         :< IsValid
      * Parameter      >:  TAGC1
      *                >:  TAGC2
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMARCTag
      *-------------------------------------------------------------------------
     P ChkMARCTag...
     P                 B
     D ChkMARCTag...
     D                 PI              N
     D  TAGC1                         3P 0
     D  TAGC2                         3P 0
      *-------------------------------------------------------------------------
      * Local Variables : ChkMARCTag
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkMARCTag
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : ChkMARCTag
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkMARCSequence
      * Description     : Check MARC sequence
      * Returns         :< IsValid
      * Parameter      >:  SEQN1
      *                >:  SEQN2
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMARCSequence
      *-------------------------------------------------------------------------
     P ChkMARCSequence...
     P                 B
     D ChkMARCSequence...
     D                 PI              N
     D  SEQN1                         3P 0
     D  SEQN2                         3P 0
      *-------------------------------------------------------------------------
      * Local Variables : ChkMARCSequence
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkMARCSequence
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : ChkMARCSequence
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkGetParms
      * Description     : Check the parameters for the accesors are valid
      * Returns         :< IsValid
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkGetParms
      *-------------------------------------------------------------------------
     P ChkGetParms...
     P                 B
     D ChkGetParms...
     D                 PI             1N
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : ChkGetParms
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkGetParms
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : ChkGetParms
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : InzSrvPgm
      * Description     : initialise and open files
      * Returns         :< IsInitilised
      * Parameter       :  *none
      *-------------------------------------------------------------------------
      * BEGIN Procedure : InzSrvPgm
      *-------------------------------------------------------------------------
     P InzSrvPgm...
     P                 B
     D InzSrvPgm...
     D                 PI             1N
      *-------------------------------------------------------------------------
      * Local Variables : InzSrvPgm
      *-------------------------------------------------------------------------
     D IsInitialised   S              1N   static
     D OpenError       S              1N
      *-------------------------------------------------------------------------
      * Program code    : InzSrvPgm
      *-------------------------------------------------------------------------
      /free
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
      *-------------------------------------------------------------------------
      * END Procedure   : InzSrvPgm
      *-------------------------------------------------------------------------

