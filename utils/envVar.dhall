let kubernetes = ../imports/kubernetes.dhall

let EnvVar
    : Type
    = { name : Text, value : Text }

in  λ(envVar : EnvVar) →
      kubernetes.EnvVar::{ name = envVar.name, value = Some envVar.value }
