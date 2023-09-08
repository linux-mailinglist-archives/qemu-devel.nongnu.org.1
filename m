Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55803798477
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:54:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeXEm-00076e-DA; Fri, 08 Sep 2023 04:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeXEk-00076A-JF
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeXEi-00031n-GV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694163187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YU+VCBC+0bYtR0HeCXi0yTMGFlSFnM0soxgBueomiYQ=;
 b=eZFkjJ4tt8O4jmGVmFjBbyAzvKTe+AUDiK1KA1DU1j3pBRXzvFVTfme7+3RqregS4uWhK4
 TgOjf+lt+jSZiEQKsytWtrJFu/NiXsjTF/BIryIPEeqVpQxBBqYJi3eH0pU9Gg5owVJdfe
 ejEZLa9pT24oo6PGBaY7UUTJ3QNAW3o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-9qf2KcexMlef6LdSvtCWjA-1; Fri, 08 Sep 2023 04:53:03 -0400
X-MC-Unique: 9qf2KcexMlef6LdSvtCWjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09B473815F6A;
 Fri,  8 Sep 2023 08:53:03 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E90D1121314;
 Fri,  8 Sep 2023 08:53:01 +0000 (UTC)
Date: Fri, 8 Sep 2023 10:53:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 0/2] virtio: Drop out of coroutine context in virtio_load()
Message-ID: <ZPrg7L2lpggb9enZ@redhat.com>
References: <20230905145002.46391-1-kwolf@redhat.com>
 <20230907184200.GB1560640@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+VR9JvWk8/2GIEag"
Content-Disposition: inline
In-Reply-To: <20230907184200.GB1560640@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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


--+VR9JvWk8/2GIEag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.09.2023 um 20:42 hat Stefan Hajnoczi geschrieben:
> On Tue, Sep 05, 2023 at 04:50:00PM +0200, Kevin Wolf wrote:
> > This fixes a recently introduced assertion failure that was reported to
> > happen when migrating virtio-net with a failover. The latent bug that
> > we're executing code in coroutine context that was never supposed to run
> > there has existed for a long time. However, the new assertion that
> > callers of bdrv_graph_rdlock_main_loop() don't run in coroutine context
> > makes it very visible because it's now always a crash.
> >=20
> > Kevin Wolf (2):
> >   vmstate: Mark VMStateInfo.get/put() coroutine_mixed_fn
> >   virtio: Drop out of coroutine context in virtio_load()
> >=20
> >  include/migration/vmstate.h |  8 ++++---
> >  hw/virtio/virtio.c          | 45 ++++++++++++++++++++++++++++++++-----
> >  2 files changed, 45 insertions(+), 8 deletions(-)
>=20
> This looks like a bandaid for a specific instance of this problem
> rather than a solution that takes care of the root cause.
>=20
> Is it possible to make VMStateInfo.get/put() consistenty coroutine_fn?

I think it is. Note that this doesn't solve the problem, virtio_load()
calls functions that must run _outside_ coroutine context. So once the
migration code is cleaned up to consistenly run in coroutine context,
you can remove the check and the one line for the !qemu_in_coroutine()
case from this series. The rest stays as it is.

It is not a solution that takes care of the root cause, but I also can't
think of one. The problem is that VMState callbacks both read/write the
migration stream (which should be done in coroutine context) and set the
device state (which can involve functions that must not run in coroutine
context). Untangling this, if possible at all, is not easy and certainly
not something for stable releases.

Kevin

--+VR9JvWk8/2GIEag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmT64OwACgkQfwmycsiP
L9auKhAAo9wGR7K1QDHMv+cmS/1Lrnc6DyIpOMKGI/oSYli+KL+kWUljqfHZ5Qsn
sXSIfXoyOPiGmx4TdTEtKTvjrH1W2/eMHyAlwydC45yhsuUA2vje8vWZJ203xc7m
pacnCBx7lf480ZtXbWYcDlFizlE//F66TEqtJBjb1u6xJT4njDhELsDvyef40Blz
qbPyBc1kNF6KYlPo3BZJMAer4aiUpONJA1ok/L63llwD/vMRfHFu2nUxVHGrhSRL
fJDjiOZ49AuBv/g+oSOBHI+95xwyeXCD7vqH7yoSg4b57kc2qupOw2zBlLBysiCJ
4J1De3H2qlqCAaMeySdjQonJDehANxyzLMB1KMuKB8xDNIfqG3+RSzV5vpGD5Cti
7TfwRwPcWSFHiCk9kTLWADv+LUpKSUO1e/NA2Y7IRlJ4TGzqQquiy+Xrgyf8y7ef
fAAUqzSxNSlZ9Tz3ZzBXzJO8RTSfbt8BmgDQJDGiZxlzB9kmsdAkuqqfKdD5/oiv
oGJgIXzKv0CmJ+9TEvO+cJumehND6pV2JjHiAerggCBYQ4ksWQl03Q2fvEXd6JT5
vfAOt2Ae1s1gqW0YMuPqO+lgfeqRBtQ3srFLUmt2xr7owntl6Nn2TG5LJMgizLF0
DX1Qf9xElijfbx5SGD9T8ZXmnCNQ9PlXfJ6TZi63uBt5r5GV2Sc=
=MV1w
-----END PGP SIGNATURE-----

--+VR9JvWk8/2GIEag--


