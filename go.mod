module github.com/MottainaiCI/mottainai-agent

go 1.15

require (
	github.com/MottainaiCI/mottainai-server v0.0.0-20201011151335-ce5b031d119b
	github.com/RichardKnop/machinery v1.9.0 // indirect
	github.com/go-redis/redis v6.15.9+incompatible // indirect
	github.com/golang/snappy v0.0.2 // indirect
	github.com/huandu/xstrings v1.3.2 // indirect
	github.com/klauspost/compress v1.11.1 // indirect
	github.com/mailru/easyjson v0.0.0-20190626092158-b2ccc519800e // indirect
	github.com/markbates/goth v1.66.0 // indirect
	github.com/spf13/cobra v0.0.3
	github.com/spf13/viper v1.3.1
	go.mongodb.org/mongo-driver v1.4.1 // indirect
	gopkg.in/macaron.v1 v1.3.9 // indirect
	k8s.io/kubernetes v1.15.0-alpha.0.0.20190629124123-d5f2096f1a37 // indirect
)

replace github.com/juju/clock v0.0.0-20190205081909-9c5c9712527c => github.com/rogpeppe/clock v0.0.0-20190514193443-f0bda0cd88c6

replace github.com/Unknwon/com v0.0.0-20181010210213-41959bdd855f => github.com/unknwon/com v0.0.0-20181010210213-41959bdd855f

replace github.com/MottainaiCI/mottainai-server => github.com/adibsaad/mottainai-server v0.0.0-20201113022152-1fc6ef5bb16a
