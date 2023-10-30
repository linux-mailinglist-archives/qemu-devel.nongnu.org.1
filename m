Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D29CF7DBC24
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:54:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTeH-0002Yh-51; Mon, 30 Oct 2023 10:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxTeE-0002UA-VO
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:53:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qxTeB-0004xH-C1
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698677621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oY0cvUyeFKDl2pLhf4rd6VVWGVlAJGxoJMQ9J8kenu8=;
 b=SFb65+/5GKB2i7N9I18Y1PKb0tp/MYUete8axPJO14TvyObgPA7Y8ozvUA4WWAkI6UeVij
 CQPo0QDFqaBu/eQUn3HrXC1tHWNjbWfj66SkwpVbIVr7vT68e6qk2/CdL2/Ra+fhtvdrPV
 9It6Lpt7MnljCTyMzdX4xlerpY4DCCo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-1lgyD_5qMHiJwAol6495LQ-1; Mon, 30 Oct 2023 10:53:40 -0400
X-MC-Unique: 1lgyD_5qMHiJwAol6495LQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 966A385A59D;
 Mon, 30 Oct 2023 14:53:39 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C846A10782;
 Mon, 30 Oct 2023 14:53:37 +0000 (UTC)
Date: Mon, 30 Oct 2023 09:53:36 -0500
From: Eric Blake <eblake@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, dlemoal@kernel.org, hare@suse.de,
 dmitry.fomichev@wdc.com, stefanha@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <i43illqyyzu7wbotuw2fbuft7izdmfo7jkwnds4yrigewachhw@7pudpozwjer5>
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030121847.4522-3-faithilikerun@gmail.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 30, 2023 at 08:18:45PM +0800, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires settings as: the device size, zone model, zone size,
> zone capacity, number of conventional zones, limits on zone
> resources (max append bytes, max open zones, and max_active_zones).
> 
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=768M -o
> zone_size=64M -o zone_capacity=64M -o conventional_zones=0 -o
> max_append_bytes=4096 -o max_open_zones=0 -o max_active_zones=0
> -o zone_model=host-managed
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> 
> fix config?

Is this comment supposed to be part of the commit message?  If not,...

> ---

...place it here under the divider, so 'git am' won't include it, if there is nothing further to change on this patch.

