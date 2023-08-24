Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 653BA78766E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:16:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDva-0002qt-QX; Thu, 24 Aug 2023 13:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDvW-0002oR-7K
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDvS-0006oi-AA
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692897316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hdaYuTdG0DC3tU9ulgnemsCJHZR8e7YaaIUyXO+FIQI=;
 b=Dm7NlxDrKMPKfmjKqxMosWqsmeEPV9MbtXazudCxhe2QHsPmLTT9ScnyaGS0SUTdD7j0nD
 kqiZBSKXBi/OUqYjcwA1WFELv1QuvFajiAr66rk7KESGw1myJWbOZzinuRiyzHYLvcgiXQ
 8UexRyh2oP2euF5eexJma2hspIIbLGk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-E7uIOsABOC2BaIPEWuQQLg-1; Thu, 24 Aug 2023 13:15:14 -0400
X-MC-Unique: E7uIOsABOC2BaIPEWuQQLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AC28185A78F;
 Thu, 24 Aug 2023 17:15:14 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02B822166B27;
 Thu, 24 Aug 2023 17:15:13 +0000 (UTC)
Date: Thu, 24 Aug 2023 13:15:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] hw/block/dataplane/virtio-block: Avoid dynamic stack
 allocation
Message-ID: <20230824171512.GA1690425@fedora>
References: <20230824165740.2653919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uFj8z8SpyGnDmrJo"
Content-Disposition: inline
In-Reply-To: <20230824165740.2653919-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--uFj8z8SpyGnDmrJo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 05:57:40PM +0100, Peter Maydell wrote:
> Instead of using a variable length array in notify_guest_bh(), always
> use a fixed sized bitmap (this will be 128 bytes).  This means we
> need to avoid assuming that bitmap and the s->batch_notify_vqs bitmap
> are the same size; the neatest way to do this is to switch to using
> bitmap.h APIs to declare, copy and clear, because then we can specify
> the length in bits, exactly as we did when creating
> s->batch_notify_vqs with bitmap_new().
>=20
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> In discussion on Philippe's attempt at getting rid of this VLA:
> https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/20210=
505211047.1496765-7-philmd@redhat.com/
> Stefan suggested getting rid of the local bitmap array entirely.
> But I don't know this code at all and have no idea of the
> implications (presumably there is a reason we have the local
> array rather than iterating directly on batch_notify_vqs),
> so I have opted for the more minimal change.
>=20
> Usual disclaimer: tested only with "make check" and
> "make check-avocado".
> ---
>  hw/block/dataplane/virtio-blk.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Hi Peter,
I recently sent a patch series that removes notify_guest_bh() completely:
https://lore.kernel.org/qemu-devel/20230817155847.3605115-5-stefanha@redhat=
=2Ecom/

If it's urgent we can merge your patch immediately, though I hope my
series will be merged soon anyway:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-=
blk.c
> index da36fcfd0b5..f31ec79d0b2 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -59,11 +59,16 @@ static void notify_guest_bh(void *opaque)
>  {
>      VirtIOBlockDataPlane *s =3D opaque;
>      unsigned nvqs =3D s->conf->num_queues;
> -    unsigned long bitmap[BITS_TO_LONGS(nvqs)];
> +    DECLARE_BITMAP(bitmap, VIRTIO_QUEUE_MAX);
>      unsigned j;
> =20
> -    memcpy(bitmap, s->batch_notify_vqs, sizeof(bitmap));
> -    memset(s->batch_notify_vqs, 0, sizeof(bitmap));
> +    /*
> +     * Note that our local 'bitmap' is declared at a fixed
> +     * worst case size, but s->batch_notify_vqs has only
> +     * nvqs bits in it.
> +     */
> +    bitmap_copy(bitmap, s->batch_notify_vqs, nvqs);
> +    bitmap_zero(s->batch_notify_vqs, nvqs);
> =20
>      for (j =3D 0; j < nvqs; j +=3D BITS_PER_LONG) {
>          unsigned long bits =3D bitmap[j / BITS_PER_LONG];
> --=20
> 2.34.1
>=20

--uFj8z8SpyGnDmrJo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTnkCAACgkQnKSrs4Gr
c8jiHwgAqRDQNWSzZoc+Uj+IOCXWWgfOtgXd6U+z7hxQB3ZZuGt+Fal4SelR6Yqh
m2ZQV7j2SnieXQ1e/6wbfeYBglxYSSG5t7lM6EDaASrLZYn+thrz+MkhOjkRMSYP
V7VGiBDj3JF+rc05XH2usBwOzwk+zdlYxT5TJk5HdrVBhJJfoC17O29T8t+cK+We
nhWzn2Jr6MICBCnjYg9EmIX4Y73R7qABIzDCv1ljnKNxwPbLmDvTsWOSozwviSNH
i0koV0bn87Wj0y+NmdKJ9zqDFOND3skqLzB5Ijhpt/0PMBupZtR2RLx44MPTLzlg
YxKXnJVlKi2N3da8KGAmIPbfrM3V1Q==
=nSyL
-----END PGP SIGNATURE-----

--uFj8z8SpyGnDmrJo--


