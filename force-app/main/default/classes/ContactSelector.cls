public inherited sharing class ContactSelector {
    public static List<Contact> getById(Set<Id> contatoIds) {
        if(contatoIds.isEmpty()) return new List<Contact>();
        List<Contact> contatos = [SELECT Id, Name, Phone, Birthdate, Email, Idade__c FROM Contact WHERE Id IN :contatoIds];
        return contatos;
    }
}