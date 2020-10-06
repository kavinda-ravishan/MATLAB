clear;
clc;
Create_data_set(0000)
data =  load('dataset.txt');       %loading data
x = data(:,1)';
y = data(:,2)';

Hidden_nodes = [15 10];                    % Setting network architecture and hyper Parameters
net = feedforwardnet(Hidden_nodes);
net.trainFcn = 'traingdx';
net.performParam.regularization = 0.3;
net.trainParam.lr = 0.1;
net.trainParam.epochs = 100;
net.divideParam.trainRatio = 0.5;
net.divideParam.testRatio = 0.1;
net.divideParam.valRatio = 0.4;

[trained_net tr]= train(net,x,y);                     %Training neural network

tr_error = immse(trained_net(x(tr.trainInd)),y(tr.trainInd));    % Calculating  training, test, and validation errors
tst_error =immse(trained_net(x(tr.testInd)),y(tr.testInd));
val_error =immse(trained_net(x(tr.valInd)),y(tr.valInd));

x_test = min(x):0.01:max(x);                       % Plotting Data and predictions
y_predict = trained_net(x_test);
plot(x,y,'x',x_test,y_predict);