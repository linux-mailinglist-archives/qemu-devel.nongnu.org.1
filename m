Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5D479F2B7
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:14:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgWER-0007kD-NX; Wed, 13 Sep 2023 16:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgWEL-0007iy-O1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgWEE-0000Me-1u
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694635968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pz4d9NeVHOdb/eYaIDvLBj3uYbfLiJsWk5YDnrvv4d8=;
 b=EEzhUzw2JNG/Db6y2e5Pr7ImM1vo5leo+wJC+QFhCknyyNc7yecpEUhK1IKfMsM/foMiXo
 JM5L9YMDOTjJZd58MV6uXxai72xW/P4nk+vLGFl+cVSTrZlU8CDfNQbSMYRvvdtkcPWQhL
 vfavp57E5PAkX4iHssS/neMidP1cuoc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-EX1F__VRNwmkYKaB1Fh2kg-1; Wed, 13 Sep 2023 16:12:44 -0400
X-MC-Unique: EX1F__VRNwmkYKaB1Fh2kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E453185A78E;
 Wed, 13 Sep 2023 20:12:44 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B500521B2413;
 Wed, 13 Sep 2023 20:12:43 +0000 (UTC)
Date: Wed, 13 Sep 2023 16:12:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, hare@suse.de, qemu-block@nongnu.org,
 dlemoal@kernel.org
