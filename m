Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88047359B7
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFzN-0002mL-S0; Mon, 19 Jun 2023 10:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBFzK-0002il-Nd
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qBFzH-0004y3-Hb
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687185370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0NfF6D3uUwLXWPvrJ8P2RESyxYnwDRuVRRAQJCRHDk=;
 b=ijrWYWe5AEMMhYA2lChIA/zpODMxSebmnCaL7/QXc2m2FCTTBiTWyAl8ihbN4m+RAfZC40
 0VifFXR9xrxywQi8sMo91tRjyNOq1SKvXs9OP5BQ7/cP03acSrr/2m2UiSGkIR8LquN5Dg
 uTXJUx3yZF3OLyd7nuSa5sB4BYwDey4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-nriPIhwwMgSCblrxQZxRUg-1; Mon, 19 Jun 2023 10:36:01 -0400
X-MC-Unique: nriPIhwwMgSCblrxQZxRUg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E192A101A531;
 Mon, 19 Jun 2023 14:36:00 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45EC740D1C9;
 Mon, 19 Jun 2023 14:35:59 +0000 (UTC)
Date: Mon, 19 Jun 2023 16:35:59 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [RFC 3/4] qcow2: add zoned emulation capability
Message-ID: <20230619143559.GD2497337@fedora>
References: <20230605104108.125270-1-faithilikerun@gmail.com>
 <20230605104108.125270-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0hexIrUZTUZhBE/4"
