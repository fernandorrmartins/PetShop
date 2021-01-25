@isTest
public inherited sharing class UtilsTest {
    @TestSetup
    static void setup(){
        TestUtils.setup();
    }

    @isTest
    static void getIdSetByFieldTest() {
        Map<Id, Pet__c> petMap = new Map<Id, Pet__c>([SELECT Id FROM Pet__c]);

        Test.startTest();
        Set<Id> animaisId = Utils.getIdSetByField((List<SObject>) petMap.values(), Schema.Pet__c.Id);
        for(Id key : petMap.keySet()) {
            System.assert(animaisId.contains(key));
        }
        System.assert(petMap.keySet().size() == animaisId.size());
        Test.stopTest();
    }

    @isTest
    static void getOrgWideEmailAddressByDisplayNameTest() {
        String emailEquipeAdocao = 'Equipe de Adoção';
        List<OrgWideEmailAddress> emails = Utils.getOrgWideEmailAddressByDisplayName(new Set<String> { emailEquipeAdocao });

        System.assert(emails.size() > 0 && emails.get(0).DisplayName.equals(emailEquipeAdocao));
    }

    @isTest
    static void getEmailTemplateByNameTest() {
        String emailTemplateName = 'Adoção Criada';
        List<EmailTemplate> templates = Utils.getEmailTemplateByName(new Set<String> { emailTemplateName });

        System.assert(templates.size() > 0 && templates.get(0).Name.equals(emailTemplateName));
    }
}