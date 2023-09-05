Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774E7923EE
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXx6-0003Jg-Ih; Tue, 05 Sep 2023 11:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdXx4-0003JT-OS
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdXx2-0003JB-LP
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693927607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LhasF3VggVinUOlBH7vaLv/wXeiad0n2AZIac3c38Fk=;
 b=FknN1ulLIIsIhPZtqOUk2ksA8mvCwbA71jaQm1vIYPcHUITd9gRtojgj5eKo6ozCOmjZhM
 GuqYWvW2V6DFLultX1YNh7nXtJUfjbvrxc8adpBoi8i46G8Y78HIqLxecNXbpiQp7ZkfkM
 /PpcHSqnOGaMgzy8J/FT0v/hFxGJwuM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-7V-0chCIMcSP1LAMBKxAxg-1; Tue, 05 Sep 2023 11:26:43 -0400
X-MC-Unique: 7V-0chCIMcSP1LAMBKxAxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E5B03C0ED41;
 Tue,  5 Sep 2023 15:26:42 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60FD31121314;
 Tue,  5 Sep 2023 15:26:41 +0000 (UTC)
Date: Tue, 5 Sep 2023 17:26:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 17/21] block: Take graph rdlock in bdrv_drop_intermediate()
Message-ID: <ZPdIsG5EGrE8mFak@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-18-kwolf@redhat.com>
 <20230822193502.GU727224@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3gxJmNjcNj3yT82m"
Content-Disposition: inline
In-Reply-To: <20230822193502.GU727224@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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


--3gxJmNjcNj3yT82m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.08.2023 um 21:35 hat Stefan Hajnoczi geschrieben:
> On Thu, Aug 17, 2023 at 02:50:16PM +0200, Kevin Wolf wrote:
> > The function reads the parents list, so it needs to hold the graph lock.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/block.c b/block.c
> > index 7df8780d6e..a82389f742 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -5934,9 +5934,11 @@ int bdrv_drop_intermediate(BlockDriverState *top=
, BlockDriverState *base,
> >          backing_file_str =3D base->filename;
> >      }
> > =20
> > +    bdrv_graph_rdlock_main_loop();
> >      QLIST_FOREACH(c, &top->parents, next_parent) {
> >          updated_children =3D g_slist_prepend(updated_children, c);
> >      }
> > +    bdrv_graph_rdunlock_main_loop();
>=20
> This is GLOBAL_STATE_CODE, so why take the read lock? I thought nothing
> can modify the graph here. If it could, then stashing the parents in
> the updated_children probably wouldn't be safe anyway.

The only thing bdrv_graph_rdlock_main_loop() does is asserting that the
conditions for doing nothing are met (GLOBAL_STATE_CODE + non-coroutine
context) and providing the right TSA attributes to make the compiler
happy.

Kevin

--3gxJmNjcNj3yT82m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmT3SLAACgkQfwmycsiP
L9ZkrxAAqLZO+he+3BANgce2FaTKB6cOdzDl2+v2YPKIWGEjqTuygsnvy2W88tR0
AgQP1JpgOr7iUcEwvGU/7WUSvluY1OPnK2MENnJtIF33FkX9BomE+GWCVlGOHQTb
MPxnYK/nVOK0AM+6h2prvNQiliqA3XLLLJ1yQHxqw+tOQTEnUcd0iftmLm0vOM5T
22AZ/psXlEhvLHNWzpcx5rw3qHN2/CdQ2I9+mB0zH+NgG1z/xrCOluIBmnQ2Q2w7
2dDRfeZ4tQuxnJ1IIM9wi3Xti7YYJYQ+vZUR0xavLr6TgDt6tnLyZ7WlbbgZaVSj
l0seJMK9cIpGoukcipe4Z2f2bP2IU+b++AOlACs0XvXWNUsKDBvWR718R+fJyu/d
ANLJyBNWzUr95HyM8x21cAIJcCMTuL9j+DaF9D2n9qgPFJt0rg3ftX5RRdr2elLD
dubsvb5IhRrcQazJxS4SiGJ5ClNShBZQ98L1fF1TntC1wKqWppDwxR2rwi1PBBt0
YCrBNWrhw81rdRGd8lzuLtBzmg4GxuV3eR+ZMj89vsdoRZrfmOUM3mOYc1KYAHt1
z6GyGni/A0d/Lt803o+WQBh2lBSDSW/xxTfTHb/AK4QVuS6udnSj6wpJ3/jmEz6q
4VqEsVDyQcQrmd8ZjHrJofPfHFrY/O1kH0Z0M9kO9c/9Zg3Aa58=
=TzFX
-----END PGP SIGNATURE-----

--3gxJmNjcNj3yT82m--


