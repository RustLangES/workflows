# 📜 Workflows Reutilizables para GitHub Actions

![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-Ready-blue?logo=github-actions)
![Reutilización](https://img.shields.io/badge/Reusabilidad-100%25-success)
![Múltiples Lenguajes](https://img.shields.io/badge/Multi-Lenguaje-orange)

Colección de workflows preconfigurados para GitHub Actions listos para usar en tus proyectos. Ahorra tiempo configurando CI/CD con estas plantillas probadas y optimizadas.

## 🗂️ Workflows Disponibles

| Workflow                                                             | Descripción                                 | Contenido                                   |
| -------------------------------------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| [clippy.yml](./.github/workflows/clippy.yml)                         | Análisis estático de código Rust con Clippy | clippy -D warnings                          |
| [format.yml](./.github/workflows/format.yml)                         | Revisión de formato en el código            | fmt --all --check                           |
| [leptosfmt.yml](./.github/workflows/leptosfmt.yml)                   | Formateo específico para Leptos             | leptosfmt --check .                         |
| [quality-gate-front.yml](./.github/workflows/quality-gate-front.yml) | Control de calidad para frontend con Leptos | fmt, clippy, leptosfmt                      |
| [quality-gate.yml](./.github/workflows/quality-gate.yml)             | Control de calidad general                  | fmt, clippy, tests                          |
| [tests.yml](./.github/workflows/tests.yml)                           | Ejecución de tests automatizados            | cargo test                                  |
| [setup-kubectl.sh](./setup-kubectl.sh)                               | Configuración de kubectl para Kubernetes    | kubectl, validacion y configuracion inicial |

## 🚀 Cómo Usar

```yml
steps:
  - uses: RustLangES/workflows/<workflow>.yml@main
    with:
      <input>: <value>
```

> [!IMPORTANT]
> En lugar de usar `main` puedes usar un hash de commit especifico para evitar problemas

Ejemplo para añadir el format check:

```yml
steps:
  - uses: RustLangES/workflows/.github/workflows/format.yml@main
  # las variables por defecto estan bien
```

Para los scipts ejecuta así

```yml
steps:
  - name: Run
    run: |
      bash <(curl -sL https://raw.githubusercontent.com/RustLangES/workflows/main/setup-kubectl.sh) --token "TU_TOKEN" --certificate "TU_CERTIFICADO" --host "TU_HOST"
```

## ✨ Características Clave

- [x] Configuración mínima requerida
- [x] Optimizados para rendimiento
- [x] Fáciles de personalizar

## 🤝 Contribución

¡Contribuciones son bienvenidas! Sigue estos pasos:

1. Haz fork del proyecto
2. Crea tu branch (`git checkout -b feature/nueva-funcionalidad`)
3. Haz commit de tus cambios (`git commit -m 'Añade nuevo workflow'`)
4. Haz push al branch (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

<p align="center">
✨ <em>Haz tus pipelines CI/CD más simples y eficientes</em> ✨
</p>