Content-Disposition: inline
In-Reply-To: <20230605104108.125270-4-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--0hexIrUZTUZhBE/4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 06:41:07PM +0800, Sam Li wrote:
> By adding zone operations and zoned metadata, the zoned emulation
> capability enables full emulation support of zoned device using
> a qcow2 file. The zoned device metadata includes zone type,
> zoned device state and write pointer of each zone, which is stored
> to an array of unsigned integers.
>=20
> Each zone of a zoned device makes state transitions following
> the zone state machine. The zone state machine mainly describes
> five states, IMPLICIT OPEN, EXPLICIT OPEN, FULL, EMPTY and CLOSED.
> READ ONLY and OFFLINE states will generally be affected by device
> internal events. The operations on zones cause corresponding state
> changing.
>=20
> Zoned devices have a limit on zone resources, which puts constraints on
> write operations into zones.
>=20
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  block/qcow2.c | 629 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  block/qcow2.h |   2 +
>  2 files changed, 629 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b886dab42b..f030965d5d 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -194,6 +194,164 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const cha=
r *fmt, Error **errp)
>      return cryptoopts_qdict;
>  }
> =20
> +#define QCOW2_ZT_IS_CONV(wp)    (wp & 1ULL << 59)
> +
> +static inline int qcow2_get_wp(uint64_t wp)
> +{
> +    /* clear state and type information */
> +    return ((wp << 5) >> 5);
> +}
> +
> +static inline int qcow2_get_zs(uint64_t wp)
> +{
> +    return (wp >> 60);
> +}
> +
> +static inline void qcow2_set_wp(uint64_t *wp, BlockZoneState zs)
> +{
> +    uint64_t addr =3D qcow2_get_wp(*wp);
> +    addr |=3D ((uint64_t)zs << 60);
> +    *wp =3D addr;
> +}
> +
> +/*
> + * File wp tracking: reset zone, finish zone and append zone can
> + * change the value of write pointer. All zone operations will change
> + * the state of that/those zone.
> + * */
> +static inline void qcow2_wp_tracking_helper(int index, uint64_t wp) {
> +    /* format: operations, the wp. */
> +    printf("wps[%d]: 0x%x\n", index, qcow2_get_wp(wp)>>BDRV_SECTOR_BITS);
> +}
> +
> +/*
> + * Perform a state assignment and a flush operation that writes the new =
wp
> + * value to the dedicated location of the disk file.
> + */
> +static int qcow2_write_wp_at(BlockDriverState *bs, uint64_t *wp,
> +                             uint32_t index, BlockZoneState zs) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    qcow2_set_wp(wp, zs);
> +    ret =3D bdrv_pwrite(bs->file, s->zoned_header.zonedmeta_offset
> +        + sizeof(uint64_t) * index, sizeof(uint64_t), wp, 0);
> +
> +    if (ret < 0) {
> +        goto exit;
> +    }
> +    qcow2_wp_tracking_helper(index, *wp);
> +    return ret;
> +
> +exit:
> +    error_report("Failed to write metadata with file");
> +    return ret;
> +}
> +
> +static int qcow2_check_active(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +
> +    if (!s->zoned_header.max_active_zones) {
> +        return 0;
> +    }
> +
> +    if (s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_closed
> +        < s->zoned_header.max_active_zones) {
> +        return 0;
> +    }
> +
> +    return -1;
> +}
> +
> +static int qcow2_check_open(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    if (!s->zoned_header.max_open_zones) {
> +        return 0;
> +    }
> +
> +    if (s->nr_zones_exp_open + s->nr_zones_imp_open
> +        < s->zoned_header.max_open_zones) {
> +        return 0;
> +    }
> +
> +    if(s->nr_zones_imp_open) {
> +        ret =3D qcow2_check_active(bs);
> +        if (ret =3D=3D 0) {
> +            /* TODO: it takes O(n) time complexity (n =3D nr_zones).
> +             * Optimizations required. */
> +            /* close one implicitly open zones to make it available */
> +            for (int i =3D s->zoned_header.zone_nr_conv;
> +            i < bs->bl.nr_zones; ++i) {
> +                uint64_t *wp =3D &s->wps->wp[i];
> +                if (qcow2_get_zs(*wp) =3D=3D BLK_ZS_IOPEN) {
> +                    ret =3D qcow2_write_wp_at(bs, wp, i, BLK_ZS_CLOSED);
> +                    if (ret < 0) {
> +                        return ret;
> +                    }
> +                    s->wps->wp[i] =3D *wp;
> +                    s->nr_zones_imp_open--;
> +                    s->nr_zones_closed++;
> +                    break;
> +                }
> +            }
> +            return 0;
> +        }
> +        return ret;
> +    }
> +
> +    return -1;
> +}
> +
> +/*
> + * The zoned device has limited zone resources of open, closed, active
> + * zones.
> + */
> +static int qcow2_check_zone_resources(BlockDriverState *bs,
> +                                      BlockZoneState zs)
> +{
> +    int ret;
> +
> +    switch (zs) {
> +    case BLK_ZS_EMPTY:
> +        ret =3D qcow2_check_active(bs);
> +        if (ret < 0) {
> +            error_report("No enough active zones");
> +            return ret;
> +        }
> +        return ret;
> +    case BLK_ZS_CLOSED:
> +        ret =3D qcow2_check_open(bs);
> +        if (ret < 0) {
> +            error_report("No enough open zones");
> +            return ret;
> +        }
> +        return ret;
> +    default:
> +        return -EINVAL;
> +    }
> +
> +}
> +
> +static inline int qcow2_refresh_zonedmeta(BlockDriverState *bs)
> +{
> +    int ret;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t *temp =3D g_malloc(s->zoned_header.zonedmeta_size);
> +    ret =3D bdrv_pread(bs->file, s->zoned_header.zonedmeta_offset,
> +                     s->zoned_header.zonedmeta_size, temp, 0);
> +    if (ret < 0) {
> +        error_report("Can not read metadata\n");
> +        return ret;
> +    }
> +
> +    memcpy(s->wps->wp, temp, s->zoned_header.zonedmeta_size);
> +    return 0;
> +}
> +
>  /*
>   * read qcow2 extension and fill bs
>   * start reading from start_offset
> @@ -455,7 +613,19 @@ qcow2_read_extensions(BlockDriverState *bs, uint64_t=
 start_offset,
>                  be32_to_cpu(zoned_ext.max_active_zones);
>              zoned_ext.max_append_sectors =3D
>                  be32_to_cpu(zoned_ext.max_append_sectors);
> +            zoned_ext.zonedmeta_offset =3D
> +                be64_to_cpu(zoned_ext.zonedmeta_offset);
> +            zoned_ext.zonedmeta_size =3D be64_to_cpu(zoned_ext.zonedmeta=
_size);
>              s->zoned_header =3D zoned_ext;
> +            s->wps =3D g_malloc(sizeof(BlockZoneWps)
> +                    + s->zoned_header.zonedmeta_size);
> +            ret =3D qcow2_refresh_zonedmeta(bs);
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret, "zonedmeta: "
> +                                             "Could not update zoned met=
a");
> +                return ret;
> +            }
> +            qemu_co_mutex_init(&s->wps->colock);
> =20
>  #ifdef DEBUG_EXT
>              printf("Qcow2: Got zoned format extension: "
> @@ -1982,6 +2152,14 @@ static void qcow2_refresh_limits(BlockDriverState =
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
> @@ -2672,9 +2850,26 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_=
t offset, int64_t bytes,
>      uint64_t host_offset;
>      QCowL2Meta *l2meta =3D NULL;
>      AioTaskPool *aio =3D NULL;
> +    int64_t start_offset, start_bytes;
> +    BlockZoneState zs;
> +    int64_t end;
> +    uint64_t *wp;
> +    int64_t zone_size =3D bs->bl.zone_size;
> +    int index;
> =20
>      trace_qcow2_writev_start_req(qemu_coroutine_self(), offset, bytes);
> =20
> +    start_offset =3D offset;
> +    start_bytes =3D bytes;
> +    /* The offset should not less than the wp of that
> +     * zone where offset starts.  */
> +    if (zone_size) {
> +        index =3D start_offset / zone_size;
> +        wp =3D &s->wps->wp[index];
> +        if (offset < qcow2_get_wp(*wp)) {
> +            return -EINVAL;
> +        }
> +    }
>      while (bytes !=3D 0 && aio_task_pool_status(aio) =3D=3D 0) {
> =20
>          l2meta =3D NULL;
> @@ -2720,6 +2915,47 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_=
t offset, int64_t bytes,
>          qiov_offset +=3D cur_bytes;
>          trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
>      }
> +
> +    if (zone_size) {
> +        index =3D start_offset / zone_size;
> +        wp =3D &s->wps->wp[index];
> +        uint64_t wpv =3D *wp;
> +        if (!QCOW2_ZT_IS_CONV(wpv)) {
> +            /*
> +             * Implicitly open one closed zone to write if there are zon=
e resources
> +             * left.
> +             */
> +            zs =3D qcow2_get_zs(wpv);
> +            if (zs =3D=3D BLK_ZS_CLOSED || zs =3D=3D BLK_ZS_EMPTY) {
> +                ret =3D qcow2_check_zone_resources(bs, zs);
> +                if (ret < 0) {
> +                    goto fail_nometa;
> +                }
> +
> +                if (zs =3D=3D BLK_ZS_CLOSED) {
> +                    s->nr_zones_closed--;
> +                    s->nr_zones_imp_open++;
> +                } else {
> +                    s->nr_zones_imp_open++;
> +                }
> +            }
> +
> +            /* align up (start_offset, zone_size), the start offset is n=
ot
> +             * necessarily power of two. */
> +            end =3D ((start_offset + zone_size) / zone_size) * zone_size;
> +            if (start_offset + start_bytes <=3D end) {
> +                *wp =3D start_offset + start_bytes;
> +            } else {
> +                ret =3D -EINVAL;
> +                goto fail_nometa;
> +            }
> +
> +            ret =3D qcow2_write_wp_at(bs, wp, index,BLK_ZS_IOPEN);
> +            if (ret < 0) {
> +                goto fail_nometa;
> +            }
> +        }
> +    }
>      ret =3D 0;
> =20
>      qemu_co_mutex_lock(&s->lock);
> @@ -3117,7 +3353,9 @@ int qcow2_update_header(BlockDriverState *bs)
>              .max_active_zones   =3D
>                  cpu_to_be32(s->zoned_header.max_active_zones),
>              .max_append_sectors =3D
> -                cpu_to_be32(s->zoned_header.max_append_sectors)
> +                cpu_to_be32(s->zoned_header.max_append_sectors),
> +            .zonedmeta_offset   =3D cpu_to_be64(s->zoned_header.zonedmet=
a_offset),
> +            .zonedmeta_size     =3D cpu_to_be64(s->zoned_header.zonedmet=
a_size)
>          };
>          ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_ZONED_FORMAT,
>                               &zoned_header, sizeof(zoned_header),
> @@ -3522,7 +3760,8 @@ qcow2_co_create(BlockdevCreateOptions *create_optio=
ns, Error **errp)
>      int version;
>      int refcount_order;
>      uint64_t *refcount_table;
> -    int ret;
> +    uint64_t zoned_meta_size, zoned_clusterlen;
> +    int ret, offset, i;
>      uint8_t compression_type =3D QCOW2_COMPRESSION_TYPE_ZLIB;
> =20
>      assert(create_options->driver =3D=3D BLOCKDEV_DRIVER_QCOW2);
> @@ -3823,6 +4062,48 @@ qcow2_co_create(BlockdevCreateOptions *create_opti=
ons, Error **errp)
>          s->zoned_header.max_open_zones =3D qcow2_opts->max_open_zones;
>          s->zoned_header.max_active_zones =3D qcow2_opts->max_active_zone=
s;
>          s->zoned_header.max_append_sectors =3D qcow2_opts->max_append_se=
ctors;
> +        s->zoned_header.nr_zones =3D qcow2_opts->size / qcow2_opts->zone=
_size;
> +
> +        zoned_meta_size =3D  sizeof(uint64_t) * s->zoned_header.nr_zones;
> +        uint64_t meta[zoned_meta_size];

