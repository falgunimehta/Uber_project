create database uber;
use uber;
show tables;

select * from driver;
select * from passenger;
select * from ride;

#Q1: What are & how many unique pickup locations are there in the dataset?

select distinct pickup_location 
from ride;

select count(distinct pickup_location) 
from ride ;


#q2: what is the total number of rides in the dataset?

select count(*) 
from ride;

#q3: calculate the average ride duration.

select avg(ride_duration) 
from ride ;

#q4: list the top 5 drivers based on their total earnings.

select driver_id, sum(earnings) as total_earnings 
from driver
group by driver_id 
order by total_earnings desc limit 5;

#q5: calculate the total number of rides for each payment method.

select payment_method, count(*) as ride_count 
from ride
group by payment_method;

#q6: retrieve rides with a fare amount greater than 20.

select * 
from ride 
where fare_amount > 20;

#q7: identify the most common pickup location.

select pickup_location, count(*) as ride_count 
from ride
group by pickup_location 
order by ride_count desc limit 1;

#q8: calculate the average fare amount.

select avg(fare_amount)
from ride ;

#q9: list the top 10 drivers with the highest average ratings.

select driver_id, avg(rating) as avg_rating 
from driver
group by driver_id 
order by avg_rating desc limit 10;

#q10: calculate the total earnings for all drivers.

select sum(earnings) 
from driver ;

#q11: how many rides were paid using the "cash" payment method?

select count(*) 
from ride 
where payment_method = 'cash';

#q12: calculate the number of rides & average ride distance for rides originating from the 'dhanbad' pickup location.

select pickup_location ,count(*), avg(ride_distance) 
from ride 
where pickup_location = 'dhanbad';

#q13: retrieve rides with a ride duration less than 10 minutes.

select * 
from ride 
where ride_duration < 10;

#q14: list the passengers who have taken the most number of rides.

select passenger_id, count(*) as ride_count 
from ride group by passenger_id 
order by ride_count desc limit 1;

#q15: calculate the total number of rides for each driver in descending order.

select driver_id, count(*) as ride_count 
from ride
group by driver_id 
order by ride_count desc;

#q16: identify the payment methods used by passengers who took rides from the 'gandhinagar' pickup location.

select distinct payment_method 
from ride
where pickup_location = 'gandhinagar';

#q17: calculate the average fare amount for rides with a ride distance greater than 10.

select avg(fare_amount) 
from ride
where ride_distance > 10;

#q18: list the drivers in descending order accordinh to their total number of rides.

select driver_id, total_rides
from driver
order by total_rides desc;

#q19: calculate the percentage distribution of rides for each pickup location.

select pickup_location, count(*) as ride_count, round(count(*) * 100.0 / (select count(*) from ride), 2) as percentage 
from ride
group by pickup_location
order by percentage desc;


select pickup_location, count(pickup_location) from ride group by pickup_location;
select pickup_location, count(*) as ride_count from ride group by pickup_location ;

select count(pickup_location) from ride;

#q20: retrieve rides where both pickup and dropoff locations are the same.

select * 
from ride
where pickup_location = dropoff_location;


#q1: list the passengers who have taken rides from at least 300 different pickup locations.

select passenger_id, count(distinct pickup_location) as distinct_locations
from ride
group by passenger_id
having distinct_locations >= 300;

#q2: identify the drivers who have taken rides with distances greater than 19.

select * from ride;
select distinct driver_id, ride_distance 
from ride
where ride_distance > 19;

#q3: calculate the total earnings for drivers who have completed more than 100 rides.

select driver_id, sum(earnings) as total_earnings
from driver
where driver_id in (select driver_id from ride group by driver_id having count(*) > 100)
group by driver_id;

select * from driver;

select d.driver_id, count(d.driver_id), sum(d.earnings) as total_earning
from driver d inner join ride r
on d.driver_id = r.driver_id
group by d.driver_id
having count(d.driver_id)>100;

#q4: retrieve rides where the fare amount is less than the average fare amount.

select * 
from ride 
where fare_amount < (select avg(fare_amount) from ride);

select avg(fare_amount) from ride;

#q5: calculate the average rating of drivers who have driven rides with both 'credit card' and 'cash' payment methods.

select driver_id, avg(rating) as avg_rating
from driver
where driver_id in (select driver_id from ride where payment_method in ('credit card', 'cash') group by driver_id having count(distinct payment_method) = 2)
group by driver_id;

select * from ride;

select * from driver;

select * from passenger;

select d.driver_id, avg(rating) as avg_rating 
from driver d inner join ride r
on d.driver_id = r.driver_id 
where r.payment_method in ("cash", "credit card")
group by d.driver_id
having count(distinct r.payment_method)=2;

#q6: list the top 3 passengers with the highest total spending.

select p.passenger_id, p.passenger_name, sum(r.fare_amount) as total_spending
from passenger p
join ride r on p.passenger_id = r.passenger_id
group by p.passenger_id, p.passenger_name
order by total_spending desc
limit 3;

