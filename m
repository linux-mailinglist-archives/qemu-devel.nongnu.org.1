Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A265831BDE
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:56:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTnl-0006D9-Bv; Thu, 18 Jan 2024 09:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQTnj-0006Cq-Lw
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQTni-0001qt-4F
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 09:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705589725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p7qX3Eq8GIIOpVpbe6ueUh7xJuLiBUIx6xmI28zFyVY=;
 b=W9q4OhzzztMMWmUjfYQQbfSjFmPZh8Yt+6rtCNyApwXihVAa6Xm2XCj1wZ0P9NU0RBm+aN
 764AanIFuEpMyx5PyFEd3wdIf6N8J7+/yMd2mVjxlJsCleAUzBk2xlesLB6Bob5SMUpNrL
 ADNtAFcSyt/Zb3vTWZzImOolkIdm75Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-EX8x7Js7PqGr1ecV_yr4Kw-1; Thu,
 18 Jan 2024 09:55:21 -0500
X-MC-Unique: EX8x7Js7PqGr1ecV_yr4Kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A3CC3C2AB10;
 Thu, 18 Jan 2024 14:55:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B29C8112D168;
 Thu, 18 Jan 2024 14:55:14 +0000 (UTC)
Date: Thu, 18 Jan 2024 09:55:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/3] iotests: port 141 to Python for reliable QMP testing
Message-ID: <20240118145513.GA1490473@fedora>
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <20240116190042.1363717-3-stefanha@redhat.com>
 <ZagWlhbvlH4Ff01S@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3tLiSQzlRO/fS15q"
Content-Disposition: inline
In-Reply-To: <ZagWlhbvlH4Ff01S@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--3tLiSQzlRO/fS15q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 07:04:06PM +0100, Kevin Wolf wrote:
> Am 16.01.2024 um 20:00 hat Stefan Hajnoczi geschrieben:
> > The common.qemu bash functions allow tests to interact with the QMP
> > monitor of a QEMU process. I spent two days trying to update 141 when
> > the order of the test output changed, but found it would still fail
> > occassionally because printf() and QMP events race with synchronous QMP
> > communication.
> >=20
> > I gave up and ported 141 to the existing Python API for QMP tests. The
> > Python API is less affected by the order in which QEMU prints output
> > because it does not print all QMP traffic by default.
> >=20
> > The next commit changes the order in which QMP messages are received.
> > Make 141 reliable first.
> >=20
> > Cc: Hanna Czenczek <hreitz@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> iotests 297 finds problems with the new Python code:
>=20
>  =3D=3D=3D pylint =3D=3D=3D
> +************* Module 141
> +141:82:0: C0301: Line too long (86/79) (line-too-long)
> +141:93:0: C0301: Line too long (86/79) (line-too-long)
> +141:94:0: C0301: Line too long (80/79) (line-too-long)
> +141:106:0: C0301: Line too long (85/79) (line-too-long)
> +141:107:0: C0301: Line too long (82/79) (line-too-long)
> +141:109:0: C0301: Line too long (82/79) (line-too-long)
> +141:117:0: C0301: Line too long (86/79) (line-too-long)
> +141:120:0: C0301: Line too long (86/79) (line-too-long)
> +141:129:0: C0301: Line too long (86/79) (line-too-long)
>  =3D=3D=3D mypy =3D=3D=3D
> +141:104: error: Value of type variable "Msg" of "log" cannot be "dict[st=
r, Any] | None"  [type-var]
> +141:114: error: Value of type variable "Msg" of "log" cannot be "dict[st=
r, Any] | None"  [type-var]
> +Found 2 errors in 1 file (checked 37 source files)

I'm not sure how to run this but I manually ran pylint and mypy and
fixed those errors. Can you share how you ran this?

The mypy errors are because the type system cannot express that
event_wait() only returns None when timeout=3D0. That's not the case in
141 but mypy complains anyway, so I added an assertion that event is not
None to silence mypy.

Thanks,
Stefan

--3tLiSQzlRO/fS15q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWpO9EACgkQnKSrs4Gr
c8htBQf9HGCsR7he5Vv5jReXdUnEudhDyqriSBWuRhRm8iy1KgJ94ih7HJS3dnrJ
Gn2/teYy8GfwlcXKtYRmbp0cTSmhilWs94FXgIVLbFBWAyIqzk8tbGomtHg9QUkL
u6REoF29MLveNqDtPasl2ftb91Os2nI0fd50E5ZDfNzcSoxtuHKIedHzj7a8yAd9
/VSXgSraC8XAU8kn/jaJhZfBBxTxGSmLbth1pgCoP4iqf6D+ZGA9oY6/w4XCa8eB
k0ve5PZtEn3Ph3CBJu6dGXUADM/xXJ3oBnrzwRVHyQAPStDOThjp8y/oqmB7ADJ3
Di8ZdCDKxkS9a7G3bqbom99zFYWXDw==
=Agi0
-----END PGP SIGNATURE-----

--3tLiSQzlRO/fS15q--


