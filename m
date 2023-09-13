Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB679F398
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 23:16:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgXBw-0002Yu-EL; Wed, 13 Sep 2023 17:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgXBu-0002YO-LX
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 17:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgXBo-0008KA-82
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 17:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694639663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoAwl+MaS5HX741TSNqqdcEOQkm4hPk6Wp89YRX3f4Y=;
 b=Fu+dywizzzh6Q/78nLhIARLkUy28nkW+OKGBFLZOXqN08+RMlBrsNNENi4nNSIu2t+0ddW
 0Jh3jmpiqlVIRYKdccH5tXpihwy/zhz+jjQz4eNELuIa3Xfc19Spo+4lgn5aNRuZsUxNuU
 O4W40DEQDlh91/YCJeyWFb6I9g2A5jE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-VG042geDMraxrVCIo3vPlw-1; Wed, 13 Sep 2023 17:14:19 -0400
X-MC-Unique: VG042geDMraxrVCIo3vPlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E52C6185A79C;
 Wed, 13 Sep 2023 21:14:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68D5310085C0;
 Wed, 13 Sep 2023 21:14:17 +0000 (UTC)
Date: Wed, 13 Sep 2023 17:11:37 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, hare@suse.de, qemu-block@nongnu.org,
 dlemoal@kernel.org
Subject: Re: [PATCH v3 3/4] qcow2: add zoned emulation capability
Message-ID: <20230913211137.GC1313843@fedora>
References: <20230828150955.3481-1-faithilikerun@gmail.com>
 <20230828150955.3481-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EfsM2bav8Wzu35ts"
Content-Disposition: inline
In-Reply-To: <20230828150955.3481-4-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--EfsM2bav8Wzu35ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 11:09:54PM +0800, Sam Li wrote:
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
>  block/qcow2.c          | 657 ++++++++++++++++++++++++++++++++++++++++-
>  block/qcow2.h          |   2 +
>  block/trace-events     |   1 +
>  docs/interop/qcow2.txt |   6 +
>  4 files changed, 664 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7074bfc620..bc98d98c8e 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -194,6 +194,153 @@ qcow2_extract_crypto_opts(QemuOpts *opts, const cha=
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
> +static inline void qcow2_set_zs(uint64_t *wp, BlockZoneState zs)
> +{
> +    uint64_t addr =3D qcow2_get_wp(*wp);
> +    addr |=3D ((uint64_t)zs << 60);
> +    *wp =3D addr;
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
> +    uint64_t wpv =3D *wp;
> +    int ret;
> +
> +    qcow2_set_zs(wp, zs);
> +    ret =3D bdrv_pwrite(bs->file, s->zoned_header.zonedmeta_offset
> +        + sizeof(uint64_t) * index, sizeof(uint64_t), wp, 0);
> +
> +    if (ret < 0) {
> +        goto exit;
> +    }
> +    trace_qcow2_wp_tracking(index, qcow2_get_wp(*wp) >> BDRV_SECTOR_BITS=
);
> +    return ret;
> +
> +exit:
> +    *wp =3D wpv;
> +    error_report("Failed to write metadata with file");
> +    return ret;
> +}
> +
> +static bool qcow2_check_active_zones(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +
> +    if (!s->zoned_header.max_active_zones) {
> +        return true;
> +    }
> +
> +    if (s->nr_zones_exp_open + s->nr_zones_imp_open + s->nr_zones_closed
> +        < s->zoned_header.max_active_zones) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static int qcow2_check_open_zones(BlockDriverState *bs)
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
> +    if(s->nr_zones_imp_open && qcow2_check_active_zones(bs)) {
> +        /* TODO: it takes O(n) time complexity (n =3D nr_zones).
> +         * Optimizations required. */
> +        /* close one implicitly open zones to make it available */
> +        for (int i =3D s->zoned_header.nr_conv_zones;

Please use uint32_t to keep the types consistent.

> +        i < bs->bl.nr_zones; ++i) {
> +            uint64_t *wp =3D &bs->wps->wp[i];
> +            if (qcow2_get_zs(*wp) =3D=3D BLK_ZS_IOPEN) {
> +                ret =3D qcow2_write_wp_at(bs, wp, i, BLK_ZS_CLOSED);
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +                bs->wps->wp[i] =3D *wp;

This assignment is unnecessary since wp points to bs->wps->wp[i]. The
value has already been updated.

> +                s->nr_zones_imp_open--;
> +                s->nr_zones_closed++;
> +                break;
> +            }
> +        }
> +        return 0;

If this for loop completes with i =3D=3D bs->bl.nr_zones then we've failed
to close an IOPEN zone. The return value should be an error like -EBUSY.

> +    }
> +
> +    return -EINVAL;

Which case does this -EINVAL cover? Won't we get here when no zones are
open yet?

--EfsM2bav8Wzu35ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUCJYkACgkQnKSrs4Gr
c8gSOwf9H8C56pm62MEkbsjZW8Jx8LiBlWq9VZ4Y4YDVl6z2DsEVnp7ShgEfJg/v
4cRAYzUH9dqTe2EAA3p7Lu0lDogvBR4BKRUSxCxN+9MkOi/Q+vSaLVSLHbqYbUlP
tidK6H6zKjV8780f24bEkHHnX2mIWfRlsmggwcyYqFw8qe6YXppwHV++xfMdYtzI
7mo+Ofgdy+3sq0IyLteLIDUBLTYJdO6B3W5Zzlciv53BnZOOYHZ+Ny1MI16fGTF6
z+nPzTIugF8Q28i02v1byWPBvMXQJr/DrwMT2mzn767g4pDICbNE0ZKrYKSxcN+0
dwrPG8au/OJjwXVT4401SmherCtYMg==
=8kE2
-----END PGP SIGNATURE-----

--EfsM2bav8Wzu35ts--


