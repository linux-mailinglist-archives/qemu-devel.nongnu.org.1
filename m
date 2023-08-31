Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2037778F358
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 21:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbnMD-0007x8-3F; Thu, 31 Aug 2023 15:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbnM6-0007wp-Uv
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbnM4-0004Qj-R8
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693510164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=INifk8Wzg5ClxYA37uJo9jBh+4BwXwZSc/cSQpNueiA=;
 b=K/DincGHfIrqTZQiOVy8utYrPj/kh4FSWCrJGkGmOdolfmGzsaf9bozUoOm7aBD2P81xVV
 5EenMWAWqqzsshKSbtjg4k6UkbL2SRMSmCHkrsbLINA0+2vlMPa2mwa2Vic7ekSGYUEAI2
 iyC2OignP4O05UJysymFu3a+d338NLI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-YUgnOZZ2OJqpj5Xa4FfdFg-1; Thu, 31 Aug 2023 15:29:20 -0400
X-MC-Unique: YUgnOZZ2OJqpj5Xa4FfdFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA7A1101A528;
 Thu, 31 Aug 2023 19:29:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1931E63F78;
 Thu, 31 Aug 2023 19:29:18 +0000 (UTC)
Date: Thu, 31 Aug 2023 15:29:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 idryomov@gmail.com, pl@kamp.de, sw@weilnetz.de,
 sstabellini@kernel.org, anthony.perard@citrix.com, paul@xen.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 fam@euphon.net, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com, kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 4/7] block/dirty-bitmap: Clean up local variable shadowing
Message-ID: <20230831192917.GD532982@fedora>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-5-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tIfqpFIfVVHA1ixk"
Content-Disposition: inline
In-Reply-To: <20230831132546.3525721-5-armbru@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--tIfqpFIfVVHA1ixk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 03:25:43PM +0200, Markus Armbruster wrote:
> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Tracked down with -Wshadow=3Dlocal.
> Clean up: delete inner declarations when they are actually redundant,
> else rename variables.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/monitor/bitmap-qmp-cmds.c | 2 +-
>  block/qcow2-bitmap.c            | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tIfqpFIfVVHA1ixk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTw6g0ACgkQnKSrs4Gr
c8jWEwf+Kosm+TTeTGNka9BQx3xY7odgQIG4HcGKBw2zzziO2vdrattnvfM/JphK
XVpnbnoig/2QDLdaoihgdA7e6siuMf36FdNBJ4Y/MwxNmHd1oQ393xLrYSDVf1fn
GS9zTOsCMp+Sp82nzQgl07vfQvhrx09NaVwrIS2FPidXus/hDKy7CwZ/uv93nw6g
H1JnL4k1/PJeGjxbLGj37QbNrY5qFdRxR5SJXuDRPLvCQjCr/LB/lRZQBodcjyL9
jeFpLUxNdF8T7RzOE/rt1w8gXzN0RhlR1ejRMnU2pxQ3yqVmTwGDyxUzdKW5V8Ex
ILImHY9up1L4mVZWqtF4E6Zda21Plw==
=JdC8
-----END PGP SIGNATURE-----

--tIfqpFIfVVHA1ixk--


