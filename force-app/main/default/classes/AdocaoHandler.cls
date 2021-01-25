public inherited sharing class AdocaoHandler {
    public static void handleTrigger() {
        if(Trigger.isAfter) {
            if(Trigger.isInsert) {
                Set<Id> contatoIds = Utils.getIdSetByField(Trigger.new, Schema.Adocao__c.Contato__c);
                Map<Id, Contact> contatoMap = new Map<Id, Contact>(ContactSelector.getById(contatoIds));
        
                Id orgWideEmailId = getOrgWideEmailAddressByDisplayName('Equipe de Adoção');
                Id templateId = getTemplateIdByName('Adoção Criada');
        
                List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
                
                for(Adocao__c adocao : (List<Adocao__c>) Trigger.new) {
                    Contact contato = contatoMap.get(adocao.Contato__c);
                    if(contato != null) {
                        emails.add(createEmail(contato.Id, adocao.Id, templateId, orgWideEmailId));
                    }
                }
                if(!emails.isEmpty()) { Messaging.sendEmail(emails, false); }
            }
        }
    }

    @TestVisible
    private static Id getOrgWideEmailAddressByDisplayName(String displayName) {
        List<OrgWideEmailAddress> emailsEmpresa = Utils.getOrgWideEmailAddressByDisplayName(new Set<String> { displayName });
        if(emailsEmpresa.isEmpty()) throw new AdocaoHandlerException('A organização não possui um endereço de email cadastrado para \'Equipe de Adoção\'.');
        return emailsEmpresa?.get(0)?.Id;
    }

    @TestVisible
    private static Id getTemplateIdByName(String name) {
        List<EmailTemplate> templates = Utils.getEmailTemplateByName(new Set<String> { name });
        if(templates.isEmpty()) throw new AdocaoHandlerException('A organização não possui um template de email \'Adoção Criada\'.');
        return templates?.get(0)?.Id;
    }

    @TestVisible
    private static Messaging.SingleEmailMessage createEmail(Id contatoId, Id adocaoId, Id templateId, Id orgWideEmailId) {
        Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(templateId, contatoId, adocaoId);
        email.setTemplateID(templateId);
        email.setSaveAsActivity(true);
        email.setOrgWideEmailAddressId(orgWideEmailId);
        email.setToAddresses(new List<Id> { contatoId });
        email.setTargetObjectId(contatoId);
        email.setWhatId(adocaoId);
        return email;
    }

    public class AdocaoHandlerException extends Exception {}
}