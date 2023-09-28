Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3B7B1EFF
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:53:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrRG-0004Rl-7E; Thu, 28 Sep 2023 09:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlrRC-0004QB-6Z
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlrR9-0007Fx-Uy
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695909134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/agUNnWBRO6Wx3U76RuSf3fWsCFqPU3OGAWap/TnvJA=;
 b=gSgsEyZIEBbWGO+11EiMg/Jng8uLLbhlY/9VLvT0nhV1iuQVf/HltmfBDm1bdxggZd4BQs
 fMcCbt6BxgD6ccGo2Tuh+yO7ejcCORjH4WGd91OCkLX46P7Prk2G0v4stFb7+PI+y7YmrY
 8spE5U5G7lhx0+8kqT/DtH7rvYTgSKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-TRBECjStOXy6D-aFr_8piA-1; Thu, 28 Sep 2023 09:52:13 -0400
X-MC-Unique: TRBECjStOXy6D-aFr_8piA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 941A8101A585
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 13:52:12 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82BD2140273E;
 Thu, 28 Sep 2023 13:52:11 +0000 (UTC)
Date: Thu, 28 Sep 2023 14:52:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
Message-ID: <ZRWFCPhUfXMCrml1@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-2-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927112544.85011-2-victortoso@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 01:25:36PM +0200, Victor Toso wrote:
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
>   |     DisplayProtocolVnc   DisplayProtocol = "vnc"
>   |     DisplayProtocolSpice DisplayProtocol = "spice"
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
> +# pylint: disable=too-many-arguments
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
> +TEMPLATE_ENUM = '''
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
> +    vis = QAPISchemaGenGolangVisitor(prefix)
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
> +        types = ["enum"]
> +        self.target = {name: "" for name in types}
> +        self.schema = None
> +        self.golang_package_name = "qapi"
> +
> +    def visit_begin(self, schema):
> +        self.schema = schema
> +
> +        # Every Go file needs to reference its package name
> +        for target in self.target:
> +            self.target[target] = f"package {self.golang_package_name}\n"
> +
> +    def visit_end(self):
> +        self.schema = None
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
> +        value = qapi_to_field_name_enum(members[0].name)
> +        fields = ""
> +        for member in members:
> +            value = qapi_to_field_name_enum(member.name)
> +            fields += f'''\t{name}{value} {name} = "{member.name}"\n'''
> +
> +        self.target["enum"] += TEMPLATE_ENUM.format(name=name, fields=fields[:-1])

Here you are formatting the enums as you visit them, appending to
the output buffer. The resulting enums appear in whatever order we
visited them with, which is pretty arbitrary.

Browsing the generated Go code to understand it, I find myself
wishing that it was emitted in alphabetical order.

This could be done if we worked in two phase. In the visit phase,
we collect the bits of data we need, and then add a format phase
then generates the formatted output, having first sorted by enum
name.

Same thought for the other types/commands.

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
> +    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
> +        pass
> +
> +    def write(self, output_dir: str) -> None:
> +        for module_name, content in self.target.items():
> +            go_module = module_name + "s.go"
> +            go_dir = "go"
> +            pathname = os.path.join(output_dir, go_dir, go_module)
> +            odir = os.path.dirname(pathname)
> +            os.makedirs(odir, exist_ok=True)
> +
> +            with open(pathname, "w", encoding="ascii") as outfile:

IIUC, we defacto consider the .qapi json files to be UTF-8, and thus
in theory we could have non-ascii characters in there somewhere. I'd
suggest we using utf8 encoding when outputting to avoid surprises.

> +                outfile.write(content)


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