zoned_meta_size is in bytes but the array is in uint64_t. I guess the
array size should be s->zoned_header.nr_zones (in zones) instead of
zoned_meta_size (in bytes).

Please use g_autoptr and g_new() for this to avoid stack overflow issues
if nr_zones is large.

> +        memset(meta, 0, zoned_meta_size);

Unnecessary if you use g_new0(). Also, zeroing is probably unnecessary
since the for loops below fill in every element of the array.

> +
> +        for (i =3D 0; i < s->zoned_header.zone_nr_conv; ++i) {
> +            meta[i] =3D i * s->zoned_header.zone_size;
> +            meta[i] +=3D 1ULL << 59;

Bitwise OR ('|') is clearer than addition. You do not rely on or want
the add operation's arithmetic carry here.

> +        }
> +        for (; i < s->zoned_header.nr_zones; ++i) {
> +            meta[i] =3D i * s->zoned_header.zone_size;
> +            /* For sequential zones, the first four most significant bit
> +             * indicates zone states. */
> +            meta[i] +=3D ((uint64_t)BLK_ZS_EMPTY << 60);

Bitwise OR.

> +        }
> +
> +        offset =3D qcow2_alloc_clusters(blk_bs(blk), zoned_meta_size);
> +        if (offset < 0) {
> +            error_setg_errno(errp, -offset, "Could not allocate clusters=
 "
> +                                            "for zoned metadata size");
> +            goto out;
> +        }
> +        s->zoned_header.zonedmeta_offset =3D offset;
> +        s->zoned_header.zonedmeta_size =3D zoned_meta_size;
> +
> +        zoned_clusterlen =3D size_to_clusters(s, zoned_meta_size)
> +                * s->cluster_size;
> +        assert(qcow2_pre_write_overlap_check(bs, 0, offset,
> +                                             zoned_clusterlen,false) =3D=
=3D 0);
> +        ret =3D bdrv_pwrite_zeroes(blk_bs(blk)->file, offset,
> +                                 zoned_clusterlen, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Could not zero fill zoned meta=
data");
> +            goto out;
> +        }
> +        ret =3D bdrv_pwrite(blk_bs(blk)->file, offset, zoned_meta_size, =
meta, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Could not write zoned metadata=
 "
> +                                         "to disk");
> +            goto out;
> +        }
>      }
> =20
>      /* Create a full header (including things like feature table) */
> @@ -4166,6 +4447,346 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDr=
iverState *bs,
>      return ret;
>  }
> =20
> +static int coroutine_fn
> +qcow2_co_zone_report(BlockDriverState *bs, int64_t offset,
> +                     unsigned int *nr_zones, BlockZoneDescriptor *zones)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t zone_size =3D s->zoned_header.zone_size;
> +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t size =3D bs->bl.nr_zones * zone_size;
> +    int i =3D 0;
> +    int si;
> +
> +    if (zone_size > 0) {
> +        si =3D offset / zone_size;

offset must be validated. It might be beyond the capacity of the device.

> +        unsigned int nrz =3D *nr_zones;

nr_zones must be validated. It might be larger than bs->bl.nr_zones.

> +        qemu_co_mutex_lock(&s->wps->colock);
> +        for (; i < nrz; ++i) {
> +            zones[i].start =3D (si + i) * zone_size;
> +
> +            /* The last zone can be smaller than the zone size */
> +            if ((si + i + 1) =3D=3D bs->bl.nr_zones && size > capacity) {
> +                zones[i].length =3D zone_size - (size - capacity);
> +            } else {
> +                zones[i].length =3D zone_size;
> +            }
> +            zones[i].cap =3D zone_size;

Should capacity also be capped for the last zone?

> +
> +            uint64_t wp =3D s->wps->wp[si + i];
> +            if (QCOW2_ZT_IS_CONV(wp)) {
> +                zones[i].type =3D BLK_ZT_CONV;
> +                zones[i].state =3D BLK_ZS_NOT_WP;
> +                /* Clear the zone type bit */
> +                wp &=3D ~(1ULL << 59);
> +            } else {
> +                zones[i].type =3D BLK_ZT_SWR;
> +                zones[i].state =3D qcow2_get_zs(wp);
> +                /* Clear the zone state bits */
> +                wp =3D qcow2_get_wp(wp);
> +            }
> +
> +            zones[i].wp =3D wp;
> +            if (si + i =3D=3D bs->bl.nr_zones) {
> +                break;
> +            }

This check is too late because wp[] has already been indexed. It is
insufficient when the first zone is already out of bounds.

> +        }
> +        qemu_co_mutex_unlock(&s->wps->colock);
> +    }
> +    *nr_zones =3D i;
> +    return 0;
> +}
> +
> +static int qcow2_open_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&s->wps->colock);
> +    uint64_t *wp =3D &s->wps->wp[index];
> +    BlockZoneState zs =3D qcow2_get_zs(*wp);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        ret =3D qcow2_check_zone_resources(bs, BLK_ZS_EMPTY);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        break;
> +    case BLK_ZS_IOPEN:
> +        s->nr_zones_imp_open--;
> +        break;
> +    case BLK_ZS_EOPEN:
> +        return 0;
> +    case BLK_ZS_CLOSED:
> +        ret =3D qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        s->nr_zones_closed--;
> +        break;
> +    case BLK_ZS_FULL:
> +        break;
> +    default:
> +        return -EINVAL;
> +    }

