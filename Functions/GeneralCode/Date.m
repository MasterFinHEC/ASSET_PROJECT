%Computing Week Dates (For ploting)

monthdate=zeros(round((length(returns)-LengthSignal)/LengthMonth,0),1);
datetomonth = datenum(date);
a = LengthSignal+1;
b = round((length(returns)-LengthSignal)/LengthMonth,0);
for i=1:b
    monthdate(i) = datetomonth(a); 
    a = a + LengthMonth;
end
monthdate = datetime(monthdate,'ConvertFrom','datenum','InputFormat','dd-MMM-yyyy');
clear datetomonth;
clear i;
clear a;
clear b;
