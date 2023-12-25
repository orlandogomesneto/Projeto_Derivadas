m = 1.0;  % Massa do objeto em movimento no sistema
k = 1.0;  % Medida da rigidez da mola no sistema

% Parâmetros iniciais
t = linspace(0, 10, 1000);  % De onde vai sair até onde se estende
y0 = [1.0; 0.0];  % Valores iniciais
x0 = 0.0;  % Posição de equilíbrio do sistema

% Coeficientes de amortecimento
b_values = [0.0, 1.0, 2.0, -0.13];

% Crie uma figura de tamanho maior
figure('Position', [100, 100, 800, 500]);

% Solução das equações diferenciais para diferentes valores de b
for b = b_values
    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
    [t, y] = ode45(@(t, y) myODE(t, y, b, m, k), t, y0, options);
    plot(t, y(:, 1), 'LineWidth', 1.5, 'DisplayName', ['b = ', num2str(b)]);
    hold on;
end

xlim([0, 10]);  % Defina os limites desejados para o eixo X
legend('Location', 'Best');
xlabel('Tempo');
ylabel('Deslocamento em relação à posição de equilíbrio (x)');
title('Amortecimento Harmônico');
grid on;
nome_arquivo = 'amortecimento_harmonico.pdf';
saveas(gcf, nome_arquivo);

% Defina a função para as equações diferenciais
function dydt = myODE(t, y, b, m, k)
    dydt = zeros(2, 1);
    dydt(1) = y(2);
    dydt(2) = -(b / m) * y(2) - (k / m) * y(1);
end