s->wps->colock is not unlocked in the return code paths above.

> +    ret =3D qcow2_write_wp_at(bs, wp, index, BLK_ZS_EOPEN);

I wanted to confirm with you and Damien that zone states are persisted
in the zoned storage model, even OPEN/CLOSED? To me, OPEN/CLOSED, seem
more related to runtime resource limits than persistent state that needs
to be stored.

> +    if (!ret) {
> +        s->nr_zones_exp_open++;
> +    }
> +    qemu_co_mutex_unlock(&s->wps->colock);
> +    return ret;
> +}
> +
> +static int qcow2_close_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&s->wps->colock);
> +    uint64_t *wp =3D &s->wps->wp[index];
> +    BlockZoneState zs =3D qcow2_get_zs(*wp);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        break;
> +    case BLK_ZS_IOPEN:
> +        s->nr_zones_imp_open--;
> +        break;
> +    case BLK_ZS_EOPEN:
> +        s->nr_zones_exp_open--;
> +        break;
> +    case BLK_ZS_CLOSED:
> +        ret =3D qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        s->nr_zones_closed--;
> +        break;
> +    case BLK_ZS_FULL:
> +        break;
> +    default:
> +        return -EINVAL;
> +    }

s->wps->colock is not unlocked in the return code paths above.

