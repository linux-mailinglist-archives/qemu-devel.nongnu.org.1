Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BB7B1FAD
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:35:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qls6Q-0002S0-E3; Thu, 28 Sep 2023 10:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qls6O-0002RT-2C
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qls6M-0001oI-7X
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695911689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UL0gSfDs4tCUojKVF+19Z9rYTEOzKwpCKGL5BSKlnqM=;
 b=asKUlljbet/FxQIphmrc0jr8I+0EeW2gsRpKUcVMr8PMh8RicUjEuu7UIXTKQQniRrfjxk
 SscyN9FqWyVpRZ8PuQ+lxTV4HfOjlcPVyE3rIg1gBpi9n4DOD0mRKTToDNxt65TvbUm1XT
 ADsHelrmnOI8/P7e9sS1OA57pdT462c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-qphPDBtRNwme2lKNIp6XCw-1; Thu, 28 Sep 2023 10:34:47 -0400
X-MC-Unique: qphPDBtRNwme2lKNIp6XCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78F2381DA85
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:34:47 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E13414171CA;
 Thu, 28 Sep 2023 14:34:46 +0000 (UTC)
Date: Thu, 28 Sep 2023 15:34:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Victor Toso <victortoso@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
Message-ID: <ZRWPBJKASLmmK/f/@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
 <ZRWFCPhUfXMCrml1@redhat.com> <87cyy2tm48.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cyy2tm48.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Sep 28, 2023 at 04:20:55PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Sep 27, 2023 at 01:25:36PM +0200, Victor Toso wrote:
