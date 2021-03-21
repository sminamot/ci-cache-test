FROM golang:1.16 as builder

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY main.go .
RUN CGO_ENABLED=0 go build -o main

FROM gcr.io/distroless/static-debian10
COPY --from=builder /app/main /bin/main

ENTRYPOINT ["/bin/main"]
