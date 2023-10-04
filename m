Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3BA7B7F1B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0zb-0004Iu-9X; Wed, 04 Oct 2023 08:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qo0zZ-0004Ii-0k
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qo0zV-00060w-Nk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696422516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PxQsA2wYV7+9U+B8scBpqM6y1/V0NGh0g3vnAsr2eN0=;
 b=It4E/XQ40zFMSq8JmDir5vrPkDQSaUEFYqJ6TPeXDY1o7794WaycsZ2/nn4oEhVaE9XUJU
 V7RSCGGFokuU8/w8wFw6/JdH70TgmozX+h7Ep0FIUhOwhGuaQPPYviSwiIITwCGyZPVw8b
 kSA0w3/AJZSPccdIxYJ9U+g5UNUkmjA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-33uM6KqCMDSPf2ucdb0NPg-1; Wed, 04 Oct 2023 08:28:24 -0400
X-MC-Unique: 33uM6KqCMDSPf2ucdb0NPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FFCC3822E88
 for <qemu-devel@nongnu.org>; Wed,  4 Oct 2023 12:28:24 +0000 (UTC)
Received: from localhost (unknown [10.45.226.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F9DA215670B;
 Wed,  4 Oct 2023 12:28:23 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:28:22 +0200
From: Victor Toso <victortoso@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
Message-ID: <jfec4n52zy67wmjhcjb3bb6scu4pvc52g2ejtl2b3z46eyofxj@vxgv7ocoev5k>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
 <CAFn=p-ZdgaCuTZF-yYa6E_CMFobR--Yt6ycSBNDz7S+sFxX14Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bzrs4hl2zxetsih7"
Content-Disposition: inline
In-Reply-To: <CAFn=p-ZdgaCuTZF-yYa6E_CMFobR--Yt6ycSBNDz7S+sFxX14Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--bzrs4hl2zxetsih7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 02, 2023 at 03:07:49PM -0400, John Snow wrote:
> On Wed, Sep 27, 2023 at 7:25=E2=80=AFAM Victor Toso <victortoso@redhat.co=
m> wrote:
> >
> > This patch handles QAPI enum types and generates its equivalent in Go.
> >
> > Basically, Enums are being handled as strings in Golang.
> >
> > 1. For each QAPI enum, we will define a string type in Go to be the
> >    assigned type of this specific enum.
> >
> > 2. Naming: CamelCase will be used in any identifier that we want to
> >    export [0], which is everything.
> >
> > [0] https://go.dev/ref/spec#Exported_identifiers
> >
> > Example:
> >
> > qapi:
> >   | { 'enum': 'DisplayProtocol',
> >   |   'data': [ 'vnc', 'spice' ] }
> >
> > go:
> >   | type DisplayProtocol string
> >   |
> >   | const (
> >   |     DisplayProtocolVnc   DisplayProtocol =3D "vnc"
> >   |     DisplayProtocolSpice DisplayProtocol =3D "spice"
> >   | )
> >
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/golang.py | 140 +++++++++++++++++++++++++++++++++++++++++
> >  scripts/qapi/main.py   |   2 +
> >  2 files changed, 142 insertions(+)
> >  create mode 100644 scripts/qapi/golang.py
> >
> > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > new file mode 100644
> > index 0000000000..87081cdd05
> > --- /dev/null
> > +++ b/scripts/qapi/golang.py
> > @@ -0,0 +1,140 @@
> > +"""
> > +Golang QAPI generator
> > +"""
> > +# Copyright (c) 2023 Red Hat Inc.
> > +#
> > +# Authors:
> > +#  Victor Toso <victortoso@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.
> > +# See the COPYING file in the top-level directory.
> > +
> > +# due QAPISchemaVisitor interface
> > +# pylint: disable=3Dtoo-many-arguments
> > +
> > +# Just for type hint on self
> > +from __future__ import annotations
> > +
> > +import os
> > +from typing import List, Optional
> > +
> > +from .schema import (
> > +    QAPISchema,
> > +    QAPISchemaType,
> > +    QAPISchemaVisitor,
> > +    QAPISchemaEnumMember,
> > +    QAPISchemaFeature,
> > +    QAPISchemaIfCond,
> > +    QAPISchemaObjectType,
> > +    QAPISchemaObjectTypeMember,
> > +    QAPISchemaVariants,
> > +)
> > +from .source import QAPISourceInfo
> > +
> > +TEMPLATE_ENUM =3D '''
> > +type {name} string
> > +const (
> > +{fields}
> > +)
> > +'''
> > +
> > +
> > +def gen_golang(schema: QAPISchema,
> > +               output_dir: str,
> > +               prefix: str) -> None:
> > +    vis =3D QAPISchemaGenGolangVisitor(prefix)
> > +    schema.visit(vis)
> > +    vis.write(output_dir)
> > +
> > +
> > +def qapi_to_field_name_enum(name: str) -> str:
> > +    return name.title().replace("-", "")
> > +
> > +
> > +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
> > +
> > +    def __init__(self, _: str):
> > +        super().__init__()
> > +        types =3D ["enum"]
> > +        self.target =3D {name: "" for name in types}
> > +        self.schema =3D None
> > +        self.golang_package_name =3D "qapi"
> > +
> > +    def visit_begin(self, schema):
> > +        self.schema =3D schema
> > +
> > +        # Every Go file needs to reference its package name
> > +        for target in self.target:
> > +            self.target[target] =3D f"package {self.golang_package_nam=
e}\n"
> > +
> > +    def visit_end(self):
> > +        self.schema =3D None
> > +
> > +    def visit_object_type(self: QAPISchemaGenGolangVisitor,
> > +                          name: str,
> > +                          info: Optional[QAPISourceInfo],
> > +                          ifcond: QAPISchemaIfCond,
> > +                          features: List[QAPISchemaFeature],
> > +                          base: Optional[QAPISchemaObjectType],
> > +                          members: List[QAPISchemaObjectTypeMember],
> > +                          variants: Optional[QAPISchemaVariants]
> > +                          ) -> None:
> > +        pass
> > +
> > +    def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
> > +                             name: str,
> > +                             info: Optional[QAPISourceInfo],
> > +                             ifcond: QAPISchemaIfCond,
> > +                             features: List[QAPISchemaFeature],
> > +                             variants: QAPISchemaVariants
> > +                             ) -> None:
> > +        pass
> > +
> > +    def visit_enum_type(self: QAPISchemaGenGolangVisitor,
> > +                        name: str,
> > +                        info: Optional[QAPISourceInfo],
> > +                        ifcond: QAPISchemaIfCond,
> > +                        features: List[QAPISchemaFeature],
> > +                        members: List[QAPISchemaEnumMember],
> > +                        prefix: Optional[str]
> > +                        ) -> None:
> > +
> > +        value =3D qapi_to_field_name_enum(members[0].name)
>=20
> Unsure if this was addressed on the mailing list yet, but in our call
> we discussed how this call was vestigial and was causing the QAPI
> tests to fail. Actually, I can't quite run "make check-qapi-schema"
> and see the failure, I'm seeing it when I run "make check" and I'm not
> sure how to find the failure more efficiently/quickly:
>=20
> jsnow@scv ~/s/q/build (review)> make
> [1/60] Generating subprojects/dtc/version_gen.h with a custom command
> [2/60] Generating qemu-version.h with a custom command (wrapped by
> meson to capture output)
> [3/44] Generating tests/Test QAPI files with a custom command
> FAILED: tests/qapi-builtin-types.c tests/qapi-builtin-types.h
> tests/qapi-builtin-visit.c tests/qapi-builtin-visit.h
> tests/test-qapi-commands-sub-sub-module.c
> tests/test-qapi-commands-sub-sub-module.h tests/test-qapi-commands.c
> tests/test-qapi-commands.h tests/test-qapi-emit-events.c
> tests/test-qapi-emit-events.h tests/test-qapi-events-sub-sub-module.c
> tests/test-qapi-events-sub-sub-module.h tests/test-qapi-events.c
> tests/test-qapi-events.h tests/test-qapi-init-commands.c
> tests/test-qapi-init-commands.h tests/test-qapi-introspect.c
> tests/test-qapi-introspect.h tests/test-qapi-types-sub-sub-module.c
> tests/test-qapi-types-sub-sub-module.h tests/test-qapi-types.c
> tests/test-qapi-types.h tests/test-qapi-visit-sub-sub-module.c
> tests/test-qapi-visit-sub-sub-module.h tests/test-qapi-visit.c
> tests/test-qapi-visit.h
> /home/jsnow/src/qemu/build/pyvenv/bin/python3
> /home/jsnow/src/qemu/scripts/qapi-gen.py -o
> /home/jsnow/src/qemu/build/tests -b -p test-
> ../tests/qapi-schema/qapi-schema-test.json --suppress-tracing
> Traceback (most recent call last):
>   File "/home/jsnow/src/qemu/scripts/qapi-gen.py", line 19, in <module>
>     sys.exit(main.main())
>              ^^^^^^^^^^^
>   File "/home/jsnow/src/qemu/scripts/qapi/main.py", line 96, in main
>     generate(args.schema,
>   File "/home/jsnow/src/qemu/scripts/qapi/main.py", line 58, in generate
>     gen_golang(schema, output_dir, prefix)
>   File "/home/jsnow/src/qemu/scripts/qapi/golang.py", line 46, in gen_gol=
ang
>     schema.visit(vis)
>   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 1227, in visit
>     mod.visit(visitor)
>   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 209, in visit
>     entity.visit(visitor)
>   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 346, in visit
>     visitor.visit_enum_type(
>   File "/home/jsnow/src/qemu/scripts/qapi/golang.py", line 102, in
> visit_enum_type
>     value =3D qapi_to_field_name_enum(members[0].name)
>                                     ~~~~~~~^^^
> IndexError: list index out of range
> ninja: build stopped: subcommand failed.
> make: *** [Makefile:162: run-ninja] Error 1
>=20
>=20
> For the rest of my review, I commented this line out and continued on.

Yes, it was a leftover when I was reorganizing the patches. You
can see this value is not actually used.

I removed it in my branch for v2.

Cheers,
Victor

> > +        fields =3D ""
> > +        for member in members:
> > +            value =3D qapi_to_field_name_enum(member.name)
> > +            fields +=3D f'''\t{name}{value} {name} =3D "{member.name}"=
\n'''
> > +
> > +        self.target["enum"] +=3D TEMPLATE_ENUM.format(name=3Dname, fie=
lds=3Dfields[:-1])
> > +
> > +    def visit_array_type(self, name, info, ifcond, element_type):
> > +        pass
> > +
> > +    def visit_command(self,
> > +                      name: str,
> > +                      info: Optional[QAPISourceInfo],
> > +                      ifcond: QAPISchemaIfCond,
> > +                      features: List[QAPISchemaFeature],
> > +                      arg_type: Optional[QAPISchemaObjectType],
> > +                      ret_type: Optional[QAPISchemaType],
> > +                      gen: bool,
> > +                      success_response: bool,
> > +                      boxed: bool,
> > +                      allow_oob: bool,
> > +                      allow_preconfig: bool,
> > +                      coroutine: bool) -> None:
> > +        pass
> > +
> > +    def visit_event(self, name, info, ifcond, features, arg_type, boxe=
d):
> > +        pass
> > +
> > +    def write(self, output_dir: str) -> None:
> > +        for module_name, content in self.target.items():
> > +            go_module =3D module_name + "s.go"
> > +            go_dir =3D "go"
> > +            pathname =3D os.path.join(output_dir, go_dir, go_module)
> > +            odir =3D os.path.dirname(pathname)
> > +            os.makedirs(odir, exist_ok=3DTrue)
> > +
> > +            with open(pathname, "w", encoding=3D"ascii") as outfile:
> > +                outfile.write(content)
> > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > index 316736b6a2..cdbb3690fd 100644
> > --- a/scripts/qapi/main.py
> > +++ b/scripts/qapi/main.py
> > @@ -15,6 +15,7 @@
> >  from .common import must_match
> >  from .error import QAPIError
> >  from .events import gen_events
> > +from .golang import gen_golang
> >  from .introspect import gen_introspect
> >  from .schema import QAPISchema
> >  from .types import gen_types
> > @@ -54,6 +55,7 @@ def generate(schema_file: str,
> >      gen_events(schema, output_dir, prefix)
> >      gen_introspect(schema, output_dir, prefix, unmask)
> >
> > +    gen_golang(schema, output_dir, prefix)
> >
> >  def main() -> int:
> >      """
> > --
> > 2.41.0
> >
>=20

--bzrs4hl2zxetsih7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUdWmYACgkQl9kSPeN6
SE8ijBAAwe8xbKR0kkPmT4F6Ndb5T74sgVxVSNO0D9+4xHaZK+o/mGugrROl2nEJ
w7Xdauh8LoeSsYuskIQzfFGQZWWfkDrs7U2jwW1N06WijP91vtFmxKQFjH0+7oon
QLCPmlP+k82dFheayWVmWXM+c2DTlxAHxy4XsyonpQ6dORjWWN5h92lKCUZtzHwM
sAqkFzGgDpp85M1hIdgkbj19Q1Udg97L1bj4NbpjxCG4Hnely9O7/sOhIIYmmaBC
dGw2Es6plbDpbcHJzTFZUtz59HZ2KYpClhnf9e7hMGuqdqbX0USQqmlvsPxgfFcA
4If7yqfzbKA1pgbf2f1u6d6BB+TgVCE+6JP7P25xHD8O24JUX31FnxkTFaYMHREs
6T8J+a2t+M6f+3wDJeOk2MgoAAiwNJJDc7FVADhlRPPfYNK/HmwcLHwEn6c9f9u1
2ij8QZRXR9N5atOfEVweBLmwsV+0cQGIPgsR6l6kwN8VeUD9kTBPFDG8CUu+Dctt
sRPULl1gSX9F0VEyAceNnzlc+j0i3g5MjLvKrF6vo/ncf3kJH9dMi7e+vF3L+6P6
cwJiG7AWzCOKw0maZXsmMCtUM7A6GRljpnXGVXVq1l10jqU3Qn1CFxD7tPkfz3BX
HQYwTtnpe/wx6pA0l+H/5LAGd20a3k7F2fnzHUxnyDxI39dXTgQ=
=ojoG
-----END PGP SIGNATURE-----

--bzrs4hl2zxetsih7--


