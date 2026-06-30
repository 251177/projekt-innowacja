import { LightningElement, api } from 'lwc';

export default class ShelterHours extends LightningElement {
    @api monday;
    @api tuesday;
    @api wednesday;
    @api thursday;
    @api friday;
    @api saturday;
    @api sunday;

    get operatingDays() {
        return [
            { id: 1, name: 'Monday', hours: this.monday, isOpen: this.checkIfOpen(this.monday) },
            { id: 2, name: 'Tuesday', hours: this.tuesday, isOpen: this.checkIfOpen(this.tuesday) },
            { id: 3, name: 'Wednesday', hours: this.wednesday, isOpen: this.checkIfOpen(this.wednesday) },
            { id: 4, name: 'Thursday', hours: this.thursday, isOpen: this.checkIfOpen(this.thursday) },
            { id: 5, name: 'Friday', hours: this.friday, isOpen: this.checkIfOpen(this.friday) },
            { id: 6, name: 'Saturday', hours: this.saturday, isOpen: this.checkIfOpen(this.saturday) },
            { id: 7, name: 'Sunday', hours: this.sunday, isOpen: this.checkIfOpen(this.sunday) }
        ];
    }

    checkIfOpen(hoursText) {
        if (!hoursText || hoursText.toLowerCase() === 'closed') {
            return false;
        }
        return true;
    }
}