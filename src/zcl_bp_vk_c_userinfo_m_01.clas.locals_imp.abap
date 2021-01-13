*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_user DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS set_user_admin      FOR MODIFY              IMPORTING keys FOR ACTION User_01~makeUserAdmin RESULT result.
    METHODS check_valid_email   FOR VALIDATE ON SAVE    IMPORTING keys FOR User_01~validEmail.
    METHODS assign_is_admin     FOR DETERMINE ON MODIFY IMPORTING keys FOR User_01~assignAdmin.

ENDCLASS.

CLASS lhc_user IMPLEMENTATION.
  METHOD set_user_admin.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_user>).
      UPDATE zvk_userinfo SET is_admin = 'YES' WHERE user_email = @<fs_user>-UserEmail.
      IF sy-subrc IS INITIAL.
        APPEND VALUE #( UserEmail = <fs_user>-UserEmail
                        %param-UserEmail = <fs_user>-UserEmail
                        %param-IsAdmin = 'YES' ) TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD check_valid_email.
    DATA: lr_regex          TYPE REF TO cl_abap_regex,
          lr_matcher        TYPE REF TO cl_abap_matcher,
          lv_email_to_check TYPE string.

    CREATE OBJECT lr_regex
      EXPORTING
        pattern     = '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'
        ignore_case = abap_true.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_user>).
      lr_matcher = lr_regex->create_matcher(
          text    = <fs_user>-UserEmail
   ).
      IF lr_matcher->match(  ) IS INITIAL.
        "if email does not match
        APPEND VALUE #( UserEmail = <fs_user>-UserEmail ) TO failed-user_01.
        APPEND VALUE #( UserEMail = <fs_user>-UserEmail  %msg = new_message( id = 'Z_USER_M_01' number = '001' v1 = <fs_user>-UserEmail severity = if_abap_behv_message=>severity-error ) )
            TO reported-user_01.
      ELSE.
        "if email matches
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD assign_is_admin.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_user>).
      IF <fs_user>-UserEmail CS 'admin'.
        MODIFY ENTITY zvk_c_userinfo_m_01 UPDATE FIELDS ( IsAdmin )
            WITH VALUE #( ( UserEmail = <fs_user>-UserEmail IsAdmin = 'YES' ) ).
      ELSE.
        MODIFY ENTITY zvk_c_userinfo_m_01 UPDATE FIELDS ( IsAdmin )
            WITH VALUE #( ( UserEmail = <fs_user>-UserEmail IsAdmin = 'NO' ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
