%Computing Week Dates (For ploting)

monthdate=zeros(385,1);
datetomonth = datenum(date);
a = 253;
for i=1:385
    monthdate(i) = datetomonth(a); 
    a = a + 20;
end
monthdate = datetime(monthdate,'ConvertFrom','datenum','InputFormat','dd-MMM-yyyy');
%weekdate = weekdate(1:1043);