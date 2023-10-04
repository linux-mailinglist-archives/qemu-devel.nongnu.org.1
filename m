Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00537B8609
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:02:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5Fo-0006ol-TF; Wed, 04 Oct 2023 13:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qo5Fl-0006ii-PE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qo5Fj-00047C-U6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuTPpurZEhEiDhFS+JP6w1KJ5x2vdWVL0TsT4kA1LKE=;
 b=MWDjoLke3nVBk0u+64KTO8n8W0HYJnaEdmgQYN7TX0/Vf9yVhv2c/PMPf2z0VgjsQGDv5z
 s484CBQ/2HDa2Vmmm2COe6UpdVzMeLI7tA+gGnPfyU054MPeutGUQ5YvPhHyk3eI91Ao+0
 QgQ2AEGkVkscuAkGRuy1idh44lWuQc4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-tZD7VotAOyaRvwyGNQ4xGg-1; Wed, 04 Oct 2023 13:01:35 -0400
X-MC-Unique: tZD7VotAOyaRvwyGNQ4xGg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 784A63857B63
 for <qemu-devel@nongnu.org>; Wed,  4 Oct 2023 17:01:31 +0000 (UTC)
Received: from localhost (unknown [10.45.226.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 118A547AD4A;
 Wed,  4 Oct 2023 17:01:30 +0000 (UTC)
Date: Wed, 4 Oct 2023 19:01:29 +0200
From: Victor Toso <victortoso@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v1 2/9] qapi: golang: Generate qapi's alternate types in Go
Message-ID: <dorvxhh46qx7gudezparinzcvzdmyfrafvkokij6fjinocgtk4@dyze26z2qu63>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-3-victortoso@redhat.com>
 <ZRWTBpWn4m3rrGMZ@redhat.com>
 <b6kkamv3owggxi4vthdrqxrlcplbykp5cnnb7lihll7buv5kda@py5hclv6oqjc>
 <ZRbE7tlQaWAn+nwP@redhat.com>
 <CAFn=p-ay5kGcj+nbakBTDbxSDwGg29zrSNwp2kFft7aaMgq5Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uxwq55mzyxkfwsau"
Content-Disposition: inline
In-Reply-To: <CAFn=p-ay5kGcj+nbakBTDbxSDwGg29zrSNwp2kFft7aaMgq5Hg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


--uxwq55mzyxkfwsau
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 02, 2023 at 05:48:37PM -0400, John Snow wrote:
> On Fri, Sep 29, 2023 at 8:37=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
> >
> > On Fri, Sep 29, 2023 at 02:23:22PM +0200, Victor Toso wrote:
> > > Hi,
> > >
> > > On Thu, Sep 28, 2023 at 03:51:50PM +0100, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Wed, Sep 27, 2023 at 01:25:37PM +0200, Victor Toso wrote:
> > > > > This patch handles QAPI alternate types and generates data struct=
ures
> > > > > in Go that handles it.
> > > >
> > > > This file (and most others) needs some imports added.
> > > > I found the following to be required in order to
> > > > actually compile this:
> > >
> > > This was by design, I mean, my preference. I decided that the
> > > generator should output correct but not necessarly
> > > formatted/buildable Go code. The consumer should still use
> > > gofmt/goimports.
> > >
> > > Do you think we should do this in QEMU? What about extra
> > > dependencies in QEMU with go binaries?
> >
> > IMHO the generator should be omitting well formatted and buildable
> > code, otherwise we need to wrap the generator in a second generator
> > to do the extra missing bits.
> >
>=20
> Unless there's some consideration I'm unaware of, I think I agree with
> Dan here - I don't *think* there's a reason to need to do this in two
> layers, unless there's some tool that magically fixes/handles
> dependencies that you want to leverage as part of the pipeline here.

But there is. In the current qapi-go repository, I have 4 line
doc.go [0] file:

 1  //go:generate ../../scripts/generate.sh
 2  //go:generate gofmt -w .
 3  //go:generate goimports -w .
 4  package qapi

With this, anyone can run `go generate` which runs this generator
(1), runs gofmt (2) and goimports (3).

- gofmt fixes the formatting
- goimports adds the imports that are missing

Both things were mentioned by Dan as a problem to be fixed but
somewhat can be solved by another tool.

=46rom what I can see, we have three options to chose:

 1. Let this be as is. That means that someone else validates
    and fixes the generator's output.

 2. Fix the indentation and the (very few) imports that are
    needed. This means gofmt and goimports should do 0 changes,
    so they would not be needed.

 3. Add a post-processing that runs gofmt and goimports from
    QEMU. I would like to avoid this just to no add go binaries
    as requirement for QEMU, but perhaps it isn't a big deal.

I'm planning to work on (2) for v2 and further discuss if (3)
will be needed on top of that.

[0] https://gitlab.com/victortoso/qapi-go/-/blob/main/pkg/qapi/doc.go

Cheers,
Victor

--uxwq55mzyxkfwsau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUdmmkACgkQl9kSPeN6
SE+8eQ//cZpW3NmEpD4q8NKNow3MBzXLJd/jP6xJUCFVleJdILFoc35hkkiN98NP
s2eFU/69n1/gdJBjZq+szDxNT9xKlAWdlUIHOL04l2OLjJdbNaTklSiQKKsaHL0z
FgWlGZS/R/6+GBlc03VaCi0IN9oooQXpLRYQOb0CrMU+tuVEnL5xNtinI9kChD/c
aWq7BTxGO7YTdXw2gwBuuaNF93rVF94wkLrMdUtjAGRnmKos+IcC1YS64BLqAkx9
as2BzN1V05v5DTyaQAGbMYsLXqBbyqDv3lFmpYX0prpp5sjQTQD2YqMPLlYLHDge
WmGpsAvHKV5KbkJmpRZxTnvFpWqqf25WnksE+WD5/2YjGHB5wFk3jToaDx4B+6A2
M5cxd85+DKXMy1JGLVKS7i3zeQ5IU4KGTE5VO9c9Qt6aiRSJOf4l8Pk+VuU/jEa1
HJ/TNbMYoZqaYIS1oF28dPLHY/fqhdN+l0m5CekkjCP6dfPIAiOH0012Gh7Tjroy
1Ll4Nt5rHA1GEeHFLrMEydWoP6/mkNSo+Pi9zwXXyT1bS4fR+Iv+fq332wgbPEme
umSXtemkE3izHCYsnsYxEVgKlxGmlIe6Ch9amYn5R9wLgkALSrDdjjZZQiScy1x0
kmR7rBFJszkzeUGxRSXnN91+mfc2qSvpjtjNx9HmsvS+LkDAHA0=
=GJu6
-----END PGP SIGNATURE-----

--uxwq55mzyxkfwsau--


