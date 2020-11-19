let apply
    : ∀(a : Type) → ∀(b : Type) → a → (a → b) → b
    = λ(a : Type) → λ(b : Type) → λ(arg : a) → λ(fn : a → b) → fn arg

in  apply
