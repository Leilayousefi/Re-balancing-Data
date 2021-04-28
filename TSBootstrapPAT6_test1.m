function [testIDpat, testIDpos, testdat] = TSBootstrapPAT_test(data, var)

    %function sample a consecutive pair of samples from each cell array
    %of time series in data. Returns all appropriate testing data ensuring
    %the binary variable, var is balanced
    
    patlen=length(data);
    datlen = [];
    for i = 1:patlen
        [datn datlen(i)] = size(data{i});
    end
    %allindices = [1:(datlen-1)];
    
    %get the testing indices where var2(t+1) = 1 - sampling with replacement
    %for 20 times on average from each patient
    i=1;
    while i < patlen*10*0.01
        testIDpat(i) = unidrnd(patlen);
        testID(i) = unidrnd(datlen(testIDpat(i))-1);
        data{testIDpat(i)}(:,testID(i)+1);
        if(cell2mat(data{testIDpat(i)}(var,testID(i)+1))==2)      
            display('return')
        else
            i=i+1;    
        end    
    end
    %get the testing indices where var2(t+1) = 2 - sampling with replacement
    %for 10 times on average from each patient
    while i < patlen*10*0.01
        testIDpat(i) = unidrnd(patlen);
        testID(i) = unidrnd(datlen(testIDpat(i))-1);
        data{testIDpat(i)}(:,testID(i)+1);
        if(cell2mat(data{testIDpat(i)}(var,testID(i)+1))==1)      
            display('return')
        else
            i=i+1;    
        end    
    end

    %get the test indices - those that are not sampled
    %testID = setdiff(allindices, testID)

    %build the output cellarrays
    testdat = {};
    testIDout = {};
    for i = 1:length(testIDpat)
        patid=testIDpat(i);
        posid=testID(i);
        testdat{i} = [data{testIDpat(i)}(:,testID(i)) data{testIDpat(i)}(:,testID(i)+1)];
        testIDpos{i} = [testID(i) testID(i)+1];
        
    end
    
%     testdat = {};
%     testIDout = {};
%     for i = 1:length(testID)
%         testdat{i} = [data(:,testID(i)) data(:,(testID(i)+1))]
%         testIDout{i} = [testID(i) testID(i)+1]
%     end
    
    
            