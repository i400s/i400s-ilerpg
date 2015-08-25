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
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *                ?:  ReturnFmt
      *                ?:  Access
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographic...
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
     D p_Access        S               *
     D GetAction       S             10A   varying
     D                                     inz('*unique')

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
     D p_Access        S               *
     D GetAction       S             10A   varying
     D                                     inz('*first')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicLast
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Keys
      *                ?:  Subset
      *                ?:  ReturnFmt
      *                ?:  Access
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicLast...
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
      * END Prototype   : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
      /endif
      /if defined(SRVDTA_GetBibliographicLast)
      /undefine   SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
      * BEGIN Procedure : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
     P SRVDTA_GetBibliographicLast...
     P                 B                   export
     D SRVDTA_GetBibliographicLast...
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
      * Local Variables : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D p_ReturnFmt     S               *
     D p_Access        S               *
     D GetAction       S             10A   varying
     D                                     inz('*last')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicLast
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
     D p_Access        S               *
     D GetAction       S             10A   varying
     D                                     inz('*next')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicPrevious
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *                ?:  ReturnFmt
      *                ?:  Access
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicPrevious...
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
      * END Prototype   : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
      /endif
      /if defined(SRVDTA_GetBibliographicPrevious)
      /undefine   SRVDTA_GetBibliographicPrevious
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
     D  ReturnFmt                    10A   options(*nopass:
     D                                             *omit)
     D  Access                       10A   options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * Local Variables : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
     D p_Data          S               *
     D p_Keys          S               *
     D p_Subset        S               *
     D p_ReturnFmt     S               *
     D p_Access        S               *
     D GetAction       S             10A   varying
     D                                     inz('*previous')

      *-------------------------------------------------------------------------
      * END Procedure   : SRVDTA_GetBibliographicPrevious
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
      * BEGIN Prototype : GetBibliographic
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  p_ReturnFmt
      *                >:  p_Access
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetBibliographic...
     D                 PR                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  p_ReturnFmt                    *
     D  p_Access                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetBibliographic
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetBibliographic)
      /undefine   GetBibliographic
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
     D  p_ReturnFmt                    *
     D  p_Access                       *
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetBibliographic
      *-------------------------------------------------------------------------
     D Data            DS                  likeds(t_Bibliographic)
     D                                     based(p_Data)
     D Keys            DS                  likeds(t_BibliographicKeys)
     D                                     based(p_keys)
     D Subset          DS                  likeds(t_BibliographicSubset)
     D                                     based(p_Subset)
     D ReturnFmt       S             10A   based(p_ReturnFmt)
     D  ReturnFmtOpts...
     D                 C                   const('*NONE     +
     D                                            *KEYSONLY +
     D                                            *DATAKEYS +
     D                                            *DATAALL  +
     D                                            *ALL      ')
     D Access          S             10A   based(p_Access)
     D  AccessOpts...
     D                 C                   const('*NOKEYS   +
     D                                            *BYKEYS   ')
     D  AccessNo       S              3I 0
     D MTBIBLSubset...
     D                 DS                  likeds(t_MTBIBLSubset)
     D                                     inz
     D Record          DS                  likeds(t_BibliographicRecord)
     D                                     inz
     D SKSNLo          S             10A   inz(*allx'00')
     D SKSNHi          S             10A   inz(*allx'FF')
     D ISBNLo          S             10A   inz(*allx'00')
     D ISBNHi          S             10A   inz(*allx'FF')

      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF)
      /undefine   GetMTBIBLF
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF
      *-------------------------------------------------------------------------
     P GetMTBIBLF...
     P                 B
     D GetMTBIBLF...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF
      *-------------------------------------------------------------------------
     D Sequence        S              3I 0
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF1
      * Description     : Get MTBIBLF1 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF1...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF1
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF1)
      /undefine   GetMTBIBLF1
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF1
      *-------------------------------------------------------------------------
     P GetMTBIBLF1...
     P                 B
     D GetMTBIBLF1...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF1
      *-------------------------------------------------------------------------
     D MTBIBLF         DS                  likerec(MTBIBLF1:*input)
     D                                     based(p_MTBIBLF)
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF2
      * Description     : Get MTBIBLF2 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF2...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF2
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF2)
      /undefine   GetMTBIBLF2
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF2
      *-------------------------------------------------------------------------
     P GetMTBIBLF2...
     P                 B
     D GetMTBIBLF2...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF2
      *-------------------------------------------------------------------------
     D MTBIBLF         DS                  likerec(MTBIBLF2:*input)
     D                                     based(p_MTBIBLF)
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF3
      * Description     : Get MTBIBLF3 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF3...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF3
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF3)
      /undefine   GetMTBIBLF3
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF3
      *-------------------------------------------------------------------------
     P GetMTBIBLF3...
     P                 B
     D GetMTBIBLF3...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF3
      *-------------------------------------------------------------------------
     D MTBIBLF         DS                  likerec(MTBIBLF3:*input)
     D                                     based(p_MTBIBLF)
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF4
      * Description     : Get MTBIBLF4 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF4...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF4
      *-------------------------------------------------------------------------
      /endif
      /if defined(GetMTBIBLF4)
      /undefine   GetMTBIBLF4
      *-------------------------------------------------------------------------
      * BEGIN Procedure : GetMTBIBLF4
      *-------------------------------------------------------------------------
     P GetMTBIBLF4...
     P                 B
     D GetMTBIBLF4...
     D                 PI                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying

      *-------------------------------------------------------------------------
      * Local Variables : GetMTBIBLF4
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
      * BEGIN Prototype : ChkSearchKeyPfx
      * Description     : Check SearchKeyPfx
      * Returns         :< IsValid
      *                >:  SearchKeyPfx
      *                >:  SearchKey
      *-------------------------------------------------------------------------
     D ChkSearchKeyPfx...
     D                 PR              N
     D  SearchKeyPfx                       likeds(t_SearchKeyPfx)
     D  SearchKey                    10
      *-------------------------------------------------------------------------
      * END Prototype   : ChkSearchKeyPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkSearchKeyPfx)
      /undefine   ChkSearchKeyPfx
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
      * BEGIN Prototype : ChkImprintPfx
      * Description     : Check ImprintPfx
      * Returns         :< IsValid
      *                >:  ImprintPfx
      *                >:  ISBN
      *-------------------------------------------------------------------------
     D ChkImprintPfx...
     D                 PR              N
     D  ImprintPfx                         likeds(t_ImprintPfx)
     D  ISBN                         10
      *-------------------------------------------------------------------------
      * END Prototype   : ChkImprintPfx
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkImprintPfx)
      /undefine   ChkImprintPfx
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
      /EOF
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkISBN
      * Description     : Check ISBN
      * Returns         :< IsValid
      *                >:  ISBN1
      *                >:  ISBN2
      *-------------------------------------------------------------------------
     D ChkISBN...
     D                 PR              N
     D  ISBN1                        10
     D  ISBN2                        10
      *-------------------------------------------------------------------------
      * END Prototype   : ChkISBN
      *-------------------------------------------------------------------------
      /endif
      /if defined(ChkISBN)
      /undefine   ChkISBN
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
