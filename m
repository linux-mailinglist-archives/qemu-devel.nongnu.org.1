Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8569787651
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDiF-0002A0-S9; Thu, 24 Aug 2023 13:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDh7-0001O1-WE
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDh3-0003qk-Il
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692896420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zIHo4ozo6+ZOanxKnuZquIOQxzFcXHWkZ6fjdljRWco=;
 b=Qhy70neXzvOHyZJuuLJGRYiPFoaVw36anM3xKSYmYJ7hMuRn+yDj7LBan5iploYEs7oOi8
 jzPnARyoXVl7qXp26N8nkeFwlfpUO6MsEm3YVfM9qSBvbERKaT7mSsM9D/Vw0D7u5M/nxj
 rdNQFf78ymjFZ2204Esxo9T2AmWGunE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-VzLcZxukNZSEB1cyabfWHA-1; Thu, 24 Aug 2023 13:00:13 -0400
X-MC-Unique: VzLcZxukNZSEB1cyabfWHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DC092807D65;
 Thu, 24 Aug 2023 17:00:13 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15E4C40C2073;
 Thu, 24 Aug 2023 17:00:12 +0000 (UTC)
Date: Thu, 24 Aug 2023 13:00:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH] aio-posix: zero out io_uring sqe user_data
Message-ID: <20230824170011.GA1689529@fedora>
References: <20230426212639.82310-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XaJm1GlTv1ruHL9X"
Content-Disposition: inline
In-Reply-To: <20230426212639.82310-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--XaJm1GlTv1ruHL9X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2023 at 05:26:39PM -0400, Stefan Hajnoczi wrote:
> liburing does not clear sqe->user_data. We must do it ourselves to avoid
> undefined behavior in process_cqe() when user_data is used.
>=20
> Note that fdmon-io_uring is currently disabled, so this is a latent bug
> that does not affect users. Let's merge this fix now to make it easier
> to enable fdmon-io_uring in the future (and I'm working on that).
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-io_uring.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan

--XaJm1GlTv1ruHL9X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTnjJsACgkQnKSrs4Gr
c8hN/wf+KM59T2lFLkKcYUJcOllgNn9cA4Gmhcl1Z3SysQ9XIFvFUbHwF/J/lVHK
iSv+Qpwpal2EziYMpvEz0ArJYw//wMJ1bkLTsv87YMOYct9ICa9Z20BhoDRCVXoV
OAis/U3lxfjlbPZUy+Lcg3ohvO45VtCYYbPe0K+tr94bmkG8QcrJkTTdyLRSZvYS
fCQYBAQ7ncRMeVrHK6rgz8f6GZN91UANH8zcsbe7yjJG5fg/C2UqtN5d7EqrYGD8
2TLz2DtfQzfThnil5cGn1AGfh963McVxTS14ZFHPnxJe3TpIY4iU2E+X9Mcf2YWR
UKYEPgS4GFkHt4a+i9hM+bI8DJDVvw==
=IJA7
-----END PGP SIGNATURE-----

--XaJm1GlTv1ruHL9X--


