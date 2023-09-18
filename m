Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A21997A453A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:57:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiA3i-0000be-MY; Mon, 18 Sep 2023 04:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiA3K-0000PQ-9K; Mon, 18 Sep 2023 04:56:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qiA3H-0000OD-Hj; Mon, 18 Sep 2023 04:56:22 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9ad8bf9bfabso552561266b.3; 
 Mon, 18 Sep 2023 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695027377; x=1695632177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6ieTysaOP0dGrESVd+SBQdyhtADgZ3b/eqeNOn+F3M=;
 b=XNVBJ16cE9uH+SNF16xc6MLTE1GefseGJd9E3V2wqpFqXRjiaztH+PIQtbbWgjjy6B
 pNIm1TyMGWr10zqIS58DPWSK1/0rzYisWoGYrekU6KGH8eqWP4YWM29m0tY/qIA9ALVr
 ETP/jRE5RIhPnASsRKVD5WIy9W3X/AkvWk7P01erPso8mo3KlbCwBZhJK4gdUYTvhSqs
 evKT8/u1rD6U62lx3zPS09BDgSK2EpZoj7BUyTpoKVSQKPYoehsQntNqrkLD9nZzyHsn
 hggdzyrHv2fqzLjt9+AC1Opcrzh1aEGqDfusyRvT8z7Zwk9dxkb9cVpo4gXZGeq2YmkZ
 PODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695027377; x=1695632177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6ieTysaOP0dGrESVd+SBQdyhtADgZ3b/eqeNOn+F3M=;
 b=pujofMH6/WlEJjxysD4U1H6xYip7gdiZD/Nu4F6cD1IoOpReK//5jotsYAm3tIpyZz
 Yut3RcbK2E7hQG5UOXExB2yEK8dLh3eBLCODpDVgKRs7D+Iz/bhr7OXMkZGSjC3gtpCd
 BCawfZVgMZGw9dYnsEtRkMtmxSxjqn8Gw0noK5/CvvCKks4cgWSnCpkUyYWKTLVKglv2
 hjyA61hlEIWkx5QPSavNquhvVftkzkfJypdwxxkZBH5edO6owaHJHRSxuva9bP1EKn8p
 rIfEn6sf2hZ5pmRdIbSrKPFufL15Vd/CY+mnM1AqnTDSz4R3DR7/OP08sSBVLWHRwrSc
 J6rA==
X-Gm-Message-State: AOJu0YwNfoGpAtocqWck3QUgUf7GUMkmu9dh6hjYc76kbp25AdvLhBrr
 +c4ouZO1ZMtScCr3lIWxR9bVchtdWiVoBl7APyo=
X-Google-Smtp-Source: AGHT+IFZTR3Sbdm2yq1UmIwKP2eRHW1B6oApmvBOdooNNa9sLVeLV5LwGjUnd8byFk/0bioev6Gw7I9Iw1yB3dEonEc=
X-Received: by 2002:a17:906:10ce:b0:9a1:ec69:23ec with SMTP id
 v14-20020a17090610ce00b009a1ec6923ecmr8133927ejv.17.1695027377180; Mon, 18
 Sep 2023 01:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230828150955.3481-1-faithilikerun@gmail.com>
 <20230828150955.3481-3-faithilikerun@gmail.com>
 <20230913201242.GB1313843@fedora>
