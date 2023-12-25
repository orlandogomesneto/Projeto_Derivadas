

t = linspace(0, 10, 1000);  % De onde vai sair até onde se estende
t0 = 0;  % Tempo inicial
T0 = 25;  % Temperatura inicial (°C)
k_values = [5.21, 0, -0.03];  % Constantes de resfriamento

% Solução das equações diferenciais para diferentes valores de k
for k = k_values
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
    [t, T] = ode45(@(t, T) myODE(t, T, k), t, T0, options);
    plot(t, T, 'LineWidth', 1.5, 'DisplayName', ['k = ', num2str(k)]);
    hold on;
end

% Defina os limites do eixo X para começar do zero
xlim([0, 10]);  % Defina os limites desejados para o eixo X

legend('Location', 'Best');
xlabel('Tempo (min)');
ylabel('f(t) - Temperatura (°C)');
title('Amortecimento Harmônico');
grid on;

% Nome do arquivo para salvar o gráfico em formato PDF
nome_arquivo = 'amortecimento_harmonico.pdf';

% Salvar a figura em formato PDF de alta qualidade com o nome de arquivo especificado
saveas(gcf, nome_arquivo);

% Defina a função para as equações diferenciais
function dTdt = myODE(t, T, k)
    dTdt = -k * T;
end



