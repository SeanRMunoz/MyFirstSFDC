//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

@IsTest
public class SmartyStreetsAddressResJSON_Test {
    
    static testMethod void testParse() {
        String json = '{'+
        '    \"input_id\": \"00161000004tbHN\",'+
        '    \"input_index\": 1,'+
        '    \"candidate_index\": 0,'+
        '    \"delivery_line_1\": \"1600 Amphitheatre Pkwy\",'+
        '    \"last_line\": \"Mountain View CA 94043-1351\",'+
        '    \"delivery_point_barcode\": \"940431351000\",'+
        '    \"components\": {'+
        '        \"primary_number\": \"1600\",'+
        '        \"street_name\": \"Amphitheatre\",'+
        '        \"street_suffix\": \"Pkwy\",'+
        '        \"city_name\": \"Mountain View\",'+
        '        \"state_abbreviation\": \"CA\",'+
        '        \"zipcode\": \"94043\",'+
        '        \"plus4_code\": \"1351\",'+
        '        \"delivery_point\": \"00\",'+
        '        \"delivery_point_check_digit\": \"0\"'+
        '    },'+
        '    \"metadata\": {'+
        '        \"record_type\": \"S\",'+
        '        \"zip_type\": \"Standard\",'+
        '        \"county_fips\": \"06085\",'+
        '        \"county_name\": \"Santa Clara\",'+
        '        \"carrier_route\": \"C909\",'+
        '        \"congressional_district\": \"18\",'+
        '        \"rdi\": \"Commercial\",'+
        '        \"elot_sequence\": \"0123\",'+
        '        \"elot_sort\": \"A\",'+
        '        \"latitude\": 37.42357,'+
        '        \"longitude\": -122.08661,'+
        '        \"precision\": \"Zip9\",'+
        '        \"time_zone\": \"Pacific\",'+
        '        \"utc_offset\": -8,'+
        '        \"dst\": true'+
        '    },'+
        '    \"analysis\": {'+
        '        \"dpv_match_code\": \"Y\",'+
        '        \"dpv_footnotes\": \"AABB\",'+
        '        \"dpv_cmra\": \"N\",'+
        '        \"dpv_vacant\": \"N\",'+
        '        \"active\": \"Y\",'+
        '        \"footnotes\": \"B#M#\"'+
        '    }'+
        '}';
        SmartyStreetsAddressResJSON obj = SmartyStreetsAddressResJSON.parse(json);
        System.assert(obj != null);
    }
}