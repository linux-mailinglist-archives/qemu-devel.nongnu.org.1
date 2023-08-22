Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5E784A07
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWqA-0002kf-Kq; Tue, 22 Aug 2023 15:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWq0-0002ia-I3
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWpt-0007u3-4G
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692731678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LaPrpGCrt7WNKZeaHhGWUmNb4lJznF80+Z4VNJi5Xb8=;
 b=GVoQnWsE2n/FPE2QYiooZ//ILek5FeFU4KqqcbWLM+P5cRbqKFbc6M86MkDffRWRqBpTLj
 57r8IG4B5KWO8KKIXhkkF2r6VitTzUW0MAQWLwoPy1vEP58ICrJtPgP0oTu7ftEptu8QmM
 O2XoqlpJtcw3ZiY0Nwh7MBh4siI0pYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-r6l_JqRsNVGtk130XErPKw-1; Tue, 22 Aug 2023 15:14:36 -0400
X-MC-Unique: r6l_JqRsNVGtk130XErPKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44EAF853063;
 Tue, 22 Aug 2023 19:14:36 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2E4BC15BAE;
 Tue, 22 Aug 2023 19:14:35 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:14:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 09/21] block: Mark bdrv_replace_child_tran() GRAPH_WRLOCK
Message-ID: <20230822191434.GL727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LNjI3BCGSeVGagna"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-10-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--LNjI3BCGSeVGagna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:08PM +0200, Kevin Wolf wrote:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_replace_child_tran(). These callers will
> typically already hold the graph lock once the locking work is
> completed, which means that they can't call functions that take it
> internally.
>=20
> While a graph lock is held, polling is not allowed. Therefore draining
> the necessary nodes can no longer be done in bdrv_remove_child() and
> bdrv_replace_node_noperm(), but the callers must already make sure that
> they are drained.
>=20
> Note that the transaction callbacks still take the lock internally, so
> tran_finalize() must be called without the lock held. This is because
> bdrv_append() also calls bdrv_attach_child_noperm(), which currently
> requires to be called unlocked. Once it changes, the transaction
> callbacks can be changed, too.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 78 ++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LNjI3BCGSeVGagna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlCRoACgkQnKSrs4Gr
c8iVTggApq8amGMH9ubsCr5v2/VqIokQpM8Rt7DT8DbbCdKLi4THmGQIHedLviRo
W06CBcMX1Nv0YbwNJTpjl0ophp/MAPTfFnzXw4P0xIBizIC1QhlWrooQP3Fz/RlE
jUBN4spPDuNsVXn2OsE11RoYGNzUIOhW4gmkXWS4T1/0gCmxW5lCRh5bFJeGADK/
DG+WV4cVlaCYs+5/b0XZ0izHIqmcAu9zqud0kZSFT/vC9ScE+fdjrbph+KOr0r4O
iiOhiRsOqfRFlFquiPbOikJYE1V7KhS+CuNK4jc2UK3Kerv2XMl1JXeJ1s5CG71J
aP12a76utwRQYG+qgM+7guDowtD8XA==
=X5ls
-----END PGP SIGNATURE-----

--LNjI3BCGSeVGagna--


