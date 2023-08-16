Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453BD77EB6D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWNjj-0002Au-H9; Wed, 16 Aug 2023 17:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWNjf-0002Ae-MW
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qWNjV-0006jn-N7
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692220029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7IthV9/cUucV4OWLuaWlpR++T0LzfSAiOpvm8ImekA=;
 b=aQMVaSKGtjFpmVzwSxJKHEKpReGCNHf5FO5tzTF8uL6az4Q4HXQch7e7Tyhhc/NmyGA7Ve
 o03WdJNvUtAcxTcPxkKt6Uif7Qlj/55zaIVNe9fysTnf0SGEuatLGIMUtMjNSscWQXFUKQ
 D3RuiH+yjH25M6axgUCyRVuqDgYUWJI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-Qu60uqx-N16D_0jpbe2xKg-1; Wed, 16 Aug 2023 17:07:05 -0400
X-MC-Unique: Qu60uqx-N16D_0jpbe2xKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E3F6185A78B;
 Wed, 16 Aug 2023 21:07:04 +0000 (UTC)
Received: from localhost (unknown [10.39.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8887C15BAD;
 Wed, 16 Aug 2023 21:07:03 +0000 (UTC)
Date: Wed, 16 Aug 2023 17:07:01 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, dlemoal@kernel.org
Subject: Re: [PATCH v2 3/4] qcow2: add zoned emulation capability
Message-ID: <20230816210701.GC3454448@fedora>
References: <20230814085802.61459-1-faithilikerun@gmail.com>
 <20230814085802.61459-4-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FVD+Y1QjaVp8OZN5"
Content-Disposition: inline
In-Reply-To: <20230814085802.61459-4-faithilikerun@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--FVD+Y1QjaVp8OZN5
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

Although the function is called qcow2_set_wp() it seems to actually be
qcow2_set_zs() since it only changes the zone state, not the write
pointer. Want to rename it?

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

This looks like debugging code that shouldn't go into qemu.git. Please
use tracing (docs/devel/tracing.rst) to capture internal information in
production code.

I will review more of this patch series another time because I need to
get going.

Stefan

--FVD+Y1QjaVp8OZN5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTdOnUACgkQnKSrs4Gr
c8jFWwgAk0NL2KyxYhua/RP18fDc4FhDWq9wwwz3QMv7xLrqRdJy5dhstWxbWeY5
IhvJCForQgQSnaPVYEEbRbbPHBXvfu0Vbv3hQDLBX55QjbIG1fpK+awu5CPqpqfh
2tpxVdnjaSipJylf3C+JYbFgu1z11f/Zu7Ek03Jf+LfjYPbWJMcolF8h85sPt7dc
r1wXVMhdU07djoNjGdxrkkdqup+iwQZjcdgDwTR2jS6CA92Iz8anhOyJFSCKZApv
+3ohHrFgsfqKMGIjXNlzyq/SAL9nZtiogNSE3eL7oitdQyUpIlcjC3Kio/8XuzBF
DyDvxu2G4ZSxWTlrvUqZyUmK/wUmXA==
=zdMf
-----END PGP SIGNATURE-----

--FVD+Y1QjaVp8OZN5--


