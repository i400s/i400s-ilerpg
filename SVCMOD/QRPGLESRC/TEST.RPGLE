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
     D TestAll         S             30A   varying
     D AllKey          C                   '*allKEY   '
     D TestAllK        S             10A
      /free
       // -------------------------------------------------------------------------
       // -------------------------------------------------------------------------
       AuthorKeys.ISBN = '0000000008';
       AuthorKeys.MARCTag = 100;
       AuthorKeys.Sequence = 1;
       SRVDTA_GetAuthor(AuthorKeys:Author);
       AuthorKeys.ISBN = '0000000008';
       AuthorKeys.MARCTag = 100;
       AuthorKeys.Sequence = 3;
       SRVDTA_GetAuthor(AuthorKeys:Author);
       SRVDTA_GetAuthor(AuthorKeys:Author:'*allkey');
       SRVDTA_GetAuthor(AuthorKeys:Author:*omit:*omit);
       monitor;
       SRVDTA_GetAuthor(AuthorKeys:Author:'':*omit);
       on-error;
       //  dump(a);
       endmon;
       monitor;
       SRVDTA_GetAuthor(AuthorKeys:Author:*omit:'');
       on-error;
       //  dump(a);
       endmon;
       TestAllK = AllKey;
       SRVDTA_GetAuthor(AuthorKeys:Author:TestAllK:*omit);
       dump(a);
       SRVDTA_GetAuthor(AuthorKeys:Author:AllKey:*omit);
       TestAll =  '*allkey';
       TestAll +=  AllKey;
       TestAll += x'00000000';
       TestAll += '*AllKeY';
       dump(a);

       *inlr = *on;
       return;

      /end-free

