      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Global definitions and templates
      *-------------------------------------------------------------------------
     D t_AuthorKeys...
     D                 DS                  qualified
     D                                     based(pt_AuthorKeys)
     D   ISBN                        10A
     D   MARCTag                      3P 0
     D   Sequence                     5P 0
     D t_Author...
     D                 DS                  qualified
     D                                     based(pt_Author)
     D   ISBN                        10A
     D   MARCTag                      3P 0
     D   Sequence                     5P 0
     D   CreatedDTS                    Z
     D   ChangedDTS                    Z
     D   Name                      2048A   varying
      *-------------------------------------------------------------------------
      * END Global definitions and templates
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthor
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Author
      *                >:  Keys
      *                ?:  KeysType
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthor...
     D                 PR                  like(*in)
     D  Author                             likeds(t_Author)
     D                                     dim(2)
     D  Keys                          1A   options(*varsize)
      /if not defined(SrvDta_)
     D                                     const
      /endif
     D  KeysType                     10A   options(*nopass:
     D                                             *omit)
      /if not defined(SrvDta_)
     D                                     const
      /endif

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      /endif

      /if defined(SRVDTA_GetAuthor)
      /undefine   SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
     P SRVDTA_GetAuthor...
     P                 B                   export
     D SRVDTA_GetAuthor...
     D                 PI                  like(*in)
     D  Author                             likeds(t_Author)
     D                                     dim(2)
     D  Keys                          1A   options(*varsize)
     D  KeysType                     10A   options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
     D p_KeysType      S               *

      *-------------------------------------------------------------------------
      * END Procedure  : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if defined(SrvDta_)
      *-------------------------------------------------------------------------
      * BEGIN Internal procedures
      *-------------------------------------------------------------------------

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetAuthor
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Author
      *                >:  Keys
      *                >:  KeysType
      *-------------------------------------------------------------------------
     D GetAuthor...
     D                 PR                  like(*in)
     D  Author                             likeds(t_Author)
     D                                     dim(2)
     D  p_AuthorKeys                   *   const
     D  p_KeysType                     *   const
      *-------------------------------------------------------------------------
      * END Prototype   : GetAuthor
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetAuthor)
      /undefine   GetAuthor
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetAuthor
      *-------------------------------------------------------------------------
     P GetAuthor...
     P                 B                   export
     D GetAuthor...
     D                 PI                  like(*in)
     D  Author                             likeds(t_Author)
     D                                     dim(2)
     D  p_AuthorKeys                   *   const
     D  p_KeysType                     *   const

      *-------------------------------------------------------------------------
      * Local Variables : GetAuthor
      *-------------------------------------------------------------------------
     D AuthorKeys      DS                  likeds(t_AuthorKeys)
     D                                     based(p_AuthorKeys)
     D KeysType        S             10A   based(p_KeysType)
      /endif

      /if NOT defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : OpenMTAUTHP
      * Description     : Opens file if not open
      * Returns         :< IsOpen
      * Parameter       : *none
      *-------------------------------------------------------------------------
     D OpenMTAUTHP...
     D                 PR                  like(*in)
      *-------------------------------------------------------------------------
      * END Prototype   : OpenMTAUTHP
      *-------------------------------------------------------------------------
      /endif
      /if defined(OpenMTAUTHP)
      /undefine OpenMTATUHP
      *-------------------------------------------------------------------------
      * BEGIN Procedure : OpenMTAUTHP
      *-------------------------------------------------------------------------
     P OpenMTAUTHP...
     P                 B
     D OpenMTAUTHP...
     D                 PI                  like(*in)
     D IsOpen          S              1N   static
     D                                     inz(*off)
      *-------------------------------------------------------------------------
      * END Procedure  : OpenMTAUTHP
      *-------------------------------------------------------------------------
      /EOF
      /endif

      *-------------------------------------------------------------------------
      * END Internal procedures
      *-------------------------------------------------------------------------
      /endif

      /define SrvDta_h
