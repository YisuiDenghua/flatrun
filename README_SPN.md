# flatrun

[English 🇬🇧](README.md)

[简体中文 🇨🇳](README_CHN.md)

[Español 🌎](README_SPN.md)

[日本語 💔](README_JPN.md)

Un script para ejecutar una aplicación flatpak sin conocer el ID completo de la App

Este es un script muy simple que creé para aliviar mi tristeza y pasar el tiempo después de que me rompieron el corazón. Envuelve una aplicación flatpak para que los usuarios puedan ejecutarla simplemente introduciendo el nombre de la aplicación, sin necesidad de escribir el ID completo.


## Uso
```shell
Uso: flatrun [OPCIONES] NOMBRE_APP [ -- SUBCOMANDOS]
Ejecuta una aplicación Flatpak coincidiendo con su nombre o ID.

Opciones:
  -c    Coincidencia sensible a mayúsculas y minúsculas (desactiva el filtrado inteligente)
  -v    Mostrar información de la versión
  -h    Mostrar este mensaje de ayuda

Ejemplos:
  flatrun steam              # Coincide inteligentemente con com.valvesoftware.Steam
  flatrun -c Steam           # Coincidencia estricta; podría mostrar el menú de selección
  flatrun vlc -- --version   # Pasa --version a VLC

```

## Instalación

### Nix Flake:

Puedes ejecutar la shell directamente mediante `nix run`:

```bash
nix run github:yisuidenghua/flatrun
```

O añadirla a tu configuración del sistema:

```
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flatrun = {
      url = "github:yisuidenghua/flatrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

El paquete está disponible como `inputs.flatrun.packages.${pkgs.stdenv.hostPlatform.system}.default` y se puede añadir a tu `environment.systemPackages`, `users.users.<nombre-de-usuario>.packages`, `home.packages` si usas home-manager, o una devshell.


### Otras distribuciones:

***Comming s∞n...***
