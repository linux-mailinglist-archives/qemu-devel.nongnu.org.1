Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE667B5AE3
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 21:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnOHJ-00070v-QI; Mon, 02 Oct 2023 15:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnOHH-00070d-TE
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 15:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnOHF-0000wQ-0Z
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 15:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696273698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YsLrhUJLC211mD4jbIHaysJ73o45YXD2aMpd5LafsBU=;
 b=DHKEi6yuy/PGLTrrG18AzMkJkfNBQKoeDCLYiRBtGDW3MBMtLjwNXK48Q4rCU3++HBE4Wy
 LvO8WtCUUQQi1t+KVfW3ERZd01jHnzJ9zUf17xqRE47YVFustE/ZW4kxUK4ueEE8Kbo2rl
 B23PTmMzZ91O7TixKh9BgalVJSQBJbA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-XzcRKnEOPzyWTk248Skczw-1; Mon, 02 Oct 2023 15:08:02 -0400
X-MC-Unique: XzcRKnEOPzyWTk248Skczw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-277527040ddso2809787a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 12:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273681; x=1696878481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsLrhUJLC211mD4jbIHaysJ73o45YXD2aMpd5LafsBU=;
 b=TiyQ+tuuVPD4g2AJlwvF8GHUY9Kf+GuksmCTRF8bs4uLQb8RJ3TvBYlAKFXWnUXqNt
 9RNiqHrDexDkQbIBUFnQUozRoiIcc3X4uzQZA9djGJjaM3G9x7Z0YKxXHHqIZjhqpkQT
 Ul8OnzBRBDs0k2VImp3hU1AzhEou6YfPTaztxNVWQV4RHQPdNkgqPI4ksIXeNBHyPhoJ
 3i6RKX5CB+kVa4Hh3Vm1xZRpkAHw+c/3Y9g5QE3ap07XCbDVZoQh8p1UV9f/MKRSfSlM
 i7j4IQebZpL/JVTvbFFFdAu0YhSwCnOoBcoEwVYxhvD21ZkBspeEXDwLS882XOG+RzV3
 Hnxg==
X-Gm-Message-State: AOJu0YyBhN/d9haGGlC35TtFkpMdS2zJeIds1qkq3eFfqkU0binVntUy
 SIxODl+Qt0EJafYU9ADQE4gPjgo6psQEdTMrDqR3twpVmtTE6+tcKvEtLkHePSgujAyTk1SSYpD
 bwjhqmBtecSu6Fx6AAeFYuBn0fBkdl3E=
X-Received: by 2002:a17:90a:6048:b0:273:f10c:b6d2 with SMTP id
 h8-20020a17090a604800b00273f10cb6d2mr675613pjm.18.1696273680933; 
 Mon, 02 Oct 2023 12:08:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFULVXbck4nj2IgBBDrYH3BGh6vM62ECCeB5SKcYkXPnu9yRbaPwpv68S4XRr8Wjc2ERE4vlaSk2fcuwuwENXA=
X-Received: by 2002:a17:90a:6048:b0:273:f10c:b6d2 with SMTP id
 h8-20020a17090a604800b00273f10cb6d2mr675579pjm.18.1696273680521; Mon, 02 Oct
 2023 12:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
In-Reply-To: <20230927112544.85011-2-victortoso@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 2 Oct 2023 15:07:49 -0400
Message-ID: <CAFn=p-ZdgaCuTZF-yYa6E_CMFobR--Yt6ycSBNDz7S+sFxX14Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Wed, Sep 27, 2023 at 7:25=E2=80=AFAM Victor Toso <victortoso@redhat.com>=
 wrote:
