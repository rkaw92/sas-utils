# SAS/SES utilities
(Tested on Linux 3.14)

## bays.sh
List enclosure drive bay numbers that correspond to your SCSI devices.
Example:
```
# lsscsi
[1:0:0:0]    disk    ATA      INTEL SSDSC2BB16 0370  /dev/sda 
[1:0:1:0]    disk    ATA      INTEL SSDSC2BB16 0370  /dev/sdb 
[1:0:2:0]    disk    HGST     HUC721010ASS600  A610  /dev/sdc 
[1:0:3:0]    disk    HGST     HUC721010ASS600  A610  /dev/sdd 
[1:0:4:0]    enclosu DP       BACKPLANE        6B02  -
```
We see that there are 4 drives present (1:0:0-3), but which physical bays are they located in?

The SES ident command can help us determine which physical location corresponds to a particular bay index by blinking a LED.

However, what --index parameter do we pass to it? bays.sh to the rescue!

```
# ./bays.sh
BAY: DEVICE
0: 1:0:0
2: 1:0:1
4: 1:0:2
6: 1:0:3
255: 1:0:4
```
 
Then, assuming we want to find and pull /dev/sdc out of the server, seeing how it's labeled as SCSI device 1:0:2 which occupies bay 4, this is what we do:

```
sg_ses --set=ident --index=4 /dev/sg4
```

where sg4 is our backplane/enclosure.
