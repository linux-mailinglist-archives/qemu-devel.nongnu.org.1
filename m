Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7677B7F81
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1Dc-0007pb-KW; Wed, 04 Oct 2023 08:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qo1DZ-0007gy-IW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qo1DW-000556-Pi
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnGptwhOh3TP/Hcicz/4I/C1dLbsd+mudv1fuV6fWHM=;
 b=E+0UdhVRGOofdBksxZqSA15tFGLlkGnlky4TGg32DuK/L1Xzcz0nlenturIs3uPtKxraqv
 Z5loLPtaCSk8juuAdsTww4/zV4+YTcVwCvR6fyhqkU4AWO8V0h4pHaw7Amyrh41PQe6J3/
 DNzQUEondPK46dr1S/PTg+h8JKY0fU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-FqIecflBN0CGnj4YxHwraQ-1; Wed, 04 Oct 2023 08:43:04 -0400
X-MC-Unique: FqIecflBN0CGnj4YxHwraQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE28880349A
 for <qemu-devel@nongnu.org>; Wed,  4 Oct 2023 12:43:03 +0000 (UTC)
Received: from localhost (unknown [10.45.226.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4459240C6EC0;
 Wed,  4 Oct 2023 12:43:03 +0000 (UTC)
Date: Wed, 4 Oct 2023 14:43:02 +0200
From: Victor Toso <victortoso@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
Message-ID: <3duepujid3nbcfzqgadqbbmzepxzztpqpofipoargriykwfnbg@5frv62vvteeb>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
 <CAFn=p-ZdgaCuTZF-yYa6E_CMFobR--Yt6ycSBNDz7S+sFxX14Q@mail.gmail.com>
 <CAFn=p-ZpZN+TjBqN_5RTm0ZxHQ4pzDtMwgr-NKKyAR83hKfwOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="j6th2slvo32bqtfr"
Content-Disposition: inline
In-Reply-To: <CAFn=p-ZpZN+TjBqN_5RTm0ZxHQ4pzDtMwgr-NKKyAR83hKfwOw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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


--j6th2slvo32bqtfr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 02, 2023 at 04:09:29PM -0400, John Snow wrote:
> On Mon, Oct 2, 2023 at 3:07=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
> >
> > On Wed, Sep 27, 2023 at 7:25=E2=80=AFAM Victor Toso <victortoso@redhat.=
com> wrote:
> > >
> > > This patch handles QAPI enum types and generates its equivalent in Go.
> > >
> > > Basically, Enums are being handled as strings in Golang.
> > >
> > > 1. For each QAPI enum, we will define a string type in Go to be the
> > >    assigned type of this specific enum.
> > >
> > > 2. Naming: CamelCase will be used in any identifier that we want to
> > >    export [0], which is everything.
> > >
> > > [0] https://go.dev/ref/spec#Exported_identifiers
> > >
> > > Example:
> > >
> > > qapi:
> > >   | { 'enum': 'DisplayProtocol',
> > >   |   'data': [ 'vnc', 'spice' ] }
> > >
> > > go:
> > >   | type DisplayProtocol string
> > >   |
> > >   | const (
> > >   |     DisplayProtocolVnc   DisplayProtocol =3D "vnc"
> > >   |     DisplayProtocolSpice DisplayProtocol =3D "spice"
> > >   | )
> > >
> > > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > > ---
> > >  scripts/qapi/golang.py | 140 +++++++++++++++++++++++++++++++++++++++=
++
> > >  scripts/qapi/main.py   |   2 +
> > >  2 files changed, 142 insertions(+)
> > >  create mode 100644 scripts/qapi/golang.py
> > >
> > > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > > new file mode 100644
> > > index 0000000000..87081cdd05
> > > --- /dev/null
> > > +++ b/scripts/qapi/golang.py
> > > @@ -0,0 +1,140 @@
> > > +"""
> > > +Golang QAPI generator
> > > +"""
> > > +# Copyright (c) 2023 Red Hat Inc.
> > > +#
> > > +# Authors:
> > > +#  Victor Toso <victortoso@redhat.com>
> > > +#
> > > +# This work is licensed under the terms of the GNU GPL, version 2.
> > > +# See the COPYING file in the top-level directory.
> > > +
> > > +# due QAPISchemaVisitor interface
> > > +# pylint: disable=3Dtoo-many-arguments
>=20
> "due to" - also, you could more selectively disable this warning by
> putting this comment in the body of the QAPISchemaVisitor class which
> would make your exemption from the linter more locally obvious.
>=20
> > > +
> > > +# Just for type hint on self
> > > +from __future__ import annotations
>=20
> Oh, you know - it's been so long since I worked on QAPI I didn't
> realize we had access to this now. That's awesome!
>=20
> (It was introduced in Python 3.7+)
>=20
> > > +
> > > +import os
> > > +from typing import List, Optional
> > > +
> > > +from .schema import (
> > > +    QAPISchema,
> > > +    QAPISchemaType,
> > > +    QAPISchemaVisitor,
> > > +    QAPISchemaEnumMember,
> > > +    QAPISchemaFeature,
> > > +    QAPISchemaIfCond,
> > > +    QAPISchemaObjectType,
> > > +    QAPISchemaObjectTypeMember,
> > > +    QAPISchemaVariants,
> > > +)
> > > +from .source import QAPISourceInfo
> > > +
>=20
> Try running isort here:
>=20
> > cd ~/src/qemu/scripts
> > isort -c qapi/golang.py
>=20
> ERROR: /home/jsnow/src/qemu/scripts/qapi/golang.py Imports are
> incorrectly sorted and/or formatted.
>=20
> you can have it fix the import order for you:
>=20
> > isort qapi/golang.py
>=20
> It's very pedantic stuff, but luckily there's a tool to just handle it fo=
r you.

Thanks! Also fixed for the next iteration.
=20
> > > +TEMPLATE_ENUM =3D '''
> > > +type {name} string
> > > +const (
> > > +{fields}
> > > +)
> > > +'''
> > > +
> > > +
> > > +def gen_golang(schema: QAPISchema,
> > > +               output_dir: str,
> > > +               prefix: str) -> None:
> > > +    vis =3D QAPISchemaGenGolangVisitor(prefix)
> > > +    schema.visit(vis)
> > > +    vis.write(output_dir)
> > > +
> > > +
> > > +def qapi_to_field_name_enum(name: str) -> str:
> > > +    return name.title().replace("-", "")
> > > +
> > > +
> > > +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
> > > +
> > > +    def __init__(self, _: str):
> > > +        super().__init__()
> > > +        types =3D ["enum"]
> > > +        self.target =3D {name: "" for name in types}
>=20
> you *could* say:
>=20
> types =3D ("enum",)
> self.target =3D dict.fromkeys(types, "")
>=20
> 1. We don't need a list because we won't be modifying it, so a tuple suff=
ices
> 2. There's an idiom for doing what you want that reads a little better
> 3. None of it really matters, though.

No complains with moving it to a tuple.

> Also keep in mind you don't *need* to initialize a dict in this way,
> you can just arbitrarily assign into it whenever you'd like.
>=20
> sellf.target['enum'] =3D foo

I think it is a problem with +=3D operator when not initialized.

    self.target['enum'] =3D foo

At least I recall having errors around dict not being
initialized.
=20
> I don't know if that makes things easier or not with however the
> subsequent patches are written.
>=20
> > > +        self.schema =3D None
> > > +        self.golang_package_name =3D "qapi"
> > > +
> > > +    def visit_begin(self, schema):
> > > +        self.schema =3D schema
> > > +
> > > +        # Every Go file needs to reference its package name
> > > +        for target in self.target:
> > > +            self.target[target] =3D f"package {self.golang_package_n=
ame}\n"
> > > +
> > > +    def visit_end(self):
> > > +        self.schema =3D None
> > > +
> > > +    def visit_object_type(self: QAPISchemaGenGolangVisitor,
> > > +                          name: str,
> > > +                          info: Optional[QAPISourceInfo],
> > > +                          ifcond: QAPISchemaIfCond,
> > > +                          features: List[QAPISchemaFeature],
> > > +                          base: Optional[QAPISchemaObjectType],
> > > +                          members: List[QAPISchemaObjectTypeMember],
> > > +                          variants: Optional[QAPISchemaVariants]
> > > +                          ) -> None:
> > > +        pass
> > > +
> > > +    def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
> > > +                             name: str,
> > > +                             info: Optional[QAPISourceInfo],
> > > +                             ifcond: QAPISchemaIfCond,
> > > +                             features: List[QAPISchemaFeature],
> > > +                             variants: QAPISchemaVariants
> > > +                             ) -> None:
> > > +        pass
> > > +
> > > +    def visit_enum_type(self: QAPISchemaGenGolangVisitor,
>=20
> Was there a problem when you omitted the type for 'self'?
> Usually that can be inferred. As of this patch, at least, I
> think this can be safely dropped. (Maybe it becomes important
> later.)

I don't think I tried removing the type for self. I actually
tried to keep all types expressed, just for the sake of knowing
what types they were.

Yes, it can be easily inferred and removed.

> > > +                        name: str,
> > > +                        info: Optional[QAPISourceInfo],
> > > +                        ifcond: QAPISchemaIfCond,
> > > +                        features: List[QAPISchemaFeature],
> > > +                        members: List[QAPISchemaEnumMember],
> > > +                        prefix: Optional[str]
> > > +                        ) -> None:
> > > +
> > > +        value =3D qapi_to_field_name_enum(members[0].name)
> >
> > Unsure if this was addressed on the mailing list yet, but in our call
> > we discussed how this call was vestigial and was causing the QAPI
> > tests to fail. Actually, I can't quite run "make check-qapi-schema"
> > and see the failure, I'm seeing it when I run "make check" and I'm not
> > sure how to find the failure more efficiently/quickly:
> >
> > jsnow@scv ~/s/q/build (review)> make
> > [1/60] Generating subprojects/dtc/version_gen.h with a custom command
> > [2/60] Generating qemu-version.h with a custom command (wrapped by
> > meson to capture output)
> > [3/44] Generating tests/Test QAPI files with a custom command
> > FAILED: tests/qapi-builtin-types.c tests/qapi-builtin-types.h
> > tests/qapi-builtin-visit.c tests/qapi-builtin-visit.h
> > tests/test-qapi-commands-sub-sub-module.c
> > tests/test-qapi-commands-sub-sub-module.h tests/test-qapi-commands.c
> > tests/test-qapi-commands.h tests/test-qapi-emit-events.c
> > tests/test-qapi-emit-events.h tests/test-qapi-events-sub-sub-module.c
> > tests/test-qapi-events-sub-sub-module.h tests/test-qapi-events.c
> > tests/test-qapi-events.h tests/test-qapi-init-commands.c
> > tests/test-qapi-init-commands.h tests/test-qapi-introspect.c
> > tests/test-qapi-introspect.h tests/test-qapi-types-sub-sub-module.c
> > tests/test-qapi-types-sub-sub-module.h tests/test-qapi-types.c
> > tests/test-qapi-types.h tests/test-qapi-visit-sub-sub-module.c
> > tests/test-qapi-visit-sub-sub-module.h tests/test-qapi-visit.c
> > tests/test-qapi-visit.h
> > /home/jsnow/src/qemu/build/pyvenv/bin/python3
> > /home/jsnow/src/qemu/scripts/qapi-gen.py -o
> > /home/jsnow/src/qemu/build/tests -b -p test-
> > ../tests/qapi-schema/qapi-schema-test.json --suppress-tracing
> > Traceback (most recent call last):
> >   File "/home/jsnow/src/qemu/scripts/qapi-gen.py", line 19, in <module>
> >     sys.exit(main.main())
> >              ^^^^^^^^^^^
> >   File "/home/jsnow/src/qemu/scripts/qapi/main.py", line 96, in main
> >     generate(args.schema,
> >   File "/home/jsnow/src/qemu/scripts/qapi/main.py", line 58, in generate
> >     gen_golang(schema, output_dir, prefix)
> >   File "/home/jsnow/src/qemu/scripts/qapi/golang.py", line 46, in gen_g=
olang
> >     schema.visit(vis)
> >   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 1227, in vis=
it
> >     mod.visit(visitor)
> >   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 209, in visit
> >     entity.visit(visitor)
> >   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 346, in visit
> >     visitor.visit_enum_type(
> >   File "/home/jsnow/src/qemu/scripts/qapi/golang.py", line 102, in
> > visit_enum_type
> >     value =3D qapi_to_field_name_enum(members[0].name)
> >                                     ~~~~~~~^^^
> > IndexError: list index out of range
> > ninja: build stopped: subcommand failed.
> > make: *** [Makefile:162: run-ninja] Error 1
> >
> >
> > For the rest of my review, I commented this line out and continued on.
> >
> > > +        fields =3D ""
> > > +        for member in members:
> > > +            value =3D qapi_to_field_name_enum(member.name)
> > > +            fields +=3D f'''\t{name}{value} {name} =3D "{member.name=
}"\n'''
> > > +
> > > +        self.target["enum"] +=3D TEMPLATE_ENUM.format(name=3Dname, f=
ields=3Dfields[:-1])
>=20
> This line is a little too long. (sorry)
>=20
> try:
>=20
> cd ~/src/qemu/scripts
> flake8 qapi/


toso@tapioca ~/s/qemu > flake8 scripts/qapi | wc
     89     734    6260

Yep, I'll fix them.

> jsnow@scv ~/s/q/scripts (review)> flake8 qapi/
> qapi/main.py:60:1: E302 expected 2 blank lines, found 1
> qapi/golang.py:106:80: E501 line too long (82 > 79 characters)

Cheers,
Victor

>=20
> > > +
> > > +    def visit_array_type(self, name, info, ifcond, element_type):
> > > +        pass
> > > +
> > > +    def visit_command(self,
> > > +                      name: str,
> > > +                      info: Optional[QAPISourceInfo],
> > > +                      ifcond: QAPISchemaIfCond,
> > > +                      features: List[QAPISchemaFeature],
> > > +                      arg_type: Optional[QAPISchemaObjectType],
> > > +                      ret_type: Optional[QAPISchemaType],
> > > +                      gen: bool,
> > > +                      success_response: bool,
> > > +                      boxed: bool,
> > > +                      allow_oob: bool,
> > > +                      allow_preconfig: bool,
> > > +                      coroutine: bool) -> None:
> > > +        pass
> > > +
> > > +    def visit_event(self, name, info, ifcond, features, arg_type, bo=
xed):
> > > +        pass
> > > +
> > > +    def write(self, output_dir: str) -> None:
> > > +        for module_name, content in self.target.items():
> > > +            go_module =3D module_name + "s.go"
> > > +            go_dir =3D "go"
> > > +            pathname =3D os.path.join(output_dir, go_dir, go_module)
> > > +            odir =3D os.path.dirname(pathname)
> > > +            os.makedirs(odir, exist_ok=3DTrue)
> > > +
> > > +            with open(pathname, "w", encoding=3D"ascii") as outfile:
> > > +                outfile.write(content)
> > > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > > index 316736b6a2..cdbb3690fd 100644
> > > --- a/scripts/qapi/main.py
> > > +++ b/scripts/qapi/main.py
> > > @@ -15,6 +15,7 @@
> > >  from .common import must_match
> > >  from .error import QAPIError
> > >  from .events import gen_events
> > > +from .golang import gen_golang
> > >  from .introspect import gen_introspect
> > >  from .schema import QAPISchema
> > >  from .types import gen_types
> > > @@ -54,6 +55,7 @@ def generate(schema_file: str,
> > >      gen_events(schema, output_dir, prefix)
> > >      gen_introspect(schema, output_dir, prefix, unmask)
> > >
> > > +    gen_golang(schema, output_dir, prefix)
> > >
> > >  def main() -> int:
> > >      """
> > > --
> > > 2.41.0
> > >
>=20

--j6th2slvo32bqtfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUdXdUACgkQl9kSPeN6
SE+Ujg//SLR53ldFr160xtGVzzW8iLzEVfiaFs4rKnhU0A3h4305HQc/Fyr3e1WL
wuSd7EJVdVDraKaLLSRc7CvI/e/YBsyyyzf+02UpBiiE58WCcOkMP+QQ8xC2Pume
uB77/kLcmmSa/muxzDUJS2EKXdb8ufGzTlny0VRkShPT8QWgYCqZ84Ef3xD9RWq+
xjtNWPYpRWkKYF102C0VDWqeLfFwIrfzvSTjc+CHOsl4GUlA3hlp7sgqQaObRE6C
yGu0oFmq9BBjILfDD9HBA/Ow/DtkACCAchjbBo+Uv/3P0dIwcWXdcWPcFKRMmGgx
we1wcqU0eVsvTNy2nKrMh3ysuf6pIGTzFEyyMwje5/apLZjRqOyWMDLQMBCSmswX
xjjQBh6NV8NQTxd50TJl2i07K6MELyZ800rZf4lYiWF6t5oMOjYU9apkP+BE1293
GVsvIBa/sdkXnnUP69CxDzIeDervAlffWJaCSLjH+H10zRmC6AUUvNnlxk57IXTK
Mpd2oNsx/mD8voQK1YFkucVMhHlFstMIq5rbRzMAw74LRmDqifAz0NRynlhrvkPM
ECZaGewPnXZ2uY2n51xvl7rNHk5UekDqHyVimC2snB1BK5VSlAitCZ0W8ff37Gp8
Qwzio7U3nWdyjC58TETVR4D+mCRaYTn0w8xg+HxPkw+3jwPdi0M=
=7hzF
-----END PGP SIGNATURE-----

--j6th2slvo32bqtfr--


