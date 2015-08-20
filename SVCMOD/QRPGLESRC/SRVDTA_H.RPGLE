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

     D t_BibliographicKeys...
     D                 DS                  qualified
     D                                     based(pt_BibliographicKeys)
     D   ISBN                        10A
     D   SupplierNo                   7P 0
     D   SearchKey                   10A
     D t_BibliographicSubset...
     D                 DS                  qualified
     D                                     based(pt_BibliographicSubset)
     D   SupplierNo                   7P 0
     D   SearchKey                   10A
     D   ImprintNo                    8P 0
     D   Deleted                      1A
     D t_BibliographicRecord...
     D               E DS                  qualified
     D                                     extname(MTBIBLP:MTBIBLF:*input)
     D                                     based(pt_BibliographicRecord)
     D t_Bibliographic...
     D                 DS                  qualified
     D                                     based(pt_Bibliographic)
     D   Keys                              likeds(t_BibliographicKeys)
     D   Record                            likeds(t_BibliographicRecord)
     D                                     dim(2)

     D t_SearchKeyPfx...
     D                 DS                  qualified
     D                                     based(pt_SearchKeyPfx)
     D  Prefix                       10    varying
     D  IsGeneric                     1N
     D t_ImprintPfx    DS                  qualified
     D                                     based(pt_ImprintPfx)
     D  Prefix                       10    varying
     D  IsGeneric                     1N
     D
     D
      /if defined(SrvDta_)
     D t_MTBIBLSubset...
     D                 DS                  qualified
     D                                     based(pt_MTBIBLSubset)
     D  SupplierNo                    7  0
     D  SearchKeyPfx                       likeds(t_SearchKeyPfx)
     D  ImprintPfx                         likeds(t_ImprintPfx)
     D  Deleted                       1A
     D  ISBN                         10A
      /endif
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
      * END Procedure   : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographic
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Bibliographic
      *                >:  Keys
      *                ?:  KeysType
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographic...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Access                       10A   options(*nopass:
     D                                             *omit)
      /if not defined(SrvDta_)
     D                                     const
      /endif
     D  ReturnFmt                    10A   options(*nopass:
     D                                             *omit)
      /if not defined(SrvDta_)
     D                                     const
      /endif
     D  Subset                             likeds(t_bibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      /if not defined(SrvDta_)
     D                                     const
      /endif

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
      /endif

      /if defined(SRVDTA_GetBibliographic)
      /undefine   SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
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
     D  ReturnFmt                    10A   options(*nopass:
     D                                             *omit)
     D  Access                       10A   options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D p_ReturnFmt     S               *
     D ReturnFmtOpts...
     D                 C                   '*NONE,*KEYSONLY,*ALL'
     D p_Access        S               *
     D AccessOpts...
     D                 C                   '*DFTKEY'

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicFirst
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Keys
      *                ?:  Subset
      *                ?:  ReturnFmt
      *                ?:  Access
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicFirst...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D                                     options(*nopass:
     D                                             *omit)
     D  Subset                             likeds(t_bibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
     D  ReturnFmt                    10A   options(*nopass:
     D                                             *omit)
      /if not defined(SrvDta_)
     D                                     const
      /endif
     D  Access                       10A   options(*nopass:
     D                                             *omit)
      /if not defined(SrvDta_)
     D                                     const
      /endif

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      /endif
      /if defined(SRVDTA_GetBibliographicFirst)
      /undefine   SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicFirst...
     P                 B                   export
     D SRVDTA_GetBibliographicFirst...
     D                 PI                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D                                     options(*nopass:
     D                                             *omit)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
     D  ReturnFmt                    10A   options(*nopass:
     D                                             *omit)
     D  Access                       10A   options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D p_ReturnFmt     S               *
     D ReturnFmtOpts...
     D                 C                   const('*NONE     +
     D                                            *KEYSONLY +
     D                                            *ALL      ')
     D p_Access        S               *
     D AccessOpts...
     D                 C                   const('*NOKEYS   +
     D                                            *BYKEY    ')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicNext
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *                ?:  ReturnFmt
      *                ?:  Access
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicNext...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_bibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
     D  ReturnFmt                    10A   options(*nopass:
     D                                             *omit)
      /if not defined(SrvDta_)
     D                                     const
      /endif
     D  Access                       10A   options(*nopass:
     D                                             *omit)
      /if not defined(SrvDta_)
     D                                     const
      /endif

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
      /endif
      /if defined(SRVDTA_GetBibliographicNext)
      /undefine   SRVDTA_GetBibliographicNext
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
     D  ReturnFmt                    10A   options(*nopass:
     D                                             *omit)
     D  Access                       10A   options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D p_ReturnFmt     S               *
     D ReturnFmtOpts...
     D                 C                   const('*NONE     +
     D                                            *KEYSONLY +
     D                                            *ALL      ')
     D p_Access        S               *
     D AccessOpts...
     D                 C                   const('*BYKEYS   ')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicNext
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
      /EOF
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
      /undefine OpenMTAUTHP
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
      * END Procedure   : OpenMTAUTHP
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetBibliographicFirst
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  p_ReturnFmt
      *                >:  p_Access
      *-------------------------------------------------------------------------
     D GetBibliographicFirst...
     D                 PR                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  p_ReturnFmt                    *
     D  p_Access                       *
      *-------------------------------------------------------------------------
      * END Prototype   : GetBibliographicFirst
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetBibliographicFirst)
      /undefine   GetBibliographicFirst
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetBibliographicFirst
      *-------------------------------------------------------------------------
     P GetBibliographicFirst...
     P                 B
     D GetBibliographicFirst...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  p_ReturnFmt                    *
     D  p_Access                       *

      *-------------------------------------------------------------------------
      * Local Variables : GetBibliographicFirst
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Bibliographic)
     D                                     based(p_Data)
     D Keys            DS                  likeds(t_BibliographicKeys)
     D                                     based(p_keys)
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     based(p_Subset)
     D ReturnFmt       S             10A   based(p_ReturnFmt)
     D Access          S             10A   based(p_Access)

     D Record          DS                  likeds(t_BibliographicRecord)
     D                                     inz
     D MTBIBLSubset...
     D                 DS                  likeds(t_MTBIBLSubset)
     D                                     inz
     D Sequence        S              3I 0
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetBibliographicNext
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  p_ReturnFmt
      *                >:  p_Access
      *-------------------------------------------------------------------------
     D GetBibliographicNext...
     D                 PR                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  p_ReturnFmt                    *
     D  p_Access                       *
      *-------------------------------------------------------------------------
      * END Prototype   : GetBibliographicNext
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetBibliographicNext)
      /undefine   GetBibliographicNext
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetBibliographicnext
      *-------------------------------------------------------------------------
     P GetBibliographicNext...
     P                 B
     D GetBibliographicNext...
     D                 PI                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  p_ReturnFmt                    *
     D  p_Access                       *

      *-------------------------------------------------------------------------
      * Local Variables : GetBibliographicNext
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Bibliographic)
     D                                     based(p_Data)
     D Keys            DS                  likeds(t_BibliographicKeys)
     D                                     based(p_keys)
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     based(p_Subset)
     D ReturnFmt       S             10A   based(p_ReturnFmt)
     D Access          S             10A   based(p_Access)

     D Record          DS                  likeds(t_BibliographicRecord)
     D                                     inz
     D MTBIBLSubset...
     D                 DS                  likeds(t_MTBIBLSubset)
     D                                     inz
     D Sequence        S              3I 0
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF1First
      * Description     : Get MTBIBLF1 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF1First...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10    const
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF1First
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF1First)
      /undefine   GetMTBIBLF1First
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF1First
      *-------------------------------------------------------------------------
     P GetMTBIBLF1First...
     P                 B
     D GetMTBIBLF1First...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10    const

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF1First
      *-------------------------------------------------------------------------
     D MTBIBLF         DS                  likerec(MTBIBLF1:*input)
     D                                     based(p_MTBIBLF)
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF2First
      * Description     : Get MTBIBLF2 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF2First...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10    const
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF2First
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF2First)
      /undefine   GetMTBIBLF2First
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF2First
      *-------------------------------------------------------------------------
     P GetMTBIBLF2First...
     P                 B
     D GetMTBIBLF2First...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10    const

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF2First
      *-------------------------------------------------------------------------
     D MTBIBLF         DS                  likerec(MTBIBLF2:*input)
     D                                     based(p_MTBIBLF)
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF3First
      * Description     : Get MTBIBLF3 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF3First...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10    const
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF3First
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF3First)
      /undefine   GetMTBIBLF3First
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF3First
      *-------------------------------------------------------------------------
     P GetMTBIBLF3First...
     P                 B
     D GetMTBIBLF3First...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10    const

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF3First
      *-------------------------------------------------------------------------
     D MTBIBLF         DS                  likerec(MTBIBLF3:*input)
     D                                     based(p_MTBIBLF)
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF4First
      * Description     : Get MTBIBLF4 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF4First...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10    const
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF4First
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF4First)
      /undefine   GetMTBIBLF4First
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF4First
      *-------------------------------------------------------------------------
     P GetMTBIBLF4First...
     P                 B
     D GetMTBIBLF4First...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10    const

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF4First
      *-------------------------------------------------------------------------
     D MTBIBLF         DS                  likerec(MTBIBLF4:*input)
     D                                     based(p_MTBIBLF)
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMTBIBLIsValid
      * Description     : Check MTBIBL record is valid
      * Returns         :< IsValid
      *                >:  Record
      *                >:  Subset
      *-------------------------------------------------------------------------
     D ChkMTBIBLIsValid...
     D                 PR              N
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMTBIBLIsValid
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkMTBIBLIsValid)
      /undefine   ChkMTBIBLIsValid
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
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLSequence
      * Description     : Get file assess sequence
      * Returns         :< Sequence
      *                >:  Subset
      *-------------------------------------------------------------------------
     D GetMTBIBLSequence...
     D                 PR             3I 0
     D  Subset                             likeds(t_MTBIBLSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLSequence)
      /undefine   GetMTBIBLSequence
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLSequence
      *-------------------------------------------------------------------------
     P GetMTBIBLSequence...
     P                 B
     D GetMTBIBLSequence...
     D                 PI             3I 0
     D  Subset                             likeds(t_MTBIBLSubset)

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLSequence
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetSearchKeyPfx
      * Description     : Get formatted SearchKeyPfx
      * Returns         :< SearchKeyPfx
      *                >:  SearchKey
      *-------------------------------------------------------------------------
     D GetSearchKeyPfx...
     D                 PR                  likeds(t_SearchKeyPfx)
     D  SearchKey                    10    const
      *-------------------------------------------------------------------------
      * END Prototype   : GetSearchKeyPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetSearchKeyPfx)
      /undefine   GetSearchKeyPfx
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
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : CmpSearchKeyPfx
      * Description     : Compare SearchKeyPfx
      * Returns         :< IsEqual
      *                >:  SearchKeyPfx
      *                >:  SearchKey
      *-------------------------------------------------------------------------
     D CmpSearchKeyPfx...
     D                 PR              N
     D  SearchKeyPfx                       likeds(t_SearchKeyPfx)
     D  SearchKey                    10
      *-------------------------------------------------------------------------
      * END Prototype   : CmpSearchKeyPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(CmpSearchKeyPfx)
      /undefine   CmpSearchKeyPfx
      *-------------------------------------------------------------------------
      * BEGIN Procedure : CmpSearchKeyPfx
      *-------------------------------------------------------------------------
     P CmpSearchKeyPfx...
     P                 B
     D CmpSearchKeyPfx...
     D                 PI              N
     D  SearchKeyPfx                       likeds(t_SearchKeyPfx)
     D  SearchKey                    10

      *-------------------------------------------------------------------------
      * Local Variables : CmpSearchKeyPfx
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetImprintPfx
      * Description     : Get formatted ImprintPfx
      * Returns         :< ImprintPfx
      *                >:  ImprintNo
      *-------------------------------------------------------------------------
     D GetImprintPfx...
     D                 PR                  likeds(t_ImprintPfx)
     D  ImprintNo                     8P 0 const
      *-------------------------------------------------------------------------
      * END Prototype   : GetImprintPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetImprintPfx)
      /undefine   GetImprintPfx
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
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : CmpImprintPfx
      * Description     : Compare ImprintPfx
      * Returns         :< IsEqual
      *                >:  ImprintPfx
      *                >:  ISBN
      *-------------------------------------------------------------------------
     D CmpImprintPfx...
     D                 PR              N
     D  ImprintPfx                         likeds(t_ImprintPfx)
     D  ISBN                         10
      *-------------------------------------------------------------------------
      * END Prototype   : CmpImprintPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(CmpImprintPfx)
      /undefine   CmpImprintPfx
      *-------------------------------------------------------------------------
      * BEGIN Procedure : CmpImprintPfx
      *-------------------------------------------------------------------------
     P CmpImprintPfx...
     P                 B
     D CmpImprintPfx...
     D                 PI              N
     D  ImprintPfx                         likeds(t_imprintPfx)
     D  ISBN                         10

      *-------------------------------------------------------------------------
      * Local Variables : CmpImprintPfx
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if NOT defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : InzSrvPgm
      * Description     : Service program initialisation
      * Returns         : *none
      * Parameter       : *none
      *-------------------------------------------------------------------------
     D InzSrvPgm...
     D                 PR             1N
      *-------------------------------------------------------------------------
      * END Prototype   : InzSrvPgm
      *-------------------------------------------------------------------------
      /endif
      /if defined(InzSrvPgm)
      /undefine InzSrvPgm
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
      * END Procedure   : InzSrvPgm
      *-------------------------------------------------------------------------
      /EOF
      /endif

      *-------------------------------------------------------------------------
      * END Internal procedures
      *-------------------------------------------------------------------------
      /endif

      /define SrvDta_h
