Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A37797B84F6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:24:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4fI-000663-8P; Wed, 04 Oct 2023 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo4fF-00065v-OW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo4fC-0005yL-6T
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cbL2oZlXLYlBPrYrTX17gUm3lPG51HXZWkGrgGOiT3A=;
 b=IN6it967FCoqQObcwVvcZHvWbM1Px393uOLD3JgNGtoHSbm0QmMtscSxWuV0CG/QhEFngh
 Vjy4n5y5utTUmR/kywRiad5pSttnQ2jajOQ+AfdusmFsdbWcFwKJ7PjhgD/JrEEmDkHRwU
 zzU+oV9aSsSy03KayceNKsuI9UkGu9w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-MGfdxfpeO5a8N1i2tuL85A-1; Wed, 04 Oct 2023 12:23:51 -0400
X-MC-Unique: MGfdxfpeO5a8N1i2tuL85A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-27903b68503so2060331a91.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436630; x=1697041430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cbL2oZlXLYlBPrYrTX17gUm3lPG51HXZWkGrgGOiT3A=;
 b=wib304d75d7skvT7bEzmxngA2V6qycjxSgVTfO+tolMzdI3MSeLnkaOAUwqsld3Yd4
 TeKBeGWLfPZ99+0WWrjlrxgu+y42SHmFXHPYOpWY8vmgQKcghLdMZIc0xg0ogZu7w+O2
 tlBGd+siqvpgiBiTRoo4G6mRySvaL6M/TPnnBadYkDr20koCvc3LRUfstjw+N3Wx3LTS
 /Hd+kP+OXehIfbXr+ePLy1jr/Cmx90ujQSf19YmCHXQm4tISHZ86lMb6ofw3iGyRQ1WU
 DAvliBJ0V4VV+tk/3f5xhsUgc3SLF02dc+4/khC3tGr466G0jHeWnTfoyhZKLnhrb8kN
 ihzg==
X-Gm-Message-State: AOJu0YzrT69FCwLyd99gcPZ4TLLiwIDY/r6GquX1I0f9Oz/DSyfAazEv
 0wgXK01noMa+tGzZXqrLSJJ2EclW0JTi8iIPSNBn65hqY+rUrSOdGHRfPTK/MqD0gz7k204cfsA
 29c/9AO4+hdTHaVAhGFJOd5WEbVk/ZHfvmSwI+Ac=
X-Received: by 2002:a17:90b:384c:b0:276:caee:db4d with SMTP id
 nl12-20020a17090b384c00b00276caeedb4dmr2513983pjb.10.1696436629891; 
 Wed, 04 Oct 2023 09:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs1hIFZJa7wOYqO7mVAS3726hkH4AUk4Rt7F8AbBkWLn7IRtumINS/kvJWPXwYcF+w+bAlq5YqrEXeJGIvqag=
X-Received: by 2002:a17:90b:384c:b0:276:caee:db4d with SMTP id
 nl12-20020a17090b384c00b00276caeedb4dmr2513958pjb.10.1696436629448; Wed, 04
 Oct 2023 09:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
 <CAFn=p-ZdgaCuTZF-yYa6E_CMFobR--Yt6ycSBNDz7S+sFxX14Q@mail.gmail.com>
 <CAFn=p-ZpZN+TjBqN_5RTm0ZxHQ4pzDtMwgr-NKKyAR83hKfwOw@mail.gmail.com>
 <3duepujid3nbcfzqgadqbbmzepxzztpqpofipoargriykwfnbg@5frv62vvteeb>
In-Reply-To: <3duepujid3nbcfzqgadqbbmzepxzztpqpofipoargriykwfnbg@5frv62vvteeb>
From: John Snow <jsnow@redhat.com>
Date: Wed, 4 Oct 2023 12:23:38 -0400
Message-ID: <CAFn=p-bxZLC_zuCDgQgKxarN+L96cE2d5pfJ_vtn-i+JtdYWmA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000aec9c20606e66eda"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000aec9c20606e66eda
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 4, 2023, 8:43 AM Victor Toso <victortoso@redhat.com> wrote:

> Hi,
>
> On Mon, Oct 02, 2023 at 04:09:29PM -0400, John Snow wrote:
> > On Mon, Oct 2, 2023 at 3:07=E2=80=AFPM John Snow <jsnow@redhat.com> wro=
te:
> > >
> > > On Wed, Sep 27, 2023 at 7:25=E2=80=AFAM Victor Toso <victortoso@redha=
t.com>
> wrote:
> > > >
> > > > This patch handles QAPI enum types and generates its equivalent in
> Go.
> > > >
> > > > Basically, Enums are being handled as strings in Golang.
> > > >
> > > > 1. For each QAPI enum, we will define a string type in Go to be the
> > > >    assigned type of this specific enum.
> > > >
> > > > 2. Naming: CamelCase will be used in any identifier that we want to
> > > >    export [0], which is everything.
> > > >
> > > > [0] https://go.dev/ref/spec#Exported_identifiers
> > > >
> > > > Example:
> > > >
> > > > qapi:
> > > >   | { 'enum': 'DisplayProtocol',
> > > >   |   'data': [ 'vnc', 'spice' ] }
> > > >
> > > > go:
> > > >   | type DisplayProtocol string
> > > >   |
> > > >   | const (
> > > >   |     DisplayProtocolVnc   DisplayProtocol =3D "vnc"
> > > >   |     DisplayProtocolSpice DisplayProtocol =3D "spice"
> > > >   | )
> > > >
> > > > Signed-off-by: Victor Toso <victortoso@redhat.com>
> > > > ---
> > > >  scripts/qapi/golang.py | 140
> +++++++++++++++++++++++++++++++++++++++++
> > > >  scripts/qapi/main.py   |   2 +
> > > >  2 files changed, 142 insertions(+)
> > > >  create mode 100644 scripts/qapi/golang.py
> > > >
> > > > diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> > > > new file mode 100644
> > > > index 0000000000..87081cdd05
> > > > --- /dev/null
> > > > +++ b/scripts/qapi/golang.py
> > > > @@ -0,0 +1,140 @@
> > > > +"""
> > > > +Golang QAPI generator
> > > > +"""
> > > > +# Copyright (c) 2023 Red Hat Inc.
> > > > +#
> > > > +# Authors:
> > > > +#  Victor Toso <victortoso@redhat.com>
> > > > +#
> > > > +# This work is licensed under the terms of the GNU GPL, version 2.
> > > > +# See the COPYING file in the top-level directory.
> > > > +
> > > > +# due QAPISchemaVisitor interface
> > > > +# pylint: disable=3Dtoo-many-arguments
> >
> > "due to" - also, you could more selectively disable this warning by
> > putting this comment in the body of the QAPISchemaVisitor class which
> > would make your exemption from the linter more locally obvious.
> >
> > > > +
> > > > +# Just for type hint on self
> > > > +from __future__ import annotations
> >
> > Oh, you know - it's been so long since I worked on QAPI I didn't
> > realize we had access to this now. That's awesome!
> >
> > (It was introduced in Python 3.7+)
> >
> > > > +
> > > > +import os
> > > > +from typing import List, Optional
> > > > +
> > > > +from .schema import (
> > > > +    QAPISchema,
> > > > +    QAPISchemaType,
> > > > +    QAPISchemaVisitor,
> > > > +    QAPISchemaEnumMember,
> > > > +    QAPISchemaFeature,
> > > > +    QAPISchemaIfCond,
> > > > +    QAPISchemaObjectType,
> > > > +    QAPISchemaObjectTypeMember,
> > > > +    QAPISchemaVariants,
> > > > +)
> > > > +from .source import QAPISourceInfo
> > > > +
> >
> > Try running isort here:
> >
> > > cd ~/src/qemu/scripts
> > > isort -c qapi/golang.py
> >
> > ERROR: /home/jsnow/src/qemu/scripts/qapi/golang.py Imports are
> > incorrectly sorted and/or formatted.
> >
> > you can have it fix the import order for you:
> >
> > > isort qapi/golang.py
> >
> > It's very pedantic stuff, but luckily there's a tool to just handle it
> for you.
>
> Thanks! Also fixed for the next iteration.
>
> > > > +TEMPLATE_ENUM =3D '''
> > > > +type {name} string
> > > > +const (
> > > > +{fields}
> > > > +)
> > > > +'''
> > > > +
> > > > +
> > > > +def gen_golang(schema: QAPISchema,
> > > > +               output_dir: str,
> > > > +               prefix: str) -> None:
> > > > +    vis =3D QAPISchemaGenGolangVisitor(prefix)
> > > > +    schema.visit(vis)
> > > > +    vis.write(output_dir)
> > > > +
> > > > +
> > > > +def qapi_to_field_name_enum(name: str) -> str:
> > > > +    return name.title().replace("-", "")
> > > > +
> > > > +
> > > > +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
> > > > +
> > > > +    def __init__(self, _: str):
> > > > +        super().__init__()
> > > > +        types =3D ["enum"]
> > > > +        self.target =3D {name: "" for name in types}
> >
> > you *could* say:
> >
> > types =3D ("enum",)
> > self.target =3D dict.fromkeys(types, "")
> >
> > 1. We don't need a list because we won't be modifying it, so a tuple
> suffices
> > 2. There's an idiom for doing what you want that reads a little better
> > 3. None of it really matters, though.
>
> No complains with moving it to a tuple.
>
> > Also keep in mind you don't *need* to initialize a dict in this way,
> > you can just arbitrarily assign into it whenever you'd like.
> >
> > sellf.target['enum'] =3D foo
>
> I think it is a problem with +=3D operator when not initialized.
>
>     self.target['enum'] =3D foo
>
> At least I recall having errors around dict not being
> initialized.
>

