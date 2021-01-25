@isTest
public inherited sharing class ContactSelectorTest {
    @TestSetup
    static void setup(){
        User usuario = TestUtils.criarUsuario('lastName', 'firstName', 'alias', 'department', 'email@emailemail123guidoni.com', TestUtils.gerarUsuarioAleatorio(123477));
        System.runAs(usuario) {
            TestUtils.setup();
        }
    }

    @isTest
    static void getByIdTest() {
        Id contatoId = [SELECT Id FROM Contact].get(0).Id;
        Set<Id> contatoIds = new Set<Id> { contatoId };

        Test.startTest();
        List<Contact> contatos = ContactSelector.getById(new Set<Id>());
        System.assert(System.Limits.getQueries() == 0);

        contatos = ContactSelector.getById(contatoIds);
        System.assert(contatoId == contatos.get(0).Id && contatos.size() == 1);
        Test.stopTest();
    }
}