Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EF9763FE6
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:44:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOkJQ-00026b-PK; Wed, 26 Jul 2023 15:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOkJM-00025J-6e
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 15:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOkJJ-0002nJ-Oa
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 15:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690400192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EA0QnIHWHj6RHqaubWZB5CW9gLweGNB6iJB4ceq3HTo=;
 b=eMQWiPMMQ+gNriH/gUTdQo6Vlnev9RhkMc1gx/dFIkKDCHLpFC/YysSKK7xFYIWxPEHN7r
 dkNw1obWtDOKRxpbmzN95Z7jN+4McZiXjZh4PkFgiM2o24E5k54YZe5Z1AooHeJd+MIbpG
 7jmSSVvTP6CsfD7BePdiPe4jQZfTAHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-NLRm-ZtPNC2tRE1A-mEp1w-1; Wed, 26 Jul 2023 15:36:29 -0400
X-MC-Unique: NLRm-ZtPNC2tRE1A-mEp1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF54A10504AF;
 Wed, 26 Jul 2023 19:36:28 +0000 (UTC)
Received: from localhost (unknown [10.39.195.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3460E1454147;
 Wed, 26 Jul 2023 19:36:27 +0000 (UTC)
Date: Wed, 26 Jul 2023 15:36:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, thuth@redhat.com,
 lvivier@redhat.com, jeuk20.kim@samsung.com
Subject: Re: [PATCH v7 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
Message-ID: <20230726193626.GD822884@fedora>
References: <cover.1690348453.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qgPIlP6mFkmHyIDf"
Content-Disposition: inline
In-Reply-To: <cover.1690348453.git.jeuk20.kim@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--qgPIlP6mFkmHyIDf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 02:30:49PM +0900, Jeuk Kim wrote:
> Since v6:
> - Add tests/qtest/ufs-test.c to test ufs initialisation and I/O
> - Add struct UtpTaskReqDesc to include/block/ufs.h
> - Fix ufs_log2() logic
> - Fix ufs-lu to use 4K as default block size to match the ufs spec
>=20
> Since I created a new file, tests/qtest/ufs-test.c, I added Laurent Vivie=
r to the cc list.
> Thank you.

Modulo the comments about the test case:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qgPIlP6mFkmHyIDf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTBdboACgkQnKSrs4Gr
c8jdXAf/eVHW9ImyUlAcokKvTPBrBrCa9D+9sereYQX3FCm+CX9/AEt5UVb/O4dj
ytrv7PWCWZvG0sz45h6TYpy3RkJDIzshK8LSpUVs18nfJzoPQ7nYcdF8Ecjkd0In
fExquj0kIx5dU34j21maqP1dcgsGqsPom1c51KnmN5fXJcvy6DW0a3lHM9G4GgLT
3iHRXCyG6En9bNDTxd+46FnrivUYEln5EV0y+P6p1S/7LL+m8B+CJx9WBmdaH73t
q52kKa6MoCR8r7KCEcltMYmYrUOcEyaBWQXZuPE2W6I9eDAcWw22wi0r1L+IfVWH
uywhNNcLLX9YtOgn8JvgrmSDzObnkg==
=0Kpq
-----END PGP SIGNATURE-----

--qgPIlP6mFkmHyIDf--


