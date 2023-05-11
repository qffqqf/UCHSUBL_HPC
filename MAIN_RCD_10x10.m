clear all
clc
addpath([pwd,'/Functions'])
addpath([pwd,'/plate_models'])
addpath([pwd,'/input_model_normal'])
warning('off','all')

tStart = tic;
%% Load
model_file = 'input_model_10x10.mat';
load(model_file)
savename = 'vbplate_10x10_Lhbms';

%% Analysis setup
options.nModeI = 20;
options.nModeA = 30;
options.exppt = 2000;

%% Hierarchical reduction
uz_Lhbms = hss(uc_model, param, tree_model, options);

figure
freq = 0:1:1000;
semilogy(freq, abs(uz_Lhbms))

timing = toc(tStart);
save([savename,'.mat'],'freq','uz_Lhbms','timing')



