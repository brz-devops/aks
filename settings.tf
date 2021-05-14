locals {
  settings = {
    subscription_id = "ab361213-7d79-43a5-ab9f-fbc87b3d9e13"
  } 
  accesspolicy_admins = [
      "lea.laemmerhirt@brz.eu"
  ]

  accesspolicy_readers = [
  ]

  snet_prefix = "172.17.1.0/24"
  vnet_prefix = "172.17.0.0/16"

}

locals {
  userids_readers = flatten([
    for user in data.azuread_user.userids_readers : 
        user.object_id    
  ])
  userids_admins = flatten([
    for user in data.azuread_user.userids_admins : 
        user.object_id    
  ])
}