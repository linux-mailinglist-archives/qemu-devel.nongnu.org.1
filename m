Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7207351AA
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 12:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBBqM-0006zV-Jx; Mon, 19 Jun 2023 06:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBBqK-0006z1-C5
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBBqI-0004wx-4x
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 06:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687169437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3OAb/oi2qlvnV/tCdeZ9b9JFudj2Lr/5PUlbumHRaJE=;
 b=P8eKB5CnPkd4LuSQwp9q2iaO0ThFe9oIm7co5Psl7dAWgj+HRvtQ7FomfRKEaeBVAU/YQ4
 DoHZCpnL+PSLu+IYD+dvO91lVvtbAGFyiG+JtNeThgjCot2wC2LBJAFLe3J6ZXssImYO/W
 3to/4q2AMGEoFC65frVqoZSKA7odlLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-EQ7A-0sfMFuRpH_HFSWvSA-1; Mon, 19 Jun 2023 06:10:33 -0400
X-MC-Unique: EQ7A-0sfMFuRpH_HFSWvSA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3110A80123E;
 Mon, 19 Jun 2023 10:10:33 +0000 (UTC)
Received: from localhost (unknown [10.39.195.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F941492C1B;
 Mon, 19 Jun 2023 10:10:32 +0000 (UTC)
Date: Mon, 19 Jun 2023 12:10:31 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC 2/4] qcow2: add configurations for zoned format extension
Message-ID: <20230619101031.GC2497337@fedora>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nrFocVKvJMvRfCWy"
Content-Disposition: inline
In-Reply-To: <20230605104108.125270-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--nrFocVKvJMvRfCWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 06:41:06PM +0800, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires following arguments: the device size, zoned profile,
> zoned model, zone size, zone capacity, number of conventional
> zones, limits on zone resources (max append sectors, max open
> zones, and max_active_zones).
>=20
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> zone_size=3D64M -o zone_capacity=3D64M -o zone_nr_conv=3D0 -o
> max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
>  -o zoned_profile=3Dzbc
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c                    | 119 +++++++++++++++++++++++++++++++
>  block/qcow2.h                    |  21 ++++++
>  include/block/block-common.h     |   5 ++
>  include/block/block_int-common.h |   8 +++
>  qapi/block-core.json             |  46 ++++++++----
>  5 files changed, 185 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7f3948360d..b886dab42b 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x7a6264
> =20
>  static int coroutine_fn
>  qcow2_co_preadv_compressed(BlockDriverState *bs,
> @@ -210,6 +211,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t =
start_offset,
>      uint64_t offset;
>      int ret;
>      Qcow2BitmapHeaderExt bitmaps_ext;
> +    Qcow2ZonedHeaderExtension zoned_ext;
> =20
>      if (need_update_header !=3D NULL) {
>          *need_update_header =3D false;
> @@ -431,6 +433,37 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>              break;
>          }
> =20
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {
> +            if (ext.len !=3D sizeof(zoned_ext)) {
> +                error_setg_errno(errp, -ret, "zoned_ext: "
> +                                             "Invalid extension length");
> +                return -EINVAL;
> +            }
> +            ret =3D bdrv_pread(bs->file, offset, ext.len, &zoned_ext, 0);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "zoned_ext: "
> +                                             "Could not read ext header"=
);
> +                return ret;
> +            }
> +
> +            zoned_ext.zone_size =3D be32_to_cpu(zoned_ext.zone_size);
> +            zoned_ext.nr_zones =3D be32_to_cpu(zoned_ext.nr_zones);
> +            zoned_ext.zone_nr_conv =3D be32_to_cpu(zoned_ext.zone_nr_con=
v);
> +            zoned_ext.max_open_zones =3D be32_to_cpu(zoned_ext.max_open_=
zones);
> +            zoned_ext.max_active_zones =3D
> +                be32_to_cpu(zoned_ext.max_active_zones);
> +            zoned_ext.max_append_sectors =3D
> +                be32_to_cpu(zoned_ext.max_append_sectors);
> +            s->zoned_header =3D zoned_ext;

Please validate these values. The image file is not trusted and may be
broken/corrupt. For example, zone_size=3D0 and nr_zones=3D0 must be rejected
because the code can't do anything useful when these values are zero
(similar for values that are not multiples of the block size).

> +
> +#ifdef DEBUG_EXT
> +            printf("Qcow2: Got zoned format extension: "
> +                   "offset=3D%" PRIu32 "\n", offset);
> +#endif
> +            break;
> +        }
> +
>          default:
>              /* unknown magic - save it in case we need to rewrite the he=
ader */
>              /* If you add a new feature, make sure to also update the fa=
st
> @@ -3071,6 +3104,31 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -=3D ret;
>      }
> =20
> +    /* Zoned devices header extension */
> +    if (s->zoned_header.zoned =3D=3D BLK_Z_HM) {
> +        Qcow2ZonedHeaderExtension zoned_header =3D {
> +            .zoned_profile      =3D s->zoned_header.zoned_profile,
> +            .zoned              =3D s->zoned_header.zoned,
> +            .nr_zones           =3D cpu_to_be32(s->zoned_header.nr_zones=
),
> +            .zone_size          =3D cpu_to_be32(s->zoned_header.zone_siz=
e),
> +            .zone_capacity      =3D cpu_to_be32(s->zoned_header.zone_cap=
acity),
> +            .zone_nr_conv       =3D cpu_to_be32(s->zoned_header.zone_nr_=
conv),
> +            .max_open_zones     =3D cpu_to_be32(s->zoned_header.max_open=
_zones),
> +            .max_active_zones   =3D
> +                cpu_to_be32(s->zoned_header.max_active_zones),
> +            .max_append_sectors =3D
> +                cpu_to_be32(s->zoned_header.max_append_sectors)
> +        };
> +        ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
> +                             &zoned_header, sizeof(zoned_header),
> +                             buflen);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +        buf +=3D ret;
> +        buflen -=3D ret;
> +    }
> +
>      /* Keep unknown header extensions */
>      QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
>          ret =3D header_ext_add(buf, uext->magic, uext->data, uext->len, =
buflen);
> @@ -3755,6 +3813,18 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>          s->image_data_file =3D g_strdup(data_bs->filename);
>      }
> =20
> +    if (!strcmp(qcow2_opts->zoned_profile, "zbc")) {
> +        BDRVQcow2State *s =3D blk_bs(blk)->opaque;
> +        s->zoned_header.zoned_profile =3D BLK_ZP_ZBC;
> +        s->zoned_header.zoned =3D BLK_Z_HM;
> +        s->zoned_header.zone_size =3D qcow2_opts->zone_size;
> +        s->zoned_header.zone_capacity =3D qcow2_opts->zone_capacity;
> +        s->zoned_header.zone_nr_conv =3D qcow2_opts->zone_nr_conv;
> +        s->zoned_header.max_open_zones =3D qcow2_opts->max_open_zones;
> +        s->zoned_header.max_active_zones =3D qcow2_opts->max_active_zone=
s;
> +        s->zoned_header.max_append_sectors =3D qcow2_opts->max_append_se=
ctors;

Where is the presence of these optional qcow2_opts checked? For example,
if the user didn't specify zone_size, then they cannot create an image
with a zoned profile.

These options also need to be validated to ensure that they contain
reasonable values (e.g. not 0).

> +    }
> +
>      /* Create a full header (including things like feature table) */
>      ret =3D qcow2_update_header(blk_bs(blk));
>      bdrv_graph_co_rdunlock();
> @@ -3873,6 +3943,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char =
*filename, QemuOpts *opts,
>          qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "v3");
>      }
> =20
> +    /* The available zoned-profile options are zbc, which stands for
> +     * ZBC/ZAC standards, and zns following NVMe ZNS spec. */
> +    val =3D qdict_get_try_str(qdict, BLOCK_OPT_Z_PROFILE);
> +    if (val) {
> +        qdict_put_str(qdict, BLOCK_OPT_Z_PROFILE, val);
> +    }

