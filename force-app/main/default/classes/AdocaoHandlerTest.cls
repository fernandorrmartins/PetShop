@isTest
public inherited sharing class AdocaoHandlerTest {
    private static String emailEquipeAdocao = 'Equipe de Adoção';
    private static String templateName = 'Adoção Criada';

    @TestSetup
    static void setup(){
        System.Test.loadData(Schema.Contact.getSObjectType(), 'Contatos');
        System.Test.loadData(Schema.Pet__c.getSObjectType(), 'Pets');
    }

    @isTest
    static void handleTriggerTest() {
        Id contatoId = [SELECT Id FROM Contact LIMIT 1].get(0).Id;
        Id petId = [SELECT Id FROM Pet__c LIMIT 1].get(0).Id;

        Adocao__c adocao = TestUtils.criarAdocao(System.today(), 'Aberto', contatoId, petId);

        Test.startTest();
        insert adocao;
        Test.stopTest();

        System.assert(String.isNotBlank(adocao.Id));
    }

    @isTest
    static void getOrgWideEmailAddressByDisplayNameTest() {
        Id orgWideEmailId = AdocaoHandler.getOrgWideEmailAddressByDisplayName(emailEquipeAdocao);

        String displayName = [SELECT Id, DisplayName FROM OrgWideEmailAddress WHERE Id = :orgWideEmailId].get(0).DisplayName;

        System.assert(emailEquipeAdocao.equals(displayName));
    }

    @isTest
    static void getTemplateIdByNameTest() {
        Id templateId = AdocaoHandler.getTemplateIdByName(templateName);

        String emailName = [SELECT Id, Name FROM EmailTemplate WHERE Id = :templateId].get(0).Name;

        System.assert(templateName.equals(emailName));
    }

    @isTest
    static void createEmailTest() {
        Id contatoId = [SELECT Id FROM Contact LIMIT 1].get(0).Id;
        Id petId = [SELECT Id FROM Pet__c LIMIT 1].get(0).Id;
        Adocao__c adocao = TestUtils.criarAdocao(System.today(), 'Aberto', contatoId, petId);
        insert adocao;
        Id adocaoId = adocao.Id;
        Id orgWideEmailId = AdocaoHandler.getOrgWideEmailAddressByDisplayName(emailEquipeAdocao);
        Id templateId = AdocaoHandler.getTemplateIdByName(templateName);

        System.Test.startTest();
        Messaging.SingleEmailMessage email = AdocaoHandler.createEmail(contatoId, adocaoId, templateId, orgWideEmailId);
        System.Test.stopTest();
        System.assert(orgWideEmailId.equals(email.orgwideemailaddressid));
        System.assert(templateId.equals(email.getTemplateId()));
    }
}