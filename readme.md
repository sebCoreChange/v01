# Övningar för vecka 1. 

### Power Bi. 
Undersök hur man skapar egna teman i power bi. 
1. Skapa ett tema efter valt företag försök även skapa ett ljus och ett mörkt tema. ( Försök att göra det utan någon generator första gången för att förstå hur fil formatet ser ut.)

    [Ms Docs Thems](https://learn.microsoft.com/en-us/power-bi/create-reports/desktop-report-themes)

2. Testa någon av de flera generator sidorna som finns.
    - fanns det delar som du inte hittade när du labbade själv när du använde genratorn?
    - fanns det någon inställning som du inte kunde hitta? 

    [PowerBI-Templates](https://github.com/MattRudy/PowerBI-ThemeTemplates)

4. I rapporten Q4.pbix så finns det en graf på sida Question 5. 
Ta fram 2 andra alternativ av samma, ett där du ökar data ink ration och en där du sänker den. 

    [Data Ink Ration](https://data.europa.eu/apps/data-visualisation-guide/chart-junk-and-data-ink-origins)

6. Utifrån datan som finns i sql_load_w1.sql svara på följande frågor. 

i datan så har vi informationen om mellan vilka datum en anställd varit knyten till en avdelning.  
En anställd kan flytta internt mellan avdelningar och då tillkommer det en ny rad för den perioden.   
Tabeler:
- **department_employee**     
    - employee_id - den anstäldas id 
    - emp_started_at - när de började på avdelning 
    - emp_ended_at - när de slutade på avdelningen
    - department_id - vilken avdelning som de är knyta på. 
- **Department**
    - department_id
    - department_name

### Edits.
Insåg kanske lite sent att svårigheten var lite hög för vad man behövde tänka på för att fylla ut emplyee tabellen. så lägger till ett script för att under lätta för bygga modellen i power bi.  
**sql_bridge_fix.sql** 

``` sql 
IF OBJECT_ID('[dbo].[bridge_dates]', 'V') IS NOT NULL
DROP VIEW [dbo].[bridge_dates]
GO
create view bridge_dates as ( 
    select record_id ,dateadd( d  , x.row_id , emp_started_at ) as bride_date 
from department_employee 
inner join 
( SELECT value as row_id from generate_series(0, 1000 ) ) x 
on 
DATEDIFF( d ,emp_started_at, emp_ended_at ) >= x.row_id
)
GO 
IF OBJECT_ID('[dbo].[department_employee_extended]', 'V') IS NOT NULL
DROP VIEW [dbo].[department_employee_extended]
GO
create view department_employee_extended as  ( 
select u.* , 
bridge_dates.bride_date as dates  
from  department_employee u 
inner join 
bridge_dates 
on 
bridge_dates.record_id = u.record_id  
)
GO 
```

7. Vem har jobbat flest av delningar? 

8. Vilken avdelning var störst 2024 Feb? 

9. Ta fram en rapport för desktop där man kan följa för en given avdelning och månad:
    - Antal individer 
    - Antal nya
    - Antal avslutade 
    
    i angiven period, förgående år och diffen där i mellan. 

10. Gör även en som är anpassad för snabb mobil sida. 

### CMD 
Via teminalen testa följande o läs på om vilka functioner som finns. [MS command docs](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands)
Läs på o testa följande: 
- help 
- cd
- dir 
- mkdir 
- echo 
- del 
- curl  
- move  

På windows så finns det 2 st olika terminaler, cmd som är den klassiska men även powershell. 
Alla de kommandon vi har tittat på finns det motsvarande på i powershell kan du hitta vilka?

1. Vad finns det för filer i den mappen jag står?

2. Hur kan man navigera sig till övningsmappen?

3. Hur kan jag flytta en fil till en annan mapp? 
