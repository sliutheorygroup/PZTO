import matplotlib.pyplot as plt
import glob
import os

dat_files = glob.glob("*.dat")
marker_styles = ['s', 'o', 'D']
color1=(150/255,155/255,199/255)
color2=(149/255,195/255,110/255)
color3=(235/255,143/255,107/255)
colors = [color1, color2, color3]
line_styles = ['-', '--', ':']
fig, axs = plt.subplots(len(dat_files), 1, figsize=(10, 6 * len(dat_files)))
for i, dat_file in enumerate(dat_files):
    data = []
    with open(dat_file, 'r') as file:
        for line in file:
            values = [float(x) for x in line.split()]
            data.append(values)

    data = list(zip(*data)) 
    temperature = data[0]
    lattice_constants = [data[j] for j in range(1, len(data), 2)]
    errors = [data[j] for j in range(2, len(data), 2)]
    labels = ['a', 'b', 'c']
    for j, lattice in enumerate(lattice_constants):
        axs[i].errorbar(
            temperature, lattice, yerr=errors[j], label=f'{labels[j]}',
            marker=marker_styles[j], markersize=8, capsize=8,
            color=colors[j], linestyle=line_styles[j]
        )
    file_name=os.path.splitext(dat_file)[0]
    axs[i].set_title(file_name)
    axs[i].set_xlabel('Temperature (K)')
    axs[i].set_ylabel('Lattice constant (A)')
    axs[i].grid(True, linestyle='--', alpha=0.5)
    axs[i].legend()
plt.tight_layout()

for i, dat_file in enumerate(dat_files):
    plt.figure(fig.number)
    plt.savefig(f"{dat_file.split('.')[0]}.png")

plt.show()

