Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9632F7B02E1
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSgF-0002R3-9R; Wed, 27 Sep 2023 07:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSg0-0002Ox-0P
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSfy-0001eQ-62
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695813953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdMKxD6s/M2setfWmq7XekuO/g+jsw3BqbxY6Sx7EuM=;
 b=hLi5kFz3iPK8kC/X39EvxT9K5hsoiUUbpQRoM9WL0WYgTA7nG5QnSN82btfXd+VXIogSMi
 SS5il0EWn4pqZTlZsOyGYM08sQ8QFLi0Xr65AHNTsiyeLj7yM/KJY0NEFLNBmUM3aGfxOR
 ZwuFsiEF0fIOPKSajXV4jszFBVA2ZjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-4l1YD71JPT2MXjbBSNKN3A-1; Wed, 27 Sep 2023 07:25:51 -0400
X-MC-Unique: 4l1YD71JPT2MXjbBSNKN3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2330E85A5BA
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:25:51 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12B851005B96;
 Wed, 27 Sep 2023 11:25:49 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v1 3/9] qapi: golang: Generate qapi's struct types in Go
Date: Wed, 27 Sep 2023 13:25:38 +0200
Message-ID: <20230927112544.85011-4-victortoso@redhat.com>
In-Reply-To: <20230927112544.85011-1-victortoso@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

This patch handles QAPI struct types and generates the equivalent
types in Go. The following patch adds extra logic when a member of the
struct has a Type that can take JSON Null value (e.g: StrOrNull in
QEMU)

The highlights of this implementation are:

1. Generating an Go struct that requires a @base type, the @base type
   fields are copied over to the Go struct. The advantage of this
   approach is to not have embed structs in any of the QAPI types.
   Note that embedding a @base type is recursive, that is, if the
   @base type has a @base, all of those fields will be copied over.

2. About the Go struct's fields:

   i) They can be either by Value or Reference.

  ii) Every field that is marked as optional in the QAPI specification
      are translated to Reference fields in its Go structure. This
      design decision is the most straightforward way to check if a
      given field was set or not. Exception only for types that can
      take JSON Null value.

 iii) Mandatory fields are always by Value with the exception of QAPI
      arrays, which are handled by Reference (to a block of memory) by
      Go.

  iv) All the fields are named with Uppercase due Golang's export
      convention.

   v) In order to avoid any kind of issues when encoding or decoding,
      to or from JSON, we mark all fields with its @name and, when it is
      optional, member, with @omitempty

Example:

qapi:
 | { 'struct': 'BlockdevCreateOptionsFile',
 |   'data': { 'filename': 'str',
 |             'size': 'size',
 |             '*preallocation': 'PreallocMode',
 |             '*nocow': 'bool',
 |             '*extent-size-hint': 'size'} }

