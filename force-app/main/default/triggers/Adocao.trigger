trigger Adocao on Adocao__c (after insert) {
    AdocaoHandler.handleTrigger();
}