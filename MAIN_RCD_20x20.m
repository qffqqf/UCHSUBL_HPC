clear all
clc
addpath([pwd,'/Functions'])
addpath([pwd,'/plate_models'])
addpath([pwd,'/input_model_normal'])
warning('off','all')

tStart = tic;
%% Load
model_file = 'input_model_20x20.mat';
load(model_file)
savename = 'vbplate_20x20_Lhbms';

%% Analysis setup
options.nModeI = 20;
options.nModeA = 30;
options.nEig = 1000;
options.exppt = 2000;

%% Hierarchical reduction
uz_Lhbms = hss(uc_model, param, tree_model, options);

figure
freq = 0:2:1000;
semilogy(freq, abs(uz_Lhbms))

timing = toc(tStart);
save([savename,'.mat'],'freq','uz_Lhbms','timing')



