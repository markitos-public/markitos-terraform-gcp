FROM golang:1.21 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY ./cmd ./cmd
RUN CGO_ENABLED=0 GOOS=linux go build -o backend ./cmd/main.go

FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY --from=builder /app/backend /backend
EXPOSE 8080
ENTRYPOINT ["/backend"]
