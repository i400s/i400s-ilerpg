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
       if SRVDTA_GetAuthor(AuthorKeys:Author);
         dsply ('Error: Record');
       endif;

       AuthorKeys.ISBN = '0000000008';
       AuthorKeys.MARCTag = 100;
       AuthorKeys.Sequence = 1;
       if not SRVDTA_GetAuthor(AuthorKeys:Author);
         dsply ('Error: No record');
       elseif Author(1).Name<>'A long author with a very sillly name to test.';
         dsply ('Error: Invalid author returned');
       endif;

       if not SRVDTA_GetAuthor(AuthorKeys:Author:*omit:*omit);
         dsply ('Error: *omit:*omit');
       endif;

       if not SRVDTA_GetAuthor(AuthorKeys:Author:'*ALLKEY');
         dsply ('Error: *ALLKEY');
       endif;

       monitor;
         SRVDTA_GetAuthor(AuthorKeys:Author:'*allkey':*omit);
         dsply ('Error: *allkey');
       on-error;
       endmon;

       monitor;
         SRVDTA_GetAuthor(AuthorKeys:Author:'*ALLKEY':'not null');
         dsply ('Error: selection not null');
       on-error;
       endmon;

       *inlr = *on;
       return;

      /end-free

