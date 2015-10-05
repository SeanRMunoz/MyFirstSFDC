trigger CampsiteDoubleBooking on Campsite_Reservation__c (before insert, before update) {

    for( Campsite_Reservation__c reqReservation : trigger.new ) {
    
        // Retrieve all other overlapping reservations for requested campsite
        List<Campsite_Reservation__c> conflicts =
            [SELECT Id FROM Campsite_Reservation__c
                WHERE ((Id != :reqReservation.Id) AND
                       (Campsite__c = :reqReservation.Campsite__c))
                AND   ((Start_Date__c <= :reqReservation.End_Date__c AND 
                        End_Date__c   >= :reqReservation.Start_Date__c))
            ];

        // If conflicts exist, add an error, which rejects the database operation
        if(!conflicts.isEmpty()){
            reqReservation.addError('The selected campsite is already reserved during all or part of this date range.');
        }
    }
}