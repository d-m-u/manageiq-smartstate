module AUFSProbe
  #
  # TODO: Verify these offsets - in the standard superblock,
  # sig (magic) is a short surrounded by two valid shorts.
  #
  AUFS_SUPER_OFFSET = 1024
  AUFS_MAGIC_OFFSET = 52
  AUFS_MAGIC_SIZE   = 4
  AUFS_SUPER_MAGIC  = 0x12121313
  AUFS_FSTYPE       = "aufs".freeze

  def self.probe(dobj)
    return(false) unless dobj.kind_of?(MiqDisk)

    # Check for aufs magic number or name at offset.
    dobj.seek(AUFS_SUPER_OFFSET + AUFS_MAGIC_OFFSET)
    buf = dobj.read(AUFS_MAGIC_SIZE)
    bs = buf&.unpack('L')
    magic = bs.nil? ? nil : bs[0]

    isAufs = false
    isAufs = true if magic == AUFS_SUPER_MAGIC
    isAufs = true if buf == AUFS_FSTYPE
    raise "AUFS is Not Supported" if isAufs

    # No AUFS.
    false
  end
end
