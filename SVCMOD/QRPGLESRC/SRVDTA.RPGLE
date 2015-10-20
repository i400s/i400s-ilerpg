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
     F                                     rename(MTIMPNF:MTIMPNF)
     FMTIMPNL2  IF   E           K DISK    usropn
     F                                     rename(MTIMPNF:MTIMPNF2)
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
      * Procedure       : SRVDTA_GetImprint
      * Description     : Get Imprint data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetImprint
      *-------------------------------------------------------------------------
     P SRVDTA_GetImprint...
     P                 B                   export
     D SRVDTA_GetImprint...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Keys                               likeds(t_ImprintKeys)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetImprint
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*bykeys')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetImprint
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

       return GetImprintData(p_Data:
                             p_Keys:
                             p_Subset:
                             GetAction);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetImprint
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetImprintFirst
      * Description     : Get Imprint data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetImprintFirst
      *-------------------------------------------------------------------------
     P SRVDTA_GetImprintFirst...
     P                 B                   export
     D SRVDTA_GetImprintFirst...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetImprintFirst
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*first')
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetImprintFirst
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

       return GetImprintData(p_Data:
                             p_Keys:
                             p_Subset:
                             GetAction);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetImprintFirst
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetImprintLast
      * Description     : Get Imprint data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetImprintLast
      *-------------------------------------------------------------------------
     P SRVDTA_GetImprintLast...
     P                 B                   export
     D SRVDTA_GetImprintLast...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetImprintLast
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*last')
      *----------------------------------------------------------------------
      * Program code    : SRVDTA_GetImprintLast
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

       return GetImprintData(p_Data:
                             p_Keys:
                             p_Subset:
                             GetAction);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetImprintLast
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetImprintNext
      * Description     : Get Imprint data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetImprintNext
      *-------------------------------------------------------------------------
     P SRVDTA_GetImprintNext...
     P                 B                   export
     D SRVDTA_GetImprintNext...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Keys                               likeds(t_ImprintKeys)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetImprintNext
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*next')
      *----------------------------------------------------------------------
      * Program code    : SRVDTA_GetImprintNext
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

       return GetImprintData(p_Data:
                             p_Keys:
                             p_Subset:
                             GetAction);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetImprintNext
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetImprintPrevious
      * Description     : Get Imprint data
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetImprintPrevious
      *-------------------------------------------------------------------------
     P SRVDTA_GetImprintPrevious...
     P                 B                   export
     D SRVDTA_GetImprintPrevious...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Imprint)
     D  Keys                               likeds(t_ImprintKeys)
     D  Subset                             likeds(t_ImprintSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetImprintPrevious
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D GetAction       S             10A   varying
     D                                     inz('*previous')
      *----------------------------------------------------------------------
      * Program code    : SRVDTA_GetImprintPrevious
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

       return GetImprintData(p_Data:
                             p_Keys:
                             p_Subset:
                             GetAction);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetImprintPrevious
      *-------------------------------------------------------------------------

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
     D                                     inz('*bykeys')
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

       return GetAuthorData(p_Data:
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

       return GetAuthorData(p_Data:
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

       return GetAuthorData(p_Data:
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

       return GetAuthorData(p_Data:
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

       return GetAuthorData(p_Data:
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
     D                                     inz('*bykeys')
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

       return GetBibliographicData(p_Data:
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

       return GetBibliographicData(p_Data:
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

       return GetBibliographicData(p_Data:
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

       return GetBibliographicData(p_Data:
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

       return GetBibliographicData(p_Data:
                                   p_Keys:
                                   p_Subset:
                                   GetAction);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : SRVDTA_GetQualifiedSearchKey
      * Description     : Get Qualified SearchKey
      * Returns         :< QualifiedSearchKey
      * Parameter      >:  SearchKey
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetQualifiedSearchKey
      *-------------------------------------------------------------------------
     P SRVDTA_GetQualifiedSearchKey...
     P                 B                   export
     D SRVDTA_GetQualifiedSearchKey...
     D                 PI            10A   varying
     D  SearchKey                    10A   varying
     D                                     const
      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetQualifiedSearchKey
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : SRVDTA_GetQualifiedSearchKey
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            // return *off;
       endif;

       return GetQualifiedGeneric(SearchKey);
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetQualifiedSearchKey
      *-------------------------------------------------------------------------

      **************************************************************************
      * BEGIN Internal procedures
      **************************************************************************

      *----------------------------------------------------------------------
      * Procedure       : GetImprintData
      * Description     : Get Imprint Data
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetImprintData
      *-------------------------------------------------------------------------
     P GetImprintData...
     P                 B
     D GetImprintData...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetImprintData
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Imprint)
     D                                     based(p_Data)
     D Record          DS                  likeds(t_ImprintRecord)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetImprintData
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
       if not GetImprintRecord(Record:
                               p_Keys:
                               p_Subset:
                               GetAction);
            return *off;
       endif;

       // Update keys within data, data structure
       Data.Keys.ImprintNo = Record.ImprintNo;
       Data.Keys.ISBNImprint = Record.ISBNImprint;
       Data.Keys.SearchKey = Record.SearchKey;

       // Update record formats within data structure
       Data.Record(1) = Record;
       Data.Record(2) = Data.Record(1);

       return *on;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetImprintData
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetImprintRecord
      * Description     : Get Imprint record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetImprintRecord
      *-------------------------------------------------------------------------
     P GetImprintRecord...
     P                 B
     D GetImprintRecord...
     D                 PI                  like(*in)
     D  Record                             likeds(t_ImprintRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetImprintRecord
      *-------------------------------------------------------------------------
     D MTIMPNRecord    DS                  likerec(MTIMPNF:*input)
      *-------------------------------------------------------------------------
      * Program code    : GetImprintRecord
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if not GetMTIMPNRecord(MTIMPNRecord:
                              p_keys:
                              p_Subset:
                              GetAction);
            return *off;
       endif;

       Record.ImprintNo = MTIMPNRecord.IPIMPN;
       Record.ISBNImprint =
                      GetQualifiedGeneric(%trimr(MTIMPNRecord.IPISBP) + '*');
       Record.Name = %trimr(MTIMPNRecord.IPIPNM);
       Record.Address.Line(1) = %trimr(MTIMPNRecord.IPADR1);
       Record.Address.Line(2) = %trimr(MTIMPNRecord.IPADR2);
       Record.Address.Line(3) = %trimr(MTIMPNRecord.IPADR3);
       Record.Address.Line(4) = %trimr(MTIMPNRecord.IPADR4);

       Record.SearchKey = %trimr(MTIMPNRecord.IPSKSN);
       Record.IsDeleted = (MTIMPNRecord.IPDLTD = 'Y');

       Record.Audit.CreatedByUSER = MTIMPNRecord.IPCUSR;
       Record.Audit.CreatedByPGM = MTIMPNRecord.IPCPGM;
       Record.Audit.CreatedDTS = MTIMPNRecord.IPCDTS;
       Record.Audit.EditedByUSER = MTIMPNRecord.IPEUSR;
       Record.Audit.EditedByPGM = MTIMPNRecord.IPEPGM;
       Record.Audit.EditedDTS = MTIMPNRecord.IPEDTS;

       return *on;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetImprintRecord
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTIMPNRecord
      * Description     : Get MTIMPN Record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTIMPNRecord
      *-------------------------------------------------------------------------
     P GetMTIMPNRecord...
     P                 B
     D GetMTIMPNRecord...
     D                 PI                  like(*in)
     D  Record                             likerec(MTIMPNF:*input)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTIMPNRecord
      *-------------------------------------------------------------------------
     D Sequence        S              3I 0
      *-------------------------------------------------------------------------
      * Program code    : GetMTIMPNRecord
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       Sequence = GetMTIMPNSequence(p_Subset:GetAction);
       select;
       when Sequence = 1;
            return GetMTIMPNF(Record:
                              p_Keys:
                              p_Subset:
                              GetAction);
       when Sequence = 2;
            return GetMTIMPNF2(Record:
                               p_Keys:
                               p_Subset:
                               GetAction);
       endsl;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTIMPNRecord
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTIMPNF
      * Description     : Get MTIMPNF data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_InKeys
      *                >:  p_InSubset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTIMPNF
      *-------------------------------------------------------------------------
     P GetMTIMPNF...
     P                 B
     D GetMTIMPNF...
     D                 PI                  like(*in)
     D  Record                             likerec(MTIMPNF:*input)
     D  p_InKeys                       *
     D  p_InSubset                     *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTIMPNF
      *-------------------------------------------------------------------------
     D InKeys          DS                  likeds(t_ImprintKeys)
     D                                     based(p_Inkeys)
     D InSubset        DS                  likeds(t_ImprintSubset)
     D                                     based(p_InSubset)
     D Keys            DS                  likerec(MTIMPNF:*key)
     D                                     inz
     D ByKeys          DS                  likerec(MTIMPNF:*key)
     D                                     inz
     D Subset          DS                  likeds(t_ImprintSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTIMPNF
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if p_InSubset <> *null;
            Subset = InSubset;
       endif;

       // Special processing for *last positioning.
       if GetAction = '*last';
            Keys.IPIMPN = *hival;
       endif;

       // Replace keys if keys passed.
       if p_InKeys <> *null;
            Keys.IPIMPN = InKeys.ImprintNo;
       endif;

       // Initialise record specific subset - key selection.
       if GetAction = '*bykeys';
            ByKeys.IPIMPN = Keys.IPIMPN;
       endif;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous'
       or   GetAction = '*bykeys';
            setll %kds(Keys) MTIMPNF;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(Keys) MTIMPNF;
       other;
            return *off;
       endsl;
       dou %eof(MTIMPNP);
            if GetAction = '*first'
            or GetAction = '*next'
            or GetAction = '*bykeys';
                 read MTIMPNF Record;
            else;
                 readp MTIMPNF Record;
            endif;
            if %eof(MTIMPNP)
            or not ChkImprintNo(ByKeys.IPIMPN:Record.IPIMPN);
                 return *off;
            endif;
            if ChkMTIMPNIsValid(Record:
                                Subset);
                 return *on;
            endif;
       enddo;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTIMPNF
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTIMPNF2
      * Description     : Get MTIMPNF2 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_InKeys
      *                >:  p_InSubset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTIMPNF2
      *-------------------------------------------------------------------------
     P GetMTIMPNF2...
     P                 B
     D GetMTIMPNF2...
     D                 PI                  like(*in)
     D  Record                             likerec(MTIMPNF2:*input)
     D  p_InKeys                       *
     D  p_InSubset                     *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTIMPNF2
      *-------------------------------------------------------------------------
     D InKeys          DS                  likeds(t_ImprintKeys)
     D                                     based(p_Inkeys)
     D InSubset        DS                  likeds(t_ImprintSubset)
     D                                     based(p_InSubset)
     D Keys            DS                  likerec(MTIMPNF2:*key)
     D                                     inz
     D Subset          DS                  likeds(t_ImprintSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTIMPNF2
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       if p_InSubset <> *null;
            Subset = InSubset;
            Keys.IPSKSN = Subset.SearchKey;
       endif;

       // Special processing for *last positioning.
       if GetAction = '*last';
            Keys.IPSKSN = GetPartialHiValue(Subset.SearchKey);
            Keys.IPIMPN = *hival;
       endif;

       // Replace keys if keys passed.
       if p_InKeys <> *null;
            Keys.IPSKSN = InKeys.SearchKey;
            Keys.IPIMPN = InKeys.ImprintNo;
       endif;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll %kds(Keys) MTIMPNF2;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(Keys) MTIMPNF2;
       other;
            return *off;
       endsl;
       dou %eof(MTIMPNL2);
            if GetAction ='*first'
            or GetAction ='*next';
                 read MTIMPNF2 Record;
            else;
                 readp MTIMPNF2 Record;
            endif;
            if %eof(MTIMPNL2)
            or not ChkSearchKey(Subset.SearchKey:Record.IPSKSN);
                 return *off;
            endif;
            if ChkMTIMPNIsValid(Record:
                                Subset);
                 return *on;
            endif;
       enddo;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTIMPNF2
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkMTIMPNIsValid
      * Description     : Check MTIMPN record is valid.
      * Returns         :< IsValid
      * Parameter      >:  Record
      *                >:  Subset
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkMTIMPNIsValid
      *-------------------------------------------------------------------------
     P ChkMTIMPNIsValid...
     P                 B
     D ChkMTIMPNIsValid...
     D                 PI              N
     D  Record                             likerec(MTIMPNF:*input)
     D  Subset                             likeds(t_ImprintSubset)
      *-------------------------------------------------------------------------
      * Local Variables : ChkMTIMPNIsValid
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkMTIMPNIsValid
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if not ChkDeleted(Subset.Deleted:Record.IPDLTD);
            return *off;
       endif;

       if not ChkSearchKey(Subset.SearchKey:Record.IPSKSN);
            return *off;
       endif;

       return *on; // Valid
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTIMPNIsValid
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTIMPNSequence
      * Description     : Get Logical index based on subset.
      * Returns         :< Sequence
      * Parameter      >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTIMPNSequence
      *-------------------------------------------------------------------------
     P GetMTIMPNSequence...
     P                 B
     D GetMTIMPNSequence...
     D                 PI             3I 0
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTIMPNSequence
      *-------------------------------------------------------------------------
     D  Subset         DS                  likeds(t_ImprintSubset)
     D                                     based(p_Subset)
      *-------------------------------------------------------------------------
      * Program code    : GetMTIMPNSequence
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return 1;
       endif;

       if GetAction = '*bykeys'
       or p_Subset = *null;
            return 1;
       endif;

       if %len(Subset.SearchKey) <> 0;
            return 2;
       endif;

       return 1;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTIMPNSequence
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetAuthorData
      * Description     : Get Author Data
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetAuthorData
      *-------------------------------------------------------------------------
     P GetAuthorData...
     P                 B
     D GetAuthorData...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetAuthorData
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Author)
     D                                     based(p_Data)
     D Record          DS                  likeds(t_AuthorRecord)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetAuthorData
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
       Data.Keys.ISBN = Record.ISBN;
       Data.Keys.MARCTagCode = Record.MARCTagCode;
       Data.Keys.MARCSequenceNo = Record.MARCSequenceNo;

       // Update record formats within data structure
       Data.Record(1) = Record;
       Data.Record(2) = Data.Record(1);

       return *on;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetAuthorData
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetAuthorRecord
      * Description     : Get Author Record
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
     D MTAUTHRecord    DS                  likerec(MTAUTHF:*input)
     D Keys            DS                  likerec(MTAUTHF:*key)
      *-------------------------------------------------------------------------
      * Program code    : GetAuthorRecord
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if not GetMTAUTHRecord(MTAUTHRecord:
                              p_Keys:
                              p_Subset:
                              GetAction);
            return *off;
       endif;

       Record.ISBN = MTAUTHRecord.AUISBN;
       Record.MARCTagCode = MTAUTHRecord.AUTAGC;
       Record.MARCSequenceNo = MTAUTHRecord.AUSEQN;

       Keys.AUISBN = MTAUTHRecord.AUISBN;
       Keys.AUTAGC = MTAUTHRecord.AUTAGC;
       Keys.AUSEQN = MTAUTHRecord.AUSEQN;
       setll %kds(Keys:3) MTAUTHF;
       dou %eof(MTAUTHP);
            reade %kds(Keys:3) MTAUTHF MTAUTHRecord;
            if not %eof(MTAUTHP);
                 Record.Name += MTAUTHRecord.AUAUTN;
            endif;
       enddo;

       return *on;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetAuthorRecord
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTAUTHRecord
      * Description     : Get MTAUTH Record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTAUTHRecord
      *-------------------------------------------------------------------------
     P GetMTAUTHRecord...
     P                 B
     D GetMTAUTHRecord...
     D                 PI                  like(*in)
     D  Record                             likerec(MTAUTHF:*input)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTAUTHRecord
      *-------------------------------------------------------------------------
     D Sequence        S              3I 0
      *-------------------------------------------------------------------------
      * Program code    : GetMTAUTHRecord
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       Sequence = GetMTAUTHSequence(p_Subset:GetAction);

       select;
       when Sequence = 1;
            return GetMTAUTHF(Record:
                              p_Keys:
                              p_Subset:
                              GetAction);
       endsl;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTAUTHRecord
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTAUTHF
      * Description     : Get MTAUTHF data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTAUTHF
      *-------------------------------------------------------------------------
     P GetMTAUTHF...
     P                 B
     D GetMTAUTHF...
     D                 PI                  like(*in)
     D  Record                             likerec(MTAUTHF:*input)
     D  p_InKeys                       *
     D  p_InSubset                     *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTAUTHF
      *-------------------------------------------------------------------------
     D InKeys          DS                  likeds(t_AuthorKeys)
     D                                     based(p_Inkeys)
     D InSubset        DS                  likeds(t_AuthorSubset)
     D                                     based(p_InSubset)
     D Keys            DS                  likerec(MTAUTHF:*key)
     D                                     inz
     D ByKeys          DS                  likerec(MTAUTHF:*key)
     D                                     inz
     D Subset          DS                  likeds(t_AuthorSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTAUTHF
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       if p_InSubset <> *null;
            Subset = InSubset;
            Keys.AUISBN = Subset.ISBN;
            Keys.AUTAGC = Subset.MARCTagCode;
            Keys.AUSEQN = Subset.MARCSequenceNo;
       endif;

       // Special processing for *last positioning.
       if GetAction = '*last';
            if Subset.ISBN = *blanks;
                 Keys.AUISBN = GetPartialHiValue;
            endif;
            if Subset.MARCTagCode = 0;
                 Keys.AUTAGC = *hival;
            endif;
            if Subset.MARCSequenceNo = 0;
                 Keys.AUSEQN = *hival;
            endif;
       endif;

       // Replace keys if keys passed.
       if p_InKeys <> *null;
            Keys.AUISBN = InKeys.ISBN;
            Keys.AUTAGC = InKeys.MARCTagCode;
            Keys.AUSEQN = InKeys.MARCSequenceNo;
       endif;

       // Initialise record specific subset - key selection.
       if GetAction = '*bykeys';
            ByKeys.AUISBN = Keys.AUISBN;
            ByKeys.AUTAGC = Keys.AUTAGC;
            ByKeys.AUSEQN = Keys.AUSEQN;
       endif;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous'
       or   GetAction = '*bykeys';
            setll %kds(Keys:3) MTAUTHF;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(Keys:3) MTAUTHF;
       other;
            return *off;
       endsl;
       dou %eof(MTAUTHP);
            if GetAction = '*first'
            or GetAction = '*next'
            or GetAction = '*bykeys';
                 read MTAUTHF Record;
            else;
                 readp MTAUTHF Record;
            endif;
            if %eof(MTAUTHP)
            or not ChkISBN(ByKeys.AUISBN:Record.AUISBN)
            or not ChkMARCTag(ByKeys.AUTAGC:Record.AUTAGC)
            or not ChkMARCsequence(ByKeys.AUSEQN:Record.AUSEQN);
                 return *off;
            endif;
            if ChkMTAUTHIsValid(Record:
                                Subset);
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
     D  Subset                             likeds(t_AuthorSubset)
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

       If not ChkMARCTag(Subset.MARCTagCode:Record.AUTAGC);
            return *off;
       endif;

       if not ChkMARCSequence(Subset.MARCSequenceNo:Record.AUSEQN);
            return *off;
       endif;

       return *on; // Valid
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTAUTHSequence
      * Description     : Get Logical index based on subset.
      * Returns         :< Sequence
      * Parameter      >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTAUTHSequence
      *-------------------------------------------------------------------------
     P GetMTAUTHSequence...
     P                 B
     D GetMTAUTHSequence...
     D                 PI             3I 0
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTAUTHSequence
      *-------------------------------------------------------------------------
     D  Subset         DS                  likeds(t_AuthorSubset)
     D                                     based(p_Subset)
      *-------------------------------------------------------------------------
      * Program code    : GetMTAUTHSequence
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return 1;
       endif;

       if GetAction = '*bykeys'
       or p_Subset = *null;
            return 1;
       endif;

       return 1;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTAUTHSequence
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetBibliographicData
      * Description     : Get Bibliographic Data
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetBibliographicData
      *-------------------------------------------------------------------------
     P GetBibliographicData...
     P                 B
     D GetBibliographicData...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetBibliographicData
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Bibliographic)
     D                                     based(p_Data)
     D Record          DS                  likeds(t_BibliographicRecord)
      *-------------------------------------------------------------------------
      * Program code    : GetBibliographicData
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
       Data.Keys.ISBN = Record.ISBN;
       Data.Keys.SupplierNo = Record.SupplierNo;
       Data.Keys.SearchKey = Record.SearchKey;

       // Update record formats within data structure
       Data.Record(1) = Record;
       Data.Record(2) = Data.Record(1);

       return *on;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetBibliographicData
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetBibliographicRecord
      * Description     : Get Bibliographic Record
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
     D MTBIBLRecord    DS                  likerec(MTBIBLF1:*input)
      *-------------------------------------------------------------------------
      * Program code    : GetBibliographicRecord
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if not GetMTBIBLRecord(MTBIBLRecord:
                              p_Keys:
                              p_Subset:
                              GetAction);
            return *off;
       endif;

       Record.ISBN = MTBIBLRecord.BLISBN;
       Record.SupplierNo = MTBIBLRecord.BLSUPN;
       Record.PublishedDate = MTBIBLRecord.BLPBDT;
       Record.RePrintDate = MTBIBLRecord.BLRPDT;
       Record.Binding = MTBIBLRecord.BLBIND;
       Record.Category = MTBIBLRecord.BLCATG;

       Record.SearchKey = %trimr(MTBIBLRecord.BLSKSN);
       Record.IsDeleted = (MTBIBLRecord.BLDLTD = 'Y');

       Record.Audit.CreatedByUSER = MTBIBLRecord.BLCUSR;
       Record.Audit.CreatedByPGM = MTBIBLRecord.BLCPGM;
       Record.Audit.CreatedDTS = MTBIBLRecord.BLCDTS;
       Record.Audit.EditedByUSER = MTBIBLRecord.BLEUSR;
       Record.Audit.EditedByPGM = MTBIBLRecord.BLEPGM;
       Record.Audit.EditedDTS = MTBIBLRecord.BLEDTS;

       return *on;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetBibliographicRecord
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTBIBLRecord
      * Description     : Get MTBIBL Record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLRecord
      *-------------------------------------------------------------------------
     P GetMTBIBLRecord...
     P                 B
     D GetMTBIBLRecord...
     D                 PI                  like(*in)
     D  Record                             likerec(MTBIBLF1:*input)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLRecord
      *-------------------------------------------------------------------------
     D Sequence        S              3I 0
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLRecord
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       Sequence = GetMTBIBLSequence(p_Subset:GetAction);

       select;
       when Sequence = 1;
            return GetMTBIBLF1(Record:
                               p_Keys:
                               p_Subset:
                               GetAction);
       when Sequence = 2;
            return GetMTBIBLF2(Record:
                               p_Keys:
                               p_Subset:
                               GetAction);
       when Sequence = 3;
            return GetMTBIBLF3(Record:
                               p_Keys:
                               p_Subset:
                               GetAction);
       when Sequence = 4;
            return GetMTBIBLF4(Record:
                               p_Keys:
                               p_Subset:
                               GetAction);
       endsl;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLRecord
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTBIBLF1
      * Description     : Get MTBIBLF1 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_InKeys
      *                >:  p_InSubset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF1
      *-------------------------------------------------------------------------
     P GetMTBIBLF1...
     P                 B
     D GetMTBIBLF1...
     D                 PI                  like(*in)
     D  Record                             likerec(MTBIBLF1:*input)
     D  p_InKeys                       *
     D  p_InSubset                     *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF1
      *-------------------------------------------------------------------------
     D InKeys          DS                  likeds(t_BibliographicKeys)
     D                                     based(p_InKeys)
     D InSubset        DS                  likeds(t_BibliographicSubset)
     D                                     based(p_InSubset)
     D Keys            DS                  likerec(MTBIBLF1:*key)
     D                                     inz
     D ByKeys          DS                  likerec(MTBIBLF1:*key)
     D                                     inz
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLF1
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       if p_InSubset <> *null;
            Subset = InSubset;
            Keys.BLISBN = Subset.ISBNImprint;
       endif;

       // Special processing for *last positioning.
       if GetAction = '*last';
            Keys.BLISBN = GetPartialHiValue(Subset.ISBNImprint);
       endif;

       // Replace keys if keys passed.
       if p_InKeys <> *null;
            Keys.BLISBN = InKeys.ISBN;
       endif;

       // Initialise record specific subset - key selection.
       if GetAction = '*bykeys';
            ByKeys.BLISBN = Keys.BLISBN;
       endif;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous'
       or   GetAction = '*bykeys';
            setll %kds(Keys) MTBIBLF1;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(Keys) MTBIBLF1;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL1);
            if GetAction = '*first'
            or GetAction = '*next'
            or GetAction = '*bykeys';
                 read MTBIBLF1 Record;
            else;
                 readp MTBIBLF1 Record;
            endif;
            if %eof(MTBIBLL1)
            or not ChkISBN(ByKeys.BLISBN:Record.BLISBN)
            or not ChkISBNImprint(Subset.ISBNImprint:
                                  Record.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(Record:
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
      *                >:  p_InKeys
      *                >:  p_InSubset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF2
      *-------------------------------------------------------------------------
     P GetMTBIBLF2...
     P                 B
     D GetMTBIBLF2...
     D                 PI                  like(*in)
     D  Record                             likerec(MTBIBLF2:*input)
     D  p_InKeys                       *
     D  p_InSubset                     *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF2
      *-------------------------------------------------------------------------
     D InKeys          DS                  likeds(t_BibliographicKeys)
     D                                     based(p_InKeys)
     D InSubset        DS                  likeds(t_BibliographicSubset)
     D                                     based(p_InSubset)
     D Keys            DS                  likerec(MTBIBLF2:*key)
     D                                     inz
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLF2
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       if p_InSubset <> *null;
            Subset = InSubset;
            Keys.BLSUPN = Subset.SupplierNo;
            Keys.BLSKSN = Subset.SearchKey;
            Keys.BLISBN = Subset.ISBNImprint;
       endif;

       // Special processing for *last positioning.
       if GetAction = '*last';
            Keys.BLSKSN = GetPartialHiValue(Subset.SearchKey);
            Keys.BLISBN = GetPartialHiValue(Subset.ISBNImprint);
       endif;

       // Replace keys if keys passed.
       if p_InKeys <> *null;
            Keys.BLSUPN = InKeys.SupplierNo;
            Keys.BLSKSN = InKeys.SearchKey;
            Keys.BLISBN = InKeys.ISBN;
       endif;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll %kds(Keys) MTBIBLF2;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(Keys) MTBIBLF2;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL2);
            if GetAction ='*first'
            or GetAction ='*next';
                 reade %kds(Keys:1) MTBIBLF2 Record;
            else;
                 readpe %kds(Keys:1) MTBIBLF2 Record;
            endif;
            if %eof(MTBIBLL2)
            or not ChkSearchKey(Subset.SearchKey:Record.BLSKSN)
            or not ChkIsPartial(Subset.SearchKey)
            and not ChkISBNImprint(Subset.ISBNImprint:
                                   Record.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(Record:
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
      *                >:  p_InKeys
      *                >:  p_InSubset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF3
      *-------------------------------------------------------------------------
     P GetMTBIBLF3...
     P                 B
     D GetMTBIBLF3...
     D                 PI                  like(*in)
     D  Record                             likerec(MTBIBLF3:*input)
     D  p_InKeys                       *
     D  p_InSubset                     *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF3
      *-------------------------------------------------------------------------
     D InKeys          DS                  likeds(t_BibliographicKeys)
     D                                     based(p_InKeys)
     D InSubset        DS                  likeds(t_BibliographicSubset)
     D                                     based(p_InSubset)
     D Keys            DS                  likerec(MTBIBLF3:*key)
     D                                     inz
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLF3
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       if p_InSubset <> *null;
            Subset = InSubset;
            Keys.BLSKSN = Subset.SearchKey;
            Keys.BLISBN = Subset.ISBNImprint;
       endif;

       // Special processing for *last positioning.
       if GetAction = '*last';
            Keys.BLSKSN = GetPartialHiValue(Subset.SearchKey);
            Keys.BLISBN = GetPartialHiValue(Subset.ISBNImprint);
       endif;

       // Replace keys if keys passed.
       if p_InKeys <> *null;
            Keys.BLSKSN = InKeys.SearchKey;
            Keys.BLISBN = InKeys.ISBN;
       endif;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll %kds(Keys) MTBIBLF3;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(Keys) MTBIBLF3;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL3);
            if GetAction = '*first'
            or GetAction = '*next';
                 read  MTBIBLF3 Record;
            else;
                 readp MTBIBLF3 Record;
            endif;
            if %eof(MTBIBLL3)
            or not ChkSearchKey(Subset.SearchKey:Record.BLSKSN)
            or not ChkIsPartial(Subset.SearchKey)
            and not ChkISBNImprint(Subset.ISBNImprint:
                                   Record.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(Record:
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
      *                >:  p_InKeys
      *                >:  p_InSubset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF4
      *-------------------------------------------------------------------------
     P GetMTBIBLF4...
     P                 B
     D GetMTBIBLF4...
     D                 PI                  like(*in)
     D  Record                             likerec(MTBIBLF4:*input)
     D  p_InKeys                       *
     D  p_InSubset                     *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF4
      *-------------------------------------------------------------------------
     D InKeys          DS                  likeds(t_BibliographicKeys)
     D                                     based(p_InKeys)
     D InSubset        DS                  likeds(t_BibliographicSubset)
     D                                     based(p_InSubset)
     D Keys            DS                  likerec(MTBIBLF4:*key)
     D                                     inz
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLF4
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       // Setup keys for record access.
       if p_InSubset <> *null;
            Subset = InSubset;
            Keys.BLSUPN = Subset.SupplierNo;
            Keys.BLISBN = Subset.ISBNImprint;
       endif;

       // Special processing for *last positioning.
       if GetAction = '*last';
            Keys.BLISBN = GetPartialHiValue(Subset.ISBNImprint);
       endif;

       // Replace keys if keys passed.
       if p_InKeys <> *null;
            Keys.BLSUPN = InKeys.SupplierNo;
            Keys.BLISBN = InKeys.ISBN;
       endif;

       select;
       when GetAction = '*first'
       or   GetAction = '*previous';
            setll %kds(Keys) MTBIBLF4;
       when GetAction = '*next'
       or   GetAction = '*last';
            setgt %kds(Keys) MTBIBLF4;
       other;
            return *off;
       endsl;
       dou %eof(MTBIBLL4);
            if GetAction = '*first'
            or GetAction = '*next';
                 reade %kds(Keys:1) MTBIBLF4 Record;
            else;
                 readpe %kds(Keys:1) MTBIBLF4 Record;
            endif;
            if %eof(MTBIBLL4)
            or not ChkISBNImprint(Subset.ISBNImprint:
                                  Record.BLISBN);
                 return *off;
            endif;
            if ChkMTBIBLIsValid(Record:
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
     D  Record                             likerec(MTBIBLF1:*input)
     D  Subset                             likeds(t_BibliographicSubset)
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

       if not ChkDeleted(Subset.Deleted:Record.BLDLTD);
            return *off;
       endif;

       if not ChkSupplierNo(Subset.SupplierNo:Record.BLSUPN);
            return *off;
       endif;

       if not ChkSearchKey(Subset.SearchKey:Record.BLSKSN);
            return *off;
       endif;

       if not ChkISBNImprint(Subset.ISBNImprint:Record.BLISBN);
            return *off;
       endif;

       return *on; // Valid
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLIsValid
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetMTBIBLSequence
      * Description     : Get Logical index based on subset.
      * Returns         :< Sequence
      * Parameter      >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLSequence
      *-------------------------------------------------------------------------
     P GetMTBIBLSequence...
     P                 B
     D GetMTBIBLSequence...
     D                 PI             3I 0
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLSequence
      *-------------------------------------------------------------------------
     D  Subset         DS                  likeds(t_BibliographicSubset)
     D                                     based(p_Subset)
      *-------------------------------------------------------------------------
      * Program code    : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return 1;
       endif;

       if GetAction = '*bykeys'
       or p_Subset = *null;
            return 1;
       endif;

       if Subset.SupplierNo <> 0
       and %len(Subset.SearchKey) <> 0;
            return 2;
       endif;

       if Subset.SupplierNo <> 0;
            return 4;
       endif;

       if %len(Subset.SearchKey) <> 0;
            return 3;
       endif;

       return 1;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetMTBIBLSequence
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetQualifiedGeneric
      * Description     : Get Qualified Generic
      * Returns         :< QualifiedGeneric
      * Parameter      >:  Generic
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetQualifiedGeneric
      *-------------------------------------------------------------------------
     P GetQualifiedGeneric...
     P                 B
     D GetQualifiedGeneric...
     D                 PI            10A   varying
     D  Generic                      10A   varying
     D                                     const
      *-------------------------------------------------------------------------
      * Local Variables : GetQualifiedGeneric
      *-------------------------------------------------------------------------
     D QualifiedGeneric...
     D                 S             10A   varying
     D                                     inz
     D i               S              3I 0
      *-------------------------------------------------------------------------
      * Program code    : GetQualifiedGeneric
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return '';
       endif;

       if Generic = '*BLANKS';
            return *BLANKS;
       endif;

       if Generic = '*ALL';
            return '';
       endif;

       i = %scan('*':Generic);
       if i = 0;
            QualifiedGeneric = *BLANKS;
            return Generic + QualifiedGeneric;
       else;
            i -= 1;
            return %subst(Generic:1:i);
       endif;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetQualifiedGeneric
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : GetPartialHiValue
      * Description     : Get Partial and/or Hi-Value
      * Returns         :< PartialHiValue
      * Parameter      ?:  Partial
      *                ?:  Size
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetPartialHiValue
      *-------------------------------------------------------------------------
     P GetPartialHiValue...
     P                 B
     D GetPartialHiValue...
     D                 PI           256A   opdesc
     D                                     varying
     D  Partial                     256A   varying
     D                                     options(*varsize:
     D                                             *nopass:
     D                                             *omit)
     D                                     const
     D  Size                         10I 0 options(*nopass)
     D                                     const
      *-------------------------------------------------------------------------
      * Local Variables : GetPartialHiValue
      *-------------------------------------------------------------------------
     D PartialPassed   S               N
     D ReturnSize      S             10I 0
     D HiValue         S                   like(Partial)
     D                                     inz(*allx'FF')
     D                                     static
     D PartialHiValue  S                   like(Partial)
     D MaxReturn       S             10I 0 inz(%size(Partial))
     D CEEDODds        DS                  likeds(t_CEEDOD)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : GetPartialHiValue
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return HiValue;
       endif;

       PartialPassed = (%parms >= 1 and %addr(Partial) <> *null);

       if %parms >= 2;
            ReturnSize = Size;
            if ReturnSize > MaxReturn - 2;
                 QmhSndPgmMsg('MSG2013':      // Return size > HiValue storage
                              MsgFileLMMSGF:  // Message file
                              '':             // Message data
                              0:              // Length of message data
                              '*ESCAPE':      // Message type
                              '*PGMBDY':      // Call stack entry
                              1:              // Call stack count
                              '':             // Message key
                              x'00000000');   // API error DS
            endif;
       endif;

       if not PartialPassed;
            if ReturnSize = 0;
                 return HiValue;
            else;
                 return %subst(HiValue:1:ReturnSize);
            endif;
       else; // PartialPassed;
            CEEDOD(1:
                   CEEDODds.DescType:
                   CEEDODds.DataType:
                   CEEDODds.DescInfo1:
                   CEEDODds.DescInfo2:
                   CEEDODds.ParmLength:
                   *omit);

            if ReturnSize = 0;
                 ReturnSize = CEEDODds.ParmLength;
            elseif ReturnSize < CEEDODds.ParmLength;
                 QmhSndPgmMsg('MSG2014':      // Return size < input value
                              MsgFileLMMSGF:  // Message file
                              '':             // Message data
                              0:              // Length of message data
                              '*ESCAPE':      // Message type
                              '*PGMBDY':      // Call stack entry
                              1:              // Call stack count
                              '':             // Message key
                              x'00000000');   // API error DS
            endif;

            return Partial + %subst(HiValue:1:(ReturnSize - %len(Partial)));
       endif;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : GetPartialHiValue
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkSearchKey
      * Description     : Check SearchKey
      * Returns         :< IsValid
      * Parameter      >:  SearchKey
      *                >:  SearchKey
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkSearchKey
      *-------------------------------------------------------------------------
     P ChkSearchKey...
     P                 B
     D ChkSearchKey...
     D                 PI              N
     D  SearchKey1                   10A   varying
     D  SearchKey2                   10A
      *-------------------------------------------------------------------------
      * Local Variables : ChkSearchKey
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkSearchKey
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if SearchKey1 = %subst(SearchKey2:1:%len(SearchKey1));
            return *on;
       endif;

       return *off;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : ChkSearckKey
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkISBNImprint
      * Description     : Check ISBN Imprint
      * Returns         :< IsValid
      * Parameter      >:  ISBNImprint
      *                >:  ISBN
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkISBNImprint
      *-------------------------------------------------------------------------
     P ChkISBNImprint...
     P                 B
     D ChkISBNImprint...
     D                 PI              N
     D  ISBNImprint                  10A   varying
     D  ISBN                         10A
      *-------------------------------------------------------------------------
      * Local Variables : ChkISBNImprint
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkISBNImprint
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if ISBNImprint = %subst(ISBN:1:%len(ISBNImprint));
            return *on;
       endif;

       return *off;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : ChkISBNImprint
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
      * Procedure       : ChkImprintNo
      * Description     : Check Imprint number
      * Returns         :< IsValid
      * Parameter      >:  ImprintNo1
      *                >:  ImprintNo2
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkImprintNo
      *-------------------------------------------------------------------------
     P ChkImprintNo...
     P                 B
     D ChkImprintNo...
     D                 PI              N
     D  ImprintNo1                    8P 0
     D  ImprintNo2                    8P 0
      *-------------------------------------------------------------------------
      * Local Variables : ChkImprintNo
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkImprintNo
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if ImprintNo1 = *zero
       or ImprintNo1 = ImprintNo2;
            return *on;
       endif;

       return *off;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : ChkImprintNo
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkSupplierNo
      * Description     : Check Supplier number
      * Returns         :< IsValid
      * Parameter      >:  SupplierNo1
      *                >:  SupplierNo2
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkSupplierNo
      *-------------------------------------------------------------------------
     P ChkSupplierNo...
     P                 B
     D ChkSupplierNo...
     D                 PI              N
     D  SupplierNo1                   7P 0
     D  SupplierNo2                   7P 0
      *-------------------------------------------------------------------------
      * Local Variables : ChkSupplierNo
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkSupplierNo
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if SupplierNo1 = *zero
       or SupplierNo1 = SupplierNo2;
            return *on;
       endif;

       return *off;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : ChkSupplierNo
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkDeleted
      * Description     : Check deleted status
      * Returns         :< IsValid
      * Parameter      >:  Deleted1
      *                >:  Deleted2
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkDeleted
      *-------------------------------------------------------------------------
     P ChkDeleted...
     P                 B
     D ChkDeleted...
     D                 PI              N
     D  Deleted1                      1A
     D  Deleted2                      1A
      *-------------------------------------------------------------------------
      * Local Variables : ChkDeleted
      *-------------------------------------------------------------------------
      *-------------------------------------------------------------------------
      * Program code    : ChkDeleted
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       if Deleted1 = 'Y' and Deleted2 = *blanks
       or Deleted1 = 'N' and Deleted2 <> *blanks;
            return *off;
       endif;

       return *on;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : ChkDeleted
      *-------------------------------------------------------------------------

      *----------------------------------------------------------------------
      * Procedure       : ChkIsPartial
      * Description     : Check length verses size
      * Returns         :< IsValid
      * Parameter      >:  Data
      *-------------------------------------------------------------------------
      * BEGIN Procedure : ChkIsPartial
      *-------------------------------------------------------------------------
     P ChkIsPartial...
     P                 B
     D ChkIsPartial...
     D                 PI              N   opdesc
     D  Data                        256A   varying
     D                                     options(*varsize)
      *-------------------------------------------------------------------------
      * Local Variables : ChkIsPartial
      *-------------------------------------------------------------------------
     D CEEDODds        DS                  likeds(t_CEEDOD)
     D                                     inz
      *-------------------------------------------------------------------------
      * Program code    : ChkIsPartial
      *-------------------------------------------------------------------------
      /free
       if not InzSrvPgm;
            return *off;
       endif;

       CEEDOD(1:
              CEEDODds.DescType:
              CEEDODds.DataType:
              CEEDODds.DescInfo1:
              CEEDODds.DescInfo2:
              CEEDODds.ParmLength:
              *omit);
       if %len(Data) < CEEDODds.ParmLength;
            return *on;
       endif;

       return *off;
      /end-free
     P                 E
      *-------------------------------------------------------------------------
      * END Procedure   : ChkIsPartial
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
       or GetAction = '*bykeys' and p_Keys = *null
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
            if not %open(MTIMPNL2);
                 open MTIMPNL2;  // Imprint
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

