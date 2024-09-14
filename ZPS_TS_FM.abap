FUNCTION zps_ts_fm.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(T_NAME) TYPE  TDOBNAME
*"     REFERENCE(T_OBJECT) TYPE  TDOBJECT
*"     REFERENCE(T_ID) TYPE  TDID
*"     REFERENCE(PROG_NAME) TYPE  SY-REPID
*"     REFERENCE(T_LANG) TYPE  SPRAS
*"  TABLES
*"      LT_VAR_NAME STRUCTURE  SOLI
*"      LT_TLINE STRUCTURE  TLINE
*"      LT_MESS STRUCTURE  BAPIRET1
*"  EXCEPTIONS
*"      TEXT_NOT_FOUND
*"      SYMBOL_NOT_FOUND
*"----------------------------------------------------------------------
  DATA : lt_text         TYPE TABLE OF tline,
         lt_text_replace TYPE TABLE OF tline,
         lv_concat       TYPE string,
         lt_count        TYPE i.


  CALL FUNCTION 'READ_TEXT'
    EXPORTING
*     CLIENT                  = SY-MANDT
      id                      = t_id
      language                = t_lang
      name                    = t_name
      object                  = t_object
*     ARCHIVE_HANDLE          = 0
*     LOCAL_CAT               = ' '
* IMPORTING
*     HEADER                  =
*     OLD_LINE_COUNTER        =
    TABLES
      lines                   = LT_Text
    EXCEPTIONS
      id                      = 1
      language                = 2
      name                    = 3
      not_found               = 4
      object                  = 5
      reference_check         = 6
      wrong_access_to_archive = 7
      OTHERS                  = 8.
  IF sy-subrc <> 0.
    RAISE text_not_found.
    RETURN.                       "RETURN ensures that the function exits cleanly without executing the remaining logic."
  ENDIF.

  lt_text_replace[] = lt_text[].

  IF lt_var_name[] IS NOT INITIAL.
    lt_count = 0.
    LOOP AT lt_var_name[] INTO DATA(ls_var_name).
      lv_concat = '&' && ls_var_name-line && '&'.
      SEARCH lt_text[] FOR lv_concat AND MARK.

      IF sy-subrc = 0.
        lt_count = lt_count + 1.
        REPLACE ALL OCCURRENCES OF lv_concat
             IN TABLE lt_text_replace[] WITH ' '
             RESPECTING CASE.
      ENDIF.
    ENDLOOP.
  ENDIF.

  SEARCH lt_text_replace[] FOR '&' AND MARK.
  IF sy-subrc = 0.
    MESSAGE 'Extra text-symbol found' TYPE 'E'.
  ENDIF.

  DATA(lv_lines) = lines( lt_var_name ).
  IF lt_count = lv_lines.

    CALL FUNCTION 'SET_TEXTSYMBOL_PROGRAM'
      EXPORTING
        program = prog_name
        event   = 'OPEN_fORM'.

    CALL FUNCTION 'REPLACE_TEXTSYMBOL'
      EXPORTING
        endline          = lv_lines
*       FORMATWIDTH      = 72
        language         = t_lang
*       LINEWIDTH        = 132
*       OPTION_DIALOG    = ' '
        replace_program  = 'X'
        replace_standard = 'X'
        replace_system   = 'X'
        replace_text     = 'X'
        startline        = 1
*     IMPORTING
*       CHANGED          =
      TABLES
        lines            = lt_text.
  ELSE.
    RAISE symbol_not_found.

  ENDIF.

  IF sy-subrc = 0.
    MOVE-CORRESPONDING lt_text[] TO lt_tline[].
  ENDIF.


ENDFUNCTION.
