import { LightningElement, api, wire } from 'lwc';
import getSheltersInSameCity from '@salesforce/apex/ShelterMapController.getSheltersInSameCity';

export default class ShelterMap extends LightningElement {
    @api recordId; 
    mapMarkers = [];
    selectedMarkerValue = '';
    error;

    @wire(getSheltersInSameCity, { recordId: '$recordId' })
    wiredShelters({ error, data }) {
        if (data) {
            this.selectedMarkerValue = this.recordId; 
            
            this.mapMarkers = data.map(shelter => {
                const isCurrentShelter = shelter.Id === this.recordId;
                
                return {
                    location: {
                        City: shelter.City__c,
                        Street: shelter.Street__c,
                        PostalCode: shelter.Postal_Code__c,
                        Country: shelter.Country__c
                    },
                    title: shelter.Name,
                    value: shelter.Id,
                    icon: isCurrentShelter ? 'custom:custom61' : 'standard:account',
                    description: isCurrentShelter ? 'This is the currently viewed shelter.' : 'Other shelter in this city.'
                };
            });
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.mapMarkers = [];
        }
    }
}