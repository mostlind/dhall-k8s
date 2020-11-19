let kubernetes = ../imports/kubernetes.dhall

let map = ../imports/map.dhall

let App = ../schemas/App.dhall

let rule =
      λ(app : App.Type) →
        kubernetes.IngressRule::{
        , host = Some app.host
        , http = Some kubernetes.HTTPIngressRuleValue::{
          , paths =
                [ kubernetes.HTTPIngressPath::{
                  , path = Some "/"
                  , backend = kubernetes.IngressBackend::{
                    , serviceName = Some app.name
                    , servicePort = Some (kubernetes.IntOrString.Int app.port)
                    }
                  }
                ]
              : List kubernetes.HTTPIngressPath.Type
          }
        }

in  λ(name : Text) →
    λ(apps : List App.Type) →
      kubernetes.Ingress::{
      , metadata = kubernetes.ObjectMeta::{ name = Some name }
      , spec = Some kubernetes.IngressSpec::{
        , rules = Some (map App.Type kubernetes.IngressRule.Type rule apps)
        }
      }