> +
> +    if (zs =3D=3D BLK_ZS_EMPTY) {
> +        ret =3D qcow2_write_wp_at(bs, wp, index, BLK_ZS_EMPTY);
> +    } else {
> +        ret =3D qcow2_write_wp_at(bs, wp, index, BLK_ZS_CLOSED);
> +        if (!ret) {
> +            s->nr_zones_closed++;
> +        }
> +    }
> +    qemu_co_mutex_unlock(&s->wps->colock);
> +    return ret;
> +}
> +
> +static int qcow2_finish_zone(BlockDriverState *bs, uint32_t index) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    qemu_co_mutex_lock(&s->wps->colock);
> +    uint64_t *wp =3D &s->wps->wp[index];
> +    BlockZoneState zs =3D qcow2_get_zs(*wp);
> +
> +    switch(zs) {
> +    case BLK_ZS_EMPTY:
> +        ret =3D qcow2_check_zone_resources(bs, BLK_ZS_EMPTY);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        break;
> +    case BLK_ZS_IOPEN:
> +        s->nr_zones_imp_open--;
> +        break;
> +    case BLK_ZS_EOPEN:
> +        s->nr_zones_exp_open--;
> +        break;
> +    case BLK_ZS_CLOSED:
> +        ret =3D qcow2_check_zone_resources(bs, BLK_ZS_CLOSED);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        s->nr_zones_closed--;
> +        break;
> +    case BLK_ZS_FULL:
> +        return 0;
> +    default:
> +        return -EINVAL;
> +    }

