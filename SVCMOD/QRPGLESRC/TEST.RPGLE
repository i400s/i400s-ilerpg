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

       *inlr = *on;
       return;

      /end-free

