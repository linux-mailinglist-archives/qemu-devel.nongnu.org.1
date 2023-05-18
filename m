Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4397084A1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:06:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfCE-0006Ag-Dn; Thu, 18 May 2023 11:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzfCC-0006AI-3y
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzfCA-0007qq-4k
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684422333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=phScfOwKt72MDcjUN0AqA+SFUzrYjkbyh2NCbktujeE=;
 b=Q9OpFxAEUnqJu54u8L7ZAalusP5Exly7Y2Ras4C3pWY+3swaBy3m/CBCJM5LUWt16ig9qt
 83V9RJ2Emq2cXGv14QAet9AA4qrFuzlNXI7ATXfVsHgnq42s8AgOSwewr0M/XB6bL8ZsWS
 QHQtFvfgfOb5DSTU9yFu1euKenx8MLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-8_QCnTjNPZ6_PYNjrfUFsA-1; Thu, 18 May 2023 11:05:29 -0400
X-MC-Unique: 8_QCnTjNPZ6_PYNjrfUFsA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13DF2857E65;
 Thu, 18 May 2023 15:05:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FF3E492B01;
 Thu, 18 May 2023 15:05:27 +0000 (UTC)
Date: Thu, 18 May 2023 11:05:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PULL 17/18] aio-posix: do not nest poll handlers
Message-ID: <20230518150525.GB403983@fedora>
References: <20230517165116.475123-1-kwolf@redhat.com>
 <20230517165116.475123-18-kwolf@redhat.com>
 <fdb97449-d234-0d98-ed02-733ec1d33ac1@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a77WSmufvOvyc3qO"
Content-Disposition: inline
In-Reply-To: <fdb97449-d234-0d98-ed02-733ec1d33ac1@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--a77WSmufvOvyc3qO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 10:13:23AM +0300, Michael Tokarev wrote:
> 17.05.2023 19:51, Kevin Wolf wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > QEMU's event loop supports nesting, which means that event handler
> > functions may themselves call aio_poll(). The condition that triggered a
> > handler must be reset before the nested aio_poll() call, otherwise the
> > same handler will be called and immediately re-enter aio_poll. This
> > leads to an infinite loop and stack exhaustion.
> >=20
> > Poll handlers are especially prone to this issue, because they typically
> > reset their condition by finishing the processing of pending work.
> > Unfortunately it is during the processing of pending work that nested
> > aio_poll() calls typically occur and the condition has not yet been
> > reset.
> >=20
> > Disable a poll handler during ->io_poll_ready() so that a nested
> > aio_poll() call cannot invoke ->io_poll_ready() again. As a result, the
> > disabled poll handler and its associated fd handler do not run during
> > the nested aio_poll(). Calling aio_set_fd_handler() from inside nested
> > aio_poll() could cause it to run again. If the fd handler is pending
> > inside nested aio_poll(), then it will also run again.
> >=20
> > In theory fd handlers can be affected by the same issue, but they are
> > more likely to reset the condition before calling nested aio_poll().
> >=20
> > This is a special case and it's somewhat complex, but I don't see a way
> > around it as long as nested aio_poll() is supported.
> >=20
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2186181
> > Fixes: c38270692593 ("block: Mark bdrv_co_io_(un)plug() and callers GRA=
PH_RDLOCK")
>=20
> Is it not a stable-8.0 material?

Yes.

Stefan

--a77WSmufvOvyc3qO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRmPrUACgkQnKSrs4Gr
c8hekwf/ZlFAn4MXQD3ZVkdZE11x4050BqnHJSbpkSmtP2nUUYWoAAXDZ4+yTqPa
tgSL1sV6wWjipwF9tiX3caqKyNBNVQhjd/d8p3uofcQ5ZyrByUWmApVs/WVFquXZ
y5sRth+ADrWhee6eC44ADb5oQGSuo5U2MZtg5R+n92MCScCVWJoh7AbkBVDfwFkr
PwhNaZ/wquzs231EvdwskG9OSuD7QXpi90Oqbt+fC35JZ88DRnljQWtIvvZqsTSd
/w+4jYsjLTbtOyEeCYFOv8Oy+HbCQ3g0D9enmNOu7WHFg1A0nhO4MA2Xn6L3Lad+
hb8wsYKFUnO7jN9KUk/Ai1hjnpH7Ow==
=P76q
-----END PGP SIGNATURE-----

--a77WSmufvOvyc3qO--


