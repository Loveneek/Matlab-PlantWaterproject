function GVol = VoltageConvertor(sensorV,WetV,thrsldV)

if sensorV<WetV % We are checking the value if its lower than our threshold Value for Wet plant then we make it equal to threshold

    sensorV=WetV;

elseif sensorV>thrsldV % We are checking the value if its greater than our threshold Value for Wet plant then we make it equal to threshold
    sensorV=thrsldV;

end
GVol=1-(sensorV-WetV)/(thrsldV-WetV);%% Used equation to convert sensor value to moisture 0 and 1
end