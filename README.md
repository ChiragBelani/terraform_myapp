# terraform_myapp

Inorder to completely run the terraform script for the vpc, subnet, sgs and running a n ec2 instance on it, follow the below steps

1.Install the terraform in yout terminal 
    cmd "brew install hashicorp/tap/terraform"

2.Clone the repository into the local machine
    cmd "git clone <repository-url>"
    
3.Init the terraform (needed for the modules self created)

    cmd "terraform init"
    
sample-image
    ![image](https://github.com/user-attachments/assets/981246d4-584d-4ec4-960a-f621cdc6dee2)
    
4.Apply the terraform script (this will automatically create a server_key (ssh key pair) for the ssh connection of the local terminal to ec2 instance.

    cmd "terraform apply"  

sample-image
    ![image](https://github.com/user-attachments/assets/5a18aedc-7d84-4970-85aa-ff3ef7301f79)


5.Cop the aws ec2 public ip(ec2_public_ip) and open the port 8080 on the local machine with the same ip, you will see the nginx server running on docker.

  <img width="600" alt="Screenshot 2024-08-28 at 12 25 37 PM" src="https://github.com/user-attachments/assets/e3a83434-f0bd-4890-b12d-24236c81941c">

6.Create a S3 bucket (myapp-bucket44 here) for the tfstate file updation.
