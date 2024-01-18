Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB8831CAB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:37:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQURf-0002VL-Nh; Thu, 18 Jan 2024 10:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQURd-0002QP-W3
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:36:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQURc-0003Il-Bd
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705592199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uBsr17taPm2+ngokB6yZXJL+jXFS94NlZZ954vewxlc=;
 b=Nhg0bxF+P1Wm/737rnbcd4njqt4/G3j+5McHxj7PE8On+2oDRUpEUN3fzu4t2EjHAX5kpV
 hjUQdb6uRUeSqozbs9uqhQ/hXRVVeOZgWNJ6H5ks6mS2yt9eDZKJMLQIB+7FK5IzdRoJyo
 GvICWIbJDB8YfWgqFJgzemU1Pzx1WcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-W-EP2NyTMViZO4pgZHqzDg-1; Thu, 18 Jan 2024 10:36:37 -0500
X-MC-Unique: W-EP2NyTMViZO4pgZHqzDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09DA1185A780;
 Thu, 18 Jan 2024 15:36:37 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3F492BA;
 Thu, 18 Jan 2024 15:36:35 +0000 (UTC)
Date: Thu, 18 Jan 2024 16:36:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 2/3] iotests: port 141 to Python for reliable QMP testing
Message-ID: <ZalFggPWyDEfZhRc@redhat.com>
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <20240116190042.1363717-3-stefanha@redhat.com>
 <ZagWlhbvlH4Ff01S@redhat.com> <20240118145513.GA1490473@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ruCH36XGeUsN9xyP"
Content-Disposition: inline
In-Reply-To: <20240118145513.GA1490473@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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


--ruCH36XGeUsN9xyP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 18.01.2024 um 15:55 hat Stefan Hajnoczi geschrieben:
> On Wed, Jan 17, 2024 at 07:04:06PM +0100, Kevin Wolf wrote:
> > Am 16.01.2024 um 20:00 hat Stefan Hajnoczi geschrieben:
> > > The common.qemu bash functions allow tests to interact with the QMP
> > > monitor of a QEMU process. I spent two days trying to update 141 when
> > > the order of the test output changed, but found it would still fail
> > > occassionally because printf() and QMP events race with synchronous Q=
MP
> > > communication.
> > >=20
> > > I gave up and ported 141 to the existing Python API for QMP tests. The
> > > Python API is less affected by the order in which QEMU prints output
> > > because it does not print all QMP traffic by default.
> > >=20
> > > The next commit changes the order in which QMP messages are received.
> > > Make 141 reliable first.
> > >=20
> > > Cc: Hanna Czenczek <hreitz@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
> > iotests 297 finds problems with the new Python code:
> >=20
> >  =3D=3D=3D pylint =3D=3D=3D
> > +************* Module 141
> > +141:82:0: C0301: Line too long (86/79) (line-too-long)
> > +141:93:0: C0301: Line too long (86/79) (line-too-long)
> > +141:94:0: C0301: Line too long (80/79) (line-too-long)
> > +141:106:0: C0301: Line too long (85/79) (line-too-long)
> > +141:107:0: C0301: Line too long (82/79) (line-too-long)
> > +141:109:0: C0301: Line too long (82/79) (line-too-long)
> > +141:117:0: C0301: Line too long (86/79) (line-too-long)
> > +141:120:0: C0301: Line too long (86/79) (line-too-long)
> > +141:129:0: C0301: Line too long (86/79) (line-too-long)
> >  =3D=3D=3D mypy =3D=3D=3D
> > +141:104: error: Value of type variable "Msg" of "log" cannot be "dict[=
str, Any] | None"  [type-var]
> > +141:114: error: Value of type variable "Msg" of "log" cannot be "dict[=
str, Any] | None"  [type-var]
> > +Found 2 errors in 1 file (checked 37 source files)
>=20
> I'm not sure how to run this but I manually ran pylint and mypy and
> fixed those errors. Can you share how you ran this?

I already answered this in IRC, but for the record: This is from running
qemu-iotests 297, which is kind of a meta-test that runs the linters on
Python files in qemu-iotests.

> The mypy errors are because the type system cannot express that
> event_wait() only returns None when timeout=3D0. That's not the case in
> 141 but mypy complains anyway, so I added an assertion that event is not
> None to silence mypy.

Sounds like the right solution to me.

Kevin

--ruCH36XGeUsN9xyP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmWpRYIACgkQfwmycsiP
L9YVWg/+NSL7qC6onWYQoZuejd6k5eMGCBf9y4J+b07Kf0G88Em1eJD9Le9pBkxy
SeEFIFNGoenSUxeU//RsJroDBBd47XUoZ0Ou3yYbC5XCYKThpseuYmkIzzwO66OJ
obOhznct/jS740sMuCwfsAV+sxSZC7f66SMvwscppYLVBM2R0K57dIGn05K5FT7I
qVyGQ08fqC7RmsXCYPHj5l6uuhI38jpc8ejsiX699d01mXp3LxEFPnFytmlY5LEF
OOCYDJG2YfGgu4+9eh2uW8Dimv0tuSCY/SDxL2u5lalGQyQNYomkDJl4NJhJXq7e
H+KCyBzmE2v4jmeNmel+TnBBxj8Erm8heTzYw8oR3tW4ZS75rKSVLc9IjAYS7d2i
CGjT+T+vzgXHh/32dU1BQikVI6uNPluB38TAl+IB05BrTxsFeBWl/kLYgB5a0Ts2
XbAQpXO1GmyOlGG5Gvht1uC0UaafVigcUYWKTFul508lEKWF1VtrNaxoRxpJQi+I
cXdkgio1+84J6fsNBn141/Oascs44mEtaKn57jcBPrHxj/091agWBrSiCySYYnwr
ZBTzOfSPtKKHdoy0AcCl/GA/jucRsAB+fEZ+hIQvnVJG9MC8S9mdQa3fVU9kG5It
uThSAvR8BmyqVIu1EyJsOTslo2A1PDNjMMjy6EL++f8BqvhLX+Q=
=HjUt
-----END PGP SIGNATURE-----

--ruCH36XGeUsN9xyP--


