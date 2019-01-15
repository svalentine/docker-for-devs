package main

import (
	"io/ioutil"
	"log"

	"github.com/go-yaml/yaml"
	"github.com/streadway/amqp"
)

type config struct {
	RabbitDSN string `yaml:"rabbit_dsn"`
	QueueName string `yaml:"rabbit_queue"`
}

func failOnError(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
	}
}

func main() {
	configFile := "./config.yml"
	data, err := ioutil.ReadFile(configFile)
	if err != nil {
		log.Fatalf("Error reading config from %s : %v", configFile, err)
	}
	var cfg config
	err = yaml.Unmarshal(data, &cfg)
	if err != nil {
		log.Fatalf("Error parsing config %v", err)
	}

	conn, err := amqp.Dial(cfg.RabbitDSN) // "amqp://guest:guest@localhost:5672/"
	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	q, err := ch.QueueDeclare(
		cfg.QueueName, // name
		false,         // durable
		false,         // delete when unused
		false,         // exclusive
		false,         // no-wait
		nil,           // arguments
	)
	failOnError(err, "Failed to declare a queue")

	msgs, err := ch.Consume(
		q.Name, // queue
		"",     // consumer
		true,   // auto-ack
		false,  // exclusive
		false,  // no-local
		false,  // no-wait
		nil,    // args
	)
	failOnError(err, "Failed to register a consumer")

	forever := make(chan bool)

	go func() {
		for d := range msgs {
			log.Printf("Received a message: %s", d.Body)
		}
	}()

	log.Printf(" [*] Waiting for messages. To exit press CTRL+C")
	<-forever
}
