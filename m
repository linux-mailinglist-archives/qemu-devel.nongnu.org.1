Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 170617B1F61
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrt6-0004yd-C9; Thu, 28 Sep 2023 10:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlrt4-0004wf-6a
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlrsz-0007CS-Ai
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695910858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fccPulAjegZ7OiO0TeYH90B6XxHmlKusVjDFJejk3qY=;
 b=YZtNZm8H35Pkvn5yGt936G8OHjV4uSo/+8JL+P7PdmQZdaNEzJdcgZB21lTEODD0tznvjN
 h0J/WCrXrnoNVC8agdRO/GPsVBWE6TGTShSlaT7szB3S3TfQLPWW+5ynBwUJuKK68pa/ZX
 iePd1EeRyxal/OCu7hMEDPW0wnAiBWE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-FvD8A8w6PMemrfJKqQEIeA-1; Thu, 28 Sep 2023 10:20:56 -0400
X-MC-Unique: FvD8A8w6PMemrfJKqQEIeA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84EA93816C98
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:20:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45B1810F1BE9
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:20:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5130B21E6904; Thu, 28 Sep 2023 16:20:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>,  qemu-devel@nongnu.org,  John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
 <ZRWFCPhUfXMCrml1@redhat.com>
Date: Thu, 28 Sep 2023 16:20:55 +0200
In-Reply-To: <ZRWFCPhUfXMCrml1@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 28 Sep 2023 14:52:08 +0100")
Message-ID: <87cyy2tm48.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Sep 27, 2023 at 01:25:36PM +0200, Victor Toso wrote:
>> This patch handles QAPI enum types and generates its equivalent in Go.
>>=20
>> Basically, Enums are being handled as strings in Golang.
>>=20
>> 1. For each QAPI enum, we will define a string type in Go to be the
>>    assigned type of this specific enum.
>>=20
>> 2. Naming: CamelCase will be used in any identifier that we want to
>>    export [0], which is everything.
>>=20
>> [0] https://go.dev/ref/spec#Exported_identifiers
>>=20
>> Example:
>>=20
>> qapi:
>>   | { 'enum': 'DisplayProtocol',
>>   |   'data': [ 'vnc', 'spice' ] }
>>=20
>> go:
>>   | type DisplayProtocol string
>>   |
>>   | const (
>>   |     DisplayProtocolVnc   DisplayProtocol =3D "vnc"
>>   |     DisplayProtocolSpice DisplayProtocol =3D "spice"
>>   | )
>>=20
>> Signed-off-by: Victor Toso <victortoso@redhat.com>
>> ---
>>  scripts/qapi/golang.py | 140 +++++++++++++++++++++++++++++++++++++++++
>>  scripts/qapi/main.py   |   2 +
>>  2 files changed, 142 insertions(+)
>>  create mode 100644 scripts/qapi/golang.py
>>=20
>> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
>> new file mode 100644
>> index 0000000000..87081cdd05
>> --- /dev/null
>> +++ b/scripts/qapi/golang.py
>> @@ -0,0 +1,140 @@
>> +"""
>> +Golang QAPI generator
>> +"""
>> +# Copyright (c) 2023 Red Hat Inc.
>> +#
>> +# Authors:
>> +#  Victor Toso <victortoso@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2.
>> +# See the COPYING file in the top-level directory.
>> +
>> +# due QAPISchemaVisitor interface
>> +# pylint: disable=3Dtoo-many-arguments
>> +
>> +# Just for type hint on self
>> +from __future__ import annotations
>> +
>> +import os
>> +from typing import List, Optional
>> +
>> +from .schema import (
>> +    QAPISchema,
>> +    QAPISchemaType,
>> +    QAPISchemaVisitor,
>> +    QAPISchemaEnumMember,
>> +    QAPISchemaFeature,
>> +    QAPISchemaIfCond,
>> +    QAPISchemaObjectType,
>> +    QAPISchemaObjectTypeMember,
>> +    QAPISchemaVariants,
>> +)
>> +from .source import QAPISourceInfo
>> +
>> +TEMPLATE_ENUM =3D '''
>> +type {name} string
>> +const (
>> +{fields}
>> +)
>> +'''
>> +
>> +
>> +def gen_golang(schema: QAPISchema,
>> +               output_dir: str,
>> +               prefix: str) -> None:
>> +    vis =3D QAPISchemaGenGolangVisitor(prefix)
>> +    schema.visit(vis)
>> +    vis.write(output_dir)
>> +
>> +
>> +def qapi_to_field_name_enum(name: str) -> str:
>> +    return name.title().replace("-", "")
>> +
>> +
>> +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
>> +
>> +    def __init__(self, _: str):
>> +        super().__init__()
>> +        types =3D ["enum"]
>> +        self.target =3D {name: "" for name in types}
>> +        self.schema =3D None
>> +        self.golang_package_name =3D "qapi"
>> +
>> +    def visit_begin(self, schema):
>> +        self.schema =3D schema
>> +
>> +        # Every Go file needs to reference its package name
>> +        for target in self.target:
>> +            self.target[target] =3D f"package {self.golang_package_name=
}\n"
>> +
>> +    def visit_end(self):
>> +        self.schema =3D None
>> +
>> +    def visit_object_type(self: QAPISchemaGenGolangVisitor,
>> +                          name: str,
>> +                          info: Optional[QAPISourceInfo],
>> +                          ifcond: QAPISchemaIfCond,
>> +                          features: List[QAPISchemaFeature],
>> +                          base: Optional[QAPISchemaObjectType],
>> +                          members: List[QAPISchemaObjectTypeMember],
>> +                          variants: Optional[QAPISchemaVariants]
>> +                          ) -> None:
>> +        pass
>> +
>> +    def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
>> +                             name: str,
>> +                             info: Optional[QAPISourceInfo],
>> +                             ifcond: QAPISchemaIfCond,
>> +                             features: List[QAPISchemaFeature],
>> +                             variants: QAPISchemaVariants
>> +                             ) -> None:
>> +        pass
>> +
>> +    def visit_enum_type(self: QAPISchemaGenGolangVisitor,
>> +                        name: str,
>> +                        info: Optional[QAPISourceInfo],
>> +                        ifcond: QAPISchemaIfCond,
>> +                        features: List[QAPISchemaFeature],
>> +                        members: List[QAPISchemaEnumMember],
>> +                        prefix: Optional[str]
>> +                        ) -> None:
>> +
>> +        value =3D qapi_to_field_name_enum(members[0].name)
>> +        fields =3D ""
>> +        for member in members:
>> +            value =3D qapi_to_field_name_enum(member.name)
>> +            fields +=3D f'''\t{name}{value} {name} =3D "{member.name}"\=
n'''
>> +
>> +        self.target["enum"] +=3D TEMPLATE_ENUM.format(name=3Dname, fiel=
ds=3Dfields[:-1])
>
> Here you are formatting the enums as you visit them, appending to
> the output buffer. The resulting enums appear in whatever order we
> visited them with, which is pretty arbitrary.

