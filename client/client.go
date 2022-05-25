package main

import (
	"context"
	"log"
	"time"

	pb "deniffel.com/go_grpc_docker/proto"
	"google.golang.org/grpc"
)

const (
	address = "localhost:50051"
)

func main() {
	conn, err := grpc.Dial(address, grpc.WithInsecure(), grpc.WithBlock())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()

	c := pb.NewUserManagementClient(conn)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	var new_users = make(map[string]int32)
	new_users["Alice"] = 43
	new_users["Bob"] = 30

	start := time.Now()
	for i := 1; i < 1000000; i++ {
		for name, age := range new_users {
			_, err := c.CreateNewUser(ctx, &pb.NewUser{Name: name, Age: age})
			if err != nil {
				log.Fatalf("could not create user %v", err)
			}
			// 		log.Printf(`User Details:
			// NAME: %s,
			// AGE: %d,
			// ID: %d`, r.GetName(), r.GetAge(), r.GetId())
		}
	}

	elapsed := time.Since(start)
	log.Printf("Took %s", elapsed)
}
