import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

# Defina os parâmetros
m = 1.0  # Massa do objeto em movimento no sistema
k = 1.0  # Medida da rigidez da mola no sistema

# Defina a função para as equações diferenciais
def f(y, t, b):
    y1, y2 = y
    dydt = [y2, -(b / m) * y2 - (k / m) * y1]
    return dydt

# Parâmetros iniciais
t = np.linspace(0, 10, 1000)  # De onde vai sair até onde se estende
y0 = [1.0, 0.0]  # Valores iniciais
x0 = 0.0  # Posição de equilíbrio do sistema

# Coeficientes de amortecimento
b_values = [0.0, 1.0, 2.0, -0.13]

# Crie uma figura de tamanho maior com resolução de 300 dpi
plt.figure(figsize=(10, 6), dpi=300)

# Solução das equações diferenciais para diferentes valores de b
for b in b_values:
    sol = odeint(f, y0, t, args=(b,))
    plt.plot(t, sol[:, 0], label=f'b = {b}')

plt.legend()
plt.xlabel('Tempo')
plt.ylabel('Deslocamento em relação à posição de equilíbrio (x)')
plt.title('Amortecimento Harmônico')
plt.grid(True)

# Defina os limites do eixo X para começar do zero
plt.xlim(0, 10)  # Defina os limites desejados para o eixo X
plt.ylim(-1.8, 1.5)
nome_arquivo = 'amortecimento_harmonico.pdf'
plt.savefig(nome_arquivo, bbox_inches='tight')
plt.show()

# Defina a função para as equações diferenciais
def f(T, t, k):
    dTdt = -k * T
    return dTdt

# Parâmetros iniciais
t = np.arange(0, 10.1, 0.1)  # Passos de tempo
t0 = 0  # Tempo inicial
T0 = 25  # Temperatura inicial (°C)
k_values = [5.21, 0, -0.03]  # Constantes de resfriamento

# Crie uma figura de tamanho maior
plt.figure(figsize=(10, 6), dpi=600)

# Solução das equações diferenciais para diferentes valores de k
for k in k_values:
    T = odeint(f, T0, t, args=(k,))
    plt.plot(t, T, label=f'k = {k}')

plt.xlabel('Tempo (min)')
plt.ylabel('f(t) - Temperatura (°C)')
plt.legend()
plt.grid(True)
nome_arquivo = 'resfriamento da maçã.pdf'
plt.savefig(nome_arquivo, bbox_inches='tight')
plt.show()


import numpy as np

theta_prime_inicial = 0
theta_inicial = np.pi/3
t0 = 0
gr = 9.81
u = 0.1
L = 2
def f(theta, theta_prime):
    theta_dois_prime = -u*theta_prime - (gr/L)*np.sin(theta)
    rturn theta_dois_prime

def g(t_final):
    theta = theta_inicial
    theta_prime = theta_prime_inicial
    delta_t = 0.01
    t = t0
    while t < t_final:
        theta_dois_prime = f(theta, theta_prime)
        theta = theta + theta_prime * delta_t
        theta_prime = theta_prime + theta_dois_prime * delta_t
        t += delta_t
    return theta
t_final = 10
p = g(t_final)
print(p)



import numpy as np
from scipy.integrate import solve_ivp
# Definindo as equações do sistema
def system(t, y):
    m, rho, V, T = y
    T = 95 - 65*np.exp(-0.1*t)
    rho = 1000 - 0.2*T
    V = m/rho
    m = 1000*V - 60*np.exp((-0.1*t)/V)
    return [m, rho, V, T]
# Condições iniciais
y0 = [10000, 1000, 10, 30]
# Intervalo de tempo
t_span = (0,3)
# Solução usando o método BDF
solution = solve_ivp(system, t_span, y0, method='BDF', t_eval=np.arange(0,4,1))
# Mostrando os resultados
print("Solução em t = 3s:")
print("m(t):", solution.y[0][-1])
print("rho(t):", solution.y[1][-1])
print("V(t):", solution.y[2][-1])
print("T(t):", solution.y[3][-1])

