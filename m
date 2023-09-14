Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 321DC7A0368
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglAV-0006AA-O0; Thu, 14 Sep 2023 08:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qglAP-00069I-LP
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qglAJ-0001WS-1D
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694693384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1XLoVFxUyoZLJD3RBnfD5BAjcElDbFumwdgo4U/KUw=;
 b=d3TFDpYFO2X4LII9VYnFZl0pYXFHi8FCU36TQZ77/zHgW3jEJj1ZrxbmHhtWr8r9QgqrzF
 qUPdlqU1IYLPQyNT/TA0B1i+SMNQirLd1PkkwBmnoIenEn4oePQu8S9C/abjSUB5A/eODl
 rn/ykqvNQMm+lyaFnWVXCmZ9+Z4sxcs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-LuOU5H05Oki5s7DlFODKDw-1; Thu, 14 Sep 2023 08:09:38 -0400
X-MC-Unique: LuOU5H05Oki5s7DlFODKDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D347185A797;
 Thu, 14 Sep 2023 12:09:38 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A62C39A;
 Thu, 14 Sep 2023 12:09:36 +0000 (UTC)
Date: Thu, 14 Sep 2023 08:09:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: Various changes "backportability"
Message-ID: <20230914120935.GB1047741@fedora>
References: <70f869ab-3e87-92c4-3df3-6aa5a0e9e1f0@tls.msk.ru>
 <CAJSP0QWT9FsGaiTXnionp8FhADxtn1haQ-e1id933HwEcTvgPA@mail.gmail.com>
 <8d2bac35-0b73-bc28-0f22-558e69619462@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6wZIQz3/8Oeij/h"
Content-Disposition: inline
In-Reply-To: <8d2bac35-0b73-bc28-0f22-558e69619462@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


--d6wZIQz3/8Oeij/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 05:44:38PM +0300, Michael Tokarev wrote:
> 13.09.2023 17:27, Stefan Hajnoczi wrote:
> ...
> > > For example, recent tpm bugfix, which is trivial by its own,
> > > uses RETRY_ON_EINTR helper which were introduced recently and
> > > which is now used everywhere.  coroutine_fn et al markers is
> > > another example, translator_io_start is yet another, and so
> > > on and so on.
>=20
> > The general concept makes sense to me but I'm not sure what the
> > specific issue with adding (?) coroutine_fn was. Can you link to the
> > patch that caused difficulties so I can review it?
>=20
> There's nothing really exciting here, and coroutine_fn example isn't
> a best one really.  I'm talking about this:
>=20
> https://gitlab.com/mjt0k/qemu/-/commit/c5034f827726f5876234bf4c6a0fab648f=
d8b020
>=20
> which is a current back-port of 92e2e6a867334a990f8d29f07ca34e3162fdd6ec
> "virtio: Drop out of coroutine context in virtio_load()":
>=20
> https://gitlab.com/mjt0k/qemu/-/commit/92e2e6a867334a990f8d29f07ca34e3162=
fdd6ec
>=20
> This is a bugfix which I tried to cherry-pick (btw, I dunno yet if it sho=
uld
> go to 8.0 or 7.2 to begin with, asked this in another email, but it still
> serves as an example).  Original patch adds coroutine_mixed_fn to some ex=
isting
> functions and to a newly added function.
>=20
> The patch introducing coroutine_mixed_fn marker is v7.2.0-909-g0f3de970 .
> This is actually a very good example of a way how things are done best,
> an excellent example of what I'm talking here, - this 0f3de970 only intro=
duces
> the new concept (to be widely used), not converting everything to it
> right away.  So it's a good example of how things can be done right.
>=20
> But this 0f3de970 change is based on earlier change which split things up
> and moved stuff from one place to another, and which is too large to
> backport.  So even if 0f3de970 did an excellent job, it is still of no
> use in this context.
>=20
> I decided to drop coroutine_mixed_fn markings in the fix for 7.2 in this
> context, - again, if this particular fix is needed there to begin with,
> which is a question unrelated to this topic.
>=20
>=20
> A better example is a trivial thing with RETRY_ON_EINTR introduction.
> A trivial macro which replaced TFR in
>=20
> commit 37b0b24e933c18269dddbf6b83f91823cacf8105
> Author: Nikita Ivanov <nivanov@cloudlinux.com>
> Date:   Sun Oct 23 12:04:22 2022 +0300
>=20
>     error handling: Use RETRY_ON_EINTR() macro where applicable
>=20
> if this change were split into two, first introducing the new macro
> and second converting existing code & removing old macro, it'd be
> possible to just cherry-pick the first part and thered' be no need
> to modify further cherry-picks which uses RETRY_ON_EINTR.
>=20
> But once again, this all is definitely not as important as getting
> good code into main :)

I see, thank you!

Stefan

--d6wZIQz3/8Oeij/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUC9/8ACgkQnKSrs4Gr
c8jaHggAvvZmoWKW66Z6J6aqkvameQiACrJFRh0jY5Vh+ox5L8a4jvpihCStGqtk
YutJgwhKoaes8oEzqnEdu1vehX1/f8Nw3IOIn/Wo3hWcxS6VFclGLnbQtIQVUI3K
v6Ch/Qv3E0UoWQtnfvoW7fPOUJ5/xBIhTw1BUo8RIVonLi/hHCBr+jbvHNZ6lURJ
czWm+wBvZsfFjxT+ljAOBo6e59pN6OrLxAt9VmChUO1Z1K5lQ0jiA53QcY6iQWvu
Sqche5hud8yJDfsi+c/ncG6k0OmAqm0nd6ttwsW+SP6F1srGhrhep17EnTmjABQS
RFSxBmAFJWkYZ3JMCV5/wEZynrJJUQ==
=QtvI
-----END PGP SIGNATURE-----

--d6wZIQz3/8Oeij/h--


