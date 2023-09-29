Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A77B34BD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEJI-0002im-9Y; Fri, 29 Sep 2023 10:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmEJE-0002ft-K2
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmEIz-0005wA-1L
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695997039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4s8b5Q3DdWWPNU7hC48hH8McgdGdd+l5baAMgps4Us=;
 b=aLLcimZYrfxRyYzG/sg1H2+yk6tI+X7rktDgCpErXaJCOnU9lQEqiIsARStNc9PzIPb4Gu
 KNAp/byPqJu5N7K/WMzkDk6KqwyNyORnX2d+0E7AK5P3t17AlTa9Fu+MYB/9z60n31DZzL
 Ex80WAcA7S3DT2Zaj6Z2SfksbHMJiDU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-xCigsRRmMpGN0KKY_EigzA-1; Fri, 29 Sep 2023 10:17:17 -0400
X-MC-Unique: xCigsRRmMpGN0KKY_EigzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B12CA3823327
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:17:16 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43C1A14171B6;
 Fri, 29 Sep 2023 14:17:16 +0000 (UTC)
Date: Fri, 29 Sep 2023 16:17:15 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 0/9] qapi-go: add generator for Golang interface
Message-ID: <eeygtf2rmghwvfpnqesuzcub5gpkp4h7gpg5yptycj6o4m7jby@5hfu3laepdch>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <ZRWCSzrqDojlPOO4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="67tznx6o7codry6m"
Content-Disposition: inline
In-Reply-To: <ZRWCSzrqDojlPOO4@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--67tznx6o7codry6m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 02:40:27PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 27, 2023 at 01:25:35PM +0200, Victor Toso wrote:
> > Hi, long time no see!
> >=20
> > This patch series intent is to introduce a generator that produces a Go
> > module for Go applications to interact over QMP with QEMU.
>=20
> snip
> =20
> > Victor Toso (9):
> >   qapi: golang: Generate qapi's enum types in Go
> >   qapi: golang: Generate qapi's alternate types in Go
> >   qapi: golang: Generate qapi's struct types in Go
> >   qapi: golang: structs: Address 'null' members
> >   qapi: golang: Generate qapi's union types in Go
> >   qapi: golang: Generate qapi's event types in Go
> >   qapi: golang: Generate qapi's command types in Go
> >   qapi: golang: Add CommandResult type to Go
> >   docs: add notes on Golang code generator
> >=20
> >  docs/devel/qapi-golang-code-gen.rst |  341 +++++++++
> >  scripts/qapi/golang.py              | 1047 +++++++++++++++++++++++++++
> >  scripts/qapi/main.py                |    2 +
> >  3 files changed, 1390 insertions(+)
> >  create mode 100644 docs/devel/qapi-golang-code-gen.rst
> >  create mode 100644 scripts/qapi/golang.py
>=20
> So the formatting of the code is kinda all over the place eg
>=20
> func (s *StrOrNull) ToAnyOrAbsent() (any, bool) {
>     if s !=3D nil {
>         if s.IsNull {
>             return nil, false
>     } else if s.S !=3D nil {
>         return *s.S, false
>         }
>     }
>=20
>     return nil, true
> }
>=20
>=20
> ought to be
>=20
> func (s *StrOrNull) ToAnyOrAbsent() (any, bool) {
>         if s !=3D nil {
>                 if s.IsNull {
>                         return nil, false
>                 } else if s.S !=3D nil {
>                         return *s.S, false
>                 }
>         }
>=20
>         return nil, true
> }
>=20
> I'd say we should add a 'make check-go' target, wired into 'make check'
> that runs 'go fmt' on the generated code to validate that we generated
> correct code. Then fix the generator to actually emit the reqired
> format.

As mentioned in another thread, my main concern with this is
requiring go binaries in the make script. Might be fine if the
scope is only when a release is done, but shouldn't be a default
requirement.

