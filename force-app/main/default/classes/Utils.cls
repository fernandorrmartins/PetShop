public inherited sharing class Utils {
    public static Set<Id> getIdSetByField(List<SObject> sObjs, Schema.SObjectField fieldName) {
        Set<Id> idSet = new Set<Id>();
        if(fieldName != null) {
            for(SObject sObj : sObjs){
                Object value = sObj.get(fieldName);
                if(value != null) {
                    idSet.add(String.valueOf(value));
                }
            }
        }
        return idSet;
    }

    public static List<OrgWideEmailAddress> getOrgWideEmailAddressByDisplayName(Set<String> displayNames) {
        if(displayNames.isEmpty()) return new List<OrgWideEmailAddress>();
        List<OrgWideEmailAddress> emailsEmpresa = [SELECT Id, DisplayName, Address FROM OrgWideEmailAddress WHERE DisplayName IN :displayNames LIMIT 1];
        return emailsEmpresa;
    }

    public static List<EmailTemplate> getEmailTemplateByName(Set<String> templateNames) {
        if(templateNames.isEmpty()) return new List<EmailTemplate>();
        List<EmailTemplate> templates = [SELECT Id FROM EmailTemplate WHERE Name IN :templateNames];
        return templates;
    }
}