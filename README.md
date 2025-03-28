# Numerical Methods for Integration and Differentiation

![MATLAB](https://img.shields.io/badge/MATLAB-R2023a-blue)
![Numerical_Analysis](https://img.shields.io/badge/Numerical_Analysis-Integration/Differentiation-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

## 📊 Project Overview
A MATLAB implementation of fundamental numerical methods for differentiation and integration, with comprehensive analysis of their accuracy and performance compared to analytical solutions.

## 📚 Implemented Methods

### Differentiation Methods
| Method | Formula | Order of Accuracy |
|--------|---------|-------------------|
| Forward Difference | `f'(x) ≈ (f(x+h) - f(x))/h` | O(h) |
| Backward Difference | `f'(x) ≈ (f(x) - f(x-h))/h` | O(h) |
| Central Difference | `f'(x) ≈ (f(x+h) - f(x-h))/(2h)` | O(h²) |

### Integration Methods
| Method | Formula | Order of Accuracy |
|--------|---------|-------------------|
| Trapezoidal Rule | `∫f(x)dx ≈ h/2 * [f(x₀) + 2Σf(xᵢ) + f(xₙ)]` | O(h²) |
| Simpson's Rule | `∫f(x)dx ≈ h/3 * [f(x₀) + 4Σf(xᵢ) + 2Σf(xⱼ) + f(xₙ)]` | O(h⁴) |
| Monte Carlo | `∫f(x)dx ≈ (b-a)/N * Σf(xᵢ)` | O(1/√N) |

## 🚀 Getting Started

### Prerequisites
- MATLAB R2020a or later
- Basic understanding of numerical analysis

