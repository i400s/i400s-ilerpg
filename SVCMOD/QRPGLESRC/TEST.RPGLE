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

      /include SrvDta_H

     D AuthorKeys      DS                  likeds(t_AuthorKeys)
     D Author          DS                  likeds(t_Author)
     D                                     dim(2)
     D BiblKeys        DS                  likeds(t_BibliographicKeys)
     D biblSubset      DS                  likeds(t_BibliographicSubset)
     D                                     inz
     D Bibl            DS                  likeds(t_Bibliographic)

     D wait            S              1A
      /free
       // -------------------------------------------------------------------------
       // -------------------------------------------------------------------------
       AuthorKeys.ISBN = '9999999999';
       AuthorKeys.MARCTag = 100;
       AuthorKeys.Sequence = 1;
       if SRVDTA_GetAuthor(Author:AuthorKeys);
            dsply ('Error: Record');
       endif;

       AuthorKeys.ISBN = '0000000008';
       AuthorKeys.MARCTag = 100;
       AuthorKeys.Sequence = 1;
       if not SRVDTA_GetAuthor(Author:AuthorKeys);
            dsply ('Error: No record');
       elseif Author(1).Name <> 'A long author with a very sillly +
                                 name to test.';
            dsply ('Error: Invalid author returned');
       endif;

       if not SRVDTA_GetAuthor(Author:AuthorKeys:*omit);
            dsply ('Error: *omit');
       endif;

       if not SRVDTA_GetAuthor(Author:AuthorKeys:'*ALLKEY');
            dsply ('Error: *ALLKEY');
       endif;

       monitor;
            SRVDTA_GetAuthor(Author:AuthorKeys:'*allkey');
            dsply ('Error: *allkey');
       on-error;
       endmon;

       // ----------------------------------------------------------------------
       // test Bibliographic
       if not SRVDTA_GetBibliographicFirst(Bibl);
            dsply ('Error, no input, no records in Bibl') ' ' wait;
       endif;

       BiblSubset.SearchKey = '*BLANKS';
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=*BLANKS, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1019000005';
            dsply ('Error, SKSN=*BLANKS, not 1019000005 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=*BLANKS, no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '1019000007';
            dsply ('ErNxt, SKSN=*BLANKS, not 1019000007 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey = '*ALL';
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=*ALL, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '0000000007';
            dsply ('Error, SKSN=*ALL, not 0000000007 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=*ALL, no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '0000000008';
            dsply ('ErNxt, SKSN=*ALL, not 0000000008 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey = '*ALL';
       BiblSubset.SupplierNo = 2;
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=*ALL:SUPN=2, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '0000000011';
            dsply ('Error, SKSN=*ALL:SUPN=2, not 0000000011 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=*ALL:SUPN:=2 no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '0000000116';
            dsply ('ErNxt, SKSN=*ALL:SUPN=2 not 0000000116 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey = 'C*';
       BiblSubset.SupplierNo = 2;
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=C*:SUPN=2, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1080000001';
            dsply ('Error, SKSN=C*:SUPN=2, not 1080000001 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=C*:SUPN=2 record in Bibl') ' ' wait;
            endif;

       endif;

       BiblSubset.SearchKey = 'CCC*';
       BiblSubset.SupplierNo = 0;
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=CCC*:SUPN=0, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1010000011';
            dsply ('Error, SKSN=CCC*:SUPN=0, not 1010000011 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=CCC*:SUPN=0 record in Bibl') ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey = '*ALL';
       BiblSubset.SupplierNo = 0;
       BiblSubset.ImprintNo = 2;
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=*ALL:IMPN=2, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '2000000002';
            dsply ('Error, SKSN=*ALL:IMPN=2, not 2000000002 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=*ALL:IMPN:=2 no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '2000000005';
            dsply ('ErNxt, SKSN=*ALL:IMPN=2 not 2000000005 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey = 'FF';
       BiblSubset.SupplierNo = 0;
       BiblSubset.ImprintNo = 1;
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=FF:IMPN=1, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1000000010';
            dsply ('Error, SKSN=FF:IMPN=1, not 1000000010 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=FF:IMPN:=1 no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '1010101010';
            dsply ('ErNxt, SKSN=FF:IMPN=1 not 1010101010 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey = '*';
       BiblSubset.SupplierNo = 0;
       BiblSubset.ImprintNo = 0;
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=*:IMPN=0, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '0000000007';
            dsply ('Error, SKSN=*:IMPN=0, not 0000000007 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if not SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=*: no records in Bibl') ' ' wait;
            elseif Bibl.Keys.ISBN <> '0000000008';
            dsply ('ErNxt, SKSN=*, not 0000000008 ' +
                   Bibl.Keys.ISBN) ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey = 'R*';
       BiblSubset.SupplierNo = 0;
       BiblSubset.ImprintNo = 1;
       if not SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=R*:IMPN=1, no records in Bibl') ' ' wait;
       elseif Bibl.Keys.ISBN <> '1010000013';
            dsply ('Error, SKSN=R*:IMPN=1, not 1010000013 ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=R*:IMPN=1 records in Bibl') ' ' wait;
            endif;
       endif;

       BiblSubset.SearchKey = 'RR*';
       BiblSubset.SupplierNo = 0;
       BiblSubset.ImprintNo = 1;
       if SRVDTA_GetBibliographicFirst(Bibl:
                                           *omit:
                                           BiblSubset:
                                           '*KEYSONLY':
                                           *omit);
            dsply ('Error, SKSN=RR*:IMPN=1, Record in Bibl ' +
                   Bibl.Keys.ISBN) ' ' wait;
       else;
            if SRVDTA_GetBibliographicNext(Bibl:
                                          Bibl.Keys:
                                          BiblSubset:
                                          '*KEYSONLY':
                                          *omit);
                 dsply ('ErNxt, SKSN=RR*:IMPN=1 records in Bibl') ' ' wait;
            endif;
       endif;

       //

       *inlr = *on;
       return;

      /end-free

