Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4077E9B2
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 21:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWMEr-0002kc-Np; Wed, 16 Aug 2023 15:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWMEl-0002k7-5A
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 15:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWMEh-000331-HF
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 15:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692214276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWYTdyOU02KeZQ3Ut3Fvl7BfxGtHtH23EtdL08lGWyw=;
 b=RD7dNOR/EGw1wARowzCnMAvHtDdqQYFcbZTRaS3h02oajZnVz6BLG+bYCTkpHR0HlSrhDf
 BuBl0jTB4rZQ8FLn/02Wrr9QziKvCxncNY7v+1lPCNmvJpjISOTH0T5biInmsiko0xjAnE
 d7ygOA/A1oUJnu/HbMNMIYNutqJGiMg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-iJZF_Q0POp2AyQ-1ADxWEA-1; Wed, 16 Aug 2023 15:31:12 -0400
X-MC-Unique: iJZF_Q0POp2AyQ-1ADxWEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 215D538149DE;
 Wed, 16 Aug 2023 19:31:10 +0000 (UTC)
Received: from localhost (unknown [10.39.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE62940C207B;
 Wed, 16 Aug 2023 19:31:08 +0000 (UTC)
Date: Wed, 16 Aug 2023 15:31:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v2 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20230816193107.GB3454448@fedora>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J7BKFgv3snv+I/dx"
Content-Disposition: inline
In-Reply-To: <20230814085802.61459-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--J7BKFgv3snv+I/dx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:58:00PM +0800, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires following arguments: the device size, zoned profile,
> zoned model, zone size, zone capacity, number of conventional
> zones, limits on zone resources (max append sectors, max open
> zones, and max_active_zones). The zoned profile option is set
> to zns when using the qcow2 file as a ZNS drive.
>=20
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> zone_size=3D64M -o zone_capacity=3D64M -o zone_nr_conv=3D0 -o
> max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
>  -o zoned_profile=3Dzbc/zns
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c                    | 125 +++++++++++++++++++++++++++++++
>  block/qcow2.h                    |  21 ++++++
>  docs/interop/qcow2.txt           |  24 ++++++
>  include/block/block-common.h     |   5 ++
>  include/block/block_int-common.h |  16 ++++
>  qapi/block-core.json             |  46 ++++++++----
>  6 files changed, 223 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index c51388e99d..c1077c4a4a 100644
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
> @@ -431,6 +433,38 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>              break;
>          }
> =20
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {
> +            if (ext.len !=3D sizeof(zoned_ext)) {
> +                error_setg_errno(errp, -ret, "zoned_ext: "

ret does not contain a useful value. I suggest calling error_setg()
instead.

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
> +            zoned_ext.zone_capacity =3D be32_to_cpu(zoned_ext.zone_capac=
ity);
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

I suggest adding checks here and refusing to open broken images:

  if (zone_size =3D=3D 0) {
      error_setg(errp, "Zoned extension header zone_size field cannot be 0"=
);
      return -EINVAL;
  }
  if (zone_capacity > zone_size) { ... }
  if (nr_zones !=3D DIV_ROUND_UP(bs->total_size, zone_size)) { ... }

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
> @@ -3089,6 +3123,31 @@ int qcow2_update_header(BlockDriverState *bs)
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
> @@ -3773,6 +3832,23 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>          s->image_data_file =3D g_strdup(data_bs->filename);
>      }
> =20
> +    if (qcow2_opts->zoned_profile) {
> +        BDRVQcow2State *s =3D blk_bs(blk)->opaque;
> +        if (!strcmp(qcow2_opts->zoned_profile, "zbc")) {
> +            s->zoned_header.zoned_profile =3D BLK_ZP_ZBC;
> +            s->zoned_header.zone_capacity =3D qcow2_opts->zone_size;
> +        } else if (!strcmp(qcow2_opts->zoned_profile, "zns")) {
> +            s->zoned_header.zoned_profile =3D BLK_ZP_ZNS;
> +            s->zoned_header.zone_capacity =3D qcow2_opts->zone_capacity;
> +        }
> +        s->zoned_header.zoned =3D BLK_Z_HM;
> +        s->zoned_header.zone_size =3D qcow2_opts->zone_size;
> +        s->zoned_header.zone_nr_conv =3D qcow2_opts->zone_nr_conv;
> +        s->zoned_header.max_open_zones =3D qcow2_opts->max_open_zones;
> +        s->zoned_header.max_active_zones =3D qcow2_opts->max_active_zone=
s;
> +        s->zoned_header.max_append_sectors =3D qcow2_opts->max_append_se=
ctors;

Please add input validation that rejects bad values. For example,
zone_size cannot be 0 and zone_capacity cannot be larger than zone_size.

> +    }
> +
>      /* Create a full header (including things like feature table) */
>      ret =3D qcow2_update_header(blk_bs(blk));
>      bdrv_graph_co_rdunlock();
> @@ -3891,6 +3967,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char =
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
> +
>      /* Change legacy command line options into QMP ones */
>      static const QDictRenames opt_renames[] =3D {
>          { BLOCK_OPT_BACKING_FILE,       "backing-file" },
> @@ -3903,6 +3986,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char =
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
> @@ -6066,6 +6156,41 @@ static QemuOptsList qcow2_create_opts =3D {
>              .help =3D "Compression method used for image cluster "      =
  \
>                      "compression",                                      \
>              .def_value_str =3D "zlib"                                   =
  \
> +        },                                                              \
> +            {

Indentation is off and the forward slash is missing. I'm surprised this
works without the forward slash because the preprocessor should interpet
the macro as ending on this line, weird.

> +            .name =3D BLOCK_OPT_Z_PROFILE,                              =
  \
> +            .type =3D QEMU_OPT_STRING,                                  =
  \
> +            .help =3D "zoned format option for the disk img",           =
  \
> +        },                                                              \
> +            {                                                           \
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

Indentation is off. QEMU uses 4-space indentation.

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
> index f789ce3ae0..3694c8d217 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -236,6 +236,20 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> =20
> +typedef struct Qcow2ZonedHeaderExtension {
> +    /* Zoned device attributes */
> +    uint8_t zoned_profile;
> +    uint8_t zoned;
> +    uint16_t reserved16;
> +    uint32_t zone_size;
> +    uint32_t zone_capacity;
> +    uint32_t nr_zones;
> +    uint32_t zone_nr_conv;
> +    uint32_t max_active_zones;
> +    uint32_t max_open_zones;
> +    uint32_t max_append_sectors;
> +} QEMU_PACKED Qcow2ZonedHeaderExtension;
> +
>  typedef struct Qcow2UnknownHeaderExtension {
>      uint32_t magic;
>      uint32_t len;
> @@ -422,6 +436,13 @@ typedef struct BDRVQcow2State {
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

Please add wps in the patch that uses this field. I thought wps was a
generic BlockDriverState field and didn't expect BDRVQcow2State to have
it.

>  } BDRVQcow2State;
> =20
>  typedef struct Qcow2COWRegion {
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 2c4618375a..ef2ba6f670 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -331,6 +331,30 @@ The fields of the bitmaps extension are:
>                     Offset into the image file at which the bitmap direct=
ory
>                     starts. Must be aligned to a cluster boundary.
> =20
> +=3D=3D Zoned extension =3D=3D
> +
> +The zoned extension is an optional header extension. It is required when
> +using the qcow2 file as the backing image for zoned device.

It's not clear here that this is about emulating a zoned storage device
rather than using qcow2 on a zoned storage device. Also, the term
"backing image" will probably be confused with qcow2's backing files
feature.

I suggest: It contains fields for emulating the zoned storage model
(https://zonedstorage.io/).

> +
> +The fields of the zoned extension are:
> +    Byte  0:  zoned_profile
> +              Type of zoned format. Must be `zbc` or `zns`.
> +                  1: `zbc`
> +                  2: `zns`
> +
> +          1:  zoned
> +              Type of zone.
> +
> +          2 - 3:  Reserved, must be zero.
> +
> +          4 - 7:  zone_size
> +          8 - 11:  zone_capacity
> +          12 - 15:  nr_zones
> +          16 - 19:  zone_nr_conv
> +          20 - 23:  max_active_zones
> +          24 - 27:  max_open_zones
> +          28 - 31:  max_append_sectors

Please document these fields, their units, etc.

> +
>  =3D=3D Full disk encryption header pointer =3D=3D
> =20
>  The full disk encryption header must be present if, and only if, the
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
> index 74195c3004..1dbe820a9b 100644
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
> @@ -872,12 +880,20 @@ typedef struct BlockLimits {
>       */
>      bool has_variable_length;
> =20
> +    BlockZonedProfile zoned_profile;
> +
>      /* device zone model */
>      BlockZoneModel zoned;
> =20
>      /* zone size expressed in bytes */
>      uint32_t zone_size;
> =20
> +    /*
> +     * the number of usable logical blocks within the zone, expressed
> +     * in bytes. A zone capacity is smaller or equal to the zone size.
> +     */
> +    uint32_t zone_capacity;
> +
>      /* total number of zones */
>      uint32_t nr_zones;
> =20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2b1d493d6e..0c97ae678b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5020,24 +5020,42 @@
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

--J7BKFgv3snv+I/dx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTdI/sACgkQnKSrs4Gr
c8jJsQf+L/YKj13iOrhlndoJjDMQRac7OzYy8r5sjBlUfPZ/EUulciYnQw/W8dbo
yUuBcnAAhlOrspCJGc2f+MKcZfibwwXJ1wAKI/1f+1RBJhSHVJnZwC5KyTwAZ7MX
0bcBMbFZUe6rxV2Lpanp9zBXK5mLvM90PJ8C35Np2s0OqQygGBZD7SakgkOCqY7T
bThQZIXrSCxW3iXdFTaTGbpj4//mzD/xarAd3+Uvdus4B6+6B1IdIcnbrwXRqRg7
0/cXQ6IFpNaxKN4TClo1jJyve7gfyhfgx6ECmfD3+2p9oknIcLiueKnq/ribyXKE
txLA2UZ20WLlFkjjZ66X0Y2QZzUnMQ==
=MQd9
-----END PGP SIGNATURE-----

--J7BKFgv3snv+I/dx--


