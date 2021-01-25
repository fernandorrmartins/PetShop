@isTest
public inherited sharing class PetSelectorTest{
	@TestSetup
	static void setup(){
		TestUtils.setup();
	}

	@isTest
	static void getByIdTest(){
        Id petId = [SELECT Id FROM Pet__c].get(0).Id;
        Set<Id> petIds = new Set<Id> { petId };

        Test.startTest();
        List<Pet__c> pets = PetSelector.getById(new Set<Id>());
        System.assert(System.Limits.getQueries() == 0);

        pets = PetSelector.getById(petIds);
        System.assert(petId == pets.get(0).Id && pets.size() == 1);
        Test.stopTest();
	}
}