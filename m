Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C697A0AC3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 18:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgpB0-0006X3-32; Thu, 14 Sep 2023 12:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qgpAx-0006Vx-Ux
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qgpAu-0007TW-DJ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694708799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wj9DWGraM9I7d6+vD0broD3mqJFPbTn1YPyaMfQ+y9M=;
 b=C0Ao+/uvb0R4BmgRF8JuC7WulArMSjKzjAvQSSFp9/+isCZz2RxB+dF93d1CEsKjUrKVaf
 gWwEnRDEhPe9qRW4qGgocgNNMe6F3b0jY0KfXeV+wshNVi+Ru+5yRB4ENhxajWv/zeHcTP
 AHSlRu+TIrr/Kn5oaXB40HfIEAGL18E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-spwErKLoPha164h6BnsQuw-1; Thu, 14 Sep 2023 12:26:18 -0400
X-MC-Unique: spwErKLoPha164h6BnsQuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 080F3829DF9;
 Thu, 14 Sep 2023 16:26:17 +0000 (UTC)
Received: from localhost (unknown [10.45.224.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8855710F1BE7;
 Thu, 14 Sep 2023 16:26:16 +0000 (UTC)
Date: Thu, 14 Sep 2023 18:26:15 +0200
From: Victor Toso <victortoso@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 0/7] Validate and test qapi examples
Message-ID: <2uxfoihjtis7xntlr6o2e5f5jzeb3lnplglec5evrlmav5v2qn@5t5y2jwyfpdi>
References: <20230905194846.169530-1-victortoso@redhat.com>
 <ZPhDkJ+RvPauLfG6@redhat.com>
 <ixihnxsvwqtozpdfb5kavkjymflhdktgiq3bddpqqqjbnwyaid@cjgi7bofphbc>
 <440707e4-c855-99ce-0ca3-03250a0bd3d2@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="peyzklnobpdwhdme"
Content-Disposition: inline
In-Reply-To: <440707e4-c855-99ce-0ca3-03250a0bd3d2@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--peyzklnobpdwhdme
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 08, 2023 at 09:51:35AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 7/9/23 20:17, Victor Toso wrote:
> > Hi,
>=20
> > >    File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", =
line 118, in parse_examples_of
> > >      assert((obj.doc is not None))
> > >              ^^^^^^^^^^^^^^^^^^^
> > > AssertionError
> > > ninja: build stopped: subcommand failed.
> > >=20
> > > not sure if that's related to the examples that still need fixing or =
not ?
> >=20
> > This is related to the script being fed with data without
> > documentation. In general, asserting should be the right approach
> > because we don't want API without docs but this failure comes
> > from the tests, that is, adding the following diff:
> >=20
> > diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
> > index c14ed11774..a961c0575d 100644
> > --- a/scripts/qapi/dumpexamples.py
> > +++ b/scripts/qapi/dumpexamples.py
> > @@ -115,6 +115,10 @@ def parse_examples_of(self:
> > QAPISchemaGenExamplesVisitor,
> >=20
> >       assert(name in self.schema._entity_dict)
> >       obj =3D self.schema._entity_dict[name]
> > +    if obj.doc is None:
> > +        print(f"{name} does not have documentation")
> > +        return
> > +
> >       assert((obj.doc is not None))
> >       module_name =3D obj._module.name
> >=20
> > gives:
> >=20
> >      user-def-cmd0 does not have documentation
> >      user-def-cmd does not have documentation
> [...]
>=20
> > So, not sure if we should:
> >   1. Avoid asserting when running with tests
>=20
> This seems the most sensible option, adding an argument to
> the 'command' invoked by meson's test_qapi_files() target in
> tests/meson.build.

In a offline discussion with Markus, he pointed out to me the
existence of 'pragma': { 'doc-required': true }, which means we
can possibly avoid extra flags and changes in meson and handle
this in the generator. I'll update the code and submit, probably
Tomorrow :)

Cheers,
Victor

> >   2. Avoid running this generator with tests
> >   3. Add some minimal docs to the tests
> >=20
> > Both (1) and (2) are quite simple. Not sure if there is real
> > benefit in (3). If we should tweak qemu tests with this, should
> > be related to using the JSON output itself, to keep examples
> > correct.
>=20
> IMO (3) is a waste of time.
>=20
> Regards,
>=20
> Phil.
>=20
> > Cheers,
> > Victor
>=20

--peyzklnobpdwhdme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUDNCcACgkQl9kSPeN6
SE8J8hAAvE4DYuBcgwOKGZHwcHo+fBNrL0UhoMqDQlOVoczzyuvAe+iL7RQQ0/IC
DopOnAW+knYx9k3JB02sQp/XZptba3I2YTaGucKTz8jFVKAhJJ/bDw+6IatBf6pR
Rbq0aU74rDSGUZDRHkynnsKDBu1T3LSkrVjj3uEKGVPc3GoPl4IFzOrq1xfobtkD
Rj8Nila9jYyUIXGQCNP5YltjWe7anqSUN93lQhrfNnkfKhFBSPIM2E7Wr+5685kr
3j6BQV5sODVbnQ7biI7NKH/l5/tyJPCBVFQqFUjcUyfiN43awj+k4f6hNzhG7Zxc
1BBQSgB5r40Hc4vclksUjBIlSKwWQ49TvTEFMw96CnPXBV/iaj2UOX5BvPNrb30i
nCwA7No5YlXzh6D8nmpmYUssk4gd0/+7bzsHYU5ZBj+odIoLwSaGWLae1Bk4NgNM
m/lET+vETW1OnTy5D0ujNetZcwxCTwyu7vRLpt+mTVy6PPwih7ywYIOr9VYx0JDT
MtZEke/a8NeDErQpiI0MZ2ImLhAR/YPiw4BqjKQms46+65PuMDpVufmOEMm3CnrV
xsZssGlwoOmFZ3uy2PH5WlbiQ6/r8rI6a1L5SD5/G1SlypJ+oV8bb2K+wXx2Xk6C
o41WOC3kkS8DKUOc8ncTPl2l8bpTMro6NFHp3qnbnKdhFy5x4lM=
=3UDf
-----END PGP SIGNATURE-----

--peyzklnobpdwhdme--