> >> This patch handles QAPI enum types and generates its equivalent in Go.
> >> 
> >> Basically, Enums are being handled as strings in Golang.
> >> 
> >> 1. For each QAPI enum, we will define a string type in Go to be the
> >>    assigned type of this specific enum.
> >> 
> >> 2. Naming: CamelCase will be used in any identifier that we want to
> >>    export [0], which is everything.
> >> 
> >> [0] https://go.dev/ref/spec#Exported_identifiers
> >> 
> >> Example:
> >> 
> >> qapi:
> >>   | { 'enum': 'DisplayProtocol',
> >>   |   'data': [ 'vnc', 'spice' ] }
> >> 
> >> go:
> >>   | type DisplayProtocol string
> >>   |
> >>   | const (
> >>   |     DisplayProtocolVnc   DisplayProtocol = "vnc"
> >>   |     DisplayProtocolSpice DisplayProtocol = "spice"
> >>   | )
> >> 
> >> Signed-off-by: Victor Toso <victortoso@redhat.com>
> >> ---
> >>  scripts/qapi/golang.py | 140 +++++++++++++++++++++++++++++++++++++++++
> >>  scripts/qapi/main.py   |   2 +
> >>  2 files changed, 142 insertions(+)
> >>  create mode 100644 scripts/qapi/golang.py
> >> 
> >> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> >> new file mode 100644
> >> index 0000000000..87081cdd05
> >> --- /dev/null
> >> +++ b/scripts/qapi/golang.py
> >> @@ -0,0 +1,140 @@
> >> +"""
> >> +Golang QAPI generator
> >> +"""
> >> +# Copyright (c) 2023 Red Hat Inc.
> >> +#
> >> +# Authors:
> >> +#  Victor Toso <victortoso@redhat.com>
> >> +#
> >> +# This work is licensed under the terms of the GNU GPL, version 2.
> >> +# See the COPYING file in the top-level directory.
> >> +
> >> +# due QAPISchemaVisitor interface
> >> +# pylint: disable=too-many-arguments
> >> +
> >> +# Just for type hint on self
> >> +from __future__ import annotations
> >> +
> >> +import os
> >> +from typing import List, Optional
> >> +
> >> +from .schema import (
> >> +    QAPISchema,
> >> +    QAPISchemaType,
> >> +    QAPISchemaVisitor,
> >> +    QAPISchemaEnumMember,
> >> +    QAPISchemaFeature,
> >> +    QAPISchemaIfCond,
> >> +    QAPISchemaObjectType,
> >> +    QAPISchemaObjectTypeMember,
> >> +    QAPISchemaVariants,
> >> +)
> >> +from .source import QAPISourceInfo
> >> +
> >> +TEMPLATE_ENUM = '''
> >> +type {name} string
> >> +const (
> >> +{fields}
> >> +)
> >> +'''
> >> +
> >> +
> >> +def gen_golang(schema: QAPISchema,
> >> +               output_dir: str,
> >> +               prefix: str) -> None:
> >> +    vis = QAPISchemaGenGolangVisitor(prefix)
> >> +    schema.visit(vis)
> >> +    vis.write(output_dir)
> >> +
> >> +
> >> +def qapi_to_field_name_enum(name: str) -> str:
> >> +    return name.title().replace("-", "")
> >> +
> >> +
> >> +class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
> >> +
> >> +    def __init__(self, _: str):
> >> +        super().__init__()
> >> +        types = ["enum"]
> >> +        self.target = {name: "" for name in types}
> >> +        self.schema = None
> >> +        self.golang_package_name = "qapi"
> >> +
> >> +    def visit_begin(self, schema):
> >> +        self.schema = schema
> >> +
> >> +        # Every Go file needs to reference its package name
> >> +        for target in self.target:
> >> +            self.target[target] = f"package {self.golang_package_name}\n"
> >> +
> >> +    def visit_end(self):
> >> +        self.schema = None
> >> +
> >> +    def visit_object_type(self: QAPISchemaGenGolangVisitor,
> >> +                          name: str,
> >> +                          info: Optional[QAPISourceInfo],
> >> +                          ifcond: QAPISchemaIfCond,
> >> +                          features: List[QAPISchemaFeature],
> >> +                          base: Optional[QAPISchemaObjectType],
> >> +                          members: List[QAPISchemaObjectTypeMember],
> >> +                          variants: Optional[QAPISchemaVariants]
> >> +                          ) -> None:
> >> +        pass
> >> +
> >> +    def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
> >> +                             name: str,
> >> +                             info: Optional[QAPISourceInfo],
> >> +                             ifcond: QAPISchemaIfCond,
> >> +                             features: List[QAPISchemaFeature],
> >> +                             variants: QAPISchemaVariants
> >> +                             ) -> None:
> >> +        pass
> >> +
> >> +    def visit_enum_type(self: QAPISchemaGenGolangVisitor,
> >> +                        name: str,
> >> +                        info: Optional[QAPISourceInfo],
> >> +                        ifcond: QAPISchemaIfCond,
> >> +                        features: List[QAPISchemaFeature],
> >> +                        members: List[QAPISchemaEnumMember],
> >> +                        prefix: Optional[str]
> >> +                        ) -> None:
> >> +
> >> +        value = qapi_to_field_name_enum(members[0].name)
> >> +        fields = ""
> >> +        for member in members:
> >> +            value = qapi_to_field_name_enum(member.name)
> >> +            fields += f'''\t{name}{value} {name} = "{member.name}"\n'''
> >> +
> >> +        self.target["enum"] += TEMPLATE_ENUM.format(name=name, fields=fields[:-1])
> >
> > Here you are formatting the enums as you visit them, appending to
> > the output buffer. The resulting enums appear in whatever order we
> > visited them with, which is pretty arbitrary.
> 
> We visit in source order, not in arbitrary order.

I meant arbitrary in the sense that us developers just add new
QAPI types pretty much anywhere we feel like it in the .qapi
files.

> 
> > Browsing the generated Go code to understand it, I find myself
> > wishing that it was emitted in alphabetical order.
> 
> If that's easier to read in generated Go, then I suspect it would also
> be easier to read in the QAPI schema and in generated C.

Yes, although C has some ordering constraints on things being
declared, so it would be a bit harder to do this in C.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