ah, okay.

You can also do:

self.target.setdefault("enum", "") +=3D "blah"

but it's also fine to initialize up front. just teaching you a trick in
case it helps.


> > I don't know if that makes things easier or not with however the
> > subsequent patches are written.
> >
> > > > +        self.schema =3D None
> > > > +        self.golang_package_name =3D "qapi"
> > > > +
> > > > +    def visit_begin(self, schema):
> > > > +        self.schema =3D schema
> > > > +
> > > > +        # Every Go file needs to reference its package name
> > > > +        for target in self.target:
> > > > +            self.target[target] =3D f"package
> {self.golang_package_name}\n"
> > > > +
> > > > +    def visit_end(self):
> > > > +        self.schema =3D None
> > > > +
> > > > +    def visit_object_type(self: QAPISchemaGenGolangVisitor,
> > > > +                          name: str,
> > > > +                          info: Optional[QAPISourceInfo],
> > > > +                          ifcond: QAPISchemaIfCond,
> > > > +                          features: List[QAPISchemaFeature],
> > > > +                          base: Optional[QAPISchemaObjectType],
> > > > +                          members: List[QAPISchemaObjectTypeMember=
],
> > > > +                          variants: Optional[QAPISchemaVariants]
> > > > +                          ) -> None:
> > > > +        pass
> > > > +
> > > > +    def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
> > > > +                             name: str,
> > > > +                             info: Optional[QAPISourceInfo],
> > > > +                             ifcond: QAPISchemaIfCond,
> > > > +                             features: List[QAPISchemaFeature],
> > > > +                             variants: QAPISchemaVariants
> > > > +                             ) -> None:
> > > > +        pass
> > > > +
> > > > +    def visit_enum_type(self: QAPISchemaGenGolangVisitor,
> >
> > Was there a problem when you omitted the type for 'self'?
> > Usually that can be inferred. As of this patch, at least, I
> > think this can be safely dropped. (Maybe it becomes important
> > later.)
>
> I don't think I tried removing the type for self. I actually
> tried to keep all types expressed, just for the sake of knowing
> what types they were.
>
> Yes, it can be easily inferred and removed.
>

Normally I'm also in favor of being explicit, but where python is concerned
this may interfere with inheritance.

Usually it's best to leave self untyped because it avoids cyclical
references and it also behaves correctly in the type tree.

There are idioms for how to express a return type of "self" if that becomes
needed.


> > > > +                        name: str,
> > > > +                        info: Optional[QAPISourceInfo],
> > > > +                        ifcond: QAPISchemaIfCond,
> > > > +                        features: List[QAPISchemaFeature],
> > > > +                        members: List[QAPISchemaEnumMember],
> > > > +                        prefix: Optional[str]
> > > > +                        ) -> None:
> > > > +
> > > > +        value =3D qapi_to_field_name_enum(members[0].name)
> > >
> > > Unsure if this was addressed on the mailing list yet, but in our call
> > > we discussed how this call was vestigial and was causing the QAPI
> > > tests to fail. Actually, I can't quite run "make check-qapi-schema"
> > > and see the failure, I'm seeing it when I run "make check" and I'm no=
t
> > > sure how to find the failure more efficiently/quickly:
> > >
> > > jsnow@scv ~/s/q/build (review)> make
> > > [1/60] Generating subprojects/dtc/version_gen.h with a custom command
> > > [2/60] Generating qemu-version.h with a custom command (wrapped by
> > > meson to capture output)
> > > [3/44] Generating tests/Test QAPI files with a custom command
> > > FAILED: tests/qapi-builtin-types.c tests/qapi-builtin-types.h
> > > tests/qapi-builtin-visit.c tests/qapi-builtin-visit.h
> > > tests/test-qapi-commands-sub-sub-module.c
> > > tests/test-qapi-commands-sub-sub-module.h tests/test-qapi-commands.c
> > > tests/test-qapi-commands.h tests/test-qapi-emit-events.c
> > > tests/test-qapi-emit-events.h tests/test-qapi-events-sub-sub-module.c
> > > tests/test-qapi-events-sub-sub-module.h tests/test-qapi-events.c
> > > tests/test-qapi-events.h tests/test-qapi-init-commands.c
> > > tests/test-qapi-init-commands.h tests/test-qapi-introspect.c
> > > tests/test-qapi-introspect.h tests/test-qapi-types-sub-sub-module.c
> > > tests/test-qapi-types-sub-sub-module.h tests/test-qapi-types.c
> > > tests/test-qapi-types.h tests/test-qapi-visit-sub-sub-module.c
> > > tests/test-qapi-visit-sub-sub-module.h tests/test-qapi-visit.c
> > > tests/test-qapi-visit.h
> > > /home/jsnow/src/qemu/build/pyvenv/bin/python3
> > > /home/jsnow/src/qemu/scripts/qapi-gen.py -o
> > > /home/jsnow/src/qemu/build/tests -b -p test-
> > > ../tests/qapi-schema/qapi-schema-test.json --suppress-tracing
> > > Traceback (most recent call last):
> > >   File "/home/jsnow/src/qemu/scripts/qapi-gen.py", line 19, in <modul=
e>
> > >     sys.exit(main.main())
> > >              ^^^^^^^^^^^
> > >   File "/home/jsnow/src/qemu/scripts/qapi/main.py", line 96, in main
> > >     generate(args.schema,
> > >   File "/home/jsnow/src/qemu/scripts/qapi/main.py", line 58, in
> generate
> > >     gen_golang(schema, output_dir, prefix)
> > >   File "/home/jsnow/src/qemu/scripts/qapi/golang.py", line 46, in
> gen_golang
> > >     schema.visit(vis)
> > >   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 1227, in
> visit
> > >     mod.visit(visitor)
> > >   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 209, in
> visit
> > >     entity.visit(visitor)
> > >   File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 346, in
> visit
> > >     visitor.visit_enum_type(
> > >   File "/home/jsnow/src/qemu/scripts/qapi/golang.py", line 102, in
> > > visit_enum_type
> > >     value =3D qapi_to_field_name_enum(members[0].name)
> > >                                     ~~~~~~~^^^
> > > IndexError: list index out of range
> > > ninja: build stopped: subcommand failed.
> > > make: *** [Makefile:162: run-ninja] Error 1
> > >
> > >
> > > For the rest of my review, I commented this line out and continued on=
.
> > >
> > > > +        fields =3D ""
> > > > +        for member in members:
> > > > +            value =3D qapi_to_field_name_enum(member.name)
> > > > +            fields +=3D f'''\t{name}{value} {name} =3D "{member.na=
me
> }"\n'''
> > > > +
> > > > +        self.target["enum"] +=3D TEMPLATE_ENUM.format(name=3Dname,
> fields=3Dfields[:-1])
> >
> > This line is a little too long. (sorry)
> >
> > try:
> >
> > cd ~/src/qemu/scripts
> > flake8 qapi/
>
>
> toso@tapioca ~/s/qemu > flake8 scripts/qapi | wc
>      89     734    6260
>
> Yep, I'll fix them.
>
> > jsnow@scv ~/s/q/scripts (review)> flake8 qapi/
> > qapi/main.py:60:1: E302 expected 2 blank lines, found 1
> > qapi/golang.py:106:80: E501 line too long (82 > 79 characters)
>
> Cheers,
> Victor
>
> >
> > > > +
> > > > +    def visit_array_type(self, name, info, ifcond, element_type):
> > > > +        pass
> > > > +
> > > > +    def visit_command(self,
> > > > +                      name: str,
> > > > +                      info: Optional[QAPISourceInfo],
> > > > +                      ifcond: QAPISchemaIfCond,
> > > > +                      features: List[QAPISchemaFeature],
> > > > +                      arg_type: Optional[QAPISchemaObjectType],
> > > > +                      ret_type: Optional[QAPISchemaType],
> > > > +                      gen: bool,
> > > > +                      success_response: bool,
> > > > +                      boxed: bool,
> > > > +                      allow_oob: bool,
> > > > +                      allow_preconfig: bool,
> > > > +                      coroutine: bool) -> None:
> > > > +        pass
> > > > +
> > > > +    def visit_event(self, name, info, ifcond, features, arg_type,
> boxed):
> > > > +        pass
> > > > +
> > > > +    def write(self, output_dir: str) -> None:
> > > > +        for module_name, content in self.target.items():
> > > > +            go_module =3D module_name + "s.go"
> > > > +            go_dir =3D "go"
> > > > +            pathname =3D os.path.join(output_dir, go_dir, go_modul=
e)
> > > > +            odir =3D os.path.dirname(pathname)
> > > > +            os.makedirs(odir, exist_ok=3DTrue)
> > > > +
> > > > +            with open(pathname, "w", encoding=3D"ascii") as outfil=
e:
> > > > +                outfile.write(content)
> > > > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > > > index 316736b6a2..cdbb3690fd 100644
> > > > --- a/scripts/qapi/main.py
> > > > +++ b/scripts/qapi/main.py
> > > > @@ -15,6 +15,7 @@
> > > >  from .common import must_match
> > > >  from .error import QAPIError
> > > >  from .events import gen_events
> > > > +from .golang import gen_golang
> > > >  from .introspect import gen_introspect
> > > >  from .schema import QAPISchema
> > > >  from .types import gen_types
> > > > @@ -54,6 +55,7 @@ def generate(schema_file: str,
> > > >      gen_events(schema, output_dir, prefix)
> > > >      gen_introspect(schema, output_dir, prefix, unmask)
> > > >
> > > > +    gen_golang(schema, output_dir, prefix)
> > > >
> > > >  def main() -> int:
> > > >      """
> > > > --
> > > > 2.41.0
> > > >
> >
>

--000000000000aec9c20606e66eda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 4, 2023, 8:43 AM Victor Toso &lt;<a href=
=3D"mailto:victortoso@redhat.com">victortoso@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Mon, Oct 02, 2023 at 04:09:29PM -0400, John Snow wrote:<br>
&gt; On Mon, Oct 2, 2023 at 3:07=E2=80=AFPM John Snow &lt;<a href=3D"mailto=
:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a=
>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Wed, Sep 27, 2023 at 7:25=E2=80=AFAM Victor Toso &lt;<a href=
=3D"mailto:victortoso@redhat.com" target=3D"_blank" rel=3D"noreferrer">vict=
ortoso@redhat.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This patch handles QAPI enum types and generates its equival=
ent in Go.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Basically, Enums are being handled as strings in Golang.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 1. For each QAPI enum, we will define a string type in Go to=
 be the<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 assigned type of this specific enum.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 2. Naming: CamelCase will be used in any identifier that we =
want to<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 export [0], which is everything.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; [0] <a href=3D"https://go.dev/ref/spec#Exported_identifiers"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">https://go.dev/ref/spec#Ex=
ported_identifiers</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Example:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; qapi:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0| { &#39;enum&#39;: &#39;DisplayProtocol&#39;,<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0|=C2=A0 =C2=A0&#39;data&#39;: [ &#39;vnc&#39;, &=
#39;spice&#39; ] }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; go:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0| type DisplayProtocol string<br>
&gt; &gt; &gt;=C2=A0 =C2=A0|<br>
&gt; &gt; &gt;=C2=A0 =C2=A0| const (<br>
&gt; &gt; &gt;=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0DisplayProtocolVnc=C2=A0 =
=C2=A0DisplayProtocol =3D &quot;vnc&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0DisplayProtocolSpice Displa=
yProtocol =3D &quot;spice&quot;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0| )<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Victor Toso &lt;<a href=3D"mailto:victortoso@=
redhat.com" target=3D"_blank" rel=3D"noreferrer">victortoso@redhat.com</a>&=
gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 scripts/qapi/golang.py | 140 +++++++++++++++++++++++++=
++++++++++++++++<br>
&gt; &gt; &gt;=C2=A0 scripts/qapi/main.py=C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt;=C2=A0 2 files changed, 142 insertions(+)<br>
&gt; &gt; &gt;=C2=A0 create mode 100644 scripts/qapi/golang.py<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py=
<br>
&gt; &gt; &gt; new file mode 100644<br>
&gt; &gt; &gt; index 0000000000..87081cdd05<br>
&gt; &gt; &gt; --- /dev/null<br>
&gt; &gt; &gt; +++ b/scripts/qapi/golang.py<br>
&gt; &gt; &gt; @@ -0,0 +1,140 @@<br>
&gt; &gt; &gt; +&quot;&quot;&quot;<br>
&gt; &gt; &gt; +Golang QAPI generator<br>
&gt; &gt; &gt; +&quot;&quot;&quot;<br>
&gt; &gt; &gt; +# Copyright (c) 2023 Red Hat Inc.<br>
&gt; &gt; &gt; +#<br>
&gt; &gt; &gt; +# Authors:<br>
&gt; &gt; &gt; +#=C2=A0 Victor Toso &lt;<a href=3D"mailto:victortoso@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">victortoso@redhat.com</a>&gt;<br=
>
&gt; &gt; &gt; +#<br>
&gt; &gt; &gt; +# This work is licensed under the terms of the GNU GPL, ver=
sion 2.<br>
&gt; &gt; &gt; +# See the COPYING file in the top-level directory.<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +# due QAPISchemaVisitor interface<br>
&gt; &gt; &gt; +# pylint: disable=3Dtoo-many-arguments<br>
&gt; <br>
&gt; &quot;due to&quot; - also, you could more selectively disable this war=
ning by<br>
&gt; putting this comment in the body of the QAPISchemaVisitor class which<=
br>
&gt; would make your exemption from the linter more locally obvious.<br>
&gt; <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +# Just for type hint on self<br>
&gt; &gt; &gt; +from __future__ import annotations<br>
&gt; <br>
&gt; Oh, you know - it&#39;s been so long since I worked on QAPI I didn&#39=
;t<br>
&gt; realize we had access to this now. That&#39;s awesome!<br>
&gt; <br>
&gt; (It was introduced in Python 3.7+)<br>
&gt; <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +import os<br>
&gt; &gt; &gt; +from typing import List, Optional<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +from .schema import (<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchema,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchemaType,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchemaVisitor,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchemaEnumMember,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchemaFeature,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchemaIfCond,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchemaObjectType,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchemaObjectTypeMember,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 QAPISchemaVariants,<br>
&gt; &gt; &gt; +)<br>
&gt; &gt; &gt; +from .source import QAPISourceInfo<br>
&gt; &gt; &gt; +<br>
&gt; <br>
&gt; Try running isort here:<br>
&gt; <br>
&gt; &gt; cd ~/src/qemu/scripts<br>
&gt; &gt; isort -c qapi/golang.py<br>
&gt; <br>
&gt; ERROR: /home/jsnow/src/qemu/scripts/qapi/golang.py Imports are<br>
&gt; incorrectly sorted and/or formatted.<br>
&gt; <br>
&gt; you can have it fix the import order for you:<br>
&gt; <br>
&gt; &gt; isort qapi/golang.py<br>
&gt; <br>
&gt; It&#39;s very pedantic stuff, but luckily there&#39;s a tool to just h=
andle it for you.<br>
<br>
Thanks! Also fixed for the next iteration.<br>
<br>
&gt; &gt; &gt; +TEMPLATE_ENUM =3D &#39;&#39;&#39;<br>
&gt; &gt; &gt; +type {name} string<br>
&gt; &gt; &gt; +const (<br>
&gt; &gt; &gt; +{fields}<br>
&gt; &gt; &gt; +)<br>
&gt; &gt; &gt; +&#39;&#39;&#39;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +def gen_golang(schema: QAPISchema,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0outp=
ut_dir: str,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pref=
ix: str) -&gt; None:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 vis =3D QAPISchemaGenGolangVisitor(prefix)<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 schema.visit(vis)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 vis.write(output_dir)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +def qapi_to_field_name_enum(name: str) -&gt; str:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 return name.title().replace(&quot;-&quot;, &q=
uot;&quot;)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def __init__(self, _: str):<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__()<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 types =3D [&quot;enum&quot;]<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.target =3D {name: &quot;&q=
uot; for name in types}<br>
&gt; <br>
&gt; you *could* say:<br>
&gt; <br>
&gt; types =3D (&quot;enum&quot;,)<br>
&gt; self.target =3D dict.fromkeys(types, &quot;&quot;)<br>
&gt; <br>
&gt; 1. We don&#39;t need a list because we won&#39;t be modifying it, so a=
 tuple suffices<br>
&gt; 2. There&#39;s an idiom for doing what you want that reads a little be=
tter<br>
&gt; 3. None of it really matters, though.<br>
<br>
No complains with moving it to a tuple.<br>
<br>
&gt; Also keep in mind you don&#39;t *need* to initialize a dict in this wa=
y,<br>
&gt; you can just arbitrarily assign into it whenever you&#39;d like.<br>
&gt; <br>
&gt; sellf.target[&#39;enum&#39;] =3D foo<br>
<br>
I think it is a problem with +=3D operator when not initialized.<br>
<br>
=C2=A0 =C2=A0 self.target[&#39;enum&#39;] =3D foo<br>
<br>
At least I recall having errors around dict not being<br>
initialized.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">ah, okay.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Yo=
u can also do:</div><div dir=3D"auto"><br></div><div dir=3D"auto">self.targ=
et.setdefault(&quot;enum&quot;, &quot;&quot;) +=3D &quot;blah&quot;</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">but it&#39;s also fine to initi=
alize up front. just teaching you a trick in case it helps.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt; I don&#39;t know if that makes things easier or not with however the<b=
r>
&gt; subsequent patches are written.<br>
&gt; <br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.schema =3D None<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.golang_package_name =3D &q=
uot;qapi&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def visit_begin(self, schema):<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.schema =3D schema<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Every Go file needs to refere=
nce its package name<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for target in self.target:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.target[targe=
t] =3D f&quot;package {self.golang_package_name}\n&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def visit_end(self):<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.schema =3D None<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def visit_object_type(self: QAPISchemaGenGola=
ngVisitor,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: str,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info: Optional[QAPISourceInfo],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifcond: QAPISchemaIfCond,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 features: List[QAPISchemaFeature],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base: Optional[QAPISchemaObjectType],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 members: List[QAPISchemaObjectTypeMember],<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 variants: Optional[QAPISchemaVariants]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) -&gt; None:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def visit_alternate_type(self: QAPISchemaGenG=
olangVisitor,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name: str,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info: Optional[QAPISourceInfo]=
,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ifcond: QAPISchemaIfCond,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features: List[QAPISchemaFeatu=
re],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0variants: QAPISchemaVariants<b=
r>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0) -&gt; None:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def visit_enum_type(self: QAPISchemaGenGolang=
Visitor,<br>
&gt; <br>
&gt; Was there a problem when you omitted the type for &#39;self&#39;?<br>
&gt; Usually that can be inferred. As of this patch, at least, I<br>
&gt; think this can be safely dropped. (Maybe it becomes important<br>
&gt; later.)<br>
<br>
I don&#39;t think I tried removing the type for self. I actually<br>
tried to keep all types expressed, just for the sake of knowing<br>
what types they were.<br>
<br>
Yes, it can be easily inferred and removed.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Normally I&#39;m also in favor o=
f being explicit, but where python is concerned this may interfere with inh=
eritance.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Usually it&#39=
;s best to leave self untyped because it avoids cyclical references and it =
also behaves correctly in the type tree.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">There are idioms for how to express a return type of &quot=
;self&quot; if that becomes needed.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 name: str,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 info: Optional[QAPISourceInfo],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ifcond: QAPISchemaIfCond,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 features: List[QAPISchemaFeature],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 members: List[QAPISchemaEnumMember],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 prefix: Optional[str]<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ) -&gt; None:<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D qapi_to_field_name_en=
um(members[0].name)<br>
&gt; &gt;<br>
&gt; &gt; Unsure if this was addressed on the mailing list yet, but in our =
call<br>
&gt; &gt; we discussed how this call was vestigial and was causing the QAPI=
<br>
&gt; &gt; tests to fail. Actually, I can&#39;t quite run &quot;make check-q=
api-schema&quot;<br>
&gt; &gt; and see the failure, I&#39;m seeing it when I run &quot;make chec=
k&quot; and I&#39;m not<br>
&gt; &gt; sure how to find the failure more efficiently/quickly:<br>
&gt; &gt;<br>
&gt; &gt; jsnow@scv ~/s/q/build (review)&gt; make<br>
&gt; &gt; [1/60] Generating subprojects/dtc/version_gen.h with a custom com=
mand<br>
&gt; &gt; [2/60] Generating qemu-version.h with a custom command (wrapped b=
y<br>
&gt; &gt; meson to capture output)<br>
&gt; &gt; [3/44] Generating tests/Test QAPI files with a custom command<br>
&gt; &gt; FAILED: tests/qapi-builtin-types.c tests/qapi-builtin-types.h<br>
&gt; &gt; tests/qapi-builtin-visit.c tests/qapi-builtin-visit.h<br>
&gt; &gt; tests/test-qapi-commands-sub-sub-module.c<br>
&gt; &gt; tests/test-qapi-commands-sub-sub-module.h tests/test-qapi-command=
s.c<br>
&gt; &gt; tests/test-qapi-commands.h tests/test-qapi-emit-events.c<br>
&gt; &gt; tests/test-qapi-emit-events.h tests/test-qapi-events-sub-sub-modu=
le.c<br>
&gt; &gt; tests/test-qapi-events-sub-sub-module.h tests/test-qapi-events.c<=
br>
&gt; &gt; tests/test-qapi-events.h tests/test-qapi-init-commands.c<br>
&gt; &gt; tests/test-qapi-init-commands.h tests/test-qapi-introspect.c<br>
&gt; &gt; tests/test-qapi-introspect.h tests/test-qapi-types-sub-sub-module=
.c<br>
&gt; &gt; tests/test-qapi-types-sub-sub-module.h tests/test-qapi-types.c<br=
>
&gt; &gt; tests/test-qapi-types.h tests/test-qapi-visit-sub-sub-module.c<br=
>
&gt; &gt; tests/test-qapi-visit-sub-sub-module.h tests/test-qapi-visit.c<br=
>
&gt; &gt; tests/test-qapi-visit.h<br>
&gt; &gt; /home/jsnow/src/qemu/build/pyvenv/bin/python3<br>
&gt; &gt; /home/jsnow/src/qemu/scripts/qapi-gen.py -o<br>
&gt; &gt; /home/jsnow/src/qemu/build/tests -b -p test-<br>
&gt; &gt; ../tests/qapi-schema/qapi-schema-test.json --suppress-tracing<br>
&gt; &gt; Traceback (most recent call last):<br>
&gt; &gt;=C2=A0 =C2=A0File &quot;/home/jsnow/src/qemu/scripts/qapi-gen.py&q=
uot;, line 19, in &lt;module&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0sys.exit(main.main())<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^<br>
&gt; &gt;=C2=A0 =C2=A0File &quot;/home/jsnow/src/qemu/scripts/qapi/main.py&=
quot;, line 96, in main<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0generate(args.schema,<br>
&gt; &gt;=C2=A0 =C2=A0File &quot;/home/jsnow/src/qemu/scripts/qapi/main.py&=
quot;, line 58, in generate<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0gen_golang(schema, output_dir, prefix)<br>
&gt; &gt;=C2=A0 =C2=A0File &quot;/home/jsnow/src/qemu/scripts/qapi/golang.p=
y&quot;, line 46, in gen_golang<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0schema.visit(vis)<br>
&gt; &gt;=C2=A0 =C2=A0File &quot;/home/jsnow/src/qemu/scripts/qapi/schema.p=
y&quot;, line 1227, in visit<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0mod.visit(visitor)<br>
&gt; &gt;=C2=A0 =C2=A0File &quot;/home/jsnow/src/qemu/scripts/qapi/schema.p=
y&quot;, line 209, in visit<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0entity.visit(visitor)<br>
&gt; &gt;=C2=A0 =C2=A0File &quot;/home/jsnow/src/qemu/scripts/qapi/schema.p=
y&quot;, line 346, in visit<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0visitor.visit_enum_type(<br>
&gt; &gt;=C2=A0 =C2=A0File &quot;/home/jsnow/src/qemu/scripts/qapi/golang.p=
y&quot;, line 102, in<br>
&gt; &gt; visit_enum_type<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0value =3D qapi_to_field_name_enum(members[0].n=
ame)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~~~~~~^^=
^<br>
&gt; &gt; IndexError: list index out of range<br>
&gt; &gt; ninja: build stopped: subcommand failed.<br>
&gt; &gt; make: *** [Makefile:162: run-ninja] Error 1<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; For the rest of my review, I commented this line out and continue=
d on.<br>
&gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fields =3D &quot;&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for member in members:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D qapi_to=
_field_name_enum(<a href=3D"http://member.name" rel=3D"noreferrer noreferre=
r" target=3D"_blank">member.name</a>)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fields +=3D f&#39=
;&#39;&#39;\t{name}{value} {name} =3D &quot;{<a href=3D"http://member.name"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">member.name</a>}&quot;\n&#=
39;&#39;&#39;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.target[&quot;enum&quot;] +=
=3D TEMPLATE_ENUM.format(name=3Dname, fields=3Dfields[:-1])<br>
&gt; <br>
&gt; This line is a little too long. (sorry)<br>
&gt; <br>
&gt; try:<br>
&gt; <br>
&gt; cd ~/src/qemu/scripts<br>
&gt; flake8 qapi/<br>
<br>
<br>
toso@tapioca ~/s/qemu &gt; flake8 scripts/qapi | wc<br>
=C2=A0 =C2=A0 =C2=A089=C2=A0 =C2=A0 =C2=A0734=C2=A0 =C2=A0 6260<br>
<br>
Yep, I&#39;ll fix them.<br>
<br>
&gt; jsnow@scv ~/s/q/scripts (review)&gt; flake8 qapi/<br>
&gt; qapi/main.py:60:1: E302 expected 2 blank lines, found 1<br>
&gt; qapi/golang.py:106:80: E501 line too long (82 &gt; 79 characters)<br>
<br>
Cheers,<br>
Victor<br>
<br>
&gt; <br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def visit_array_type(self, name, info, ifcond=
, element_type):<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def visit_command(self,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 name: str,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 info: Optional[QAPISourceInfo],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ifcond: QAPISchemaIfCond,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 features: List[QAPISchemaFeature],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 arg_type: Optional[QAPISchemaObjectType],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ret_type: Optional[QAPISchemaType],<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 gen: bool,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 success_response: bool,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 boxed: bool,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 allow_oob: bool,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 allow_preconfig: bool,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 coroutine: bool) -&gt; None:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def visit_event(self, name, info, ifcond, fea=
tures, arg_type, boxed):<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 def write(self, output_dir: str) -&gt; None:<=
br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for module_name, content in sel=
f.target.items():<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 go_module =3D mod=
ule_name + &quot;s.go&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 go_dir =3D &quot;=
go&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pathname =3D os.p=
ath.join(output_dir, go_dir, go_module)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 odir =3D os.path.=
dirname(pathname)<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.makedirs(odir,=
 exist_ok=3DTrue)<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(pathnam=
e, &quot;w&quot;, encoding=3D&quot;ascii&quot;) as outfile:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out=
file.write(content)<br>
&gt; &gt; &gt; diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py<br>
&gt; &gt; &gt; index 316736b6a2..cdbb3690fd 100644<br>
&gt; &gt; &gt; --- a/scripts/qapi/main.py<br>
&gt; &gt; &gt; +++ b/scripts/qapi/main.py<br>
&gt; &gt; &gt; @@ -15,6 +15,7 @@<br>
&gt; &gt; &gt;=C2=A0 from .common import must_match<br>
&gt; &gt; &gt;=C2=A0 from .error import QAPIError<br>
&gt; &gt; &gt;=C2=A0 from .events import gen_events<br>
&gt; &gt; &gt; +from .golang import gen_golang<br>
&gt; &gt; &gt;=C2=A0 from .introspect import gen_introspect<br>
&gt; &gt; &gt;=C2=A0 from .schema import QAPISchema<br>
&gt; &gt; &gt;=C2=A0 from .types import gen_types<br>
&gt; &gt; &gt; @@ -54,6 +55,7 @@ def generate(schema_file: str,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 gen_events(schema, output_dir, prefix)<b=
r>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 gen_introspect(schema, output_dir, prefi=
x, unmask)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 gen_golang(schema, output_dir, prefix)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 def main() -&gt; int:<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.41.0<br>
&gt; &gt; &gt;<br>
&gt; <br>
</blockquote></div></div></div>

--000000000000aec9c20606e66eda--