>  block/qcow2.c                    | 205 ++++++++++++++++++++++++++++++-
>  block/qcow2.h                    |  37 +++++-
>  docs/interop/qcow2.txt           |  67 +++++++++-
>  include/block/block_int-common.h |  13 ++
>  qapi/block-core.json             |  45 ++++++-
>  5 files changed, 362 insertions(+), 5 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index aa01d9e7b5..cd53268ca7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
>  
>  static int coroutine_fn
>  qcow2_co_preadv_compressed(BlockDriverState *bs,
> @@ -210,6 +211,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>      uint64_t offset;
>      int ret;
>      Qcow2BitmapHeaderExt bitmaps_ext;
> +    Qcow2ZonedHeaderExtension zoned_ext;
>  
>      if (need_update_header != NULL) {
>          *need_update_header = false;
> @@ -431,6 +433,63 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>              break;
>          }
>  
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {
> +            if (ext.len != sizeof(zoned_ext)) {
> +                error_setg(errp, "zoned_ext: Invalid extension length");
> +                return -EINVAL;
> +            }

Do we ever anticipate the struct growing in size in the future to add
further features?  Forcing the size to be constant, rather than a
minimum, may get in the way of clean upgrades to a future version of
the extension header.

> +            ret = bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "zoned_ext: "
> +                                             "Could not read ext header");
> +                return ret;
> +            }
> +
> +            if (s->incompatible_features & QCOW2_INCOMPAT_ZONED_FORMAT) {
> +                warn_report("A program lacking zoned format support "
> +                           "may modify this file and zoned metadata are "
> +                           "now considered inconsistent");
> +                error_printf("The zoned metadata is corrupted.\n");

Why is this mixing warn_report and error_printf at the same time.
Also, grammar is inconsistent from the similar
QCOW2_AUTOCLEAR_BITMAPS, which used:

                if (s->qcow_version < 3) {
                    /* Let's be a bit more specific */
                    warn_report("This qcow2 v2 image contains bitmaps, but "
                                "they may have been modified by a program "
                                "without persistent bitmap support; so now "
                                "they must all be considered inconsistent");
                } else {
                    warn_report("a program lacking bitmap support "
                                "modified this file, so all bitmaps are now "
                                "considered inconsistent");

This also raises the question whether we want to ever allow zoned
support with a v2 image, or whether it should just be a hard error if
it is not a v3 image (my preference would be the latter).

> +            }
> +
> +            zoned_ext.zone_size = be32_to_cpu(zoned_ext.zone_size);
> +            zoned_ext.zone_capacity = be32_to_cpu(zoned_ext.zone_capacity);
> +            zoned_ext.conventional_zones =
> +                be32_to_cpu(zoned_ext.conventional_zones);
> +            zoned_ext.nr_zones = be32_to_cpu(zoned_ext.nr_zones);
> +            zoned_ext.max_open_zones = be32_to_cpu(zoned_ext.max_open_zones);
> +            zoned_ext.max_active_zones =
> +                be32_to_cpu(zoned_ext.max_active_zones);
> +            zoned_ext.max_append_bytes =
> +                be32_to_cpu(zoned_ext.max_append_bytes);
> +            s->zoned_header = zoned_ext;
> +
> +            /* refuse to open broken images */
> +            if (zoned_ext.zone_size == 0) {
> +                error_setg(errp, "Zoned extension header zone_size field "
> +                                 "can not be 0");
> +                return -EINVAL;
> +            }
> +            if (zoned_ext.zone_capacity > zoned_ext.zone_size) {
> +                error_setg(errp, "Zoned extension header zone_capacity field "
> +                                 "can not be larger that zone_size field");
> +                return -EINVAL;
> +            }
> +            if (zoned_ext.nr_zones != DIV_ROUND_UP(
> +                bs->total_sectors * BDRV_SECTOR_SIZE, zoned_ext.zone_size)) {
> +                error_setg(errp, "Zoned extension header nr_zones field "
> +                                 "is wrong");
> +                return -EINVAL;
> +            }

Are there any other sanity checks you should do, such as ensuring
max_open_zones <= the number of total possible zones once you divide
image size by zone size?

Such sanity checks would also be useful when creating new image with
zones (and not just when opening a pre-existing image); should you
have a helper function that performs all the sanity checks for zone
values being self-consistent, and reuse it in each context, rather
than repeated open-coding the same checks?

> +
> +#ifdef DEBUG_EXT
> +            printf("Qcow2: Got zoned format extension: "
> +                   "offset=%" PRIu32 "\n", offset);
> +#endif
> +            break;
> +        }
> +
>          default:
>              /* unknown magic - save it in case we need to rewrite the header */
>              /* If you add a new feature, make sure to also update the fast
> +++ b/block/qcow2.h
> @@ -236,6 +236,27 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
>  
> +typedef struct Qcow2ZonedHeaderExtension {
> +    /* Zoned device attributes */
> +    uint8_t zoned;
> +    uint8_t reserved[3];
> +    uint32_t zone_size;
> +    uint32_t zone_capacity;
> +    uint32_t conventional_zones;
> +    uint32_t nr_zones;
> +    uint32_t max_active_zones;
> +    uint32_t max_open_zones;
> +    uint32_t max_append_bytes;
> +    uint64_t zonedmeta_size;
> +    uint64_t zonedmeta_offset;
> +} QEMU_PACKED Qcow2ZonedHeaderExtension;

Nice that everything is well-aligned so that the struct packs into 6
consecutive 8-byte values.

