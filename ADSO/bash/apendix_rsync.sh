#!/bin/bash 
# ----------------------------------------------------------------- 
# mikes handy rotating-filesystem-snapshot utility 
# http://www.mikerubel.org/computers/rsync_snapshots 
# Modified by Mauricio Alvarez: http://people.ac.upc.edu/alvarez 
# ----------------------------------------------------------------- 
 
# ---------- system commands used by this script------------------ 
ID=/usr/bin/id 
ECHO=/bin/echo 
MOUNT=/bin/mount 
RM=/bin/rm 
MV=/bin/mv 
CP=/bin/cp 
TOUCH=/usr/bin/touch 
RSYNC=/usr/bin/rsync 
 
# ------------- file locations -----------------------------------
MOUNT_DEVICE=/dev/sda4
SNAPSHOT_MOUNTPOINT=/home/aso/backups
SNAPSHOT_DIR=backup-rsync/snapshot
EXCLUDES=
SOURCE_DIR=/var/log
# ------------- the script itself--------------------------------- 
 
# make sure we're running as root 
if (( `$ID -u` != 0 )); then { $ECHO "Sorry, must be root.  Exiting..."; exit; } fi 
 
# attempt to remount the RW mount point as RW; else abort 
$(ssh root@172.16.1.2 "mount -o remount,rw $MOUNT_DEVICE $SNAPSHOT_MOUNTPOINT")
if (( $? )); then 
{ 
    $ECHO "snapshot: could not remount $SNAPSHOT_MOUNTPOINT readwrite"; 
    exit; 
} 
fi; 
 
# rotating snapshots of /$SNAPSHOT_DIR 
 
# step 1: delete the oldest snapshot, if it exists: 
if [ $(ssh root@172.16.1.2 "ls $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.3 | wc -l") -eq 1 ] ; then 
    #$RM -rf $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.3
    $(ssh root@172.16.1.2 "rm -rf $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.3") 
fi
# step 2: shift the middle snapshotss back by one, if they exist
if [ $(ssh root@172.16.1.2 "ls $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.2 | wc -l") -eq 2 ] ; then 
    $(ssh root@172.16.1.2 "mv $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.2 $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.3")
fi 
 
if [ $(ssh root@172.16.1.2 "ls $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.1 | wc -l") -eq 1 ] ; then 
    $(ssh root@172.16.1.2 "mv $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.1 $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.2")
fi 
 
if [ $(ssh root@172.16.1.2 "ls $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.0 | wc -l") -eq 1 ] ; then 
    $(ssh root@172.16.1.2 "mv $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.0 $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.1")
    #$MV $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.0 $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.1 
fi; 
 
# step 3: rsync from the system into the latest snapshot 
$RSYNC -av --exclude "*.gz" --delete --no-p --no-g --chmod=700 --link-dest=$SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.1 $SOURCE_DIR -e ssh root@172.16.1.2:$SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.0
# complete here what is missing for the rsync command: 
# - basic options: 
# - excludes: 
# - --link-dest= 
# - source and destination directories 
 
# step 5: update the mtime of daily.0 to reflect the snapshot time 
#$TOUCH $SNAPSHOT_MOUNTPOINT/$SNAPSHOT_DIR/daily.0 ; 
 
# now remount the RW snapshot mountpoint as readonly 
$(ssh root@172.16.1.2 "mount -o remount,ro $MOUNT_DEVICE $SNAPSHOT_MOUNTPOINT")
if (( $? )); then 
{ 
    $ECHO "snapshot: could not remount $SNAPSHOT_MOUNTPOINT readonly"; 
    exit;
} fi;
