Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E0F7DFE5A
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:24:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyknB-0003Yu-2o; Thu, 02 Nov 2023 23:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qykn9-0003Yk-FB
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qykn2-0006BH-Fi
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698981847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+rJ1xM9q5+VC97qe8ShYAcXIokJ4vHXduGXaBF89iJA=;
 b=fazOd2Y7jJ7aMmgR3xhQxYM3lqAVyRYPKypeGgO+We2vRS2JarOqgOJGDO9wA1EfYrKA0a
 Fku39uBHYQOrpz+1F8Yi40bLMkTbpfm8K+28RU4E84V4nwZIMwUSWNsil9ctGhGeHA8ySU
 bqU/Bejnflle1+fbcerZkVzVovSx09I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-7mCxlNaVP5O6Lcp8g4cqDw-1; Thu,
 02 Nov 2023 23:24:05 -0400
X-MC-Unique: 7mCxlNaVP5O6Lcp8g4cqDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F4542808FD0;
 Fri,  3 Nov 2023 03:24:05 +0000 (UTC)
Received: from localhost (unknown [10.39.192.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 912F4502D;
 Fri,  3 Nov 2023 03:24:03 +0000 (UTC)
Date: Thu, 2 Nov 2023 18:19:08 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 dlemoal@kernel.org, hare@suse.de, dmitry.fomichev@wdc.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 2/4] qcow2: add configurations for zoned format
 extension
Message-ID: <20231102101908.GB726730@fedora>
References: <20231030121847.4522-1-faithilikerun@gmail.com>
 <20231030121847.4522-3-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Avbp6PuOo1aanenT"
Content-Disposition: inline
In-Reply-To: <20231030121847.4522-3-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.393, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--Avbp6PuOo1aanenT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 08:18:45PM +0800, Sam Li wrote:
> To configure the zoned format feature on the qcow2 driver, it
> requires settings as: the device size, zone model, zone size,
> zone capacity, number of conventional zones, limits on zone
> resources (max append bytes, max open zones, and max_active_zones).
>=20
> To create a qcow2 file with zoned format, use command like this:
> $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> zone_size=3D64M -o zone_capacity=3D64M -o conventional_zones=3D0 -o
> max_append_bytes=3D4096 -o max_open_zones=3D0 -o max_active_zones=3D0
> -o zone_model=3Dhost-managed
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
>=20
> fix config?
> ---
>  block/qcow2.c                    | 205 ++++++++++++++++++++++++++++++-
>  block/qcow2.h                    |  37 +++++-
>  docs/interop/qcow2.txt           |  67 +++++++++-
>  include/block/block_int-common.h |  13 ++
>  qapi/block-core.json             |  45 ++++++-
>  5 files changed, 362 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index aa01d9e7b5..cd53268ca7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x007a6264
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
> @@ -431,6 +433,63 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
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
> +            if (s->incompatible_features & QCOW2_INCOMPAT_ZONED_FORMAT) {
> +                warn_report("A program lacking zoned format support "
> +                           "may modify this file and zoned metadata are "
> +                           "now considered inconsistent");
> +                error_printf("The zoned metadata is corrupted.\n");
> +            }

This check is not necessary: the code already checks for unknown
incompatible features (QCOW2_INCOMPAT_MASK) in qcow2_do_open().

> +
> +            zoned_ext.zone_size =3D be32_to_cpu(zoned_ext.zone_size);
> +            zoned_ext.zone_capacity =3D be32_to_cpu(zoned_ext.zone_capac=
ity);
> +            zoned_ext.conventional_zones =3D
> +                be32_to_cpu(zoned_ext.conventional_zones);
> +            zoned_ext.nr_zones =3D be32_to_cpu(zoned_ext.nr_zones);
> +            zoned_ext.max_open_zones =3D be32_to_cpu(zoned_ext.max_open_=
zones);
> +            zoned_ext.max_active_zones =3D
> +                be32_to_cpu(zoned_ext.max_active_zones);
> +            zoned_ext.max_append_bytes =3D
> +                be32_to_cpu(zoned_ext.max_append_bytes);
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
> +                                 "is wrong");
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
> @@ -1967,6 +2026,15 @@ static void qcow2_refresh_limits(BlockDriverState =
*bs, Error **errp)
>      }
>      bs->bl.pwrite_zeroes_alignment =3D s->subcluster_size;
>      bs->bl.pdiscard_alignment =3D s->cluster_size;
> +    bs->bl.zoned =3D s->zoned_header.zoned;
> +    bs->bl.nr_zones =3D s->zoned_header.nr_zones;
> +    bs->bl.max_append_sectors =3D s->zoned_header.max_append_bytes
> +        >> BDRV_SECTOR_BITS;
> +    bs->bl.max_active_zones =3D s->zoned_header.max_active_zones;
> +    bs->bl.max_open_zones =3D s->zoned_header.max_open_zones;
> +    bs->bl.zone_size =3D s->zoned_header.zone_size;
> +    bs->bl.zone_capacity =3D s->zoned_header.zone_capacity;
> +    bs->bl.write_granularity =3D BDRV_SECTOR_SIZE;
>  }
> =20
>  static int GRAPH_UNLOCKED
> @@ -3062,6 +3130,11 @@ int qcow2_update_header(BlockDriverState *bs)
>                  .bit  =3D QCOW2_INCOMPAT_EXTL2_BITNR,
>                  .name =3D "extended L2 entries",
>              },
> +            {
> +                .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,
> +                .bit  =3D QCOW2_INCOMPAT_ZONED_FORMAT_BITNR,
> +                .name =3D "zoned format",
> +            },
>              {
>                  .type =3D QCOW2_FEAT_TYPE_COMPATIBLE,
>                  .bit  =3D QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
> @@ -3107,6 +3180,31 @@ int qcow2_update_header(BlockDriverState *bs)
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
> +            .conventional_zones =3D
> +                cpu_to_be32(s->zoned_header.conventional_zones),
> +            .nr_zones           =3D cpu_to_be32(s->zoned_header.nr_zones=
),
> +            .max_open_zones     =3D cpu_to_be32(s->zoned_header.max_open=
_zones),
> +            .max_active_zones   =3D
> +                cpu_to_be32(s->zoned_header.max_active_zones),
> +            .max_append_bytes =3D
> +                cpu_to_be32(s->zoned_header.max_append_bytes)
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
> @@ -3718,6 +3816,10 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>          header->incompatible_features |=3D
>              cpu_to_be64(QCOW2_INCOMPAT_DATA_FILE);
>      }
> +    if (qcow2_opts->zone_model !=3D QCOW2_ZONE_MODEL_HOST_MANAGED) {

Should !=3D be =3D=3D? The incompatible feature bit must be set when the zo=
ne
model is host-managed.

> +        header->incompatible_features |=3D
> +            cpu_to_be64(QCOW2_INCOMPAT_ZONED_FORMAT);
> +    }
>      if (qcow2_opts->data_file_raw) {
>          header->autoclear_features |=3D
>              cpu_to_be64(QCOW2_AUTOCLEAR_DATA_FILE_RAW);
> @@ -3786,11 +3888,70 @@ qcow2_co_create(BlockdevCreateOptions *create_opt=
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
> +    if (qcow2_opts->zone_model =3D=3D QCOW2_ZONE_MODEL_HOST_MANAGED) {
> +        if (!qcow2_opts->has_zone_size) {
> +            error_setg(errp, "Missing zone_size parameter");
> +            ret =3D -EINVAL;
> +            goto out;
> +        }
> +
> +        if (qcow2_opts->zone_size =3D=3D 0) {
> +            s->zoned_header.zoned =3D BLK_Z_NONE;
> +            error_setg(errp, "Zoned devices can not allow a larger-than-=
zero "
> +                             "zone_size");

This error message is confusing. The zone size must be larger than zero
when the zone model is host-managed:

  error_setg(errp, "zone_size must be larger than zero");

> +            ret =3D -EINVAL;
> +            goto out;
> +        }
> +
> +        s->zoned_header.zoned =3D BLK_Z_HM;
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
> +                ret =3D -EINVAL;
> +                goto out;
> +            }
> +            s->zoned_header.zone_capacity =3D qcow2_opts->zone_capacity;
> +        } else {
> +            s->zoned_header.zone_capacity =3D qcow2_opts->zone_size;
> +        }
> +
> +        if (qcow2_opts->has_conventional_zones) {
> +            s->zoned_header.conventional_zones =3D qcow2_opts->conventio=
nal_zones;
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
> +                ret =3D -EINVAL;
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
> +        s->zoned_header.max_append_bytes =3D qcow2_opts->max_append_byte=
s;
> +    } else {
> +        s->zoned_header.zoned =3D BLK_Z_NONE;
> +    }
> +
>      /* Create a full header (including things like feature table) */
>      ret =3D qcow2_update_header(blk_bs(blk));
>      bdrv_graph_co_rdunlock();
> @@ -3921,6 +4082,13 @@ qcow2_co_create_opts(BlockDriver *drv, const char =
*filename, QemuOpts *opts,
>          { BLOCK_OPT_COMPAT_LEVEL,       "version" },
>          { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
>          { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
> +        { BLOCK_OPT_ZONE_MODEL,         "zone-model"},
> +        { BLOCK_OPT_CONVENTIONAL_ZONES, "conventional-zones"},
> +        { BLOCK_OPT_MAX_OPEN_ZONES,     "max-open-zones"},
> +        { BLOCK_OPT_MAX_ACTIVE_ZONES,   "max-active-zones"},
> +        { BLOCK_OPT_MAX_APPEND_BYTES,   "max-append-bytes"},
> +        { BLOCK_OPT_ZONE_SIZE,          "zone-size"},
> +        { BLOCK_OPT_ZONE_CAPACITY,      "zone-capacity"},
>          { NULL, NULL },
>      };
> =20
> @@ -6087,6 +6255,41 @@ static QemuOptsList qcow2_create_opts =3D {
>              .help =3D "Compression method used for image cluster "      =
  \
>                      "compression",                                      \
>              .def_value_str =3D "zlib"                                   =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_ZONE_MODEL,                             =
  \
> +            .type =3D QEMU_OPT_STRING,                                  =
  \
> +            .help =3D "zone model",                                     =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_ZONE_SIZE,                              =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "zone size",                                      =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_ZONE_CAPACITY,                          =
  \
> +            .type =3D QEMU_OPT_SIZE,                                    =
  \
> +            .help =3D "zone capacity",                                  =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_CONVENTIONAL_ZONES,                     =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "numbers of conventional zones",                  =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_MAX_APPEND_BYTES,                       =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "max append bytes",                               =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_MAX_ACTIVE_ZONES,                       =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "max active zones",                               =
  \
> +        },                                                              \
> +        {                                                               \
> +            .name =3D BLOCK_OPT_MAX_OPEN_ZONES,                         =
  \
> +            .type =3D QEMU_OPT_NUMBER,                                  =
  \
> +            .help =3D "max open zones",                                 =
  \
>          },
>          QCOW_COMMON_OPTIONS,
>          { /* end of list */ }
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 29958c512b..6e5d90afd2 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -236,6 +236,27 @@ typedef struct Qcow2CryptoHeaderExtension {
>      uint64_t length;
>  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> =20
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
>      QCOW2_INCOMPAT_DATA_FILE_BITNR  =3D 2,
>      QCOW2_INCOMPAT_COMPRESSION_BITNR =3D 3,
>      QCOW2_INCOMPAT_EXTL2_BITNR      =3D 4,
> +    QCOW2_INCOMPAT_ZONED_FORMAT_BITNR =3D 5,
>      QCOW2_INCOMPAT_DIRTY            =3D 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
>      QCOW2_INCOMPAT_CORRUPT          =3D 1 << QCOW2_INCOMPAT_CORRUPT_BITN=
R,
>      QCOW2_INCOMPAT_DATA_FILE        =3D 1 << QCOW2_INCOMPAT_DATA_FILE_BI=
TNR,
>      QCOW2_INCOMPAT_COMPRESSION      =3D 1 << QCOW2_INCOMPAT_COMPRESSION_=
BITNR,
>      QCOW2_INCOMPAT_EXTL2            =3D 1 << QCOW2_INCOMPAT_EXTL2_BITNR,
> +    QCOW2_INCOMPAT_ZONED_FORMAT     =3D 1 << QCOW2_INCOMPAT_ZONED_FORMAT=
_BITNR,
> =20
>      QCOW2_INCOMPAT_MASK             =3D QCOW2_INCOMPAT_DIRTY
>                                      | QCOW2_INCOMPAT_CORRUPT
>                                      | QCOW2_INCOMPAT_DATA_FILE
>                                      | QCOW2_INCOMPAT_COMPRESSION
> -                                    | QCOW2_INCOMPAT_EXTL2,
> +                                    | QCOW2_INCOMPAT_EXTL2
> +                                    | QCOW2_INCOMPAT_ZONED_FORMAT,
>  };
> =20
>  /* Compatible feature bits */
> @@ -285,7 +309,6 @@ enum {
>      QCOW2_AUTOCLEAR_DATA_FILE_RAW       =3D 1 << QCOW2_AUTOCLEAR_DATA_FI=
LE_RAW_BITNR,
> =20
>      QCOW2_AUTOCLEAR_MASK                =3D QCOW2_AUTOCLEAR_BITMAPS
> -                                        | QCOW2_AUTOCLEAR_DATA_FILE_RAW,

What is the purpose of this change?

>  };
> =20
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
> =20
>  typedef struct Qcow2COWRegion {
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 2c4618375a..b210bc4580 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -125,7 +125,18 @@ the next fields through header_length.
>                                  allows subcluster-based allocation. See =
the
>                                  Extended L2 Entries section for more det=
ails.
> =20
> -                    Bits 5-63:  Reserved (set to 0)
> +                    Bit 5:      Zoned extension bit. If this bit is set =
then
> +                                the file is a zoned device file with
> +                                host-managed model.
> +
> +                                It is unsafe when any qcow2 writer which=
 does
> +                                not understand zone information edits a =
file
> +                                with the zoned extension. The write poin=
ter
> +                                tracking is corrupted between different =
version
> +                                of qcow2 writes. In such cases, the file=
 can
> +                                no longer be seen as a zoned device.

Here is a suggestion for rephrasing this:

  Bit 5:
  Zoned emulation bit.  If this bit is set then the file is an emulated
  zoned device. The Zoned extension must be present. Implementations
  that do not support zoned emulation cannot open this file because it
  generally only makes sense to interpret the data along with the zone
  information and write pointers.

Don't mention the host-managed model in case other zone models are
supported in the future.

> +
> +                    Bits 6-63:  Reserved (set to 0)
> =20
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation can
> @@ -249,6 +260,7 @@ be stored. Each extension has a structure like the fo=
llowing:
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header pointer
>                          0x44415441 - External data file name string
> +                        0x007a6264 - Zoned extension
>                          other      - Unknown header extension, can be sa=
fely
>                                       ignored
> =20
> @@ -331,6 +343,59 @@ The fields of the bitmaps extension are:
>                     Offset into the image file at which the bitmap direct=
ory
>                     starts. Must be aligned to a cluster boundary.
> =20
> +=3D=3D Zoned extension =3D=3D
> +
> +The zoned extension is an optional header extension. It contains fields =
for
> +emulating the zoned stroage model (https://zonedstorage.io/).

s/stroage/storage/

> +
> +When the device model is not recognized as host-managed, it is regared as

s/regared/regarded/

> +incompatible and report an error to users.
> +
> +The fields of the zoned extension are:
> +    Byte       0:  zoned
> +                   This bit represents zone model of devices. 1 is for
> +                   host-managed, which only allows sequential writes.
> +                   And 0 is for non-zoned devices without such constrain=
ts.
> +
> +          1 -  3:  Reserved, must be zero.
> +
> +          4 -  7:  zone_size
> +                   Total size of each zones, in bytes. It is less than 4=
GB
> +                   in the contained image for simplicity.
> +
> +          8 - 11:  zone_capacity
> +                   The number of writable bytes within the zones.
> +                   A zone capacity is always smaller or equal to the
> +                   zone size.
> +
> +         12 - 15:  conventional_zones
> +                   The number of conventional zones.
> +
> +         16 - 19:  nr_zones
> +                   The number of zones. It is the sum of conventional zo=
nes
> +                   and sequential zones.
> +
> +         20 - 23:  max_active_zones
> +                   The number of the zones that are in the implicit open,
> +                   explicit open or closed state.
> +
> +         24 - 27:  max_open_zones
> +                   The maximal number of open (implicitly open or explic=
itly
> +                   open) zones.
> +
> +         28 - 31:  max_append_bytes
> +                   The number of bytes of a zone append request that can=
 be
> +                   issued to the device. It must be 512-byte aligned.
> +
> +         32 - 39:  zonedmeta_size
> +                   The size of zoned metadata in bytes. It contains no m=
ore
> +                   than 4GB. The zoned metadata structure is the write
> +                   pointers for each zone.
> +
> +         40 - 47:  zonedmeta_offset
> +                   The offset of zoned metadata structure in the contain=
ed
> +                   image, in bytes.
> +
>  =3D=3D Full disk encryption header pointer =3D=3D
> =20
>  The full disk encryption header must be present if, and only if, the
> diff --git a/include/block/block_int-common.h b/include/block/block_int-c=
ommon.h
> index b8d9d24f39..4b94e55eb4 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -57,6 +57,13 @@
>  #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
>  #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
>  #define BLOCK_OPT_EXTL2             "extended_l2"
> +#define BLOCK_OPT_ZONE_MODEL        "zone_model"
> +#define BLOCK_OPT_ZONE_SIZE         "zone_size"
> +#define BLOCK_OPT_ZONE_CAPACITY     "zone_capacity"
> +#define BLOCK_OPT_CONVENTIONAL_ZONES    "conventional_zones"
> +#define BLOCK_OPT_MAX_APPEND_BYTES      "max_append_bytes"
> +#define BLOCK_OPT_MAX_ACTIVE_ZONES      "max_active_zones"
> +#define BLOCK_OPT_MAX_OPEN_ZONES        "max_open_zones"
> =20
>  #define BLOCK_PROBE_BUF_SIZE        512
> =20
> @@ -883,6 +890,12 @@ typedef struct BlockLimits {
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
> index 89751d81f2..884e058046 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4981,6 +4981,21 @@
>  { 'enum': 'Qcow2CompressionType',
>    'data': [ 'zlib', { 'name': 'zstd', 'if': 'CONFIG_ZSTD' } ] }
> =20
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
> =20
>  ##
>  # @BlockdevCreateOptionsQed:
> --=20
> 2.40.1
>=20

--Avbp6PuOo1aanenT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVDd5wACgkQnKSrs4Gr
c8iNrAf/W0SOYkkHaRDGVdovObGRh+6rLWLThAQLUYux7r5/mOgt6TG8B8bm93dh
YvwweV9ki1Qu39E5bCcwENI3HIf7L5mpScsbMzWNETnw2p6gEqj4alP0sbIO0nHc
Y8bqTKmRfjv6Pa2ZcrIx2NgkvvDjNpNIAdWl2ce2Ab2HjoOaGt/xKkHMnGl69Yvv
c/TJqmRe+G4tVPMwP79NjnzvZ1VYhGWfqZ6yJQWXaxq8AhqB68tfWXwEKMU1FJPy
0AFLIGaYOMWa0rEttwt4QQ7JNgOQuVLlN/tX9YiwrJvVwr06fBZZoh4FsIonr1pV
Oh6RAH8gUpccDUgx5vjrolObHCyMmg==
=g3i2
-----END PGP SIGNATURE-----

--Avbp6PuOo1aanenT--