We visit in source order, not in arbitrary order.

> Browsing the generated Go code to understand it, I find myself
> wishing that it was emitted in alphabetical order.

If that's easier to read in generated Go, then I suspect it would also
be easier to read in the QAPI schema and in generated C.

> This could be done if we worked in two phase. In the visit phase,
> we collect the bits of data we need, and then add a format phase
> then generates the formatted output, having first sorted by enum
> name.
>
> Same thought for the other types/commands.
>
>> +
>> +    def visit_array_type(self, name, info, ifcond, element_type):
>> +        pass
>> +
>> +    def visit_command(self,
>> +                      name: str,
>> +                      info: Optional[QAPISourceInfo],
>> +                      ifcond: QAPISchemaIfCond,
>> +                      features: List[QAPISchemaFeature],
>> +                      arg_type: Optional[QAPISchemaObjectType],
>> +                      ret_type: Optional[QAPISchemaType],
>> +                      gen: bool,
>> +                      success_response: bool,
>> +                      boxed: bool,
>> +                      allow_oob: bool,
>> +                      allow_preconfig: bool,
>> +                      coroutine: bool) -> None:
>> +        pass
>> +
>> +    def visit_event(self, name, info, ifcond, features, arg_type, boxed=
):
>> +        pass
>> +
>> +    def write(self, output_dir: str) -> None:
>> +        for module_name, content in self.target.items():
>> +            go_module =3D module_name + "s.go"
>> +            go_dir =3D "go"
>> +            pathname =3D os.path.join(output_dir, go_dir, go_module)
>> +            odir =3D os.path.dirname(pathname)
>> +            os.makedirs(odir, exist_ok=3DTrue)
>> +
>> +            with open(pathname, "w", encoding=3D"ascii") as outfile:
>
> IIUC, we defacto consider the .qapi json files to be UTF-8, and thus
> in theory we could have non-ascii characters in there somewhere. I'd
> suggest we using utf8 encoding when outputting to avoid surprises.

Seconded.  QAPIGen.write() already uses encoding=3D'utf-8' for writing
generated files.

>> +                outfile.write(content)
>
>
> With regards,
> Daniel


