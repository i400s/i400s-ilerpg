 ENTRY:      PGM        PARM(&PGM &OPT &FKY &CPC &SKSN &SUPN &IMPN &DLTD &ISBN &EC)

             /* */
             DCL        VAR(&MSGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGF) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGFLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGDTA) TYPE(*CHAR) LEN(200)

             /* */
             DCL        VAR(&PGM) TYPE(*CHAR) LEN(10) /* Program name */
             DCL        VAR(&OPT) TYPE(*CHAR) LEN(2) /* Option */
             DCL        VAR(&FKY) TYPE(*CHAR) LEN(2) /* Function key */
             DCL        VAR(&CPC) TYPE(*LGL) /* Caller performs commit */

             /* */
             DCL        VAR(&SKSN) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SUPN) TYPE(*DEC) LEN(7 0)
             DCL        VAR(&IMPN) TYPE(*DEC) LEN(8 0)
             DCL        VAR(&DLTD) TYPE(*CHAR) LEN(1)
             DCL        VAR(&ISBN) TYPE(*CHAR) LEN(10)
             DCL        VAR(&EC) TYPE(*CHAR) LEN(272)

             /* */
             CHGVAR     VAR(&EC) VALUE(X'0000011000000000') /* Bytes provided, 000000110 = +
                          272 */

             MONMSG     MSGID(CPF0000 RPG9001) EXEC(GOTO PGMERR)


             /* */
             CALL       PGM(SO1710) PARM(&PGM &OPT &FKY &CPC &SKSN &SUPN &IMPN &DLTD &ISBN &EC)



             /* */
             GOTO       CMDLBL(ENDPGM)

             /* */
 PGMERR:     RCVMSG     PGMQ(*SAME (*)) MSGTYPE(*EXCP) RMV(*NO) MSGDTA(&MSGDTA) MSGID(&MSGID) +
                          MSGF(&MSGF) SNDMSGFLIB(&MSGFLIB)
             IF         COND(&MSGFLIB *NE '          ') THEN(DO)
                ROLLBACK
                MONMSG     MSGID(CPF0000)
                SNDPGMMSG  MSGID(&MSGID) MSGF(&MSGFLIB/&MSGF) MSGDTA(&MSGDTA) MSGTYPE(*ESCAPE)
             ENDDO


 ENDPGM:
             ENDPGM

