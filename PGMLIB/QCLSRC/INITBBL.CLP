 ENTRY:      PGM        PARM(&OPTION)

             /* */
             DCL        VAR(&OPTION) TYPE(*CHAR) LEN(10)

             /* */
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGFLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(200)

             /* */
             MONMSG     MSGID(CPF0000) EXEC(GOTO PGMERR)

             /* */
             IF         COND(&OPTION *EQ '*START') THEN(DO)
                ADDLIBLE   LIB(JWILSON2) POSITION(*LAST)
                CHGJOB     DATFMT(*MDY) LANGID(ENU) CCSID(37)

                STRCMTCTL  LCKLVL(*CHG) NFYOBJ(JWILSON (*MSGQ)) CMTSCOPE(*JOB) +
                             DFTJRN(JWILSON2/JRN) OMTJRNE(*NONE)
             ENDDO

             /* */
             IF         COND(&OPTION *EQ '*END') THEN(DO)
                RMVLIBLE   LIB(JWILSON2)
                MONMSG     MSGID(CPF0000)
                ENDCMTCTL
                MONMSG     MSGID(CPF0000)
             ENDDO


             /* */
             GOTO       CMDLBL(ENDPGM)

             /* */
 PGMERR:     RCVMSG     PGMQ(*SAME (*)) MSGTYPE(*EXCP) RMV(*NO) MSGDTA(&MSGDTA) MSGID(&MSGID) +
                          MSGF(&MSGF) SNDMSGFLIB(&MSGFLIB)
             IF         COND(&MSGFLIB *NE '          ') THEN(DO)
                SNDPGMMSG  MSGID(&MSGID) MSGF(&MSGFLIB/&MSGF) MSGDTA(&MSGDTA) MSGTYPE(*ESCAPE)
             ENDDO


 ENDPGM:
             ENDPGM
