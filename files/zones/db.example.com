$TTL	86400 ; 1 day - $TTL used for all RRs without explicit TTL value

$ORIGIN example.com.
@  IN  SOA ns1.example.com. hostmaster.example.com. (
			      2002022401 ; serial
			      3H ; refresh
			      15 ; retry
			      1w ; expire
			      3h ; nxdomain ttl
			     )
       IN  NS     ns1.example.com. ; primary dns
       IN  NS     ns2.example.com. ; secondary (slave) dns

; server host definitions
ns1    IN  A      192.168.0.1  ; ns1.example.com
ns2    IN  A      192.168.0.2  ; ns2.example.com
www    IN  A      192.168.0.3  ; www.example.com
ftp    IN  A      192.168.0.4  ; ftp.example.com

; non server domain hosts
host1   IN  A      192.168.0.5  ; host1.example.com
host2   IN  A      192.168.0.6  ; host2.example.com