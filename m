Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4D7B6FFE
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:38:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjJT-0000pR-Hb; Tue, 03 Oct 2023 13:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnjJF-0000WF-A2
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnjJD-0008LJ-Nh
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696354546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoDPE6Jp0SAGbalSUEQBMwNUPbi8A9taX+0DPotIgd8=;
 b=TCgjk7zO/skLMroL5neKln4BL46xqJytahUmCksma28HJHyqpra92Zhx3A888s/CnDi2C2
 gEkDFhSZVtwhpaRE97e/P6dyQAYqsXPXmwiyAU0lcZRdhi2GtMqbRuB1/BLl/MJOB6kM9k
 SUta+9nbx9qJPnO1/Y7dmL/+QWrdJKA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-6Nj8uNHWNpq73iOKfUi_bA-1; Tue, 03 Oct 2023 13:35:42 -0400
X-MC-Unique: 6Nj8uNHWNpq73iOKfUi_bA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BEDD185A79B;
 Tue,  3 Oct 2023 17:35:42 +0000 (UTC)
Received: from localhost (unknown [10.39.192.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0774E400E89;
 Tue,  3 Oct 2023 17:35:41 +0000 (UTC)
Date: Tue, 3 Oct 2023 13:35:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH RESEND] osdep: set _FORTIFY_SOURCE=2 when optimization is
 enabled
Message-ID: <20231003173540.GA1133503@fedora>
References: <20231003091549.223020-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BqiSaku87RX/lW5w"
Content-Disposition: inline
In-Reply-To: <20231003091549.223020-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--BqiSaku87RX/lW5w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 10:15:49AM +0100, Daniel P. Berrang=E9 wrote:
> Currently we set _FORTIFY_SOURCE=3D2 as a compiler argument when the
> meson 'optimization' setting is non-zero, the compiler is GCC and
> the target is Linux.
>=20
> While the default QEMU optimization level is 2, user could override
> this by setting CFLAGS=3D"-O0" or --extra-cflags=3D"-O0" when running
> configure and this won't be reflected in the meson 'optimization'
> setting. As a result we try to enable _FORTIFY_SOURCE=3D2 and then the
> user gets compile errors as it only works with optimization.
>=20
> Rather than trying to improve detection in meson, it is simpler to
> just check the __OPTIMIZE__ define from osdep.h.
>=20
> The comment about being incompatible with clang appears to be
> outdated, as compilation works fine without excluding clang.
>=20
> In the coroutine code we must set _FORTIFY_SOURCE=3D0 to stop the
> logic in osdep.h then enabling it.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>=20
> Re-sent due to previous bad patch submission
>=20
>  include/qemu/osdep.h         |  4 ++++
>  meson.build                  | 10 ----------
>  util/coroutine-sigaltstack.c |  4 ++--
>  util/coroutine-ucontext.c    |  4 ++--
>  4 files changed, 8 insertions(+), 14 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--BqiSaku87RX/lW5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUcUOwACgkQnKSrs4Gr
c8g/OQgAsIzXDjEUJaVcQAqyiMZ+31FTSwv/W/xV7XB70nMHg3XsdIKrotmhCoRm
7eTXZDVR6MYm5nWwTVwu8UrGq9TA/mGLqYQHR5S6pQGnw3l09ZzXWERK9blmKwsP
IHD++aJw0z6A/Ym615j2bSbAKaKv0g5F1VWBNQtNM0aJNd6DvUZ7wXLCJLkY6GQJ
CpYggi72zdv+oeFbnaqtHI9V0PVk78KPKXJkfz9qPBXG+DYzK902MTx61pa8rhGa
NhAwvqAH6jWMQ1qP8CNGLtMlkbBKJl55wtmu9bhZYDy+qR/GSYCs2nPPIhSoT2eB
hsz93aqMm4NZGEXlRBP8FGib2904mQ==
=xs4T
-----END PGP SIGNATURE-----

--BqiSaku87RX/lW5w--


