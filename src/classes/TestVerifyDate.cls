@isTest
public class TestVerifyDate {
    @isTest static void testCheckDates_IsWithin30() {
        Date date1 = Date.newInstance(2015, 10, 01);
        Date date2 = Date.newInstance(2015, 10, 25);
        Date expect = date2;
        Date result = VerifyDate.CheckDates(date1, date2);
		System.assertEquals(expect, result);
    }
    
    @isTest static void testCheckDates_NotWithin30() {
        Date date1 = Date.newInstance(2015, 10, 01);
        Date date2 = Date.newInstance(2015, 11, 25);
        Date expect = Date.newInstance(2015, 10, 31);
        Date result = VerifyDate.CheckDates(date1, date2);
		System.assertEquals(expect, result);
    }
}