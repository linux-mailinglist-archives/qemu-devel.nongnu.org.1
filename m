Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C633726865
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:21:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6xlH-0005f1-HF; Wed, 07 Jun 2023 14:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q6xlF-0005ej-8k
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q6xlD-0003j8-SX
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686161994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xo6gsl+1xQZeVqpC73Fnj6zeS4yDW/fLHYbJlDXn784=;
 b=cK9iQamc+/SvW90oZK2baIXDe+dbaZQAP2rWsO+Syo8NdEksOuN3WCiW2P6rBA7vTgw3tM
 Lt76iY4JIlJeZfEd/o8aXCxAkrbkTgaH8x0U2a7sSW32S++opvR1j0ZTi884XVGDAdiPQ4
 O85fhRxcC0FxuYhZhMMt4kn3nbktHWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-rFO9vMBDOX2nzQH_u5OawQ-1; Wed, 07 Jun 2023 14:19:51 -0400
X-MC-Unique: rFO9vMBDOX2nzQH_u5OawQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2092385A5A8;
 Wed,  7 Jun 2023 18:19:51 +0000 (UTC)
Received: from localhost (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8247740D1B66;
 Wed,  7 Jun 2023 18:19:50 +0000 (UTC)
Date: Wed, 7 Jun 2023 11:59:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, jsnow@redhat.com,
 richard.henderson@linaro.org, thuth@redhat.com, philmd@linaro.org
Subject: Re: [PATCH] iotests: fix 194: filter out racy postcopy-active event
Message-ID: <20230607155949.GC2138915@fedora>
References: <20230607143606.1557395-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XQV1AaBGNWW0CJsD"
Content-Disposition: inline
In-Reply-To: <20230607143606.1557395-1-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--XQV1AaBGNWW0CJsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 05:36:06PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> The event is racy: it will not appear in the output if bitmap is
> migrated during downtime period of migration and postcopy phase is not
> started.
>=20
> Fixes: ae00aa239847 "iotests: 194: test also migration of dirty bitmap"
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>=20
> The patch fixes the problem described in
>   [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
> and we can keep the test in gitlab ci
>=20
>  tests/qemu-iotests/194     | 5 +++++
>  tests/qemu-iotests/194.out | 1 -
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XQV1AaBGNWW0CJsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSAqXUACgkQnKSrs4Gr
c8jdiggAyefIfDDvDpkG79oIFYlywnYheq+iHgnbsdVJeUIvhqX5Gsd4MlhpNoKX
s5Kia0eiwAZ3pmEwVSFX2IeLJoy5M2t3ZL4A5Dech+aAmkZ1AwuztVGJ4CIgjD4A
X75HWRu5AQqSgXv9fTnavPwjVfaYfWwEih/PL9G6/JaeN+pQwTpU8hPl8C/rtMp4
JT9cW8cG+z1nHBTpZ7jUNHC+x0zZ2eXFTQk59gVUUAVqz6xdg+LDEfhSYOAkpSbf
DR7TMeLco91JjoMwX5npE/x3kwCNGGw3DS/CxVKzAqyhlXjtNhck6X3UOP39RIVQ
Lr6MifKO95zPtiLSS1eyvpGtnvZqYg==
=M/hT
-----END PGP SIGNATURE-----

--XQV1AaBGNWW0CJsD--


