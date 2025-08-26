FROM golang:1.21 AS builder
WORKDIR /app
COPY ./cmd/main.go ./cmd/main.go
RUN CGO_ENABLED=0 GOOS=linux go build -o frontend ./cmd/main.go

FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY --from=builder /app/frontend /frontend
EXPOSE 8081
ENTRYPOINT ["/frontend"]