In-Reply-To: <20230913201242.GB1313843@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 18 Sep 2023 16:55:50 +0800
Message-ID: <CAAAx-8JyBbG4q1EU4ZNZBKi_qkhucnxVibLOQZx2mKXJY3y=hQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] qcow2: add configurations for zoned format
 extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 dmitry.fomichev@wdc.com, 
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 hare@suse.de, qemu-block@nongnu.org, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8814=E6=
=97=A5=E5=91=A8=E5=9B=9B 04:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 28, 2023 at 11:09:53PM +0800, Sam Li wrote:
> > To configure the zoned format feature on the qcow2 driver, it
> > requires following arguments: the device size, zoned profile,
> > zone model, zone size, zone capacity, number of conventional
> > zones, limits on zone resources (max append sectors, max open
> > zones, and max_active_zones).
> >
> > To create a qcow2 file with zoned format, use command like this:
> > $ qemu-img create -f qcow2 test.qcow2 -o size=3D768M -o
> > zone_size=3D64M -o zone_capacity=3D64M -o nr_conv_zones=3D0 -o
> > max_append_sectors=3D512 -o max_open_zones=3D0 -o max_active_zones=3D0
> > -o zone_model=3D1
> >
> > Signed-off-by: Sam Li <faithilikerun@gmail.com>
> > ---
> >  block/qcow2.c                    | 176 ++++++++++++++++++++++++++++++-
> >  block/qcow2.h                    |  20 ++++
> >  docs/interop/qcow2.txt           |  36 +++++++
> >  include/block/block_int-common.h |  13 +++
> >  qapi/block-core.json             |  30 +++++-
> >  5 files changed, 273 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index c51388e99d..7074bfc620 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -73,6 +73,7 @@ typedef struct {
> >  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
> >  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> >  #define  QCOW2_EXT_MAGIC_DATA_FILE 0x44415441
> > +#define  QCOW2_EXT_MAGIC_ZONED_FORMAT 0x7a6264
> >
> >  static int coroutine_fn
> >  qcow2_co_preadv_compressed(BlockDriverState *bs,
> > @@ -210,6 +211,7 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_=
t start_offset,
> >      uint64_t offset;
> >      int ret;
> >      Qcow2BitmapHeaderExt bitmaps_ext;
> > +    Qcow2ZonedHeaderExtension zoned_ext;
> >
> >      if (need_update_header !=3D NULL) {
> >          *need_update_header =3D false;
> > @@ -431,6 +433,55 @@ qcow2_read_extensions(BlockDriverState *bs, uint64=
_t start_offset,
> >              break;
> >          }
> >
> > +        case QCOW2_EXT_MAGIC_ZONED_FORMAT:
> > +        {
> > +            if (ext.len !=3D sizeof(zoned_ext)) {
> > +                error_setg(errp, "zoned_ext: Invalid extension length"=
);
> > +                return -EINVAL;
> > +            }
> > +            ret =3D bdrv_pread(bs->file, offset, ext.len, &zoned_ext, =
0);
> > +            if (ret < 0) {
> > +                error_setg_errno(errp, -ret, "zoned_ext: "
> > +                                             "Could not read ext heade=
r");
> > +                return ret;
> > +            }
> > +
> > +            zoned_ext.zone_size =3D be32_to_cpu(zoned_ext.zone_size);
> > +            zoned_ext.zone_capacity =3D be32_to_cpu(zoned_ext.zone_cap=
acity);
> > +            zoned_ext.nr_conv_zones =3D be32_to_cpu(zoned_ext.nr_conv_=
zones);
> > +            zoned_ext.nr_zones =3D be32_to_cpu(zoned_ext.nr_zones);
> > +            zoned_ext.max_open_zones =3D be32_to_cpu(zoned_ext.max_ope=
n_zones);
> > +            zoned_ext.max_active_zones =3D
> > +                be32_to_cpu(zoned_ext.max_active_zones);
> > +            zoned_ext.max_append_sectors =3D
> > +                be32_to_cpu(zoned_ext.max_append_sectors);
> > +            s->zoned_header =3D zoned_ext;
> > +
> > +            /* refuse to open broken images */
> > +            if (zoned_ext.zone_size =3D=3D 0) {
> > +                error_setg(errp, "Zoned extension header zone_size fie=
ld "
> > +                                 "can not be 0");
> > +                return -EINVAL;
> > +            }
> > +            if (zoned_ext.zone_capacity > zoned_ext.zone_size) {
> > +                error_setg(errp, "Zoned extension header zone_capacity=
 field "
> > +                                 "can not be larger that zone_size fie=
ld");
> > +                return -EINVAL;
> > +            }
> > +            if (zoned_ext.nr_zones !=3D DIV_ROUND_UP(
> > +                bs->total_sectors * BDRV_SECTOR_SIZE, zoned_ext.zone_s=
ize)) {
> > +                error_setg(errp, "Zoned extension header nr_zones fiel=
d "
> > +                                 "gets wrong");
>
> "gets" -> "is"
>
> > +                return -EINVAL;
> > +            }
> > +
> > +#ifdef DEBUG_EXT
> > +            printf("Qcow2: Got zoned format extension: "
> > +                   "offset=3D%" PRIu32 "\n", offset);
> > +#endif
> > +            break;
> > +        }
> > +
> >          default:
> >              /* unknown magic - save it in case we need to rewrite the =
header */
> >              /* If you add a new feature, make sure to also update the =
fast
> > @@ -1967,6 +2018,14 @@ static void qcow2_refresh_limits(BlockDriverStat=
e *bs, Error **errp)
> >      }
> >      bs->bl.pwrite_zeroes_alignment =3D s->subcluster_size;
> >      bs->bl.pdiscard_alignment =3D s->cluster_size;
> > +    bs->bl.zoned =3D s->zoned_header.zoned;
> > +    bs->bl.nr_zones =3D s->zoned_header.nr_zones;
> > +    bs->wps =3D s->wps;
> > +    bs->bl.max_append_sectors =3D s->zoned_header.max_append_sectors;
> > +    bs->bl.max_active_zones =3D s->zoned_header.max_active_zones;
> > +    bs->bl.max_open_zones =3D s->zoned_header.max_open_zones;
> > +    bs->bl.zone_size =3D s->zoned_header.zone_size;
> > +    bs->bl.write_granularity =3D BDRV_SECTOR_SIZE;
> >  }
> >
> >  static int qcow2_reopen_prepare(BDRVReopenState *state,
> > @@ -3089,6 +3148,30 @@ int qcow2_update_header(BlockDriverState *bs)
> >          buflen -=3D ret;
> >      }
> >
> > +    /* Zoned devices header extension */
> > +    if (s->zoned_header.zoned =3D=3D BLK_Z_HM) {
> > +        Qcow2ZonedHeaderExtension zoned_header =3D {
> > +            .zoned              =3D s->zoned_header.zoned,
> > +            .zone_size          =3D cpu_to_be32(s->zoned_header.zone_s=
ize),
> > +            .zone_capacity      =3D cpu_to_be32(s->zoned_header.zone_c=
apacity),
> > +            .nr_conv_zones      =3D cpu_to_be32(s->zoned_header.nr_con=
v_zones),
> > +            .nr_zones           =3D cpu_to_be32(s->zoned_header.nr_zon=
es),
> > +            .max_open_zones     =3D cpu_to_be32(s->zoned_header.max_op=
en_zones),
> > +            .max_active_zones   =3D
> > +                cpu_to_be32(s->zoned_header.max_active_zones),
> > +            .max_append_sectors =3D
> > +                cpu_to_be32(s->zoned_header.max_append_sectors)
> > +        };
> > +        ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
> > +                             &zoned_header, sizeof(zoned_header),
> > +                             buflen);
> > +        if (ret < 0) {
> > +            goto fail;
> > +        }
> > +        buf +=3D ret;
> > +        buflen -=3D ret;
> > +    }
> > +
> >      /* Keep unknown header extensions */
> >      QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
> >          ret =3D header_ext_add(buf, uext->magic, uext->data, uext->len=
, buflen);
> > @@ -3768,11 +3851,60 @@ qcow2_co_create(BlockdevCreateOptions *create_o=
ptions, Error **errp)
> >      }
> >
> >      /* Set the external data file if necessary */
> > +    BDRVQcow2State *s =3D blk_bs(blk)->opaque;
> >      if (data_bs) {
> > -        BDRVQcow2State *s =3D blk_bs(blk)->opaque;
> >          s->image_data_file =3D g_strdup(data_bs->filename);
> >      }
> >
> > +    if (qcow2_opts->has_zone_model && qcow2_opts->zone_model =3D=3D BL=
K_Z_HM) {
> > +        if (qcow2_opts->has_zone_size && qcow2_opts->zone_size =3D=3D =
0) {
>
> has_zone_size is mandatory:
>
>   if (!qcow2_opts->has_zone_size) {
>       error_setg(errp, "Missing zone_size parameter");
>       ret =3D -EINVAL;
>       goto out;
>   }
>   ...
>
> > +            s->zoned_header.zoned =3D BLK_Z_NONE;
> > +            error_setg(errp, "Zoned devices can not allow a larger-tha=
n-zero "
> > +                             "zone_size");
>
> Missing "ret =3D -EINVAL;".
>
> > +            goto out;
> > +        }
> > +        s->zoned_header.zoned =3D qcow2_opts->zone_model;
> > +        s->zoned_header.zone_size =3D qcow2_opts->zone_size;
> > +        s->zoned_header.nr_zones =3D DIV_ROUND_UP(qcow2_opts->size,
> > +                                                qcow2_opts->zone_size)=
;
> > +
> > +        if (qcow2_opts->has_zone_capacity) {
> > +            if (qcow2_opts->zone_capacity > qcow2_opts->zone_size) {
> > +                s->zoned_header.zoned =3D BLK_Z_NONE;
> > +                error_setg(errp, "zone capacity %" PRIu64 "B exceeds z=
one size "
> > +                           "%" PRIu64"B", qcow2_opts->zone_capacity,
> > +                           qcow2_opts->zone_size);
>
> Missing "ret =3D -EINVAL;".
>
> > +                goto out;
> > +            }
> > +            s->zoned_header.zone_capacity =3D qcow2_opts->zone_capacit=
y;
> > +        } else {
> > +            s->zoned_header.zone_capacity =3D qcow2_opts->zone_size;
> > +        }
> > +
> > +        if (qcow2_opts->has_nr_conv_zones) {
> > +            s->zoned_header.nr_conv_zones =3D qcow2_opts->nr_conv_zone=
s;
> > +        }
> > +
> > +        if (qcow2_opts->has_max_active_zones) {
> > +            if (qcow2_opts->max_open_zones > qcow2_opts->max_active_zo=
nes) {
> > +                s->zoned_header.zoned =3D BLK_Z_NONE;
> > +                error_setg(errp, "max_open_zones %" PRIu32 " exceeds "
> > +                           "max_active_zones %" PRIu32"",
> > +                           qcow2_opts->max_open_zones,
> > +                           qcow2_opts->max_active_zones);
>
> Missing "ret =3D -EINVAL;".
>
> > +                goto out;
> > +            }
> > +            if (qcow2_opts->has_max_open_zones) {
> > +                s->zoned_header.max_open_zones =3D qcow2_opts->max_act=
ive_zones;
> > +            } else {
> > +                s->zoned_header.max_open_zones =3D qcow2_opts->max_act=
ive_zones;
> > +            }
> > +        }
> > +        s->zoned_header.max_append_sectors =3D qcow2_opts->max_append_=
sectors;
> > +    } else {
> > +        s->zoned_header.zoned =3D BLK_Z_NONE;
> > +    }
> > +
> >      /* Create a full header (including things like feature table) */
> >      ret =3D qcow2_update_header(blk_bs(blk));
> >      bdrv_graph_co_rdunlock();
> > @@ -3903,6 +4035,13 @@ qcow2_co_create_opts(BlockDriver *drv, const cha=
r *filename, QemuOpts *opts,
> >          { BLOCK_OPT_COMPAT_LEVEL,       "version" },
> >          { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
> >          { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
> > +        { BLOCK_OPT_Z_MODEL,            "zone-model"},
> > +        { BLOCK_OPT_Z_NR_COV,           "nr-conv-zones"},
> > +        { BLOCK_OPT_Z_MOZ,              "max-open-zones"},
> > +        { BLOCK_OPT_Z_MAZ,              "max-active-zones"},
> > +        { BLOCK_OPT_Z_MAS,              "max-append-sectors"},
> > +        { BLOCK_OPT_Z_SIZE,             "zone-size"},
> > +        { BLOCK_OPT_Z_CAP,              "zone-capacity"},
> >          { NULL, NULL },
> >      };
> >
> > @@ -6066,6 +6205,41 @@ static QemuOptsList qcow2_create_opts =3D {
> >              .help =3D "Compression method used for image cluster "    =
    \
> >                      "compression",                                    =
  \
> >              .def_value_str =3D "zlib"                                 =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_Z_MODEL,                              =
    \
> > +            .type =3D QEMU_OPT_NUMBER,                                =
    \
> > +            .help =3D "zone model",                                   =
   \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_Z_SIZE,                               =
    \
> > +            .type =3D QEMU_OPT_SIZE,                                  =
    \
> > +            .help =3D "zone size",                                    =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_Z_CAP,                                =
    \
> > +            .type =3D QEMU_OPT_SIZE,                                  =
    \
> > +            .help =3D "zone capacity",                                =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_Z_NR_COV,                             =
    \
> > +            .type =3D QEMU_OPT_NUMBER,                                =
    \
> > +            .help =3D "numbers of conventional zones",                =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_Z_MAS,                                =
    \
> > +            .type =3D QEMU_OPT_NUMBER,                                =
    \
> > +            .help =3D "max append sectors",                           =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_Z_MAZ,                                =
    \
> > +            .type =3D QEMU_OPT_NUMBER,                                =
    \
> > +            .help =3D "max active zones",                             =
    \
> > +        },                                                            =
  \
> > +        {                                                             =
  \
> > +            .name =3D BLOCK_OPT_Z_MOZ,                                =
    \
> > +            .type =3D QEMU_OPT_NUMBER,                                =
    \
> > +            .help =3D "max open zones",                               =
    \
> >          },
> >          QCOW_COMMON_OPTIONS,
> >          { /* end of list */ }
> > diff --git a/block/qcow2.h b/block/qcow2.h
> > index f789ce3ae0..edb8eebcb3 100644
> > --- a/block/qcow2.h
> > +++ b/block/qcow2.h
> > @@ -236,6 +236,19 @@ typedef struct Qcow2CryptoHeaderExtension {
> >      uint64_t length;
> >  } QEMU_PACKED Qcow2CryptoHeaderExtension;
> >
> > +typedef struct Qcow2ZonedHeaderExtension {
> > +    /* Zoned device attributes */
> > +    uint8_t zoned;
> > +    uint8_t reserved[3];
> > +    uint32_t zone_size;
> > +    uint32_t zone_capacity;
> > +    uint32_t nr_conv_zones;
> > +    uint32_t nr_zones;
> > +    uint32_t max_active_zones;
> > +    uint32_t max_open_zones;
> > +    uint32_t max_append_sectors;
> > +} QEMU_PACKED Qcow2ZonedHeaderExtension;
> > +
> >  typedef struct Qcow2UnknownHeaderExtension {
> >      uint32_t magic;
> >      uint32_t len;
> > @@ -422,6 +435,13 @@ typedef struct BDRVQcow2State {
> >       * is to convert the image with the desired compression type set.
> >       */
> >      Qcow2CompressionType compression_type;
> > +
> > +    /* States of zoned device */
> > +    Qcow2ZonedHeaderExtension zoned_header;
> > +    uint32_t nr_zones_exp_open;
> > +    uint32_t nr_zones_imp_open;
> > +    uint32_t nr_zones_closed;
> > +    BlockZoneWps *wps;
>
> How does this relate to bs->wps? I think I've asked about this before.
> I wonder if it's possible to avoid duplicating this field in two
> structs.

This field is used for storing write pointers in the metadata.
"bs->wps" reads/writes wp from/to this field. I can only remove
"s->wps" in BDRVQcow2State while maintaining wp tracking.

219:    zone_wp =3D bs->wps->wp[index];
343:    memcpy(bs->wps->wp, temp, wps_size);
612:            bs->wps =3D g_malloc(sizeof(BlockZoneWps)
629:            qemu_co_mutex_init(&bs->wps->colock);

>
> >  } BDRVQcow2State;
> >
> >  typedef struct Qcow2COWRegion {
> > diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> > index 2c4618375a..80ff03a826 100644
> > --- a/docs/interop/qcow2.txt
> > +++ b/docs/interop/qcow2.txt
> > @@ -331,6 +331,42 @@ The fields of the bitmaps extension are:
> >                     Offset into the image file at which the bitmap dire=
ctory
> >                     starts. Must be aligned to a cluster boundary.
> >
> > +=3D=3D Zoned extension =3D=3D
> > +
> > +The zoned extension is an optional header extension. It contains field=
s for
> > +emulating the zoned stroage model (https://zonedstorage.io/).
> > +
> > +The fields of the zoned extension are:
> > +    Byte        0:  zoned
> > +                    Zoned model, 1 for host-managed and 0 for non-zone=
d devices.
> > +
> > +            1 - 3:  Reserved, must be zero.
> > +
> > +            4 - 7:  zone_size
> > +                    Total number of logical blocks within the zones in=
 bytes.
> > +
> > +           8 - 11:  zone_capacity
> > +                    The number of writable logical blocks within the z=
ones in
> > +                    bytes. A zone capacity is always smaller or equal =
to the
> > +                    zone size.
> > +
> > +          12 - 15:  nr_conv_zones
> > +                    The number of conventional zones.
> > +
> > +          16 - 19:  nr_zones
> > +                    The number of zones.
> > +
> > +          20 - 23:  max_active_zones
> > +                    The limit of the zones that have the implicit open=
,
> > +                    explicit open or closed state.
> > +
> > +          24 - 27:  max_open_zones
> > +                    The maximal allowed open zones.
> > +
> > +          28 - 35:  max_append_sectors
> > +                    The maximal data size in sectors of a zone
>
> 512-byte sectors? Please clarify the size of the sectors.
>
> > +                    append request that can be issued to the device.
> > +
> >  =3D=3D Full disk encryption header pointer =3D=3D
> >
> >  The full disk encryption header must be present if, and only if, the
> > diff --git a/include/block/block_int-common.h b/include/block/block_int=
-common.h
> > index 74195c3004..332c0c765c 100644
> > --- a/include/block/block_int-common.h
> > +++ b/include/block/block_int-common.h
> > @@ -57,6 +57,13 @@
> >  #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
> >  #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
> >  #define BLOCK_OPT_EXTL2             "extended_l2"
> > +#define BLOCK_OPT_Z_MODEL           "zone_model"
> > +#define BLOCK_OPT_Z_SIZE            "zone_size"
> > +#define BLOCK_OPT_Z_CAP             "zone_capacity"
> > +#define BLOCK_OPT_Z_NR_COV          "nr_conv_zones"
> > +#define BLOCK_OPT_Z_MAS             "max_append_sectors"
> > +#define BLOCK_OPT_Z_MAZ             "max_active_zones"
> > +#define BLOCK_OPT_Z_MOZ             "max_open_zones"
> >
> >  #define BLOCK_PROBE_BUF_SIZE        512
> >
> > @@ -878,6 +885,12 @@ typedef struct BlockLimits {
> >      /* zone size expressed in bytes */
> >      uint32_t zone_size;
> >
> > +    /*
> > +     * the number of usable logical blocks within the zone, expressed
> > +     * in bytes. A zone capacity is smaller or equal to the zone size.
> > +     */
> > +    uint32_t zone_capacity;
> > +
> >      /* total number of zones */
> >      uint32_t nr_zones;
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 2b1d493d6e..0d8f9e0a88 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5021,6 +5021,27 @@
> >  # @compression-type: The image cluster compression method
> >  #     (default: zlib, since 5.1)
> >  #
> > +# @zone-model: Zoned device model, 1 for host-managed and 0 for
> > +#     non-zoned devices (default: 0, since 8.0)
> > +#
> > +# @zone-size: Total number of logical blocks within zones in bytes
> > +#     (since 8.0)
> > +#
> > +# @zone-capacity: The number of usable logical blocks within zones
> > +#     in bytes. A zone capacity is always smaller or equal to the
> > +#     zone size. (since 8.0)
> > +#
> > +# @nr-conv-zones: The number of conventional zones of the zoned device
> > +#     (since 8.0)
> > +#
> > +# @max-open-zones: The maximal allowed open zones (since 8.0)
> > +#
> > +# @max-active-zones: The limit of the zones that have the implicit
> > +#     open, explicit open or closed state (since 8.0)
> > +#
> > +# @max-append-sectors: The maximal data size in sectors of a zone
> > +#     append request that can be issued to the device. (since 8.0)
> > +#
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsQcow2',
> > @@ -5037,7 +5058,14 @@
> >              '*preallocation':   'PreallocMode',
> >              '*lazy-refcounts':  'bool',
> >              '*refcount-bits':   'int',
> > -            '*compression-type':'Qcow2CompressionType' } }
> > +            '*compression-type':'Qcow2CompressionType',
> > +            '*zone-model':         'uint8',
> > +            '*zone-size':          'size',
> > +            '*zone-capacity':      'size',
> > +            '*nr-conv-zones':      'uint32',
> > +            '*max-open-zones':     'uint32',
> > +            '*max-active-zones':   'uint32',
> > +            '*max-append-sectors': 'uint32' } }
> >
> >  ##
> >  # @BlockdevCreateOptionsQed:
> > --
> > 2.40.1
> >

