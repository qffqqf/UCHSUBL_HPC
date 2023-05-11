function x_resp = Loewner(K, M, F, R, freq)

tol_mf = 5e-3;
nSamp_init = 4;
nSamp = 2; 
nStep = 2;
freq_check = linspace(freq(1),freq(end),6*numel(freq));
uz_1 = 0*freq_check;
uz_0 = rand(size(freq_check));
error_all = [];
error = tol_mf*1e6;
new_index = round(linspace(5,numel(freq_check)-5,nSamp_init));
omega_LR_index = [];
omega_LR = [];
uz_sample = [];

%% initialize the reduced system
while error > tol_mf
    for iWave = 1:numel(new_index)
        omega = 2*pi* freq_check(new_index(iWave));
        D = -omega^2*M + K;
        uz_sample = [uz_sample, R'* (D\F)];
    end
    omega_LR_index = [omega_LR_index, new_index];
    omega_LR = [omega_LR, 2*pi* freq_check(new_index)];
    uz_1 = frequency_interpolation(omega_LR, 2*pi* freq_check, uz_sample);
    [new_index, error] = adaptive_selection(omega_LR_index, uz_1, uz_0, nSamp, nStep);
    uz_0 = uz_1;
    error_all = [error_all, error];
    %% Plot error
    semilogy(error_all, '-','Linewidth', 2)
    hold on;
    semilogy([1, numel(error_all)+1], [tol_mf,tol_mf], '--', ...
              'Color', [0.6055, 0.6484, 0.6914],'Linewidth', 3)
    hold off;
    title('Matrix-free algorithm')
    xlabel('Iteration step [-]');ylabel('relative difference [-]')
    set(gca, 'FontSize', 20)
    xlim([1, numel(error_all)+1])
    ylim([1e-2*tol_mf, 1e2])
    yticks(10.^[-6:2:2])
    drawnow
end
x_resp = frequency_interpolation(omega_LR, 2*pi* freq, uz_sample);
nSamp = numel(uz_sample)