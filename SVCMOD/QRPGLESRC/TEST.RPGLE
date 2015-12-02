      *_________________________________________________________________________
      * Description  : Test stuff.
      * Programmer   : Jonathan Wilson
      * Date Created : 30/07/2015
      *_________________________________________________________________________
      * MODIFICATIONS
      *_________________________________________________________________________
      *
      * By           :
      * Date         :
      * Scan string  :
      * Description  :
      *_________________________________________________________________________
      /define SrvDta
      /include qincprsrc,StdHSpec
      *
      *_________________________________________________________________________
      * Global data and procedure specifications
      *_________________________________________________________________________
      /include StdDSpec
      *
      /include SrvDta_H

     D ImprintKeys     DS                  likeds(t_ImprintKeys)
     D                                     inz
     D ImprintToKeys   DS                  likeds(t_ImprintKeys)
     D                                     inz
     D Imprint         DS                  likeds(t_Imprint)
     D                                     inz
     D ImprintSubset   DS                  likeds(t_ImprintSubset)
     D                                     inz
     D AuthorKeys      DS                  likeds(t_AuthorKeys)
     D                                     inz
     D Author          DS                  likeds(t_Author)
     D                                     inz
     D AuthorSubset    DS                  likeds(t_AuthorSubset)
     D                                     inz
     D BiblKeys        DS                  likeds(t_BibliographicKeys)
     D                                     inz
     D biblSubset      DS                  likeds(t_BibliographicSubset)
     D                                     inz
     D Bibl            DS                  likeds(t_Bibliographic)
     D                                     inz

     D wait            S              1A
     D i               S              3I 0
     D WK001C          S              1A
      /free
       // -------------------------------------------------------------------------
       ImprintKeys.ImprintNo = 99999999;
       if SRVDTA_GetImprint(Imprint:ImprintKeys);
            dsply ('Error: Record');
       endif;

       ImprintKeys.ImprintNo = 2;
       if not SRVDTA_GetImprint(Imprint:ImprintKeys:*omit);
            dsply ('Error: No record');
       elseif Imprint.Record(1).Name <> 'Imprint name2';
            dsply ('Error: Invalid Imprint name returned');
            dump(a);
       endif;

       if not SRVDTA_GetImprint(Imprint:Imprint:*omit);
            dsply ('Error: *omit');
       endif;

       if not SRVDTA_GetImprintLast(Imprint);
            dsply ('Error: no last') '' wait;
       elseif Imprint.Keys.ImprintNo <> 98989898;
            dsply ('Error: ImpNo not 98989898 ' +
                   %char(Imprint.Keys.ImprintNo)) ' ' wait;
       else;
            if not SRVDTA_GetImprintPrevious(Imprint:Imprint.Keys);
                 dsply ('Error: Imp no previous') ' ' wait;
            elseif Imprint.Keys.ImprintNo <> 1102;
                 dsply ('Error: Previous ImpNo <> 1102 ' +
                        %char(Imprint.Keys.ImprintNo)) ' ' wait;
            endif;
       endif;

       if not SRVDTA_GetImprintFirst(Imprint);
            dsply ('Error: no first') '' wait;
       elseif Imprint.Keys.ImprintNo <> 1;
            dsply ('Error: ImpNo not 1 ' +
                   %char(Imprint.Keys.ImprintNo)) ' ' wait;
       else;
            if not SRVDTA_GetImprintNext(Imprint:Imprint.Keys);
                 dsply ('Error: no next Impn') ' ' wait;
            elseif Imprint.Keys.ImprintNo <> 2;
                 dsply ('Error: Next ImpNo <> 2 ' +
                        %char(Imprint.Keys.ImprintNo)) ' ' wait;
            endif;
       endif;

       ImprintSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('MPRNTN*');

       if not SRVDTA_GetImprintFirst(Imprint:ImprintSubset);
            dsply ('Error: no first MPRNTN*') '' wait;
       elseif Imprint.Keys.ImprintNo <> 2;
            dsply ('Error: ImpNo MPRNTN* not 2 ' +
                   %char(Imprint.Keys.ImprintNo)) ' ' wait;
       else;
            if not SRVDTA_GetImprintNext(Imprint:Imprint.Keys:ImprintSubset);
                 dsply ('Error: no next MPRNTN* ') ' ' wait;
            elseif Imprint.Keys.ImprintNo <> 3;
                 dsply ('Error: Next MPRNTN* ImpNo <> 3 ' +
                        %char(Imprint.Keys.ImprintNo)) ' ' wait;
            else;
          if not SRVDTA_GetImprintPrevious(Imprint:Imprint.Keys:ImprintSubset);
                 dsply ('Error: no prev MPRNTN*') ' ' wait;
            elseif Imprint.Keys.ImprintNo <> 2;
                 dsply ('Error: prev MPRNTN* ImpNo <> 2 ' +
                        %char(Imprint.Keys.ImprintNo)) ' ' wait;
            endif;
            endif;
       endif;

       ImprintSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('MPRNTN*');
       ImprintSubset.Deleted = 'N';

       if not SRVDTA_GetImprintFirst(Imprint:ImprintSubset);
            dsply ('Error: no first MPRNTN*') '' wait;
       elseif Imprint.Keys.ImprintNo <> 2;
            dsply ('Error: ImpNo MPRNTN* not 2 ' +
                   %char(Imprint.Keys.ImprintNo)) ' ' wait;
       else;
            if SRVDTA_GetImprintNext(Imprint:Imprint.Keys:ImprintSubset);
                 dsply ('Error: next MPRNTN* ') ' ' wait;
            else;
            if SRVDTA_GetImprintPrevious(Imprint:Imprint.Keys:ImprintSubset);
                 dsply ('Error: prev MPRNTN*') ' ' wait;
            endif;
            endif;
       endif;

       if not SRVDTA_GetImprintLast(Imprint:ImprintSubset);
            dsply ('Error: no last MPRNTN*') '' wait;
       elseif Imprint.Keys.ImprintNo <> 2;
            dsply ('Error: ImpNo lst MPRNTN* not 2 ' +
                   %char(Imprint.Keys.ImprintNo)) ' ' wait;
       else;
            if SRVDTA_GetImprintPrevious(Imprint:Imprint.Keys:ImprintSubset);
                 dsply ('Error: Prevlst MPRNTN* ') ' ' wait;
            else;
            if SRVDTA_GetImprintNext(Imprint:Imprint.Keys:ImprintSubset);
                 dsply ('Error: nextlst MPRNTN*') ' ' wait;
            endif;
            endif;
       endif;

       ImprintSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('MPRNTNM2');
       if not SRVDTA_GetImprintLast(Imprint:ImprintSubset);
            dsply ('Error: no last MPRNTNM2') '' wait;
       elseif Imprint.Keys.ImprintNo <> 2;
            dsply ('Error: ImpNo lst MPRNTNM2 not 2 ' +
                   %char(Imprint.Keys.ImprintNo)) ' ' wait;
       endif;

       monitor;
            SRVDTA_ActionImprint('*copy':*off:*on:ImprintKeys:*omit);
            dsply ('False no Error: Imprint *copy ') '' wait;
       on-error;
       endmon;

       monitor;
            SRVDTA_ActionImprint('*garbage':*off:*on:ImprintKeys:*omit);
            dsply ('False no Error: Imprint *garbage ') '' wait;
       on-error;
       endmon;

       monitor;
            SRVDTA_ActionImprint('*delete':WK001C:*on:ImprintKeys:*omit);
            dsply ('False no Error: Imprint *delete no *in') '' wait;
       on-error;
       endmon;

       monitor;
            SRVDTA_ActionImprint('*delete':*off:wk001C:ImprintKeys:*omit);
            dsply ('False no Error: Imprint *delete no *off:*in ') '' wait;
       on-error;
       endmon;

       clear ImprintKeys;
       ImprintKeys.ImprintNo = 00000005;
       if not SRVDTA_GetImprint(Imprint:ImprintKeys);
            dsply ('Error: No Imprint 00000005') '' wait;
       endif;

       monitor;
            if SRVDTA_ActionImprint('*delete':*off:*off:ImprintKeys);
                 if not SRVDTA_GetImprint(Imprint:ImprintKeys);
                      dsply ('Error: No Imprint:*del 00000005') '' wait;
                 elseif not Imprint.Record(1).IsDeleted;
                      dsply ('Error: Not *del Imprint 00000005') '' wait;
                 endif;
            else;
                 dsply ('Error: Not Action *del Imprint 00000005') '' wait;
            endif;
       on-error;
            dsply ('On-Error: *del Imprint 00000005') '' wait;
       endmon;

       monitor;
            if SRVDTA_ActionImprint('*undelete':*off:*off:ImprintKeys);
                 if not SRVDTA_GetImprint(Imprint:ImprintKeys);
                      dsply ('Error: No Imprint:*udel 00000005') '' wait;
                 elseif Imprint.Record(1).IsDeleted;
                      dsply ('Error: *del Imprint 00000005') '' wait;
                 endif;
            else;
                 dsply ('Error: Not Action *udel Imprint 00000005') '' wait;
            endif;
       on-error;
            dsply ('On-Error: *udel Imprint 00000005') '' wait;
       endmon;

       ImprintToKeys.ImprintNo = 90000005;
       ImprintToKeys.ISBNImprint = '95';
       SRVDTA_ActionImprint('*copy':*off:*off:ImprintKeys:ImprintToKeys);
       ImprintKeys.ImprintNo = 90000005;
       ImprintToKeys.ImprintNo = 90000006;
       SRVDTA_ActionImprint('*rename':*off:*off:ImprintKeys:ImprintToKeys);
       SRVDTA_ActionImprint('*delete':*off:*off:ImprintToKeys);
       SRVDTA_ActionImprint('*purge':*off:*off:ImprintTokeys);

       monitor;
       ImprintKeys.ImprintNo = 91919191; // no exist
       SRVDTA_ActionImprint('*delete':*off:*off:ImprintKeys);
       on-error;
       endmon;

       ImprintKeys.ImprintNo = 00000005;
       SRVDTA_ActionImprint('*delete':*off:*off:ImprintKeys);

       monitor;
       ImprintKeys.ImprintNo = 00000005; // alredy deleted
       SRVDTA_ActionImprint('*delete':*off:*off:ImprintKeys);
       on-error;
       endmon;

       ImprintKeys.ImprintNo = 00000005;
       SRVDTA_ActionImprint('*undelete':*off:*off:ImprintKeys);


       // -------------------------------------------------------------------------
       AuthorKeys.ISBN = '9999999999';
       AuthorKeys.MARCTagCode = 100;
       AuthorKeys.MARCSequenceNo = 1;
       if SRVDTA_GetAuthor(Author:AuthorKeys);
            dsply ('Error: Record');
       endif;

       AuthorKeys.ISBN = '0000000008';
       AuthorKeys.MARCTagCode = 100;
       AuthorKeys.MARCSequenceNo = 1;
       if not SRVDTA_GetAuthor(Author:AuthorKeys:*omit);
            dsply ('Error: No record');
       elseif Author.Record(1).Name <> 'A long author with a very sillly +
                                 name to test.';
            dsply ('Error: Invalid author name returned');
            dump(a);
       endif;

       if not SRVDTA_GetAuthor(Author:AuthorKeys:*omit);
            dsply ('Error: *omit');
       endif;

       if not SRVDTA_GetAuthorLast(Author);
            dsply ('Error: no last') '' wait;
       elseif Author.Keys.ISBN <> '9898989898';
            dsply ('Error: ISBN not 9898989898 ' +
                   Author.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetAuthorPrevious(Author:Author.Keys);
                 dsply ('Error: no previous') ' ' wait;
            elseif Author.Keys.ISBN <> '9898989898'
            and Author.Keys.MARCTagCode <> 2;
                 dsply ('Error: Previous MarcTag <> 2 ' +
                        %char(Author.Keys.MARCTagCode)) ' ' wait;
            endif;
       endif;

       if not SRVDTA_GetAuthorFirst(Author);
            dsply ('Error: no first') '' wait;
       elseif Author.Keys.ISBN <> '0000000004';
            dsply ('Error: ISBN not 0000000004 ' +
                   Author.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetAuthorNext(Author:Author.Keys);
                 dsply ('Error: no next') ' ' wait;
            elseif Author.Keys.ISBN <> '0000000004'
            and Author.Keys.MARCTagCode <> 700;
                 dsply ('Error: Previous MarcTag <> 700 ' +
                        %char(Author.Keys.MARCTagCode)) ' ' wait;
            endif;
       endif;

       AuthorSubset.ISBN = '0000000007';

       if not SRVDTA_GetAuthorFirst(Author:AuthorSubset);
            dsply ('Error: no first 0000000007') '' wait;
       elseif Author.Keys.ISBN <> '0000000007';
            dsply ('Error: ISBN not 0000000007 ' +
                   Author.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetAuthorNext(Author:Author.Keys:AuthorSubset);
                 dsply ('Error: no next 0000000007') ' ' wait;
            elseif Author.Keys.ISBN <> '0000000007'
            and Author.Keys.MARCTagCode <> 700;
                 dsply ('Error: Next 0000000007 MarcTag <> 700 ' +
                        %char(Author.Keys.MARCTagCode)) ' ' wait;
            else;
            if not SRVDTA_GetAuthorPrevious(Author:Author.Keys:AuthorSubset);
                 dsply ('Error: no prev 0000000007') ' ' wait;
            elseif Author.Keys.ISBN <> '0000000007'
            and Author.Keys.MARCTagCode <> 100;
                 dsply ('Error: prev 0000000007 MarcTag <> 100 ' +
                        %char(Author.Keys.MARCTagCode)) ' ' wait;
            endif;
            endif;
       endif;

       clear AuthorSubset;
       AuthorSubset.MARCSequenceNo = 1;
       monitor;
            SRVDTA_GetAuthorFirst(Author:AuthorSubset);
            dsply ('Error: no exception MARCSeq') '' wait;
       on-error;
       endmon;

       clear AuthorSubset;
       AuthorSubset.MARCTagCode = 700;
       AuthorSubset.MARCSequenceNo = 1;
       if not SRVDTA_GetAuthorFirst(Author:AuthorSubset);
            dsply ('Error: no first 700') '' wait;
       elseif Author.Keys.ISBN <> '0000000004';
            dsply ('Error: ISBN not 0000000004 ' +
                   Author.Keys.ISBN) ' ' wait;
       elseif not SRVDTA_GetAuthorNext(Author:Author.Keys:AuthorSubset);
            dsply ('Error: no next 700') '' wait;
       elseif Author.Keys.ISBN <> '0000000016';
            dsply ('Error: ISBN not 00000000016 ' +
                   Author.Keys.ISBN) ' ' wait;
       endif;



       // ----------------------------------------------------------------------
       // test Bibliographic
       if not SRVDTA_GetBibliographicFirst(Bibl);
            dsply ('Error, no input, no records in Bibl') ' ' wait;
       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('*BLANKS');

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=*BLANKS, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1019000005';
            dsply ('Error, SKSN=*BLANKS, not 1019000005 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset);
                 dsply ('ErNxt, SKSN=*BLANKS, no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '1019000007';
            dsply ('ErNxt, SKSN=*BLANKS, not 1019000007 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('*ALL');

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=*ALL, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '0000000007';
            dsply ('Error, SKSN=*ALL, not 0000000007 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset);
                 dsply ('ErNxt, SKSN=*ALL, no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '0000000008';
            dsply ('ErNxt, SKSN=*ALL, not 0000000008 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('*ALL');
       BiblSubset.SupplierNo = 2;

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=*ALL:SUPN=2, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '0000000011';
            dsply ('Error, SKSN=*ALL:SUPN=2, not 0000000011 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset);
                 dsply ('ErNxt, SKSN=*ALL:SUPN:=2 no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '0000000116';
            dsply ('ErNxt, SKSN=*ALL:SUPN=2 not 0000000116 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('C*');
       BiblSubset.SupplierNo = 2;

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=C*:SUPN=2, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1080000001';
            dsply ('Error, SKSN=C*:SUPN=2, not 1080000001 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset);
                 dsply ('ErNxt, SKSN=C*:SUPN=2 record in Bibl') ' ' wait;
            endif;

       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('F*');
       ImprintKeys.ImprintNo = 3;
       if SRVDTA_GetImprint(Imprint:ImprintKeys:*omit);
            BiblSubset.ISBNImprint = Imprint.Record(1).ISBNImprint;
       endif;

       if not SRVDTA_GetBibliographicLast(Bibl:
                                          BiblSubset);
            dsply ('Error, SKSN=F*:SUPN=2:IMPN=3 NoRcdin Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '0004567890';
            dsply ('Err:SKSN=F*:SUPN=2,IMPN=3 not 0004567890 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset);
                 dsply ('ErNxt, SKSN=F*:SUPN=2:IMPN=3 record in Bibl') ' ' wait;
            endif;
            if not SRVDTA_GetBibliographicPrevious(Bibl:
                                                   Bibl.Keys:
                                                   BiblSubset);
                 dsply ('ErNxt, SKSN=F*:SUPN=2:IMPN=3 NoRcdin Bibl') ' ' wait;
            endif;

       endif;

       reset BiblSubset;
       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('CCC*');

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=CCC*:SUPN=0, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1010000011';
            dsply ('Error, SKSN=CCC*:SUPN=0, not 1010000011 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if SRVDTA_GetBibliographicNext(Bibl:
                                           Bibl.Keys:
                                           BiblSubset);
                 dsply ('ErNxt, SKSN=CCC*:SUPN=0 record in Bibl') ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('*ALL');
       BiblSubset.SupplierNo = 0;
       ImprintKeys.ImprintNo = 2;
       if SRVDTA_GetImprint(Imprint:ImprintKeys:*omit);
            BiblSubset.ISBNImprint = Imprint.Record(1).ISBNImprint;
       endif;

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=*ALL:IMPN=2, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '2000000002';
            dsply ('Error, SKSN=*ALL:IMPN=2, not 2000000002 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset);
                 dsply ('ErNxt, SKSN=*ALL:IMPN:=2 no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '2000000005';
            dsply ('ErNxt, SKSN=*ALL:IMPN=2 not 2000000005 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('FF');
       ImprintKeys.ImprintNo = 1;
       if SRVDTA_GetImprint(Imprint:ImprintKeys:*omit);
            BiblSubset.ISBNImprint = Imprint.Record(1).ISBNImprint;
       endif;

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=FF:IMPN=1, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1000000010';
            dsply ('Error, SKSN=FF:IMPN=1, not 1000000010 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                               Bibl.Keys:
                                               BiblSubset);
                 dsply ('ErNxt, SKSN=FF:IMPN:=1 no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '1010101010';
            dsply ('ErNxt, SKSN=FF:IMPN=1 not 1010101010 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       reset BiblSubset;
       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('*');

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=*:IMPN=0, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '0000000007';
            dsply ('Error, SKSN=*:IMPN=0, not 0000000007 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                               Bibl.Keys:
                                               BiblSubset);
                 dsply ('ErNxt, SKSN=*: no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '0000000008';
            dsply ('ErNxt, SKSN=*, not 0000000008 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('R*');
       ImprintKeys.ImprintNo = 1;
       if SRVDTA_GetImprint(Imprint:ImprintKeys:*omit);
            BiblSubset.ISBNImprint = Imprint.Record(1).ISBNImprint;
       endif;

       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           BiblSubset);
            dsply ('Error, SKSN=R*:IMPN=1, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1010000013';
            dsply ('Error, SKSN=R*:IMPN=1, not 1010000013 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if SRVDTA_GetBibliographicNext(Bibl:
                                           Bibl.Keys:
                                           BiblSubset);
                 dsply ('ErNxt, SKSN=R*:IMPN=1 records in Bibl') ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('RR*');

       if SRVDTA_GetBibliographicFirst(Bibl:
                                       BiblSubset);
            dsply ('Error, SKSN=RR*:IMPN=1, Record in Bibl ' +
                   Bibl.Keys.ISBN) ' ' wait;
        endif;

       reset BiblKeys;
       BiblKeys.ISBN = '1080000001';
       reset Bibl;
       reset BiblSubset;
       if not SRVDTA_GetBibliographic(Bibl:
                                      BiblKeys:
                                      *omit);
            dsply ('Error, ISBN=1080000001, No Record in Bibl ')
                    ' ' wait;
       elseif Bibl.Keys.ISBN <> '1080000001';
            dsply ('Error, ISBN=108000000, <> ' +
                   Bibl.Keys.ISBN) ' ' wait;

       endif;
       BiblKeys.ISBN = '9898989898';
       if SRVDTA_GetBibliographic(Bibl:
                                  BiblKeys);
            dsply ('Error, ISBN=9898989898, Record in Bibl ')
                    ' ' wait;

       endif;

       if not SRVDTA_GetBibliographicLast(Bibl:
                                          *omit);
            dsply ('Error, no Record in Bibl ' +
                   Bibl.Keys.ISBN) ' ' wait;

       elseif not SRVDTA_GetBibliographicPrevious(Bibl:
                                                  Bibl.Keys:
                                                  *omit);
            dsply ('Error, Previous, No record in Bibl ' +
                   Bibl.Keys.ISBN) ' ' wait;

       endif;

       BiblSubset.SearchKey =
            SRVDTA_GetQualifiedSearchKey('C*');
       ImprintKeys.ImprintNo = 1;
       if SRVDTA_GetImprint(Imprint:ImprintKeys:*omit);
            BiblSubset.ISBNImprint = Imprint.Record(1).ISBNImprint;
       endif;

       i = 1;
       if not SRVDTA_GetBibliographicLast(Bibl:
                                          BiblSubset);
            dsply ('Error: SKSN=C*:IMPN=1, No last Record in Bibl ') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1010000011';
            dsply ('Error, SKSN=C*:IMPN=1,ISBN 1010000011 <> ' + Bibl.Keys.ISBN)
                    ' ' wait;
       else;
            BiblKeys = Bibl.Keys;
            dow SRVDTA_GetBibliographicPrevious(Bibl:
                                                Bibl.Keys:
                                                BiblSubset)
            and i < 15;
                 i += 1;
            enddo;
            if i <> 5 or Bibl.Keys.ISBN <> '1010000012';
                 dsply ('Err, SKSN=C*:IMPN=1, prevloop ' +
                        Bibl.Keys.ISBN + ' ' + %char(i))
                        ' ' wait;
            endif;
       endif;

       //

       *inlr = *on;
       return;

      /end-free

