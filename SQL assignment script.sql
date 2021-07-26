# Select our working database
use assignment;

# All CSV Import completed...

## 1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)

## for Bajaj Auto ##

# formatting date column 
UPDATE `bajaj auto` SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table `bajaj auto` modify column `date` date;

# Creating bajaj1 table
create table bajaj1
  as (select Date as `Date`, `Close Price` as  `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `bajaj auto`);
  
  
  ## For Eicher Motors ##
  
  
  # formatting date column 
UPDATE `eicher motors` SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table `eicher motors` modify column `date` date;

# Creating eicher1 table
create table eicher1
  as (select Date as `Date`, `Close Price` as  `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `eicher motors`);
  
  
   ## For hero motocorp ##
  
  
  # formatting date column 
UPDATE `hero motocorp` SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table `hero motocorp` modify column `date` date;

# Creating hero1 table
create table hero1
  as (select Date as `Date`, `Close Price` as  `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `hero motocorp`);
  
  
  # For infosys ##
  
  
  # formatting date column 
UPDATE infosys SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table infosys modify column `date` date;

# Creating infosys1 table
create table infosys1
  as (select Date as `Date`, `Close Price` as  `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from infosys);



# For TCS ##
  
  
  # formatting date column 
UPDATE tcs SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table tcs modify column `date` date;

# Creating tcs1 table
create table tcs1
  as (select Date as `Date`, `Close Price` as  `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from tcs);
  
  
  
  # For TVS Motors##
  
  
  # formatting date column 
UPDATE `tvs motors` SET `Date` = STR_TO_DATE(`Date`,'%d-%M-%Y');

# Date column type convertion to date from string
alter table `tvs motors` modify column `date` date;

# Creating tvs1 table
create table tvs1
  as (select Date as `Date`, `Close Price` as  `Close Price` , 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `tvs motors`);
  
  
  
##  2. Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock)

create table master
select baj.`Date` as Date , baj.`Close Price` as Bajaj , tcs.`Close Price` as TCS , 
tvs.`Close Price` as TVS , inf.`Close Price` as Infosys , eic.`Close Price` as Eicher , her.`Close Price` as Hero
from `bajaj auto` baj
inner join `tcs` tcs on tcs.`Date` = baj.`Date`
inner join `tvs motors` tvs on tvs.`Date` = baj.`Date`
inner join `infosys` inf on inf.`Date` = baj.`Date`
inner join `eicher motors` eic on eic.`Date` = baj.`Date`
inner join `hero motocorp` her on her.`Date` = baj.`Date` ;

select * from master order by `Date`;


## 3. Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks.

## for Bajaj Auto ##

create table bajaj2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from bajaj1);

## for Eicher Motors ##

create table eicher2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from eicher1);


## for Hero Motocorp ##

create table hero2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from hero1);


## for infosys ##

create table infosys2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from infosys1);


## for TCS ##

create table tcs2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from tcs1);


## for TVS Motors ##

create table tvs2 as
(select Date, `Close Price`, 
CASE 
	WHEN `20 Day MA`>`50 Day MA` then 'BUY'
    WHEN `20 Day MA`<`50 Day MA` then 'SELL'
    ELSE 'HOLD'
END AS `Signal` 
from tvs1);



##  4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock. (Hint: The signal of sell and buy for that particular day is generated by subtracting the previous day's flag value. Flag value is generated using short-term and long-term moving averages.)


delimiter $$

create function get_signal_for_date( input_date date)

returns varchar(10)

deterministic

begin

declare signal_value varchar(10);

select `Signal` into signal_value 
from bajaj2
where `Date` = input_date;

return signal_value;

end $$

delimiter ;
 
# date format - yyyy-mm-dd  
# Test function for all three signals
select get_signal_for_date('2015-01-02') as day_signal;  # result - hold
select get_signal_for_date('2015-08-24') as day_signal; # result - sell
select get_signal_for_date('2015-05-18') as day_signal; # result - buy
