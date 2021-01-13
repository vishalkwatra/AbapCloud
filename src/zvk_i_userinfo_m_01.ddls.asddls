@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I view for user info'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZVK_I_USERINFO_M_01
  as select from zvk_userinfo
{
  key user_email as UserEmail,
      first_name as FirstName,
      last_name  as LastName,
      is_admin   as IsAdmin,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as lastChangedAt
}
