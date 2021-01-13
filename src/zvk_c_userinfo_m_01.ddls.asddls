@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
@EndUserText.label: 'C view for userinfo'

define root view entity ZVK_C_USERINFO_M_01
  as select from ZVK_I_USERINFO_M_01
{
  key UserEmail,
      FirstName,
      LastName,
      IsAdmin,
      concat_with_space(FirstName, LastName, 2) as FullName,
      @Semantics.systemDateTime.lastChangedAt: true
      lastChangedAt
}
