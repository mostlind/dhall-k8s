let kubernetes = ../imports/kubernetes.dhall

let SecretsEnvVar
    : Type
    = { name : Text, secret : Text, key : Text }

in  λ(secret : SecretsEnvVar) →
      kubernetes.EnvVar::{
      , name = secret.name
      , valueFrom = Some kubernetes.EnvVarSource::{
        , secretKeyRef = Some kubernetes.SecretKeySelector::{
          , name = Some secret.secret
          , key = secret.key
          }
        }
      }
