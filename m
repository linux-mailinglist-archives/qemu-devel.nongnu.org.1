Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 086AD7B320A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 14:08:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmCHO-0006h2-86; Fri, 29 Sep 2023 08:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmCHD-0006gl-BW
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qmCH2-0007s4-Ej
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695989230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CqxgtOox9VWTmn5VTdPDuQ9aY0ozqRQVe+6lx+3UZQ8=;
 b=TCaLRzJl727SOnEO2sXBQr4bxmfWE1/EyumSA2xxfSbA5RxcFMEXlpmMjAjMmqv8JwAtlM
 HgVkLlD91iLFLl3VXTLnk6pNt+KSIqtl1ts6X+Cw0WaG0FQ6wcrPSR13XyH12erZQa1z4L
 7N4RXW8D2fgS97LrlO56PpwVrhdOXHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-MgOERGR8ODSgC9fR3MZPMA-1; Fri, 29 Sep 2023 08:07:07 -0400
X-MC-Unique: MgOERGR8ODSgC9fR3MZPMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FFD4811E7D
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 12:07:07 +0000 (UTC)
Received: from localhost (unknown [10.45.225.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C91E170E9;
 Fri, 29 Sep 2023 12:07:07 +0000 (UTC)
Date: Fri, 29 Sep 2023 14:07:06 +0200
From: Victor Toso <victortoso@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
Message-ID: <iaj3dftuzxb6itdxccm6zkfnpvy6av4f3a2hyrvdple4q63o5f@ptzrli3c7qwk>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
 <ZRWFCPhUfXMCrml1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q6kdfb6k5vwpvl23"
Content-Disposition: inline
In-Reply-To: <ZRWFCPhUfXMCrml1@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--q6kdfb6k5vwpvl23
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2023 at 02:52:08PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Sep 27, 2023 at 01:25:36PM +0200, Victor Toso wrote:
> > This patch handles QAPI enum types and generates its equivalent in Go.
> >=20
> > Basically, Enums are being handled as strings in Golang.
> >=20
> > 1. For each QAPI enum, we will define a string type in Go to be the
> >    assigned type of this specific enum.
> >=20
> > 2. Naming: CamelCase will be used in any identifier that we want to
> >    export [0], which is everything.
> >=20
> > [0] https://go.dev/ref/spec#Exported_identifiers
> >=20
> > Example:
> >=20
> > qapi:
> >   | { 'enum': 'DisplayProtocol',
> >   |   'data': [ 'vnc', 'spice' ] }
> >=20
> > go:
> >   | type DisplayProtocol string
> >   |
> >   | const (
> >   |     DisplayProtocolVnc   DisplayProtocol =3D "vnc"
> >   |     DisplayProtocolSpice DisplayProtocol =3D "spice"
> >   | )
> >=20
> > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > ---
> >  scripts/qapi/golang.py | 140 +++++++++++++++++++++++++++++++++++++++++
> >  scripts/qapi/main.py   |   2 +
> >  2 files changed, 142 insertions(+)
> >  create mode 100644 scripts/qapi/golang.py
> >=20
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
> > +        fields =3D ""
> > +        for member in members:
> > +            value =3D qapi_to_field_name_enum(member.name)
> > +            fields +=3D f'''\t{name}{value} {name} =3D "{member.name}"=
\n'''
> > +
> > +        self.target["enum"] +=3D TEMPLATE_ENUM.format(name=3Dname, fie=
lds=3Dfields[:-1])
>=20
> Here you are formatting the enums as you visit them, appending to
> the output buffer. The resulting enums appear in whatever order we
> visited them with, which is pretty arbitrary.
>=20
> Browsing the generated Go code to understand it, I find myself
> wishing that it was emitted in alphabetical order.
>=20
> This could be done if we worked in two phase. In the visit phase,
> we collect the bits of data we need, and then add a format phase
> then generates the formatted output, having first sorted by enum
> name.
>=20
> Same thought for the other types/commands.

I cared for sorted in some places [0] but not all of them indeed.
I'll include your request/suggestion in the next version.

[0] https://gitlab.com/victortoso/qemu/-/blob/qapi-golang-v1/scripts/qapi/g=
olang.py?ref_type=3Dheads#L804

>=20
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
>=20
> IIUC, we defacto consider the .qapi json files to be UTF-8, and thus
> in theory we could have non-ascii characters in there somewhere. I'd
> suggest we using utf8 encoding when outputting to avoid surprises.

Sure thing.

Cheers,
Victor

--q6kdfb6k5vwpvl23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAmUWveoACgkQl9kSPeN6
SE/XwQ//UzgPSXzNqsV81DYQwjrGbIHMbTKiYk2S891WYM9NCXXV8DZ/7MGl69O2
47kjvBGAscWpHzTXjl8nhs4zfGdt/cXZgzB8NxlxmBUqGegzZ93SceNSK0WNI0xJ
AaNwGQSNB3m92Ngxp68uAx0Jpv5+P/0CaL0NMwt5MwHj2gt7/r48+/Fd3aedwajO
+8FljL8D2q+9eRoDEJZqdzepkFELQ8bXn5cD+XAaCcVL4z3BTTN0qeW7Ebfi7fXy
5D2D4BlLRiQKzf2ao0IkJAvp3IyjuX0pEB43xVnR7j75d1W72eDDYRjHClXgA249
mxnU4JeD3x+ND2h8+yG+jq77/2dXyGXbujqQsFlAFuteyY6fRcLMu2IAoCHOqH1U
I5HTqn0gHTTwwPwciZHZnG5Pk+XdsFpB5dLHv2YhSMZblMM2uKe8lVzM1tGzrYTw
YbcfM6rT+SRfTnEt3iAYjFHyXOuEZyCs8nxMHE62cTCKmU5406tOemaCZCx/q6D8
IFknG05EMmPbV2HiMcnHtsH8KMcx0w9XT0Jgk0eS1hKh13sDxpV6V4tuQbFviJY9
W+AaNmgpfA3+aNgUdYEfX7HWaNs1V7tODcJJxEYzck20O3TkL9i8KrPrvWlHkZ85
IZpfKB9dzaEASPUoDsFf6+NMYd6ulRwxI81LFk2i797u2o4FmeI=
=P4SZ
-----END PGP SIGNATURE-----

--q6kdfb6k5vwpvl23--


