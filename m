Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038047B5BD9
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:11:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPEr-0006xj-NX; Mon, 02 Oct 2023 16:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnPEp-0006xW-Bf
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnPEf-00062c-FE
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696277383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVvZDNrBfGeKcb8kqUFMg5cmolQ4CS7v3GD9Alwf5k4=;
 b=e+yiENSLSBAoDrrT4kbAx/jYdQAou+pj5KYsSVdeR3UTyXZks051C3njI7Hlrxykl+4TTt
 M9y8gGWWpUr5RyX7qkuhA45VG2FUZluuE//J9HDnfBGP2uM5yIjeorZma/SvEL7UgEhtBD
 q1deGYuuOmQwSQYNZCt8+sxW7i7Uv4g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-5JjKENdINsiL3jsUVBsYKA-1; Mon, 02 Oct 2023 16:09:41 -0400
X-MC-Unique: 5JjKENdINsiL3jsUVBsYKA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2775642edfcso143810a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 13:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696277381; x=1696882181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVvZDNrBfGeKcb8kqUFMg5cmolQ4CS7v3GD9Alwf5k4=;
 b=LDr4esNvpguSCZSY6UTKGc1HthuGbv+ZRrCCSMxFwfCf8bqsF7Mc5b1wwmT08+2GOw
 cY3BmZvz+PP22SsZ42T++KopDZAKW7W75zwAW+LS7nFwgCYqvZzYy0gzewSiZ0PskDi7
 CmzT891TgJ0girtfgmb7d0u2CDyjhy217Vhi6PrmLK6FliUvLeQ+NKYd3RnqAn3dNht9
 CA9fshOcDRnXo8xs2jW36CwpWzF1qAHdFmhHxjH34pWl/xf7ig074JEYDuyDwsT7sFtP
 Tuhst1fiwKh+/kcc+7JYhJXvtvVjj97c2ZvTFfSR85J5AcgN0FMyZP+/EUTwxWuu6CLs
 Oy4A==
X-Gm-Message-State: AOJu0YwKJeHMcigJ+JJ2pX54ODhcid8BgbOhmkkZWUW2baMGzeIvF0CZ
 AatSIT77nVhQoCwGmzHN9D26TJoCqLZY6CuiUH26alL/NJAn8MMJmh2iPyWBa/ENrSx2gVj7XwV
 sWDOY0IyGUkIpZrI0AmenJZhblIGO0jc=
X-Received: by 2002:a17:90b:347:b0:277:852:cf45 with SMTP id
 fh7-20020a17090b034700b002770852cf45mr9970851pjb.19.1696277380653; 
 Mon, 02 Oct 2023 13:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqLk+9Omu5mMOXkNmzXJte6sUXbfgp+htd3zlUUHj1M/LXZFu8IM09HrnuIjsm86KmUS6Ab6P/k3HvgAtPflY=
X-Received: by 2002:a17:90b:347:b0:277:852:cf45 with SMTP id
 fh7-20020a17090b034700b002770852cf45mr9970838pjb.19.1696277380326; Mon, 02
 Oct 2023 13:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
 <CAFn=p-ZdgaCuTZF-yYa6E_CMFobR--Yt6ycSBNDz7S+sFxX14Q@mail.gmail.com>
In-Reply-To: <CAFn=p-ZdgaCuTZF-yYa6E_CMFobR--Yt6ycSBNDz7S+sFxX14Q@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 2 Oct 2023 16:09:29 -0400
Message-ID: <CAFn=p-ZpZN+TjBqN_5RTm0ZxHQ4pzDtMwgr-NKKyAR83hKfwOw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Mon, Oct 2, 2023 at 3:07=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
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

"due to" - also, you could more selectively disable this warning by
putting this comment in the body of the QAPISchemaVisitor class which
would make your exemption from the linter more locally obvious.

> > +
> > +# Just for type hint on self
> > +from __future__ import annotations

Oh, you know - it's been so long since I worked on QAPI I didn't
realize we had access to this now. That's awesome!

(It was introduced in Python 3.7+)

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

Try running isort here:

> cd ~/src/qemu/scripts
> isort -c qapi/golang.py

ERROR: /home/jsnow/src/qemu/scripts/qapi/golang.py Imports are
incorrectly sorted and/or formatted.

you can have it fix the import order for you:

> isort qapi/golang.py

It's very pedantic stuff, but luckily there's a tool to just handle it for =
you.

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

you *could* say:

types =3D ("enum",)
self.target =3D dict.fromkeys(types, "")

1. We don't need a list because we won't be modifying it, so a tuple suffic=
es
2. There's an idiom for doing what you want that reads a little better
3. None of it really matters, though.

Also keep in mind you don't *need* to initialize a dict in this way,
you can just arbitrarily assign into it whenever you'd like.

sellf.target['enum'] =3D foo

I don't know if that makes things easier or not with however the
subsequent patches are written.

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

Was there a problem when you omitted the type for 'self'? Usually that
can be inferred. As of this patch, at least, I think this can be
safely dropped. (Maybe it becomes important later.)

> > +                        name: str,
> > +                        info: Optional[QAPISourceInfo],
> > +                        ifcond: QAPISchemaIfCond,
> > +                        features: List[QAPISchemaFeature],
> > +                        members: List[QAPISchemaEnumMember],
> > +                        prefix: Optional[str]
> > +                        ) -> None:
> > +
> > +        value =3D qapi_to_field_name_enum(members[0].name)
>
> Unsure if this was addressed on the mailing list yet, but in our call
> we discussed how this call was vestigial and was causing the QAPI
> tests to fail. Actually, I can't quite run "make check-qapi-schema"
> and see the failure, I'm seeing it when I run "make check" and I'm not
> sure how to find the failure more efficiently/quickly:
>
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
>
>
> For the rest of my review, I commented this line out and continued on.
>
> > +        fields =3D ""
> > +        for member in members:
> > +            value =3D qapi_to_field_name_enum(member.name)
> > +            fields +=3D f'''\t{name}{value} {name} =3D "{member.name}"=
\n'''
> > +
> > +        self.target["enum"] +=3D TEMPLATE_ENUM.format(name=3Dname, fie=
lds=3Dfields[:-1])

This line is a little too long. (sorry)

try:

cd ~/src/qemu/scripts
flake8 qapi/

jsnow@scv ~/s/q/scripts (review)> flake8 qapi/
qapi/main.py:60:1: E302 expected 2 blank lines, found 1
qapi/golang.py:106:80: E501 line too long (82 > 79 characters)

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


