Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A65BD830797
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:08:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6a8-0006fo-3a; Wed, 17 Jan 2024 09:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQ6a3-0006d6-W6
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQ6a2-0001r3-CL
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705500465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xHJSpZihf54gMyT2D/VWA5uo29jLB6aVTPXfolxdZ5Q=;
 b=ch5BwQ0Er/SFNXHVF5tikjm+gzV/SKegtf9xPfwInfdjHwCewTD9xIXLO9DrrBTDxowDEv
 FfeQsj3ZZcgGYxwwbeaMQhqQICl5N3AGmHsxEcdoli/EwURy4HaYK20KKlv40Aplh5qBO2
 HNWM5nmG7iURL3b7pSpE98MiQdpSE2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-86RR9BCBPZKbtIS8H1Tujw-1; Wed, 17 Jan 2024 09:07:39 -0500
X-MC-Unique: 86RR9BCBPZKbtIS8H1Tujw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4499D85CDE5;
 Wed, 17 Jan 2024 14:07:39 +0000 (UTC)
Received: from localhost (unknown [10.39.194.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0602026D6F;
 Wed, 17 Jan 2024 14:07:38 +0000 (UTC)
Date: Wed, 17 Jan 2024 09:07:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Lingfeng Yang <lfy@google.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] coroutine-ucontext: Save fake stack for pooled
 coroutine
Message-ID: <20240117140736.GA1399147@fedora>
References: <20240117-asan-v2-1-26f9e1ea6e72@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kM3EYjLoqBAfyAUp"
Content-Disposition: inline
In-Reply-To: <20240117-asan-v2-1-26f9e1ea6e72@daynix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--kM3EYjLoqBAfyAUp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 04:06:02PM +0900, Akihiko Odaki wrote:
> Coroutine may be pooled even after COROUTINE_TERMINATE if
> CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
> such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
> I'm seeing stack corruption without fake stack being saved.
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Added missing set_current() (Marc-Andr=E9 Lureau)
> - Added G_STATIC_ASSERT(!IS_ENABLED(CONFIG_TSAN)) (Marc-Andr=E9 Lureau)
> - Renamed terminate() to terminate_asan() for clarity and consistency.
> - Changed terminate_asan() to call start_switch_fiber_asan() for
>   consistency.
> - Link to v1: https://lore.kernel.org/r/20240112-asan-v1-1-e330f0d0032c@d=
aynix.com
> ---
>  util/coroutine-ucontext.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--kM3EYjLoqBAfyAUp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWn3ygACgkQnKSrs4Gr
c8gy1Qf9GtM23Q7RSnBNxYFwz12ey4+aZpxQscK9WpHm51KHSwAAWjvJmCL1xLoo
mZtvAWpbQj+IHKCxTEAhqSeI3BCyDwt9LPaHarqLguyWeVzk2CBb5juuKID/fNqA
gY2vb/X8Vv07lhLoke5aYHNpVfdzr6VA1ZibmuviirAu2PSNQxWOMMS+tuLO9Rmn
abHLMlLStP/7Hh2B4q99zD/kLy2lwR0U+HipT4wpNwigK62J0z0nLuU+3cV/B6Ku
Gc2Eu/0UFDiaRimuxXbeQw4jxx6mQ0IdKtIYB/bNOfoaYlLOgX5/aftMjmkHS/i2
USu7jVOyeWDD4B7Lr4DXwLnnzX+YAg==
=QcPb
-----END PGP SIGNATURE-----

--kM3EYjLoqBAfyAUp--


