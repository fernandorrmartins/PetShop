public inherited sharing class PetSelector {
    public static List<Pet__c> getById(Set<Id> petIds) {
        if(petIds.isEmpty()) return new List<Pet__c>();
        List<Pet__c> animais = [SELECT Id, Name, Especie__c, Raca__c FROM Pet__c WHERE Id IN :petIds];
        return animais;
    }
}