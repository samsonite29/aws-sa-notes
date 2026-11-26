# VPC

## IP Address

Each of the four octets can be any number from 0 to 255. So the full range runs from 0.0.0.0 to 255.255.255.255.

Where Base IP = 255.255.255.255

1 octet = 8 bits, so one octet holds values 0–255(0 included).

Subnet Mask(How many of the bits can change in an IP)

1. /32 none of the octets can change = 255.255.255.255
2. /24 the last octet can change = 255.255.255.0 to 255.255.255.255
3. /16 the last two octets can change = 255.255.0.0 to 255.255.255.255 - There are 65,536 and its calculated like 256 x 256 for the last two octets(it's 256 because we are counting the 0 - 255)
4. /8 the last three octets can change = 255.0.0.0 to 255.255.255.255
5. /0 all octet can change = 0.0.0.0 to 255.255.255.255

## Formula for calculating CIDR ranges = 2^(32 − prefix)

***Example 10.0.4.0/28 = 2^(32-28) = 16, so 10.0.4.0 = 10.0.4.15***
***10.0.4.0/29 = 2^(32-29) = 8, so 10.0.4.0 = 10.0.4.7***


## VPC Subnet

A subnet is a smaller CIDR range carved out of the VPC's range, and AWS adds an AZ, a route table and a NACL(Firewall for subnet) on top.

A subnet is tied to one AZ and they are for Routing control (security boundary)

Exam Tip - You need 29 IP Address for EC2 instance

You can't use 10.0.0.0/27 because 2^(32-27) = 32-5(AWS reserves first 3 and last address) = 27 which is less than 29(what you need)
You can use 10.0.0.0/26 because 2^(32-26) = 64 - 5 = 59 and 59 > 29