Subject: Re: [PATCH v3 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20230913201242.GB1313843@fedora>
References: <20230828150955.3481-1-faithilikerun@gmail.com>
 <20230828150955.3481-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6iPiwrSgB8Aan2vs"
Content-Disposition: inline
In-Reply-To: <20230828150955.3481-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--6iPiwrSgB8Aan2vs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 11:09:53PM +0800, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires following arguments: the device size, zoned profile,
> zone model, zone size, zone capacity, number of conventional
> zones, limits on zone resources (max append sectors, max open
> zones, and max_active_zones).
>=20
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> zone_size=3D64M -o zone_capacity=3D64M -o nr_conv_zones=3D0 -o
> max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
> -o zone_model=3D1
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c                    | 176 ++++++++++++++++++++++++++++++-
>  block/qcow2.h                    |  20 ++++
>  docs/interop/qcow2.txt           |  36 +++++++
>  include/block/block_int-common.h |  13 +++
>  qapi/block-core.json             |  30 +++++-
>  5 files changed, 273 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index c51388e99d..7074bfc620 100644
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
> @@ -431,6 +433,55 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>              break;
>          }
> =20
> +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> +        {
> +            if (ext.len !=3D sizeof(zoned_ext)) {
> +                error_setg(errp, "zoned_ext: Invalid extension length");
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
> +            zoned_ext.nr_conv_zones =3D be32_to_cpu(zoned_ext.nr_conv_zo=
nes);
> +            zoned_ext.nr_zones =3D be32_to_cpu(zoned_ext.nr_zones);
> +            zoned_ext.max_open_zones =3D be32_to_cpu(zoned_ext.max_open_=
zones);
> +            zoned_ext.max_active_zones =3D
> +                be32_to_cpu(zoned_ext.max_active_zones);
> +            zoned_ext.max_append_sectors =3D
> +                be32_to_cpu(zoned_ext.max_append_sectors);
> +            s->zoned_header =3D zoned_ext;
> +
> +            /* refuse to open broken images */
> +            if (zoned_ext.zone_size =3D=3D 0) {
> +                error_setg(errp, "Zoned extension header zone_size field=
 "
> +                                 "can not be 0");
> +                return -EINVAL;
> +            }
> +            if (zoned_ext.zone_capacity > zoned_ext.zone_size) {
> +                error_setg(errp, "Zoned extension header zone_capacity f=
ield "
> +                                 "can not be larger that zone_size field=
");
> +                return -EINVAL;
> +            }
> +            if (zoned_ext.nr_zones !=3D DIV_ROUND_UP(
> +                bs->total_sectors * BDRV_SECTOR_SIZE, zoned_ext.zone_siz=
e)) {
> +                error_setg(errp, "Zoned extension header nr_zones field "
> +                                 "gets wrong");

"gets" -> "is"

> +                return -EINVAL;
> +            }
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
> @@ -1967,6 +2018,14 @@ static void qcow2_refresh_limits(BlockDriverState =
*bs, Error **errp)
>      }
>      bs->bl.pwrite_zeroes_alignment =3D s->subcluster_size;
>      bs->bl.pdiscard_alignment =3D s->cluster_size;
> +    bs->bl.zoned =3D s->zoned_header.zoned;
> +    bs->bl.nr_zones =3D s->zoned_header.nr_zones;
> +    bs->wps =3D s->wps;
> +    bs->bl.max_append_sectors =3D s->zoned_header.max_append_sectors;
> +    bs->bl.max_active_zones =3D s->zoned_header.max_active_zones;
> +    bs->bl.max_open_zones =3D s->zoned_header.max_open_zones;
> +    bs->bl.zone_size =3D s->zoned_header.zone_size;
> +    bs->bl.write_granularity =3D BDRV_SECTOR_SIZE;
>  }
> =20
>  static int qcow2_reopen_prepare(BDRVReopenState *state,
> @@ -3089,6 +3148,30 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -=3D ret;
>      }
> =20
> +    /* Zoned devices header extension */
> +    if (s->zoned_header.zoned =3D=3D BLK_Z_HM) {
> +        Qcow2ZonedHeaderExtension zoned_header =3D {
> +            .zoned              =3D s->zoned_header.zoned,
> +            .zone_size          =3D cpu_to_be32(s->zoned_header.zone_siz=
e),
> +            .zone_capacity      =3D cpu_to_be32(s->zoned_header.zone_cap=
acity),
> +            .nr_conv_zones      =3D cpu_to_be32(s->zoned_header.nr_conv_=
zones),
> +            .nr_zones           =3D cpu_to_be32(s->zoned_header.nr_zones=
),
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
> @@ -3768,11 +3851,60 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
ions, Error **errp)
>      }
> =20
>      /* Set the external data file if necessary */
> +    BDRVQcow2State *s =3D blk_bs(blk)->opaque;
>      if (data_bs) {
> -        BDRVQcow2State *s =3D blk_bs(blk)->opaque;
>          s->image_data_file =3D g_strdup(data_bs->filename);
>      }
> =20
> +    if (qcow2_opts->has_zone_model && qcow2_opts->zone_model =3D=3D BLK_=
Z_HM) {
> +        if (qcow2_opts->has_zone_size && qcow2_opts->zone_size =3D=3D 0)=
 {

has_zone_size is mandatory:

  if (!qcow2_opts->has_zone_size) {
      error_setg(errp, "Missing zone_size parameter");
      ret =3D -EINVAL;
      goto out;
  }
  ...

> +            s->zoned_header.zoned =3D BLK_Z_NONE;
> +            error_setg(errp, "Zoned devices can not allow a larger-than-=
zero "
> +                             "zone_size");

Missing "ret =3D -EINVAL;".

> +            goto out;
> +        }
> +        s->zoned_header.zoned =3D qcow2_opts->zone_model;
> +        s->zoned_header.zone_size =3D qcow2_opts->zone_size;
> +        s->zoned_header.nr_zones =3D DIV_ROUND_UP(qcow2_opts->size,
> +                                                qcow2_opts->zone_size);
> +
> +        if (qcow2_opts->has_zone_capacity) {
> +            if (qcow2_opts->zone_capacity > qcow2_opts->zone_size) {
> +                s->zoned_header.zoned =3D BLK_Z_NONE;
> +                error_setg(errp, "zone capacity %" PRIu64 "B exceeds zon=
e size "
> +                           "%" PRIu64"B", qcow2_opts->zone_capacity,
> +                           qcow2_opts->zone_size);

Missing "ret =3D -EINVAL;".

> +                goto out;
> +            }
> +            s->zoned_header.zone_capacity =3D qcow2_opts->zone_capacity;
> +        } else {
> +            s->zoned_header.zone_capacity =3D qcow2_opts->zone_size;
> +        }
> +
> +        if (qcow2_opts->has_nr_conv_zones) {
> +            s->zoned_header.nr_conv_zones =3D qcow2_opts->nr_conv_zones;
> +        }
> +
> +        if (qcow2_opts->has_max_active_zones) {
> +            if (qcow2_opts->max_open_zones > qcow2_opts->max_active_zone=
s) {
> +                s->zoned_header.zoned =3D BLK_Z_NONE;
> +                error_setg(errp, "max_open_zones %" PRIu32 " exceeds "
> +                           "max_active_zones %" PRIu32"",
> +                           qcow2_opts->max_open_zones,
> +                           qcow2_opts->max_active_zones);

Missing "ret =3D -EINVAL;".

> +                goto out;
> +            }
> +            if (qcow2_opts->has_max_open_zones) {
> +                s->zoned_header.max_open_zones =3D qcow2_opts->max_activ=
e_zones;
> +            } else {
> +                s->zoned_header.max_open_zones =3D qcow2_opts->max_activ=
e_zones;
> +            }
> +        }
> +        s->zoned_header.max_append_sectors =3D qcow2_opts->max_append_se=
ctors;
> +    } else {
> +        s->zoned_header.zoned =3D BLK_Z_NONE;
> +    }
> +
>      /* Create a full header (including things like feature table) */
>      ret =3D qcow2_update_header(blk_bs(blk));
>      bdrv_graph_co_rdunlock();
> @@ -3903,6 +4035,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char =
*filename, QemuOpts *opts,
>          { BLOCK_OPT_COMPAT_LEVEL,       "version" },
>          { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
>          { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
> +        { BLOCK_OPT_Z_MODEL,            "zone-model"},
> +        { BLOCK_OPT_Z_NR_COV,           "nr-conv-zones"},
> +        { BLOCK_OPT_Z_MOZ,              "max-open-zones"},
> +        { BLOCK_OPT_Z_MAZ,              "max-active-zones"},
> +        { BLOCK_OPT_Z_MAS,              "max-append-sectors"},
> +        { BLOCK_OPT_Z_SIZE,             "zone-size"},
> +        { BLOCK_OPT_Z_CAP,              "zone-capacity"},
>          { NULL, NULL },
>      };
> =20
> @@ -6066,6 +6205,41 @@ static QemuOptsList qcow2_create_opts =3D {
>              .help =3D "Compression method used for image cluster "      =
  \
>                      "compression",                                      \
>              .def_value_str =3D "zlib"                                   =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_Z_MODEL,                                =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "zone model",                                     =
 \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_Z_SIZE,                                 =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "zone size",                                      =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_Z_CAP,                                  =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "zone capacity",                                  =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_Z_NR_COV,                               =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "numbers of conventional zones",                  =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_Z_MAS,                                  =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "max append sectors",                             =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_Z_MAZ,                                  =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "max active zones",                               =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_Z_MOZ,                                  =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "max open zones",                                 =
  \
>          },
>          QCOW_COMMON_OPTIONS,
>          { /* end of list */ }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index f789ce3ae0..edb8eebcb3 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -236,6 +236,19 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> =20
> +typedef struct Qcow2ZonedHeaderExtension {
> +    /* Zoned device attributes */
> +    uint8_t zoned;
> +    uint8_t reserved[3];
> +    uint32_t zone_size;
> +    uint32_t zone_capacity;
> +    uint32_t nr_conv_zones;
> +    uint32_t nr_zones;
> +    uint32_t max_active_zones;
> +    uint32_t max_open_zones;
> +    uint32_t max_append_sectors;
> +} QEMU_PACKED Qcow2ZonedHeaderExtension;
> +
>  typedef struct Qcow2UnknownHeaderExtension {
>      uint32_t magic;
>      uint32_t len;
> @@ -422,6 +435,13 @@ typedef struct BDRVQcow2State {
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

How does this relate to bs->wps? I think I've asked about this before.
I wonder if it's possible to avoid duplicating this field in two
structs.

>  } BDRVQcow2State;
> =20
>  typedef struct Qcow2COWRegion {
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 2c4618375a..80ff03a826 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -331,6 +331,42 @@ The fields of the bitmaps extension are:
>                     Offset into the image file at which the bitmap direct=
ory
>                     starts. Must be aligned to a cluster boundary.
> =20
> +=3D=3D Zoned extension =3D=3D
> +
> +The zoned extension is an optional header extension. It contains fields =
for
> +emulating the zoned stroage model (https://zonedstorage.io/).
> +
> +The fields of the zoned extension are:
> +    Byte        0:  zoned
> +                    Zoned model, 1 for host-managed and 0 for non-zoned =
devices.
> +
> +            1 - 3:  Reserved, must be zero.
> +
> +            4 - 7:  zone_size
> +                    Total number of logical blocks within the zones in b=
ytes.
> +
> +           8 - 11:  zone_capacity
> +                    The number of writable logical blocks within the zon=
es in
> +                    bytes. A zone capacity is always smaller or equal to=
 the
> +                    zone size.
> +
> +          12 - 15:  nr_conv_zones
> +                    The number of conventional zones.
> +
> +          16 - 19:  nr_zones
> +                    The number of zones.
> +
> +          20 - 23:  max_active_zones
> +                    The limit of the zones that have the implicit open,
> +                    explicit open or closed state.
> +
> +          24 - 27:  max_open_zones
> +                    The maximal allowed open zones.
> +
> +          28 - 35:  max_append_sectors
> +                    The maximal data size in sectors of a zone

512-byte sectors? Please clarify the size of the sectors.

> +                    append request that can be issued to the device.
> +
>  =3D=3D Full disk encryption header pointer =3D=3D
> =20
>  The full disk encryption header must be present if, and only if, the
> diff --git a/include/block/block_int-common.h b/include/block/block_int-c=
ommon.h
> index 74195c3004..332c0c765c 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -57,6 +57,13 @@
>  #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
>  #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
>  #define BLOCK_OPT_EXTL2             "extended_l2"
> +#define BLOCK_OPT_Z_MODEL           "zone_model"
> +#define BLOCK_OPT_Z_SIZE            "zone_size"
> +#define BLOCK_OPT_Z_CAP             "zone_capacity"
> +#define BLOCK_OPT_Z_NR_COV          "nr_conv_zones"
> +#define BLOCK_OPT_Z_MAS             "max_append_sectors"
> +#define BLOCK_OPT_Z_MAZ             "max_active_zones"
> +#define BLOCK_OPT_Z_MOZ             "max_open_zones"
> =20
>  #define BLOCK_PROBE_BUF_SIZE        512
> =20
> @@ -878,6 +885,12 @@ typedef struct BlockLimits {
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
> index 2b1d493d6e..0d8f9e0a88 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5021,6 +5021,27 @@
>  # @compression-type: The image cluster compression method
>  #     (default: zlib, since 5.1)
>  #
> +# @zone-model: Zoned device model, 1 for host-managed and 0 for
> +#     non-zoned devices (default: 0, since 8.0)
> +#
> +# @zone-size: Total number of logical blocks within zones in bytes
> +#     (since 8.0)
> +#
> +# @zone-capacity: The number of usable logical blocks within zones
> +#     in bytes. A zone capacity is always smaller or equal to the
> +#     zone size. (since 8.0)
> +#
> +# @nr-conv-zones: The number of conventional zones of the zoned device
> +#     (since 8.0)
> +#
> +# @max-open-zones: The maximal allowed open zones (since 8.0)
> +#
> +# @max-active-zones: The limit of the zones that have the implicit
> +#     open, explicit open or closed state (since 8.0)
> +#
> +# @max-append-sectors: The maximal data size in sectors of a zone
> +#     append request that can be issued to the device. (since 8.0)
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsQcow2',
> @@ -5037,7 +5058,14 @@
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
>              '*refcount-bits':   'int',
> -            '*compression-type':'Qcow2CompressionType' } }
> +            '*compression-type':'Qcow2CompressionType',
> +            '*zone-model':         'uint8',
> +            '*zone-size':          'size',
> +            '*zone-capacity':      'size',
> +            '*nr-conv-zones':      'uint32',
> +            '*max-open-zones':     'uint32',
> +            '*max-active-zones':   'uint32',
> +            '*max-append-sectors': 'uint32' } }
> =20
>  ##
>  # @BlockdevCreateOptionsQed:
> --=20
> 2.40.1
>=20

--6iPiwrSgB8Aan2vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUCF7oACgkQnKSrs4Gr
c8jqbggAt3FRmGLpjElL7ria54eM+ufg8iROef0kt1Hq/e7rOmJAB9KjhUC/GDix
hjbvWZJeIHNk7EvaFGf8z4nL7lljSTqhrt6TKOoCzutq2BfE7MjBSp+EjodOfuNj
o6d4q1oN/TFA586zbeS1Cv+qbKpat0wa79yv32u0pvz3QOzILEFVCFQ28OzvoQYZ
JxsQpNSnDuDbpHRrSjGPH98aQ1yn0zmlj+hq3EQan7I1Iftnq8pJp43b02Rzajtb
vZYUEgArKe62KN5e1NH3YZTRj43B3WKaIspvGAT+CeE7IP9PmMLsw3SboeRJwbUF
PUEVU1YdWVtAfGIyz5fl4WLwBLdLNg==
=13+V
-----END PGP SIGNATURE-----

--6iPiwrSgB8Aan2vs--