What is the purpose of this code, it fetches and replaces the same qdict
element?

> +
>      /* Change legacy command line options into QMP ones */
>      static const QDictRenames opt_renames[] =3D {
>          { BLOCK_OPT_BACKING_FILE,       "backing-file" },
> @@ -3885,6 +3962,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char =
*filename, QemuOpts *opts,
>          { BLOCK_OPT_COMPAT_LEVEL,       "version" },
>          { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
>          { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
> +        { BLOCK_OPT_Z_PROFILE,          "zoned-profile"},
> +        { BLOCK_OPT_Z_NR_COV,           "zone-nr-conv"},
> +        { BLOCK_OPT_Z_MOZ,              "max-open-zones"},
> +        { BLOCK_OPT_Z_MAZ,              "max-active-zones"},
> +        { BLOCK_OPT_Z_MAS,              "max-append-sectors"},
> +        { BLOCK_OPT_Z_SIZE,             "zone-size"},
> +        { BLOCK_OPT_Z_CAP,              "zone-capacity"},
>          { NULL, NULL },
>      };
> =20
> @@ -6048,6 +6132,41 @@ static QemuOptsList qcow2_create_opts =3D {
>              .help =3D "Compression method used for image cluster "      =
  \
>                      "compression",                                      \
>              .def_value_str =3D "zlib"                                   =
  \
> +        },                                                              \
> +            {

The forward slash ('\') that wraps the line is missing and indentation
is off.

> +            .name =3D BLOCK_OPT_Z_PROFILE,                              =
  \
> +            .type =3D QEMU_OPT_STRING,                                  =
  \
> +            .help =3D "zoned format option for the disk img",           =
  \
> +        },                                                              \
> +            {                                                           \

Indentation is off.

> +            .name =3D BLOCK_OPT_Z_SIZE,                                 =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "zone size",                                      =
  \
> +        },                                                              \
> +        {                                                           \
> +            .name =3D BLOCK_OPT_Z_CAP,                                  =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "zone capacity",                                  =
  \
> +        },                                                              \
> +        {                                                               \
> +                .name =3D BLOCK_OPT_Z_NR_COV,                           =
  \

Indentation is off.

> +                .type =3D QEMU_OPT_NUMBER,                              =
  \
> +                .help =3D "numbers of conventional zones",              =
  \
> +        },                                                              \
> +        {                                                               \
> +                .name =3D BLOCK_OPT_Z_MAS,                              =
  \
> +                .type =3D QEMU_OPT_NUMBER,                              =
  \
> +                .help =3D "max append sectors",                         =
  \
> +        },                                                              \
> +        {                                                               \
> +                .name =3D BLOCK_OPT_Z_MAZ,                              =
  \
> +                .type =3D QEMU_OPT_NUMBER,                              =
  \
> +                .help =3D "max active zones",                           =
  \
> +        },                                                              \
> +        {                                                               \
> +                .name =3D BLOCK_OPT_Z_MOZ,                              =
  \
> +                .type =3D QEMU_OPT_NUMBER,                              =
  \
> +                .help =3D "max open zones",                             =
  \
>          },
>          QCOW_COMMON_OPTIONS,
>          { /* end of list */ }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 4f67eb912a..fe18dc4d97 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -235,6 +235,20 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> =20
> +typedef struct Qcow2ZonedHeaderExtension {
> +    /* Zoned device attributes */
> +    BlockZonedProfile zoned_profile;
> +    BlockZoneModel zoned;
> +    uint32_t zone_size;
> +    uint32_t zone_capacity;
> +    uint32_t nr_zones;
> +    uint32_t zone_nr_conv;
> +    uint32_t max_active_zones;
> +    uint32_t max_open_zones;
> +    uint32_t max_append_sectors;
> +    uint8_t padding[3];

This looks strange. Why is there 3 bytes of padding at the end? Normally
padding would align to an even power-of-two number of bytes like 2, 4,
8, etc.

> +} QEMU_PACKED Qcow2ZonedHeaderExtension;
> +
>  typedef struct Qcow2UnknownHeaderExtension {
>      uint32_t magic;
>      uint32_t len;
> @@ -419,6 +433,13 @@ typedef struct BDRVQcow2State {
>       * is to convert the image with the desired compression type set.
>       */
>      Qcow2CompressionType compression_type;
> +
> +    /* States of zoned device */
> +    Qcow2ZonedHeaderExtension zoned_header;
> +    uint32_t nr_zones_exp_open;
> +    uint32_t nr_zones_imp_open;
> +    uint32_t nr_zones_closed;
> +    BlockZoneWps *wps;

Normally qcow2 code passes bs around, so it should be possible to access
the wps pointer without duplicating it here. This new field is not used
in this patch, so I can't tell yet how important it is. It's safer to
avoid duplicating pointers when the original pointer can be accessed
conveniently so that use-after-free, double-free, and similar memory
management bugs can be eliminated.

>  } BDRVQcow2State;
> =20
>  typedef struct Qcow2COWRegion {
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index e15395f2cb..9f04a772f6 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -108,6 +108,11 @@ typedef enum BlockZoneType {
>      BLK_ZT_SWP =3D 0x3, /* Sequential writes preferred */
>  } BlockZoneType;
> =20
> +typedef enum BlockZonedProfile {
> +    BLK_ZP_ZBC =3D 0x1,
> +    BLK_ZP_ZNS =3D 0x2,
> +} BlockZonedProfile;
> +
>  /*
>   * Zone descriptor data structure.
>   * Provides information on a zone with all position and size values in b=
ytes.
> diff --git a/include/block/block_int-common.h b/include/block/block_int-c=
ommon.h
> index 74195c3004..4be35feaf8 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -57,6 +57,14 @@
>  #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
>  #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
>  #define BLOCK_OPT_EXTL2             "extended_l2"
> +#define BLOCK_OPT_Z_PROFILE         "zoned_profile"
> +#define BLOCK_OPT_Z_MODEL           "zoned"
> +#define BLOCK_OPT_Z_SIZE            "zone_size"
> +#define BLOCK_OPT_Z_CAP             "zone_capacity"
> +#define BLOCK_OPT_Z_NR_COV          "zone_nr_conv"
> +#define BLOCK_OPT_Z_MAS             "max_append_sectors"
> +#define BLOCK_OPT_Z_MAZ             "max_active_zones"
> +#define BLOCK_OPT_Z_MOZ             "max_open_zones"
> =20
>  #define BLOCK_PROBE_BUF_SIZE        512
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4bf89171c6..f9a584cbb3 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5013,24 +5013,42 @@
>  #
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
> +# @zoned-profile: Two zoned device protocol options, zbc or zns
> +#                 (default: off, since 8.0)
> +# @zone-size: The size of a zone of the zoned device (since 8.0)
> +# @zone-capacity: The capacity of a zone of the zoned device (since 8.0)
> +# @zone-nr-conv: The number of conventional zones of the zoned device
> +#                (since 8.0)
> +# @max-open-zones: The maximal allowed open zones (since 8.0)
> +# @max-active-zones: The limit of the zones that have the implicit open,
> +#                    explicit open or closed state (since 8.0)
> +# @max-append-sectors: The maximal sectors that is allowed to append wri=
te
> +#                      (since 8.0)

Since 8.1.

>  #
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> -  'data': { 'file':             'BlockdevRef',
> -            '*data-file':       'BlockdevRef',
> -            '*data-file-raw':   'bool',
> -            '*extended-l2':     'bool',
> -            'size':             'size',
> -            '*version':         'BlockdevQcow2Version',
> -            '*backing-file':    'str',
> -            '*backing-fmt':     'BlockdevDriver',
> -            '*encrypt':         'QCryptoBlockCreateOptions',
> -            '*cluster-size':    'size',
> -            '*preallocation':   'PreallocMode',
> -            '*lazy-refcounts':  'bool',
> -            '*refcount-bits':   'int',
> -            '*compression-type':'Qcow2CompressionType' } }
> +  'data': { 'file':                'BlockdevRef',
> +            '*data-file':          'BlockdevRef',
> +            '*data-file-raw':      'bool',
> +            '*extended-l2':        'bool',
> +            'size':                'size',
> +            '*version':            'BlockdevQcow2Version',
> +            '*backing-file':       'str',
> +            '*backing-fmt':        'BlockdevDriver',
> +            '*encrypt':            'QCryptoBlockCreateOptions',
> +            '*cluster-size':       'size',
> +            '*preallocation':      'PreallocMode',
> +            '*lazy-refcounts':     'bool',
> +            '*refcount-bits':      'int',
> +            '*compression-type':   'Qcow2CompressionType',
> +            '*zoned-profile':      'str',
> +            '*zone-size':          'size',
> +            '*zone-capacity':      'size',
> +            '*zone-nr-conv':       'uint32',
> +            '*max-open-zones':     'uint32',
> +            '*max-active-zones':   'uint32',
> +            '*max-append-sectors': 'uint32'}}
> =20
>  ##
>  # @BlockdevCreateOptionsQed:
> --=20
> 2.40.1
>=20

--nrFocVKvJMvRfCWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSQKZcACgkQnKSrs4Gr
c8jLWQf/dDeZGU3S2uXkeC7qLdJyKq9Wg0e15+EMbB0eWM71AqY9qT4YVQ9+zmdt
858zJljOXy/SeeOWhbQbb9bn1sitMvwp3iazBxoM+AOhiEbSuUf0446fkZzy54vw
A6l9ZK8ViBsn4Xksu2O0PhJGPw+qf8H+r599no7fHtn7iDxvgK/meP1nfdkDkFTl
sVPKe/g18rPq/qoVReNXJ4h4cYoNtwvNhKO6EDU0EccTzLVL1EVP78DVp6MRW0v2
Q0iqeHWbdvkCIqe4CIa2fjb5qGkq/6EwRODisvMwdptMHfKcA5QLliTRTTXPx6vy
NJsdMdIW0a6x2cfu1KFcNxjpJjBE8Q==
=N4Vu
-----END PGP SIGNATURE-----

--nrFocVKvJMvRfCWy--


