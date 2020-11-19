let kubernetes = ../imports/kubernetes.dhall

let ConfigMapEnvVar
    : Type
    = { name : Text, configMap : Text, key : Text }

in  λ(configMap : ConfigMapEnvVar) →
      kubernetes.EnvVar::{
      , name = configMap.name
      , valueFrom = Some kubernetes.EnvVarSource::{
        , configMapKeyRef = Some kubernetes.ConfigMapKeySelector::{
          , name = Some configMap.configMap
          , key = configMap.key
          }
        }
      }
