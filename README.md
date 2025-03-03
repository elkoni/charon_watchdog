# charon_watchdog
Strongswan charon daemon watchdog ,similar to wireguard one  .

Charon daemon poorly handles dynamic ip of a responder, after sudden disconnects  
and assigning new ip from ISP. There is a constatnt FQDN of a responder. The script  
checks new ip and compares to installed SA's remote. Triggered by updown maybe.  
  The responder is a VPN server behind a router and firewall. The ISP provides a dynamic  
ip address. MOBIKE does not work in this case.  
  In case of ISP disconnect, the VPN server is seen at different ip , but same fqdn due to  
dynamic DNS used.  
  This script is used on initiator, to make charon re-resolve new ip.  
Limited to one IKE_SA and one CHILD_SA.  
WIP follows.  
