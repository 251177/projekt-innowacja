public with sharing class AdoptionEmailHandler {
    
    public static void sendStatusUpdateEmails(List<Adoption__c> newAdoptions, Map<Id, Adoption__c> oldMap) {
        Set<Id> adoptionsToEmail = new Set<Id>();
        
        for(Adoption__c ad : newAdoptions) {
            Adoption__c oldAd = oldMap.get(ad.Id);
            if(ad.Status__c != oldAd.Status__c) {
                adoptionsToEmail.add(ad.Id);
            }
        }
        
        if(adoptionsToEmail.isEmpty()) {
            return;
        }
        
        List<Adoption__c> adoptionsWithDetails = [
            SELECT Id, Status__c, 
                   Animal__r.Name, 
                   Contact__r.FirstName, Contact__r.LastName, Contact__r.Email 
            FROM Adoption__c 
            WHERE Id IN :adoptionsToEmail
        ];
        
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        
        for(Adoption__c ad : adoptionsWithDetails) {
            if(ad.Contact__r.Email != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] { ad.Contact__r.Email });
                mail.setSubject('Aktualizacja statusu adopcji / Adoption Status Update');
                
                String logoUrl = 'https://i.postimg.cc/WzWz2ksL/ai-mals-icon.png'; 
                
                String htmlBody = '<div style="text-align: center;"><img src="' + logoUrl + '" alt="Ai:Mals Logo" width="200"/></div><br/>';
                htmlBody += '<p>Good Morning ' + ad.Contact__r.FirstName + ' ' + ad.Contact__r.LastName + ',</p>';
                htmlBody += '<p>Status of adoption for your animal <b>' + ad.Animal__r.Name + '</b> has changed to <b>' + ad.Status__c + '</b>.</p>';
                htmlBody += '<br/><hr/>';
                htmlBody += '<p>Best regards,<br/><i>Ai:mals team</i></p>';
                
                mail.setHtmlBody(htmlBody);
                emailsToSend.add(mail);
            }
        }
        
        if(!emailsToSend.isEmpty()) {
            Messaging.sendEmail(emailsToSend);
        }
    }
}