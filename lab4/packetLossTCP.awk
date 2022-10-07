#============================= throughput.awk ========================

BEGIN {
drop=0;
sent=0
gotime = 0;
time = 0;
packet_size = $6;
time_interval=0.01;
}
#body
{
  event = $1
  time = $2
  node_id = $4
  pktType = $5
  packet_size = $6
	     
 if(time>gotime && event=="r") {
  print time, drop/sent; #packet size * ... gives results in kbps
  sent = sent - drop - 1;
  drop=0;
  }

#============= CALCULATE throughput=================

  if (event == "+")
  {
     sent++;
  }
  if (event == "d")
  {
     drop++;
  }
} #body


END {
;
}
#============================= Ends ============================
