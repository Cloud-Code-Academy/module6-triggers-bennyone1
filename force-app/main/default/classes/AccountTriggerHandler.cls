public with sharing class AccountTriggerHandler {
    public static void setTypeProspectBeforeInsert(List<Account> newAccounts) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : newAccounts) {
            if (acc.Type == null) {
                acc.Type = 'Prospect';
                accountsToUpdate.add(acc);
            }
        }
    }
    

    public static void addressCopyBeforeInsert(List<Account> newAccounts) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : newAccounts) {
            if (acc.ShippingStreet != null ||
                acc.ShippingCity != null ||
                acc.ShippingState != null ||
                acc.ShippingPostalCode != null ||
                acc.ShippingCountry != null) {
                
                    acc.BillingStreet = acc.ShippingStreet;
                    acc.BillingCity = acc.ShippingCity;
                    acc.BillingState = acc.ShippingState;
                    acc.BillingPostalCode = acc.ShippingPostalCode;
                    acc.BillingCountry = acc.ShippingCountry;

                }
            }    
        }
        

    public static void setRating(List<Account> newAccounts) {
        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : newAccounts) {
            if (acc.Phone != null && acc.Website != null && acc.Fax != null) {
                    acc.Rating = 'Hot';
            }
        }
    }

    public static void defaultContact(List<Account> newAccounts) {
        List<Contact> defaultContactsToCreate = new List<Contact>();
        for (Account acc : newAccounts) {
            Contact con = new Contact(
                AccountId = acc.Id,
                LastName = 'DefaultContact',
                Email = 'default@email.com' 
            );
            defaultContactsToCreate.add(con);
        }
        insert defaultContactsToCreate;
    }
}