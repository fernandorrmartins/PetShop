@isTest
public class TestUtils{
	public static void setup(){
		Test.loadData(Schema.Contact.getSObjectType(), 'Contatos');
		Test.loadData(Schema.Pet__c.getSObjectType(), 'Pets');
		List<Contact> contatos = ContactSelector.getById(Utils.getIdSetByField([SELECT Id
		                                                                        FROM Contact], Schema.Contact.Id));
		List<Pet__c> animais = PetSelector.getById(Utils.getIdSetByField([SELECT Id
		                                                                  FROM Pet__c], Schema.Pet__c.Id));

		List<Adocao__c> adocoes = new List<Adocao__c>();

		Integer size = contatos.size();
		for (Integer i = 0; i < size; i++){
			adocoes.add(criarAdocao(System.today(), 'Aberto', contatos.get(i).Id, animais.get(i).Id));
		}
		insert adocoes;
	}

	public static User criarUsuario(String lastName, String firstName, String alias, String department, String email, String username){
		return criarUsuario(lastName, firstName, alias, department, email, username, null);
	}

	public static User criarUsuario(String lastName, String firstName, String alias, String department, String email, String username, String profileId){
		List<UserRole> roles = [SELECT Id
		                        FROM UserRole];
		Id roleId = roles != null && roles.size() > 0 ? roles.get(0).Id : null;

		User usuario = new User(LastName = lastName, FirstName = firstName, Alias = alias, Department = department, Email = email, Username = username, ProfileId = String.isNotBlank(profileId) ? profileId : System.UserInfo.getProfileId(), TimeZoneSidKey = 'GMT', LanguageLocaleKey = 'en_US', EmailEncodingKey = 'UTF-8', LocaleSidKey = 'en_US', UserRoleId = roleId);
		return usuario;
	}

	public static String gerarUsuarioAleatorio(Integer num){
		num = num != null ? num : 0;
		String randomUsername = 'everymind-' + System.Datetime.now().getTime()+'-' + Integer.valueof((Math.random() * 100000))+'-' + num + '@email.com';
		return randomUsername;
	}

	public static Adocao__c criarAdocao(Date data, String status, Id contatoId, Id petId){
		Adocao__c adocao = new Adocao__c();
		adocao.Data__c = data;
		adocao.Status__c = status;
		adocao.Contato__c = contatoId;
		adocao.Pet__c = petId;
		return adocao;
	}
}