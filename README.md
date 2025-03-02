# charon_watchdog
Strongswan charon daemon watchdog ,similar to wireguard one  .

Charon daemon poorly handles dynamic ip of a responder, after sudden disconnects  
and assigning new ip from ISP. There is a constatnt FQDN of a responder. The script  
checks new ip and compares to installed SA's remote. Triggered by updown maybe. 

WIP.
  


