Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D89784A70
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYX44-0007zP-44; Tue, 22 Aug 2023 15:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX40-0007pz-Hi
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYX3y-0003Ge-9a
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692732553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFYwEeEAQh5Ea4QBzkZcBpq1B1olnrAooNxCAKkUvFs=;
 b=e36ihgnF0FnvJqa/Yp1BnFebKiDS/YDu09wMf+xPz9ayvwc2IvpB6ZPYlZmDgxGH7sKBk9
 wsu4XZh2+LXkXoumd81eBlmbPSx/VhFSkZmg8PF4CklvCyE4gTS3U4B3OtXdRjHRkdxn+v
 lS5KLkJtt70GxW9XGQaiESrY7ZRwmC8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-kx9Q8-bQMXaSKoStrvZ6DQ-1; Tue, 22 Aug 2023 15:29:11 -0400
X-MC-Unique: kx9Q8-bQMXaSKoStrvZ6DQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1331D800193;
 Tue, 22 Aug 2023 19:29:11 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C7F92026D76;
 Tue, 22 Aug 2023 19:29:10 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:29:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 15/21] block: Mark bdrv_child_perm() GRAPH_RDLOCK
Message-ID: <20230822192909.GS727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-16-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v+sLsuqbXECFGC+5"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-16-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--v+sLsuqbXECFGC+5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:14PM +0200, Kevin Wolf wrote:
> This adds GRAPH_RDLOCK annotations to declare that callers of
> bdrv_child_perm() need to hold a reader lock for the graph because
> some implementations access the children list of a node.
>=20
> The callers of bdrv_child_perm() conveniently already hold the lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int-common.h | 10 +++++-----
>  block.c                          | 11 ++++++-----
>  block/copy-before-write.c        | 10 +++++-----
>  3 files changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--v+sLsuqbXECFGC+5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlDIUACgkQnKSrs4Gr
c8g0MggAkccJ2SCbtZdAxAoyH2cViGPGEHWLp8U1bcFojPH9rzRlghedEyjAQ8Pk
E9xmuFGmbG7aVo+SnAJVcyHfBQRW8BTxTs0908pC7CzjikcONPa9I5xufYQT8/y4
q+6UzL9HOwLYhOrLVEyc87wYuIcyLX6wt3PgJnQqgLCEeNevHCTGjMce8A5irX9c
3Iuz+yoeGBAMD0XDwCFE1+WvsHSJ8Gm52d6MU2U43CNyM7T8NCsmg/3SL4r9fldZ
b41QkZS6mQtxKG81sUvxVy/X8EykKL9fCBgGTEELJ3mIOzarI0lG1nUgQcWlnSI+
ocUPIz5cpvnG1W+re79ZFjQ4Jk1DwQ==
=zvG7
-----END PGP SIGNATURE-----

--v+sLsuqbXECFGC+5--