> +
> +typedef struct Qcow2ZoneListEntry {
> +    QLIST_ENTRY(Qcow2ZoneListEntry) exp_open_zone_entry;
> +    QLIST_ENTRY(Qcow2ZoneListEntry) imp_open_zone_entry;
> +    QLIST_ENTRY(Qcow2ZoneListEntry) closed_zone_entry;
> +} Qcow2ZoneListEntry;
> +
>  typedef struct Qcow2UnknownHeaderExtension {
>      uint32_t magic;
>      uint32_t len;
> @@ -256,17 +277,20 @@ enum {
>      QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
>      QCOW2_INCOMPAT_COMPRESSION_BITNR = 3,
>      QCOW2_INCOMPAT_EXTL2_BITNR      = 4,
> +    QCOW2_INCOMPAT_ZONED_FORMAT_BITNR = 5,
>      QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
>      QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
>      QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
>      QCOW2_INCOMPAT_COMPRESSION      = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
>      QCOW2_INCOMPAT_EXTL2            = 1 << QCOW2_INCOMPAT_EXTL2_BITNR,
> +    QCOW2_INCOMPAT_ZONED_FORMAT     = 1 << QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
>  
>      QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
>                                      | QCOW2_INCOMPAT_CORRUPT
>                                      | QCOW2_INCOMPAT_DATA_FILE
>                                      | QCOW2_INCOMPAT_COMPRESSION
> -                                    | QCOW2_INCOMPAT_EXTL2,
> +                                    | QCOW2_INCOMPAT_EXTL2
> +                                    | QCOW2_INCOMPAT_ZONED_FORMAT,
>  };

In the previous version, I had suggested an autoclear bit; but it
looks like you went with a full-bore incompatible bit.  What about the
format of the disk makes it impossible to read an image if you don't
know about zoned formats?  Other incompat bits have obvious reasons:
for example, you can't extract data from an extl2 if you don't know
how to access the external data; and you can't uncompress an image
with zstd if you don't have the compression header calling out that
compression type.  But so far, I haven't seen anything about how zone
information makes the image unreadable by an earlier version of qemu.

Do you have proper sanity checks that the incompat bit and the zone
extension header are either both present or both absent?

>  
>  /* Compatible feature bits */
> @@ -285,7 +309,6 @@ enum {
>      QCOW2_AUTOCLEAR_DATA_FILE_RAW       = 1 << QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR,
>  
>      QCOW2_AUTOCLEAR_MASK                = QCOW2_AUTOCLEAR_BITMAPS
> -                                        | QCOW2_AUTOCLEAR_DATA_FILE_RAW,
>  };

Why are you removing a bit from the autoclear mask?  Did you
experiment with making zoned devices an autoclear bit, and then change
your mind to making it an incompatible bit instead?  At any rate, this
part of the hunk looks wrong.

>  
>  enum qcow2_discard_type {
> @@ -422,6 +445,16 @@ typedef struct BDRVQcow2State {
>       * is to convert the image with the desired compression type set.
>       */
>      Qcow2CompressionType compression_type;
> +
> +    /* States of zoned device */
> +    Qcow2ZonedHeaderExtension zoned_header;
> +    QLIST_HEAD(, Qcow2ZoneListEntry) exp_open_zones;
> +    QLIST_HEAD(, Qcow2ZoneListEntry) imp_open_zones;
> +    QLIST_HEAD(, Qcow2ZoneListEntry) closed_zones;
> +    Qcow2ZoneListEntry *zone_list_entries;
> +    uint32_t nr_zones_exp_open;
> +    uint32_t nr_zones_imp_open;
> +    uint32_t nr_zones_closed;
>  } BDRVQcow2State;
>  
>  typedef struct Qcow2COWRegion {
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 2c4618375a..b210bc4580 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -125,7 +125,18 @@ the next fields through header_length.
>                                  allows subcluster-based allocation. See the
>                                  Extended L2 Entries section for more details.
>  
> -                    Bits 5-63:  Reserved (set to 0)
> +                    Bit 5:      Zoned extension bit. If this bit is set then
> +                                the file is a zoned device file with
> +                                host-managed model.
> +
> +                                It is unsafe when any qcow2 writer which does
> +                                not understand zone information edits a file
> +                                with the zoned extension. The write pointer
> +                                tracking is corrupted between different version
> +                                of qcow2 writes. In such cases, the file can
> +                                no longer be seen as a zoned device.

This wording sounds more like you want an autoclear bit than an
incompat bit.  An incompat bit implies that an image unaware of the
zone extension cannot even open the device for reads (making it
impossible to write and corrupt the zone information).

> +
> +                    Bits 6-63:  Reserved (set to 0)
>  
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation can
> @@ -249,6 +260,7 @@ be stored. Each extension has a structure like the following:
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header pointer
>                          0x44415441 - External data file name string
> +                        0x007a6264 - Zoned extension
>                          other      - Unknown header extension, can be safely
>                                       ignored
>  
> @@ -331,6 +343,59 @@ The fields of the bitmaps extension are:
>                     Offset into the image file at which the bitmap directory
>                     starts. Must be aligned to a cluster boundary.
>  
> +== Zoned extension ==
> +
> +The zoned extension is an optional header extension. It contains fields for
> +emulating the zoned stroage model (https://zonedstorage.io/).

If you stick with an incompat bit, then this header should be
mandatory when the incompat bit is set, and omitted when the incompat
bit is clear.

> +
> +When the device model is not recognized as host-managed, it is regared as

regarded

> +incompatible and report an error to users.

I'm not quite sure what you meant by a 'device model is not recognized
as host-managed'.  The phrase 'and report an error to users' does not
seem to match anywhere else in the spec; I think what you are trying
to state is that a given implementation must refuse to open a qcow2
file with the zone extension header containing a 'zoned' byte (the
enum at offset 0) with a value it cannot support.

> +
> +The fields of the zoned extension are:
> +    Byte       0:  zoned
> +                   This bit represents zone model of devices. 1 is for
> +                   host-managed, which only allows sequential writes.
> +                   And 0 is for non-zoned devices without such constraints.

Grammar suggestions, and it's nice to list values in order.  How about:

This bit represents the zone model of the device.  0 is for a
non-zoned device (all other information in this header is ignored).  1
is for a host-managed device, which only allows for sequential writes
within each zone.  Other values may be added later; the implementation
must refuse to open a device containing an unknown zone model.

> +
> +          1 -  3:  Reserved, must be zero.
> +
> +          4 -  7:  zone_size
> +                   Total size of each zones, in bytes. It is less than 4GB

each zone

> +                   in the contained image for simplicity.

Must this be a power of 2, and/or a multiple of the cluster size?
Will we ever want to support making zones larger than 4G, in which
case we need to plan on sizing this field bigger to begin with?

> +
> +          8 - 11:  zone_capacity
> +                   The number of writable bytes within the zones.
> +                   A zone capacity is always smaller or equal to the
> +                   zone size.

I'm still not understanding why we need this separate from zone_size.

> +
> +         12 - 15:  conventional_zones
> +                   The number of conventional zones.

Given that this is a spec, it is probably worth defining what a
conventional zone is.  I'm assuming it is a zone that does not have
append-only semantics?

> +
> +         16 - 19:  nr_zones
> +                   The number of zones. It is the sum of conventional zones
> +                   and sequential zones.

Does the qcow2 implementation of zones guarantee that all conventional
zones appear before any sequential zones?

> +
> +         20 - 23:  max_active_zones
> +                   The number of the zones that are in the implicit open,
> +                   explicit open or closed state.

s/are/can be/

> +
> +         24 - 27:  max_open_zones
> +                   The maximal number of open (implicitly open or explicitly
> +                   open) zones.

What other states are there besides open and closed?  If a closed zone
is active, then when can a zone ever not be active?  Is it required
that max_open_zones <= max_active_zones <= nr_zones?

> +
> +         28 - 31:  max_append_bytes
> +                   The number of bytes of a zone append request that can be
> +                   issued to the device. It must be 512-byte aligned.

Here, you call out bytes; in the docs above you called out sectors.
Make sure your patch is self-consistent.

> +
> +         32 - 39:  zonedmeta_size
> +                   The size of zoned metadata in bytes. It contains no more
> +                   than 4GB. The zoned metadata structure is the write
> +                   pointers for each zone.

It contains no more than 4G, but yet has an 8-byte value.  Why?

> +
> +         40 - 47:  zonedmeta_offset
> +                   The offset of zoned metadata structure in the contained
> +                   image, in bytes.
> +
>  == Full disk encryption header pointer ==
>  
>  The full disk encryption header must be present if, and only if, the
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h

It feels like you are missing documentation on the zonedmeta
cluster(s) - you've described it as being write pointers for each
zone, but is it just 8 bytes per zone, taking up as many bytes as
needed to cover all zones, with all remaining bytes in the cluster
being zero padding?

> +++ b/qapi/block-core.json
> @@ -4981,6 +4981,21 @@
>  { 'enum': 'Qcow2CompressionType',
>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
>  
> +##
> +# @Qcow2ZoneModel:
> +#
> +# Zoned device model used in qcow2 image file
> +#
> +# @non-zoned: non-zoned model is for regular block devices
> +#
> +# @host-managed: host-managed model only allows sequential write over the
> +#     device zones
> +#
> +# Since 8.2
> +##
> +{ 'enum': 'Qcow2ZoneModel',
> +  'data': ['non-zoned', 'host-managed'] }
> +
>  ##
>  # @BlockdevCreateOptionsQcow2:
>  #
> @@ -5023,6 +5038,27 @@
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
>  #
> +# @zone-model: @Qcow2ZoneModel.  The zone device model.
> +#     (default: non-zoned, since 8.2)
> +#
> +# @zone-size: Total number of bytes within zones (since 8.2)

If @zone-model is "non-zoned", does it make sense to even allow
@zone-size and friends?  Should this use a QMP union, where you can
pass in the remaining zone-* fields only when zone-model is set to
host-managed?

> +#
> +# @zone-capacity: The number of usable logical blocks within zones
> +#     in bytes.  A zone capacity is always smaller or equal to the
> +#     zone size (since 8.2)
> +#
> +# @conventional-zones: The number of conventional zones of the
> +#     zoned device (since 8.2)
> +#
> +# @max-open-zones: The maximal number of open zones (since 8.2)
> +#
> +# @max-active-zones: The maximal number of zones in the implicit
> +#     open, explicit open or closed state (since 8.2)
> +#
> +# @max-append-bytes: The maximal number of bytes of a zone
> +#     append request that can be issued to the device.  It must be
> +#     512-byte aligned (since 8.2)
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> @@ -5039,7 +5075,14 @@
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
>              '*refcount-bits':   'int',
> -            '*compression-type':'Qcow2CompressionType' } }
> +            '*compression-type':'Qcow2CompressionType',
> +            '*zone-model':         'Qcow2ZoneModel',
> +            '*zone-size':          'size',
> +            '*zone-capacity':      'size',
> +            '*conventional-zones': 'uint32',
> +            '*max-open-zones':     'uint32',
> +            '*max-active-zones':   'uint32',
> +            '*max-append-bytes':   'uint32' } }

In other words, I'm envisioning something like an optional
'*zone':'ZoneStruct', where:

{ 'struct': 'ZoneHostManaged',
  'data': { 'size': 'size', '*capacity': 'size', ..., '*max-append-bytes': 'uint32' } }
{ 'union': 'ZoneStruct',
  'base': { 'model': 'Qcow2ZoneModel' },
  'discriminator': 'model',
  'data': { 'non-zoned': {},
            'host-managed': 'ZoneHostManaged' } }

then over the wire, QMP can use the existing:
{ ..., "compression-type":"zstd" }

as a synonym for the new but explicit non-zoned:
{ ..., "compression-type":"zstd", "zone":{"mode":"non-zoned"} }

and when we want to use zones, we pass:
{ ..., "compression-type":"zstd", "zone":{"mode":"host-managed", "size":16777216} }

where you don't have to have zone- prefixing everywhere because it is
instead contained in the smart union object where it is obvious from
the 'mode' field what other fields should be present.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