> Having said that, this brings up the question of how we expect apps to
> consume the Go code. Generally an app would expect to just add the
> module to their go.mod file, and have the toolchain download it on
> the fly during build.
>=20
> If we assume a go namespace under qemu.org, we'll want one or more
> modules. Either we have one module, containing APIs for all of QEMU,
> QGA, and QSD, or we have separate go modules for each. I'd probably
> tend towards the latter, since it means we can version them separately
> which might be useful if we're willing to break API in one of them,
> but not the others.
>=20
> IOW, integrating this directly into qemu.git as a build time output
> is not desirable in this conext though, as 'go build' can't consume
> that.
>=20
> IOW, it would push towards
>=20
>    go-qemu.git
>    go-qga.git
>    go-qsd.git
>=20
> and at time of each QEMU release, we would need to invoke the code
> generator, and store its output in the respective git modules.

In which point, I think it is fair to run the gofmt and goimports.
Still, if you think it isn't a problem to add such make check-go
target with tooling specific to go code in them, I'll add that to
next iteration.

> This would also need the generator application to be a
> standalone tool, separate from the C QAPI generator.

It is. I mean, both run together now but that can be improved.

> Finally Go apps would want to do
>=20
>    import (
>        qemu.org/go/qemu
>        qemu.org/go/qga
>        qemu.org/go/gsd
>    )
>=20
> and would need us to create the "https://qemu.org/go/qemu" page
> containing dummy HTML content with=20
>=20
>     <meta name=3D"go-import" content=3D"qemu.org/go/qemu git https://gitl=
ab.com/qemu-project/go-qemu.git@/>

Neat. I didn't know this. Yes, we want that, but with different
name for the git [0]. Perhaps just another folder:

    https://gitlab.com/qemu-project/go/qemu.git
    https://gitlab.com/qemu-project/go/qga.git
    https://gitlab.com/qemu-project/go/gsd.git

> and likewise for the other modules.

[0] https://github.com/digitalocean/go-qemu

Thanks again for the reviews!

Cheers,
Victor

--67tznx6o7codry6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUW3GoACgkQl9kSPeN6
SE+Zfg/6AyQOgpZnPjLRRTvcINrpd/b/U9aRuYNWgNSoBgiKzOz3z9LxBlRgkHw/
mFBimKB4GC+uOmuLHCuwsrVqyjZndAPiOxP6Yd5MPWUVhWvDHuUQRa5ydgVlFtc6
gx8TnZ/uFEdTcGhH5W3hW2Qu3fCbHHYbKQlChxICfuASEDM/0jx0HonHwRnc3oXb
GKiVA5Ph0O49TGo6tm3JrMlir7je6znHs4EkW4QHVhH3uwZdV2fJxAOGEcduD8i8
9l5SzSXvq8dM158Xln+H9s3P2+5mdGjDIm02AFR55ehjWd5AQP5DtoqZOEPqYZ7a
aSoY5YS29UH7bR57uovtrv4/XejlkFge99Oq4UrPLKn6X2M/B40WNnJMF0nHXn2w
JseVPYNKOLE0rLqNZzKxMpSIJYrJk/B4m0mY7KWlqvquNIa317ZOQopxGfSu6g2q
JLg9zsrprcafVu/Qm/2GpgyZ6UWyX5E6zt7mn3KvVvMh5ATF+qn6N2JSEJUeHHnV
SzkbTQiPF5MHiEPQxQH9+ikW7sVauRFwU3uqK5dS/m8MTMmeUY0KwKZKU43IxlHI
aQKM/u0hmW82FttUwUw9i/tupyMFiQPIHCopeK1YjZsUU5lAHwjdmbrF0fo3JQl7
ZcHZGeXzMVc4hth2FsjpjP4/3ISFY4dxXvJQQqOEii7Ae65sQF0=
=Uqx7
-----END PGP SIGNATURE-----

--67tznx6o7codry6m--


