// CREATE LOCALE WITH LANGUAGE AND COUNTRY CODE
var locale = new java.util.Locale(
    language_code.getString()
,   country_code.getString()
);

// GET YES AND NO VALUES FOR LOCALE
var yes = local_yes.getString();
var no = local_no.getString();


// CREATE CALENDAR WITH LOCALE AND INITIAL DATE AND SET IT TO CURRENT DAT BY ADDING DaySequence DAYS
var calendar = new java.util.GregorianCalendar(locale);
calendar.setTime(initial_date.getDate());
calendar.add(calendar.DAY_OF_MONTH,DaySequence.getInteger() - 1);


// GET DATE AND CREATE DATE ATTRIBUTES
var date = new java.util.Date(calendar.getTimeInMillis());

// Parse date to yyyy-mm-dd
var simpleDateFormat = java.text.SimpleDateFormat("yyyy-MM-dd",locale);
var date_value = simpleDateFormat.format(date);

// Day in month: 1..31
simpleDateFormat.applyPattern("d")
var day_in_month = simpleDateFormat.format(date);

// Day name: e.g. "Monday" in en-us
simpleDateFormat.applyPattern("EEEE");
var day_name = simpleDateFormat.format(date);

// Calculate the next day
calendar.add(calendar.DAY_OF_MONTH,1);
var next_day = new java.util.Date(calendar.getTimeInMillis());

// Find out if this is the first day of the month
var is_first_day_in_month;
if(day_in_month == 1){
    is_first_day_in_month = yes;
} else {
    is_first_day_in_month = no;
}

// Find out if this is the last day in the month
var is_last_day_in_month;
if(java.text.SimpleDateFormat("d",locale).format(next_day)==1){
    is_last_day_in_month = yes;
} else {
    is_last_day_in_month = no;
}

// Month number in year, 1..12
simpleDateFormat.applyPattern("MM");
var month_number = simpleDateFormat.format(date);

// Week in year, 1..53
simpleDateFormat.applyPattern("ww");
var week_in_year = simpleDateFormat.format(date);

// Quarter of year 1..4
var quarter_number;
switch(parseInt(month_number)){
    case 1: case 2: case 3: quarter_number = "1"; break;
    case 4: case 5: case 6: quarter_number = "2"; break;
    case 7: case 8: case 9: quarter_number = "3"; break;
    case 10: case 11: case 12: quarter_number = "4"; break;
}

// 4-Digit representation of the year, example:  2007
simpleDateFormat.applyPattern("yyyy");
var year4 = "" + simpleDateFormat.format(date);


// CALCULATE KEY
var date_key = year4 + month_number + (day_in_month<10?"0":"") + day_in_month;