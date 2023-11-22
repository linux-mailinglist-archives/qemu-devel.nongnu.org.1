Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0417F5201
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 22:03:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5uMZ-00071P-Jz; Wed, 22 Nov 2023 16:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5uMX-00070Z-B0
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 16:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r5uMT-0000CJ-8e
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 16:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700686932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKCodkJ+pQL+VXok1mDUx1CJHwEBtcL1/pfh1V23HGs=;
 b=KlsICBtbg3oywnWSkG2nHGQ+I3LXKEjOpv0pQXT6LrytrE/hvLk/MH8fNooUD7wPvEo3Vi
 WjMjew2fKYCyCkL16/z1LYIH3gQ9ToewJ/TJudPCeP2YHy019/yhqpa9Wln5CGxDLU+3bQ
 LN5tqxYTHWx4TlIi9H3POMavrEqnC7I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-JEWPZ88vMdmJ__pdF1mq6g-1; Wed,
 22 Nov 2023 16:02:08 -0500
X-MC-Unique: JEWPZ88vMdmJ__pdF1mq6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 734D21C0BB4B;
 Wed, 22 Nov 2023 21:02:07 +0000 (UTC)
Received: from localhost (unknown [10.39.192.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53CFB492BE0;
 Wed, 22 Nov 2023 21:02:06 +0000 (UTC)
Date: Wed, 22 Nov 2023 16:02:04 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-9.0] iothread: Remove unused Error** argument in
 aio_context_set_aio_params
Message-ID: <20231122210204.GC101774@fedora>
References: <20231120171806.19361-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fD9l2HtndGlQWTFd"
Content-Disposition: inline
In-Reply-To: <20231120171806.19361-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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


--fD9l2HtndGlQWTFd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 06:18:06PM +0100, Philippe Mathieu-Daud=E9 wrote:
> aio_context_set_aio_params() doesn't use its undocumented
> Error** argument. Remove it to simplify.
>=20
> Note this removes a use of "unchecked Error**" in
> iothread_set_aio_context_params().
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  include/block/aio.h | 3 +--
>  iothread.c          | 3 +--
>  util/aio-posix.c    | 3 +--
>  util/aio-win32.c    | 3 +--
>  util/main-loop.c    | 5 +----
>  5 files changed, 5 insertions(+), 12 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--fD9l2HtndGlQWTFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVebEwACgkQnKSrs4Gr
c8iBSwgAlbkyQkR2gJWNZyWM48b+YIvwytuDz68PkMEkrJYKcABUgKJARjEvzZzu
+5hy59EBUU+aL1Dq8c1ZHene/PzXGD5WCytvCghIjjKqMWTt1xQELoWlvivVF2Wb
20fje8pPYj4/3z+0PoCYEwFCS8HetgnU93bz/UEcfPSGLEn/eVSpN8nZQpJYKtm0
kDusJljzZma3OB6idn7R7oHtGENvejrUxJMTG3PC3rTN8o0lwpXLibl0VQ5lOHKk
YOdoTkWsBgkOmEVwmia/PGPOdbjrpkCg/+TMF7XdcAa5epfjYyclMIIiQWIvHr8K
u9kHV8P9MWynaBeTX0tNWA1QCNLrzQ==
=Jleq
-----END PGP SIGNATURE-----

--fD9l2HtndGlQWTFd--


