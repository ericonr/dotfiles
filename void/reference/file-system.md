# File system management

## Traditional partitioning

Create EFI partition.

Create other partitions. F2FS and ext4 support per folder encryption (important
in multi-user systems). BtrFS does transparent compression.

### Encryption

```
cryptsetup --type luks2 luksFormat /path/to/device

cryptsetup open /path/to/device mappername

mkfs.filesystem /dev/mapper/mappername [-O encrypt]
```


### Swap file

```
# create file
dd if=/dev/zero of=<partition or file> bs=1024 count=<number of KiB>

chmod 600 <partition or file>

mkswap <partition or file>
swapon <partition or file>
```

From `/etc/fstab`:

```
<partition or file> none swap defaults,nofail 0 0
```

#### Encrypted swap

For an ephemeral encrypted swap (no password, no hibernation), waiting on a
`void-runit` commit.