s->wps->colock is not unlocked in the return code paths above.

> +
> +    *wp =3D (index + 1) * s->zoned_header.zone_size;

There is an integer overflow here. Please see my comment in
qcow2_reset_zone() below.

> +    ret =3D qcow2_write_wp_at(bs, wp, index, BLK_ZS_FULL);
> +    qemu_co_mutex_unlock(&s->wps->colock);
> +    return ret;
> +}
> +
> +static int qcow2_reset_zone(BlockDriverState *bs, uint32_t index,
> +                            int64_t len) {
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int nrz =3D bs->bl.nr_zones;
> +    int zone_size =3D bs->bl.zone_size;
> +    int n, ret =3D 0;
> +
> +    qemu_co_mutex_lock(&s->wps->colock);
> +    uint64_t *wp =3D &s->wps->wp[index];
> +    if (len =3D=3D bs->total_sectors << BDRV_SECTOR_BITS) {
> +        n =3D nrz;
> +        index =3D 0;
> +    } else {
> +        n =3D len / zone_size;
> +    }
> +
> +    for (int i =3D 0; i < n; ++i) {
> +        uint64_t *wp_i =3D (uint64_t *)(wp + i);
> +        uint64_t wpi_v =3D *wp_i;
> +        if (QCOW2_ZT_IS_CONV(wpi_v)) {
> +            continue;
> +        }
> +       =20
> +        BlockZoneState zs =3D qcow2_get_zs(wpi_v);
> +        switch (zs) {
> +        case BLK_ZS_EMPTY:
> +            break;
> +        case BLK_ZS_IOPEN:
> +            s->nr_zones_imp_open--;
> +            break;
> +        case BLK_ZS_EOPEN:
> +            s->nr_zones_exp_open--;
> +            break;
> +        case BLK_ZS_CLOSED:
> +            s->nr_zones_closed--;
> +            break;
> +        case BLK_ZS_FULL:
> +            break;
> +        default:
> +            return -EINVAL;
> +        }
> +
> +        if (zs =3D=3D BLK_ZS_EMPTY) {
> +            continue;
> +        }
> +
> +        *wp_i =3D (index + i) * zone_size;

This calculation needs uint64_t to avoid overflowing int. The types
involved are:

  uint64_t =3D (uint32_t + int) * int;

You can fix it using:

  *wp_i =3D ((uint64_t)index + i) * zone_size;

Then the entire expression will be evaluated as a 64-bit integer instead
of a 32-bit integer.

> +        ret =3D qcow2_write_wp_at(bs, wp_i, index + i, BLK_ZS_EMPTY);
> +        if (ret < 0) {
> +            return ret;

s->wps->colock must be unlocked.

> +        }
> +        /* clear data */
> +        ret =3D qcow2_co_pwrite_zeroes(bs, qcow2_get_wp(*wp_i), zone_siz=
e, 0);

Does zone reset guarantee that the data blocks will be zeroed according
to the zoned storage model?

> +        if (ret < 0) {
> +            error_report("Failed to reset zone at 0x%" PRIx64 "", *wp_i);
> +        }
> +    }
> +    qemu_co_mutex_unlock(&s->wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn qcow2_co_zone_mgmt(BlockDriverState *bs, BlockZo=
neOp op,
> +                                           int64_t offset, int64_t len)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret =3D 0;
> +    int64_t capacity =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +    int64_t zone_size =3D s->zoned_header.zone_size;
> +    int64_t zone_size_mask =3D zone_size - 1;
> +    uint32_t index =3D offset / zone_size;
> +    BlockZoneWps *wps =3D s->wps;
> +
> +    if (offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone s=
ize"
> +                     " %" PRId64 "", offset / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    if (((offset + len) < capacity && len & zone_size_mask) ||
> +        offset + len > capacity) {
> +        error_report("number of sectors %" PRId64 " is not aligned to zo=
ne"
> +                     " size %" PRId64 "", len / 512, zone_size / 512);
> +        return -EINVAL;
> +    }
> +
> +    qemu_co_mutex_lock(&wps->colock);
> +    uint64_t wpv =3D wps->wp[offset / zone_size];

Use index here instead of recalculating it?

> +    if (QCOW2_ZT_IS_CONV(wpv) && len !=3D capacity) {
> +        error_report("zone mgmt operations are not allowed for "
> +                     "conventional zones");
> +        ret =3D -EIO;
> +        goto unlock;
> +    }
> +    qemu_co_mutex_unlock(&wps->colock);
> +
> +    switch(op) {
> +    case BLK_ZO_OPEN:
> +        ret =3D qcow2_open_zone(bs, index);
> +        break;
> +    case BLK_ZO_CLOSE:
> +        ret =3D qcow2_close_zone(bs, index);
> +        break;
> +    case BLK_ZO_FINISH:
> +        ret =3D qcow2_finish_zone(bs, index);
> +        break;
> +    case BLK_ZO_RESET:
> +        ret =3D qcow2_reset_zone(bs, index, len);
> +        break;
> +    default:
> +        error_report("Unsupported zone op: 0x%x", op);
> +        ret =3D -ENOTSUP;
> +        break;
> +    }
> +    return ret;
> +
> +unlock:
> +    qemu_co_mutex_unlock(&wps->colock);
> +    return ret;
> +}
> +
> +static int coroutine_fn
> +qcow2_co_zone_append(BlockDriverState *bs, int64_t *offset, QEMUIOVector=
 *qiov,
> +                     BdrvRequestFlags flags)
> +{
> +    assert(flags =3D=3D 0);
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +    int64_t zone_size_mask =3D bs->bl.zone_size - 1;
> +    int64_t iov_len =3D 0;
> +    int64_t len =3D 0;
> +
> +    /* offset + len should not pass the end of that zone starting from o=
ffset */
> +    if (*offset & zone_size_mask) {
> +        error_report("sector offset %" PRId64 " is not aligned to zone s=
ize "
> +                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 51=
2);
> +        return -EINVAL;
> +    }
> +
> +    int64_t wg =3D bs->bl.write_granularity;
> +    int64_t wg_mask =3D wg - 1;
> +    for (int i =3D 0; i < qiov->niov; i++) {
> +        iov_len =3D qiov->iov[i].iov_len;
> +        if (iov_len & wg_mask) {
> +            error_report("len of IOVector[%d] %" PRId64 " is not aligned=
 to "
> +                         "block size %" PRId64 "", i, iov_len, wg);
> +            return -EINVAL;
> +        }
> +    }
> +    len =3D qiov->size;
> +
> +    if ((len >> BDRV_SECTOR_BITS) > bs->bl.max_append_sectors) {
> +        return -ENOTSUP;
> +    }
> +
> +    qemu_co_mutex_lock(&s->wps->colock);
> +    uint64_t wp =3D s->wps->wp[*offset / bs->bl.zone_size];

Where is *offset checked against nr_zones to prevent an access beyond
the end of the array?

> +    uint64_t wp_i =3D qcow2_get_wp(wp);
> +    ret =3D qcow2_co_pwritev_part(bs, wp_i, len, qiov, 0, 0);
> +    if (ret =3D=3D 0) {
> +        *offset =3D wp_i;
> +    } else {
> +        error_report("qcow2: zap failed");
> +    }
> +
> +    qemu_co_mutex_unlock(&s->wps->colock);
> +    return ret;
> +}
> +
>  static int coroutine_fn GRAPH_RDLOCK
>  qcow2_co_copy_range_from(BlockDriverState *bs,
>                           BdrvChild *src, int64_t src_offset,
> @@ -6214,6 +6835,10 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_co_pwritev_part   =3D qcow2_co_pwritev_part,
>      .bdrv_co_flush_to_os    =3D qcow2_co_flush_to_os,
> =20
> +    .bdrv_co_zone_report    =3D qcow2_co_zone_report,
> +    .bdrv_co_zone_mgmt    =3D qcow2_co_zone_mgmt,
> +    .bdrv_co_zone_append    =3D qcow2_co_zone_append,
> +
>      .bdrv_co_pwrite_zeroes  =3D qcow2_co_pwrite_zeroes,
>      .bdrv_co_pdiscard       =3D qcow2_co_pdiscard,
>      .bdrv_co_copy_range_from =3D qcow2_co_copy_range_from,
> diff --git a/block/qcow2.h b/block/qcow2.h
> index fe18dc4d97..a3a96ddbce 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -246,6 +246,8 @@ typedef struct Qcow2ZonedHeaderExtension {
>      uint32_t max_active_zones;
>      uint32_t max_open_zones;
>      uint32_t max_append_sectors;
> +    uint64_t zonedmeta_offset;
> +    uint64_t zonedmeta_size;
>      uint8_t padding[3];
>  } QEMU_PACKED Qcow2ZonedHeaderExtension;
> =20
> --=20
> 2.40.1
>=20

--0hexIrUZTUZhBE/4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSQZ84ACgkQnKSrs4Gr
c8gndgf+OPkc5Z7T6kJa/P+pLp0CTpnAbHtVE15aYp75n8zr3gpjGzWzesyJPUsG
FcvAPd/8aV89owo9ignRIWEFIzIrpZDvifAP78Rrp2Dkst65ySdPFITzYfIMMxQZ
CXllBAnWkzKtBTYTA08ghLWFYr8SUtyeFV7DeOk4pjCqku9bybT3+pzd/eM5s4OH
W1yTj+K7qDoU5nj53SFNiydK7YU4zER0RFHJPyh87sxxwytu4MXzceAgazqg2cSw
d58zzi+X6CroTdStUOF5H/eYZWt0pC2t43jUlq9CBVJThbhfUbZClzaDWVeLGN06
mUq3LMe+1RroCp5t9Z6O7GjuKvQHcQ==
=BmiF
-----END PGP SIGNATURE-----

--0hexIrUZTUZhBE/4--