>
> This patch handles QAPI enum types and generates its equivalent in Go.
>
> Basically, Enums are being handled as strings in Golang.
>
> 1. For each QAPI enum, we will define a string type in Go to be the
>    assigned type of this specific enum.
>
> 2. Naming: CamelCase will be used in any identifier that we want to
>    export [0], which is everything.
>
> [0] https://go.dev/ref/spec#Exported_identifiers
>
> Example:
>
> qapi:
>   | { 'enum': 'DisplayProtocol',
>   |   'data': [ 'vnc', 'spice' ] }
>
> go:
>   | type DisplayProtocol string
>   |
>   | const (
>   |     DisplayProtocolVnc   DisplayProtocol =3D "vnc"
>   |     DisplayProtocolSpice DisplayProtocol =3D "spice"
>   | )
>
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/golang.py | 140 +++++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/main.py   |   2 +
>  2 files changed, 142 insertions(+)
>  create mode 100644 scripts/qapi/golang.py
>
> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> new file mode 100644
> index 0000000000..87081cdd05
> --- /dev/null
> +++ b/scripts/qapi/golang.py
> @@ -0,0 +1,140 @@
> +"""
> +Golang QAPI generator
> +"""
> +# Copyright (c) 2023 Red Hat Inc.
> +#
> +# Authors:
> +#  Victor Toso <victortoso@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.
> +
> +# due QAPISchemaVisitor interface
> +# pylint: disable=3Dtoo-many-arguments
> +
> +# Just for type hint on self
> +from __future__ import annotations
> +
> +import os
> +from typing import List, Optional
> +
> +from .schema import (
> +    QAPISchema,
> +    QAPISchemaType,
> +    QAPISchemaVisitor,
> +    QAPISchemaEnumMember,
> +    QAPISchemaFeature,
> +    QAPISchemaIfCond,
> +    QAPISchemaObjectType,
> +    QAPISchemaObjectTypeMember,
> +    QAPISchemaVariants,
> +)
> +from .source import QAPISourceInfo
> +
> +TEMPLATE_ENUM =3D '''
> +type {name} string
> +const (
> +{fields}
> +)
> +'''
> +
> +
> +def gen_golang(schema: QAPISchema,
> +               output_dir: str,
> +               prefix: str) -> None:
> +    vis =3D QAPISchemaGenGolangVisitor(prefix)
> +    schema.visit(vis)
> +    vis.write(output_dir)
> +
> +
> +def qapi_to_field_name_enum(name: str) -> str:
> +    return name.title().replace("-", "")
> +
> +
> +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
> +
> +    def __init__(self, _: str):
> +        super().__init__()
> +        types =3D ["enum"]
> +        self.target =3D {name: "" for name in types}
> +        self.schema =3D None
> +        self.golang_package_name =3D "qapi"
> +
> +    def visit_begin(self, schema):
> +        self.schema =3D schema
> +
> +        # Every Go file needs to reference its package name
> +        for target in self.target:
> +            self.target[target] =3D f"package {self.golang_package_name}=
\n"
> +
> +    def visit_end(self):
> +        self.schema =3D None
> +
> +    def visit_object_type(self: QAPISchemaGenGolangVisitor,
> +                          name: str,
> +                          info: Optional[QAPISourceInfo],
> +                          ifcond: QAPISchemaIfCond,
> +                          features: List[QAPISchemaFeature],
> +                          base: Optional[QAPISchemaObjectType],
> +                          members: List[QAPISchemaObjectTypeMember],
> +                          variants: Optional[QAPISchemaVariants]
> +                          ) -> None:
> +        pass
> +
> +    def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
> +                             name: str,
> +                             info: Optional[QAPISourceInfo],
> +                             ifcond: QAPISchemaIfCond,
> +                             features: List[QAPISchemaFeature],
> +                             variants: QAPISchemaVariants
> +                             ) -> None:
> +        pass
> +
> +    def visit_enum_type(self: QAPISchemaGenGolangVisitor,
> +                        name: str,
> +                        info: Optional[QAPISourceInfo],
> +                        ifcond: QAPISchemaIfCond,
> +                        features: List[QAPISchemaFeature],
> +                        members: List[QAPISchemaEnumMember],
> +                        prefix: Optional[str]
> +                        ) -> None:
> +
> +        value =3D qapi_to_field_name_enum(members[0].name)

Unsure if this was addressed on the mailing list yet, but in our call
we discussed how this call was vestigial and was causing the QAPI
tests to fail. Actually, I can't quite run "make check-qapi-schema"
and see the failure, I'm seeing it when I run "make check" and I'm not
sure how to find the failure more efficiently/quickly:

jsnow@scv ~/s/q/build (review)> make
[1/60] Generating subprojects/dtc/version_gen.h with a custom command
[2/60] Generating qemu-version.h with a custom command (wrapped by
meson to capture output)
[3/44] Generating tests/Test QAPI files with a custom command
FAILED: tests/qapi-builtin-types.c tests/qapi-builtin-types.h
tests/qapi-builtin-visit.c tests/qapi-builtin-visit.h
tests/test-qapi-commands-sub-sub-module.c
tests/test-qapi-commands-sub-sub-module.h tests/test-qapi-commands.c
tests/test-qapi-commands.h tests/test-qapi-emit-events.c
tests/test-qapi-emit-events.h tests/test-qapi-events-sub-sub-module.c
tests/test-qapi-events-sub-sub-module.h tests/test-qapi-events.c
tests/test-qapi-events.h tests/test-qapi-init-commands.c
tests/test-qapi-init-commands.h tests/test-qapi-introspect.c
tests/test-qapi-introspect.h tests/test-qapi-types-sub-sub-module.c
tests/test-qapi-types-sub-sub-module.h tests/test-qapi-types.c
tests/test-qapi-types.h tests/test-qapi-visit-sub-sub-module.c
tests/test-qapi-visit-sub-sub-module.h tests/test-qapi-visit.c
tests/test-qapi-visit.h
/home/jsnow/src/qemu/build/pyvenv/bin/python3
/home/jsnow/src/qemu/scripts/qapi-gen.py -o
/home/jsnow/src/qemu/build/tests -b -p test-
../tests/qapi-schema/qapi-schema-test.json --suppress-tracing
Traceback (most recent call last):
  File "/home/jsnow/src/qemu/scripts/qapi-gen.py", line 19, in <module>
    sys.exit(main.main())
             ^^^^^^^^^^^
  File "/home/jsnow/src/qemu/scripts/qapi/main.py", line 96, in main
    generate(args.schema,
  File "/home/jsnow/src/qemu/scripts/qapi/main.py", line 58, in generate
    gen_golang(schema, output_dir, prefix)
  File "/home/jsnow/src/qemu/scripts/qapi/golang.py", line 46, in gen_golan=
g
    schema.visit(vis)
  File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 1227, in visit
    mod.visit(visitor)
  File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 209, in visit
    entity.visit(visitor)
  File "/home/jsnow/src/qemu/scripts/qapi/schema.py", line 346, in visit
    visitor.visit_enum_type(
  File "/home/jsnow/src/qemu/scripts/qapi/golang.py", line 102, in
visit_enum_type
    value =3D qapi_to_field_name_enum(members[0].name)
                                    ~~~~~~~^^^
IndexError: list index out of range
ninja: build stopped: subcommand failed.
make: *** [Makefile:162: run-ninja] Error 1


For the rest of my review, I commented this line out and continued on.

> +        fields =3D ""
> +        for member in members:
> +            value =3D qapi_to_field_name_enum(member.name)
> +            fields +=3D f'''\t{name}{value} {name} =3D "{member.name}"\n=
'''
> +
> +        self.target["enum"] +=3D TEMPLATE_ENUM.format(name=3Dname, field=
s=3Dfields[:-1])
> +
> +    def visit_array_type(self, name, info, ifcond, element_type):
> +        pass
> +
> +    def visit_command(self,
> +                      name: str,
> +                      info: Optional[QAPISourceInfo],
> +                      ifcond: QAPISchemaIfCond,
> +                      features: List[QAPISchemaFeature],
> +                      arg_type: Optional[QAPISchemaObjectType],
> +                      ret_type: Optional[QAPISchemaType],
> +                      gen: bool,
> +                      success_response: bool,
> +                      boxed: bool,
> +                      allow_oob: bool,
> +                      allow_preconfig: bool,
> +                      coroutine: bool) -> None:
> +        pass
> +
> +    def visit_event(self, name, info, ifcond, features, arg_type, boxed)=
:
> +        pass
> +
> +    def write(self, output_dir: str) -> None:
> +        for module_name, content in self.target.items():
> +            go_module =3D module_name + "s.go"
> +            go_dir =3D "go"
> +            pathname =3D os.path.join(output_dir, go_dir, go_module)
> +            odir =3D os.path.dirname(pathname)
> +            os.makedirs(odir, exist_ok=3DTrue)
> +
> +            with open(pathname, "w", encoding=3D"ascii") as outfile:
> +                outfile.write(content)
> diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> index 316736b6a2..cdbb3690fd 100644
> --- a/scripts/qapi/main.py
> +++ b/scripts/qapi/main.py
> @@ -15,6 +15,7 @@
>  from .common import must_match
>  from .error import QAPIError
>  from .events import gen_events
> +from .golang import gen_golang
>  from .introspect import gen_introspect
>  from .schema import QAPISchema
>  from .types import gen_types
> @@ -54,6 +55,7 @@ def generate(schema_file: str,
>      gen_events(schema, output_dir, prefix)
>      gen_introspect(schema, output_dir, prefix, unmask)
>
> +    gen_golang(schema, output_dir, prefix)
>
>  def main() -> int:
>      """
> --
> 2.41.0
>


