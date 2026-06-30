public with sharing class ShelterMapController {
    
    @AuraEnabled(cacheable=true)
    public static List<Shelter__c> getSheltersInSameCity(Id recordId) {
        // 1. Pobieramy miasto aktualnego schroniska
        Shelter__c currentShelter = [SELECT Id, City__c FROM Shelter__c WHERE Id = :recordId LIMIT 1];
        
        if(currentShelter.City__c == null) {
            return new List<Shelter__c>();
        }
        
        // 2. Szukamy schronisk w tym samym mieście, zaciągając od razu pełny adres
        return [
            SELECT Id, Name, City__c, Street__c, Postal_Code__c, Country__c
            FROM Shelter__c 
            WHERE City__c = :currentShelter.City__c
        ];
    }
}