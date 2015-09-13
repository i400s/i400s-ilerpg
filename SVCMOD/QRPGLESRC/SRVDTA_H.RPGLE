      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Global definitions and templates
      *-------------------------------------------------------------------------
     D t_AuthorKeys...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   ISBN                        10A
     D   MARCTag                      3P 0
     D   Sequence                     3P 0
     D t_AuthorSubset...
     D                 DS                  Likeds(T_AuthorKeys)
     D                                     based(pt_Template)
     D t_AuthorRecord...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   AUISBN                      10A
     D   AUTAGC                       3P 0
     D   AUSEQN                       3P 0
     D   CreatedDTS                    Z
     D   ChangedDTS                    Z
     D   Name                      2048A   varying
     D t_Author...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   Keys                              likeds(t_AuthorKeys)
     D   Record                            likeds(t_AuthorRecord)
     D                                     dim(2)
      /if defined(SrvDta_)
     D t_MTAUTHSubset...
     D                 DS                  Likeds(T_AuthorSubset)
     D                                     based(pt_Template)
      /endif

     D t_BibliographicKeys...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   ISBN                        10A
     D   SupplierNo                   7P 0
     D   SearchKey                   10A
     D t_BibliographicSubset...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   SupplierNo                   7P 0
     D   SearchKey                   10A
     D   ImprintNo                    8P 0
     D   Deleted                      1A
     D t_BibliographicRecord...
     D               E DS                  qualified
     D                                     extname(MTBIBLP:MTBIBLF:*input)
     D                                     based(pt_Template)
     D t_Bibliographic...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D   Keys                              likeds(t_BibliographicKeys)
     D   Record                            likeds(t_BibliographicRecord)
     D                                     dim(2)

     D t_SearchKeyPfx...
     D                 DS                  qualified
     D                                     based(pt_Template)
     D  Prefix                       10    varying
     D  IsGeneric                     1N
     D t_ImprintPfx    DS                  qualified
     D                                     based(pt_Template)
     D  Prefix                       10    varying
     D  IsGeneric                     1N
     D
     D
      /if defined(SrvDta_)
     D t_MTBIBLSubset...
     D                 DS                  qualified
     D                                     based(pt_Template)
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
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthor...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)

      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthor
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthorFirst
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthorFirst...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthorFirst
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthorLast
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthorLast...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthorLast
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthorNext
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthorNext...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthorNext
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetAuthorPrevious
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetAuthorPrevious...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Author)
     D  Keys                               likeds(t_AuthorKeys)
     D  Subset                             likeds(t_AuthorSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetAuthorPrevious
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographic
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographic...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographic
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicFirst
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicFirst...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicFirst
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicLast
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicLast...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicLast
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicNext
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicNext...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicNext
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : SRVDTA_GetBibliographicPrevious
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< Data
      *                >:  Keys
      *                ?:  Subset
      *-------------------------------------------------------------------------
     D SRVDTA_GetBibliographicPrevious...
     D                 PR                  like(*in)
     D  Data                               likeds(t_Bibliographic)
     D  Keys                               likeds(t_BibliographicKeys)
     D  Subset                             likeds(t_BibliographicSubset)
     D                                     options(*nopass:
     D                                             *omit)
      *-------------------------------------------------------------------------
      * END Prototype   : SRVDTA_GetBibliographicPrevious
      *-------------------------------------------------------------------------
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
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetAuthor...
     D                 PR                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetAuthor
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetAuthorRecord
      * Description     : Get Author
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetAuthorRecord...
     D                 PR                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetAuthorRecord
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTAUTHF
      * Description     : Get MTAUTHF data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTAUTHF...
     D                 PR                  like(*in)
     D  Record                             likeds(t_AuthorRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTAUTHSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTAUTHF
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMTAUTHIsValid
      * Description     : Check MTAUTH record is valid
      * Returns         :< IsValid
      *                >:  Record
      *                >:  Subset
      *-------------------------------------------------------------------------
     D ChkMTAUTHIsValid...
     D                 PR              N
     D  Record                             likerec(MTAUTHF:*input)
     D  Subset                             likeds(t_MTAUTHSubset)
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMTAUTHIsValid
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTAUTHSequence
      * Description     : Get file assess sequence
      * Returns         :< Sequence
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTAUTHSequence...
     D                 PR             3I 0
     D  Subset                             likeds(t_MTAUTHSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTAUTHSequence
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetBibliographic
      * Description     : Get Bibliographic
      * Returns         :< IsFound
      * Parameter      >:< p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetBibliographic...
     D                 PR                  like(*in)
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetBibliographic
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetBibliographicRecord
      * Description     : Get Bibliographic record
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetBibliographicRecord...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetBibliographicRecord
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF1
      * Description     : Get MTBIBLF1 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF1...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF1
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF2
      * Description     : Get MTBIBLF2 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF2...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF2
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF3
      * Description     : Get MTBIBLF3 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF3...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_keys                         *
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF3
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLF4
      * Description     : Get MTBIBLF4 data
      * Returns         :< IsFound
      * Parameter      >:< Record
      *                >:  p_Keys
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLF4...
     D                 PR                  like(*in)
     D  Record                             likeds(t_BibliographicRecord)
     D  p_Keys                         *
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLF4
      *-------------------------------------------------------------------------
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

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : GetMTBIBLSequence
      * Description     : Get file assess sequence
      * Returns         :< Sequence
      *                >:  Subset
      *                >:  GetAction
      *-------------------------------------------------------------------------
     D GetMTBIBLSequence...
     D                 PR             3I 0
     D  Subset                             likeds(t_MTBIBLSubset)
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : GetMTBIBLSequence
      *-------------------------------------------------------------------------
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

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMARCTag
      * Description     : Check MARC tag
      * Returns         :< IsValid
      *                >:  TAGC1
      *                >:  TAGC2
      *-------------------------------------------------------------------------
     D ChkMARCTag...
     D                 PR              N
     D  TAGC1                         3P 0
     D  TAGC2                         3P 0
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMARCTag
      *-------------------------------------------------------------------------
      /endif

      /if not defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkMARCSequence
      * Description     : Check MARC sequence
      * Returns         :< IsValid
      *                >:  SEQN1
      *                >:  SEQN2
      *-------------------------------------------------------------------------
     D ChkMARCsequence...
     D                 PR              N
     D  SEQN1                         3P 0
     D  SEQN2                         3P 0
      *-------------------------------------------------------------------------
      * END Prototype   : ChkMARCSequence
      *-------------------------------------------------------------------------
      /endif

      /if NOT defined(SrvDta_h)
      *-------------------------------------------------------------------------
      * BEGIN Prototype : ChkGetParms
      * Description     : Check the parameters for the accessors
      * Returns         : IsValid
      * Parameter      >:  p_Data
      *                >:  p_Keys
      *                >:  p_Subset
      *                >:  GetAction
      *
      *-------------------------------------------------------------------------
     D ChkGetParms...
     D                 PR             1N
     D  p_Data                         *
     D  p_Keys                         *
     D  p_Subset                       *
     D  GetAction                    10A   varying
      *-------------------------------------------------------------------------
      * END Prototype   : ChkGetParms
      *-------------------------------------------------------------------------
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

      *-------------------------------------------------------------------------
      * END Internal procedures
      *-------------------------------------------------------------------------
      /endif

      /define SrvDta_h
