Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC79784ACF
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYXMX-0004CA-Td; Tue, 22 Aug 2023 15:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXMV-0004Bj-Rv
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXMT-0000Gx-91
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692733699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0y96W4hgyr2b/VmSf9Plb5Vyd9pUkYoOyyP8q0rmkY=;
 b=DQFwLDcfkG3enez3TSa1M+nBHd4ET1VbU7aA/eY19z5VM72Tknbzq9ST+I8837P7cIWIfG
 +ha59g35XuJm1eEbb3UWTsV0vgVBL7/4TPcLb498n8Hfgh4SiZ+449CO6UcS4UGNk2+SSI
 wHyD/pLzIuLtaGDKE7i12CW2MI7Of+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-Y_dUC7gsPzW62TKPYb9_Fw-1; Tue, 22 Aug 2023 15:48:17 -0400
X-MC-Unique: Y_dUC7gsPzW62TKPYb9_Fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04D27853065;
 Tue, 22 Aug 2023 19:48:17 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86B68C15BAE;
 Tue, 22 Aug 2023 19:48:16 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:48:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v2 3/4] qcow2: add zoned emulation capability
Message-ID: <20230822194814.GB37847@fedora>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="86703pJudoXLNVVu"
Content-Disposition: inline
In-Reply-To: <20230814085802.61459-4-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--86703pJudoXLNVVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:58:01PM +0800, Sam Li wrote:
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
>  block/qcow2.c          | 676 ++++++++++++++++++++++++++++++++++++++++-
>  block/qcow2.h          |   2 +
>  docs/interop/qcow2.txt |   2 +
>  3 files changed, 678 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index c1077c4a4a..5ccf79cbe7 100644
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

Should *wp be restored to its original value to undo the effect of
qcow2_set_wp()?

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

Please rename this to qcow2_check_active_zones() to avoid confusion with
other uses "active" in qcow2.

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

(This function could return a bool instead of 0/-1 since it doesn't
really need an int.)

> +
> +static int qcow2_check_open(BlockDriverState *bs)

qcow2_check_open_zones() or, even better, qcow2_can_open_zone().

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

One solution is to keep an implicitly open list. Then this operation is
O(1).

> +            /* close one implicitly open zones to make it available */
> +            for (int i =3D s->zoned_header.zone_nr_conv;
> +            i < bs->bl.nr_zones; ++i) {
> +                uint64_t *wp =3D &s->wps->wp[i];
> +                if (qcow2_get_zs(*wp) =3D=3D BLK_ZS_IOPEN) {
> +                    ret =3D qcow2_write_wp_at(bs, wp, i, BLK_ZS_CLOSED);

I'm wondering if it's correct to store the zone state persistently in
the qcow2 file. If the guest or QEMU crashes, then zones will be left in
states like EOPEN. Since the guest software will have forgotten about
explicitly opened zones, the guest would need to recover zone states.
I'm not sure if existing software is designed to do that.

Damien: Should the zone state be persistent?

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

This returns 0 if there are no IOPEN zones available. It needs to return
an error when there are not enough resources available.

> +        }
> +        return ret;
> +    }
> +
> +    return -1;

This function mixes 0/-1 with -errno return values. -1 is -EPERM, but I
think that's not what you want.

--86703pJudoXLNVVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlEP4ACgkQnKSrs4Gr
c8jmnwf+PSV63m/8RZ/ajL916c4YOU+uinbVRAL0r7R6v6SFZEPWNy2O8xee+Wnk
zByjdgQqZfdzselHo2HBiDOcTidD27nk/T0pKcJd73d1Z4ThL0t75jQaZ9jetXm6
32WqksOF3i6rXcA9JFEAQHsDJBSUa1IzX4+fWTVOghBCX1P8rP0j3HRErlS3JdYI
b06dChydyRxXT09HlVM4W/JYkj4N232OzFEInESl37i5hRYLud1PzyVvgCWeGm3n
64s88paPKfkHnEd9zC9sPiFD4okv6gGdNJ5ySMfWYk15S+3C5HaMNmEoRlQRYDHn
Cn93Lavm2r0Wi1gKVqwptHogERuCDQ==
=RKew
-----END PGP SIGNATURE-----

--86703pJudoXLNVVu--


