let kubernetes = ../imports/kubernetes.dhall

let App = ../schemas/App.dhall

let servicePort = λ(port : Integer) → kubernetes.ServicePort::{ port }

let service =
      λ(app : App.Type) →
        kubernetes.Service::{
        , metadata = kubernetes.ObjectMeta::{ name = Some app.name }
        , spec = Some kubernetes.ServiceSpec::{
          , ports = Some [ servicePort app.port ]
          , selector = Some (toMap { app = app.name })
          }
        }

in  service
