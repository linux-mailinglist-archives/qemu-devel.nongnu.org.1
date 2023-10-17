Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F287CC519
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:48:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskPu-0005kQ-20; Tue, 17 Oct 2023 09:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qskPl-0005jT-Ei
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qskPj-0005Aq-Gz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697550433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSIy4H06gJX306y3lD4NRcTPZPd1ShxNVwyaQXv5bEc=;
 b=WK6rBE8a2lri9cTxrw0PWosxUgVvQLZLOcQgwe8B8W3oIsVC/yZuQhXXLB767c0zuHNPYU
 k8RWyRq6ggNcstLcpfTXh9SCrTj06Gl0w1bj+nL61d+y+WzLPHoDD7v76MOcACrjdWeVJL
 9WvXDr1PAiZPJIxTh6ILYV9zkJkmFt4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-qkRbto6AOlagGYYufdCeaA-1; Tue, 17 Oct 2023 09:46:55 -0400
X-MC-Unique: qkRbto6AOlagGYYufdCeaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48EAE81D9ED;
 Tue, 17 Oct 2023 13:46:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5A842BA;
 Tue, 17 Oct 2023 13:46:54 +0000 (UTC)
Date: Tue, 17 Oct 2023 09:46:53 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, hujian <hu.jian@zte.com.cn>
Subject: Re: [PULL 1/1] virtio-blk: don't start dataplane during the stop of
 dataplane
Message-ID: <20231017134653.GB211967@fedora>
References: <20231016194028.163610-1-stefanha@redhat.com>
 <20231016194028.163610-2-stefanha@redhat.com>
 <851be4cf-d3e1-4031-bc5a-95fbef1ce21f@proxmox.com>
 <ZS5bstofOtQIdz84@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hRY23LTO+7V/JsRy"
Content-Disposition: inline
In-Reply-To: <ZS5bstofOtQIdz84@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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


--hRY23LTO+7V/JsRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 12:02:26PM +0200, Kevin Wolf wrote:
> Am 17.10.2023 um 11:01 hat Fiona Ebner geschrieben:
> > Am 16.10.23 um 21:40 schrieb Stefan Hajnoczi:
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index 39e7f23fab..c2d59389cb 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -1166,7 +1166,7 @@ static void virtio_blk_handle_output(VirtIODevi=
ce *vdev, VirtQueue *vq)
> > >  {
> > >      VirtIOBlock *s =3D (VirtIOBlock *)vdev;
> > > =20
> > > -    if (s->dataplane && !s->dataplane_started) {
> > > +    if (s->dataplane && !s->dataplane_started && !s->stopping) {
> >=20
> > Isn't 'stopping' a property of VirtIOBlockDataPlane? Here, s is VirtIOB=
lock.
>=20
> Indeed, this patch doesn't even build for me.
>=20
> However, even if we wrote !s->dataplane->stopping, would it really be
> right to be handling I/O in the main thread while the dataplane hasn't
> stopped yet? At least without all the multiqueue changes, it's not
> obvious to me that it can't cause problems. Unfortunately, the commit
> message doesn't say anything about why it's safe.

Thanks for pointing these things out, Fiona and Kevin. I've dropped the
patch for now.

Stefan

--hRY23LTO+7V/JsRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUukE0ACgkQnKSrs4Gr
c8iBFQgAoOl+vvXlxZeeXqtz5Clp86+x7otHXsqAE5bl8i2vfa/P0ki3VAOBoGiq
2ZjAaK8AYVeI6ROJli64YaysuyRdzeR9WJu5Ux8VyqmgC+px6tqlCsxdQn8CMNX+
kflJ9Dbqw5a+OKqrA0rhs3zvdXFyVQd/U+cnMrt25LZNzDQQpjkeH4cvizu1CyMG
CdcsTz8dosTGfG1W++de1uI1wD6BwBzN81b/npAOoOsuQOzj6AgGW9TQCq3b6iEI
wG9tu6EcuNPk/a6D7eAQtbF/Ju2N8AKefKkfrF5/izscMeRoMkQRkgRjAESog5gR
DYN14Iv1Ok1kvuuXwaal5TntfpFl5Q==
=J8yX
-----END PGP SIGNATURE-----

--hRY23LTO+7V/JsRy--