select p.passenger_id, p.passenger_name, sum(r.fare_amount) as total_fare
from passenger p inner join ride r 
on p.passenger_id = r.passenger_id 
group by p.passenger_id , p.passenger_name
order by total_fare desc
limit 3;

#q7: calculate the average fare amount for rides taken during different months of the year.

select month(ride_timestamp) as month_of_year, avg(fare_amount) as avg_fare
from ride
group by month_of_year;


#q8: identify the most common pair of pickup and dropoff locations.

select pickup_location, dropoff_location, count(*) as ride_count
from ride
group by pickup_location, dropoff_location
order by ride_count desc
limit 1;

#q9: calculate the total earnings for each driver and order them by earnings in descending order.

select driver_id, sum(earnings) as total_earnings
from driver
group by driver_id
order by total_earnings desc;

#q10: list the passengers who have taken rides on their signup date.

select p.passenger_id, p.passenger_name
from passenger p
join ride r on p.passenger_id = r.passenger_id
where date(p.signup_date) = date(r.ride_timestamp);

#q11: calculate the average earnings for each driver and order them by earnings in descending order.

select driver_id, avg(earnings) as average_earnings
from driver
group by driver_id
order by average_earnings desc;

#q12: retrieve rides with distances less than the average ride distance.

select ride_id, avg(ride_distance)
from ride 
where ride_distance < (select avg(ride_distance) from ride)
group by ride_id;

select avg(ride_distance) from ride;

#q13: list the drivers who have completed the least number of rides.

select driver_name,  count(driver_id) as ride_count
from driver 
group by driver_name
order by ride_count asc;

select * from ride;

select * from driver;

#q14: calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.

select avg(fare_amount)
from ride
where passenger_id in (select passenger_id from ride group by passenger_id having count(*) >= 20);

#q15: identify the pickup location with the highest average fare amount.

select pickup_location, avg(fare_amount) as avg_fare
from ride
group by pickup_location
order by avg_fare desc
limit 1;

#q16: calculate the average rating of drivers who completed at least 100 rides.

select avg(rating) from driver where driver_id in 
(select driver_id from ride group by driver_id  having count(*) >= 100);

select d.driver_id, avg(rating) as avg_rating
from driver d inner join ride r
on d.driver_id = r.driver_id 
group by d.driver_id 
having avg(rating)<100;


#q17: list the passengers who have taken rides from at least 5 different pickup locations.

select passenger_id,pickup_location, count(distinct pickup_location) as distinct_locations
from ride r 
group by passenger_id, pickup_location
having distinct_locations >= 300;

#q18: calculate the average fare amount for rides taken by passengers with ratings above 4.

select avg(fare_amount) from ride where passenger_id in
(select passenger_id from passenger p where rating > 4);

#q19: retrieve rides with the shortest ride duration in each pickup location

select ride_id, pickup_location, min(ride_duration) as min_duration 
from ride r group by pickup_location,ride_id;


#q1: list the drivers who have driven rides in all pickup locations.

select driver_id
from driver
where driver_id not in (
    select distinct driver_id
    from ride
    where pickup_location not in (
        select distinct pickup_location
        from ride));

select distinct driver_id from ride 
where pickup_location not in (select distinct pickup_location from ride);


#q2: calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.
#solution

select avg(fare_amount)
from ride
where passenger_id in (select passenger_id from passenger where total_spent > 300);

#q3: list the bottom 5 drivers based on their average earnings.

select driver_id, avg(earnings) as avg_earnings 
from driver 
group by driver_id 
order by avg_earnings asc 
limit 5;

#q4: calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.

select sum(fare_amount)
from ride
where passenger_id in (select passenger_id from ride group by passenger_id
having count(distinct payment_method) > 1);

select passenger_id from ride group by passenger_id
having count(distinct payment_method) > 1;

select count(distinct payment_method) from ride;


#q5: retrieve rides where the fare amount is significantly above the average fare amount.

select * from ride 
where fare_amount > (select avg(fare_amount) from ride);

select avg(fare_amount) from ride;

#q6: list the drivers who have completed rides on the same day they joined.

select d.driver_id, d.driver_name
from driver d join ride r
on d.driver_id = r.driver_id
where d.join_date = r.ride_timestamp;


select join_date from driver;

select ride_timestamp from ride;

#q7: calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.

select avg(fare_amount)
from ride
where passenger_id in (
    select passenger_id
    from  ride
    group by passenger_id
    having count(distinct payment_method) > 1);

#q8: identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.

select pickup_location, avg(fare_amount) as avg_fare,
       (avg(fare_amount) - (select avg(fare_amount) from ride)) * 100.0 / (select avg(fare_amount) from ride) as percentage_increase
from ride 
group by pickup_location
order by percentage_increase desc
limit 1;

#q9: retrieve rides where the dropoff location is the same as the pickup location.

select * from ride 
where pickup_location = dropoff_location;

#q10: calculate the average rating of drivers who have driven rides with varying pickup locations.

select avg(rating) from driver 
where driver_id in (select distinct driver_id from ride 
    group by driver_id
    having count(distinct pickup_location) > 1);




