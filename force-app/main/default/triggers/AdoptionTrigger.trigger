trigger AdoptionTrigger on Adoption__c (after update) {
    if(Trigger.isAfter && Trigger.isUpdate) {
        AdoptionEmailHandler.sendStatusUpdateEmails(Trigger.new, Trigger.oldMap);
    }
}