go:
| type BlockdevCreateOptionsFile struct {
|     Filename       string        `json:"filename"`
|     Size           uint64        `json:"size"`
|     Preallocation  *PreallocMode `json:"preallocation,omitempty"`
|     Nocow          *bool         `json:"nocow,omitempty"`
|     ExtentSizeHint *uint64       `json:"extent-size-hint,omitempty"`
| }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 138 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 43dbdde14c..1b19e4b232 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -117,12 +117,35 @@ def gen_golang(schema: QAPISchema,
     schema.visit(vis)
     vis.write(output_dir)
 
+def qapi_name_is_base(name: str) -> bool:
+    return qapi_name_is_object(name) and name.endswith("-base")
+
+def qapi_name_is_object(name: str) -> bool:
+    return name.startswith("q_obj_")
+
 def qapi_to_field_name(name: str) -> str:
     return name.title().replace("_", "").replace("-", "")
 
 def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
+def qapi_to_go_type_name(name: str) -> str:
+    if qapi_name_is_object(name):
+        name = name[6:]
+
+    # We want to keep CamelCase for Golang types. We want to avoid removing
+    # already set CameCase names while fixing uppercase ones, eg:
+    # 1) q_obj_SocketAddress_base -> SocketAddressBase
+    # 2) q_obj_WATCHDOG-arg -> WatchdogArg
+    words = list(name.replace("_", "-").split("-"))
+    name = words[0]
+    if name.islower() or name.isupper():
+        name = name.title()
+
+    name += ''.join(word.title() for word in words[1:])
+
+    return name
+
 def qapi_schema_type_to_go_type(qapitype: str) -> str:
     schema_types_to_go = {
             'str': 'string', 'null': 'nil', 'bool': 'bool', 'number':
@@ -156,6 +179,82 @@ def generate_struct_type(type_name, args="") -> str:
     return f'''{with_type} struct {{{args}}}
 '''
 
+def get_struct_field(self: QAPISchemaGenGolangVisitor,
+                     qapi_name: str,
+                     qapi_type_name: str,
+                     is_optional: bool,
+                     is_variant: bool) -> str:
+
+    field = qapi_to_field_name(qapi_name)
+    member_type = qapi_schema_type_to_go_type(qapi_type_name)
+
+    optional = ""
+    if is_optional:
+        if member_type not in self.accept_null_types:
+            optional = ",omitempty"
+
+    # Use pointer to type when field is optional
+    isptr = "*" if is_optional and member_type[0] not in "*[" else ""
+
+    fieldtag = '`json:"-"`' if is_variant else f'`json:"{qapi_name}{optional}"`'
+    return f"\t{field} {isptr}{member_type}{fieldtag}\n"
+
+def recursive_base(self: QAPISchemaGenGolangVisitor,
+                   base: Optional[QAPISchemaObjectType]) -> str:
+    fields = ""
+
+    if not base:
+        return fields
+
+    if base.base is not None:
+        embed_base = self.schema.lookup_entity(base.base.name)
+        fields = recursive_base(self, embed_base)
+
+    for member in base.local_members:
+        if base.variants and base.variants.tag_member.name == member.name:
+            fields += '''// Discriminator\n'''
+
+        field = get_struct_field(self, member.name, member.type.name, member.optional, False)
+        fields += field
+
+    if len(fields) > 0:
+        fields += "\n"
+
+    return fields
+
+# Helper function that is used for most of QAPI types
+def qapi_to_golang_struct(self: QAPISchemaGenGolangVisitor,
+                          name: str,
+                          _: Optional[QAPISourceInfo],
+                          __: QAPISchemaIfCond,
+                          ___: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          variants: Optional[QAPISchemaVariants]) -> str:
+
+
+    fields = recursive_base(self, base)
+
+    if members:
+        for member in members:
+            field = get_struct_field(self, member.name, member.type.name, member.optional, False)
+            fields += field
+
+        fields += "\n"
+
+    if variants:
+        fields += "\t// Variants fields\n"
+        for variant in variants.variants:
+            if variant.type.is_implicit():
+                continue
+
+            field = get_struct_field(self, variant.name, variant.type.name, True, True)
+            fields += field
+
+    type_name = qapi_to_go_type_name(name)
+    content = generate_struct_type(type_name, fields)
+    return content
+
 def generate_template_alternate(self: QAPISchemaGenGolangVisitor,
                                 name: str,
                                 variants: Optional[QAPISchemaVariants]) -> str:
@@ -218,7 +317,7 @@ class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
 
     def __init__(self, _: str):
         super().__init__()
-        types = ["alternate", "enum", "helper"]
+        types = ["alternate", "enum", "helper", "struct"]
         self.target = {name: "" for name in types}
         self.objects_seen = {}
         self.schema = None
@@ -258,7 +357,42 @@ def visit_object_type(self: QAPISchemaGenGolangVisitor,
                           members: List[QAPISchemaObjectTypeMember],
                           variants: Optional[QAPISchemaVariants]
                           ) -> None:
-        pass
+        # Do not handle anything besides struct.
+        if (name == self.schema.the_empty_object_type.name or
+                not isinstance(name, str) or
+                info.defn_meta not in ["struct"]):
+            return
+
+        # Base structs are embed
+        if qapi_name_is_base(name):
+            return
+
+        # Safety checks.
+        assert name not in self.objects_seen
+        self.objects_seen[name] = True
+
+        # visit all inner objects as well, they are not going to be
+        # called by python's generator.
+        if variants:
+            for var in variants.variants:
+                assert isinstance(var.type, QAPISchemaObjectType)
+                self.visit_object_type(self,
+                                       var.type.name,
+                                       var.type.info,
+                                       var.type.ifcond,
+                                       var.type.base,
+                                       var.type.local_members,
+                                       var.type.variants)
+
+        # Save generated Go code to be written later
+        self.target[info.defn_meta] += qapi_to_golang_struct(self,
+                                                             name,
+                                                             info,
+                                                             ifcond,
+                                                             features,
+                                                             base,
+                                                             members,
+                                                             variants)
 
     def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
                              name: str,
-- 
2.41.0


