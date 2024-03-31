%% Program to Pump Water to the plant on the basis of Dryness of Soil of plant
thrsldV=3.4046; %% This is the voltage shows for sensor when Soil is dry.
WetV=2.6001;%% This is the voltage reading of sensor when soil is fully wet
Button=0; %% Button Variable for first Loop
SButton=0;%% Second Button Variable 
Vol=[]; %%  Array for voltage of sensor
time=[]; %% array for time corresponding to our Sensor values
starttime=tic; %% Tic function is used as stopwatch 
figure; %% This is used create figure for our graph
ax = axes;
xlabel('Time'); %% xlablel function used to name X-axis as Time
ylabel('Moisture Readings');%% ylablel function used to name Y-axis as Moisture Readings
title('Moisture Reading vs Time');%%Tittle of Chart
grid on; %% This function will create a grid on our Graph
line = animatedline(ax, 'Color', 'r', 'MarkerSize', 2,'Marker','*'); %% animated line is used to modify the line in our graph

%% When I do run Button for our program this disp function will display a line to ask user to Press the button

disp("Please press the Button to start the System");

%% Main Loop This loop is used to take the value when button is pressed.
while Button==0
   SButton=readDigitalPin(a,"D6");
   %% As soon as User press the Button program enter into this loop as Button value becomes 1 after pressing
while SButton == 1
    sensorV=readVoltage(a,"A1"); %% I used readVoltage function to read the voltage of our soil through sensor and store it into sensorV Variable

    %% I used three conditional statments to Check value of voltage 
    if sensorV>thrsldV  %% check volatge is higher then our Threshold value
        fprintf("Soil is dry and the voltage reading of soil is %.3f\n",sensorV);
        writeDigitalPin(a,'D2',1);%% Turn on the water pump to pump the water
    elseif sensorV>WetV && sensorV<thrsldV %%compare sensor volatge in less than dry threshold and more than Wet voltage value
        fprintf("Soil is Wet but not enough as Volatge reading of soil is %.3f so start watering the Plant\n",sensorV);
        writeDigitalPin(a,'D2',1);%% This will Turn on the water pump to pump the water
    elseif sensorV<WetV %% If the voltage is less than Wet Voltage value then system will display the message.
        fprintf("Plant is Wet as voltage reading of sensor is %.3f,No need of Water\n",sensorV);
        writeDigitalPin(a,"D2",0); %% This will turn off the pump
    end     
    if readDigitalPin(a,"D6") == 1 %%  when button is again pressed
       disp("Plant watering system has been turned off");
       writeDigitalPin(a,"D2",0); %% This will turn off the pump
       SButton=0;
       Button=1;
    end
     GVol = VoltageConvertor(sensorV,WetV,thrsldV);%% This my user defined function which is converting our volatge value to be Moisture value which is between 0 and 1.
     Vol(end+1)=GVol; %% EVery loop the value will be stored into Vol array
     t=toc(starttime);%% This will record the time corresponding to Moisture level
     time(end+1)=t;%% Here value of time is stored into array
     clearpoints(line);
     addpoints(line,time,Vol);%% 
     xlim([0, t + 1]); %% I have used t+1 for x limit so that t will be keep on increasing and this program can work 24/7.
     ylim([0, 1]);%% Limits for moisture value between 0 and 1 
     drawnow;
end     
end