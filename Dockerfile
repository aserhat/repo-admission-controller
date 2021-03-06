FROM golang:1.11.4 as builder
WORKDIR /go/src/github.com/aserhat/repo-whitelist-controller
COPY main.go .
RUN go get "k8s.io/api/admission/v1beta1" && go get "k8s.io/api/core/v1" && go get "k8s.io/apimachinery/pkg/apis/meta/v1"
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app

FROM alpine:3.9
WORKDIR /root/
COPY --from=builder /go/src/github.com/aserhat/repo-whitelist-controller/app .
CMD ["./app"]
