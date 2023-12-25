clc; clear;
caso = 5
select caso
case 1 then
    function dTdt = f(t,T,k)
        dTdt = -k*T
    endfunction
    // parametros iniciais
    t = [0:0.1:10]; // passos de tempo
    t0 = 0; // tempo inicial
    T0 = 25; // temperatura inicial (°C)
    k = 5.21; // Constante de resfriamento
    T = ode(T0,t0,t,list(f,k));
    k1 = 0; T1 = ode(T0,t0,t,list(f,k1));
    k2 = -0.03; T2 = ode(T0,t0,t,list(f,k2));
    plot(t,T,t,T1,t,T2)
    xlabel('tempo (min)'); ylabel('f(t) - Temperatura (°C)');
    legend('k = 5.21','k1 = 0','k2 = -0.03',2)
    //
case 2 then
    k = 0.25; // valor da constante
    // Define the ODE function
    function dTdt = f(t, T)
        dTdt = -k*T;
    endfunction
    // Definição dos parâmetros
    h = 0.01; // tamanho do passo
    t = 0:h:10; // tempo de inicio - passo - final
    T0 = 25; // condição inicial da temperatura (°C)
    // Euler Explicíto
    T = zeros(1, length(t)); T(1) = T0;
    for i = 1:length(t) - 1
        T(i+1) = T(i) + h*f(t(i),T(i));
    end
    plot(t,T,t,T0*exp(-k*t));
    xtitle('Approximate and Exact Solution for Simple ODE', 't', 'f(t)');
    xlabel('t'); ylabel('f(t)');
    legend('Aproximada','Exata',1)
    grid on;
//
case 3 then
    m = 1; // massa do objeto em movimento no sistema
    k = 1; // medida da rigidez da mola no sistema
    function y = f(x,y,b)
        y = [y(2); -(b/m)*y(2)-(k/m)*y(1)] // ODEs
    endfunction
    // parametros iniciais
    x = [0:0.1:10]; // de onde vai sair até onde se estende
    x0 = 0; // posição de equilíbrio do sistema
    y0 = [1;0]; // valores iniciais
    b1 = 0; // coeficiente de amortecimento 
    y1 = ode(y0,x0,x,list(f,b1));
    b2 = 1; y2 = ode(y0,x0,x,list(f,b2));
    b3 = 2; y3 = ode(y0,x0,x,list(f,b3));
    plot(x,y1(1,:),x,y2(1,:),x,y3(1,:))
    legend('b = 0 - sem amortecimento','b = 1 - subamortecido','b = 2 - amortecimento crítico',-1);
    xlabel('deslocamento em relação à sua posição de equilíbrio (x)'); ylabel('f(x)');
    xgrid(1,1,3)
    b = -1; y = ode(y0,x0,x,list(f,b));
    plot(x,y(1,:))
    //
case 4 then
    function dydt = f(t,x,a)
        dydt(1) = x(2);
        dydt(2) = -3*x(2) + a*x(1);
    endfunction
    t0 = 0; y0 = [1;3];
    t = [3:0.1:5];
    a = 10; y = ode(y0,t0,t,list(f,a));
    a =  8; y1 = ode(y0,t0,t,list(f,a));
    plot(t,y(1,:),t,y1(1,:),'--or');
    legend('a = 10','a = 8',2)
//
case 5 then
    k = 0.25; // valor da constante
    function dTdt = f(t, T)
        dTdt = -k * T;
    endfunction
    h = 0.01; // tamanho do passo
    t = 0:h:10; // tempo de início - passo - final
    T0 = 25; // condição inicial da temperatura (°C)
    
    T = zeros(1, length(t)); // Inicializa o vetor para armazenar a solução
    T(1) = T0; // Define a condição inicial
    for i = 1:length(t) - 1
        ti = t(i);
        Ti = T(i);
        k1 = h * f(ti, Ti);
        k2 = h * f(ti + h/2, Ti + k1/2);
        k3 = h * f(ti + h/2, Ti + k2/2);
        k4 = h * f(ti + h, Ti + k3);
        T(i+1) = Ti + (k1 + 2*k2 + 2*k3 + k4)/6; // Métodoo de RK4
    end
    plot(t, T, t, T0*exp(-k*t));
    xtitle('Solução Aproximada e Solução Exata para EDO Simples (RK4)', 't', 'f(t)');
    xlabel('t'); ylabel('f(t)'); legend('Aproximada', 'Exata', 1);
    grid on;
end


