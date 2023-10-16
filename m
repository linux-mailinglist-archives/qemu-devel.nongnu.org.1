Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C117CAD84
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPVM-0001X9-Nh; Mon, 16 Oct 2023 11:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPVK-0001Wa-4o
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV4-0003OL-Mk
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4UGeHM+wuJlFvsAuVCpcyMS7Unx0q539CcUwF56Xqec=;
 b=fp1PagbT3WS6zEBhyNQa72WD78isnsq4ZvuYCChgBqcuSiIUKVRrWsaEJcf2L52veD6RsT
 ZGu2gDD3jed5+aZVq4B4mL7Bzx9qH1fTQhVKRDlpZORIyDDyLAL9kJawoCE6OsdTwpxVle
 yFT4fIgS0aWTWLpEA2vdJIYGeujy+FQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-3Jp_3TsrNiewVpUPY31ydw-1; Mon, 16 Oct 2023 11:27:18 -0400
X-MC-Unique: 3Jp_3TsrNiewVpUPY31ydw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1B3C81B15E
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:17 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B12B202B17E;
 Mon, 16 Oct 2023 15:27:16 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 06/11] qapi: golang: structs: Address 'null' members
Date: Mon, 16 Oct 2023 17:26:59 +0200
Message-ID: <20231016152704.221611-7-victortoso@redhat.com>
In-Reply-To: <20231016152704.221611-1-victortoso@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Explaining why this is needed needs some context, so taking the
example of StrOrNull alternate type and considering a simplified
struct that has two fields:

qapi:
 | { 'struct': 'MigrationExample',
 |   'data': { '*label': 'StrOrNull',
 |             'target': 'StrOrNull' } }

We have a optional member 'label' which can have three JSON values:
 1. A string: { "target": "a.host.com", "label": "happy" }
 2. A null  : { "target": "a.host.com", "label": null }
 3. Absent  : { "target": null}

The member 'target' is not optional, hence it can't be absent.

A Go struct that contains a optional type that can be JSON Null like
'label' in the example above, will need extra care when Marshaling and
Unmarshaling from JSON.

This patch handles this very specific case:
 - It implements the Marshaler interface for these structs to properly
   handle these values.
 - It adds the interface AbsentAlternate() and implement it for any
   Alternate that can be JSON Null

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 243 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 228 insertions(+), 15 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 73d0804d0a..6a7e37dd90 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -110,6 +110,26 @@
 """
 
 
+TEMPLATE_STRUCT_WITH_NULLABLE_MARSHAL = """
+func (s {type_name}) MarshalJSON() ([]byte, error) {{
+\tm := make(map[string]any)
+{map_members}{map_special}
+\treturn json.Marshal(&m)
+}}
+
+func (s *{type_name}) UnmarshalJSON(data []byte) error {{
+\ttmp := {struct}{{}}
+
+\tif err := json.Unmarshal(data, &tmp); err != nil {{
+\t\treturn err
+\t}}
+
+{set_members}{set_special}
+\treturn nil
+}}
+"""
+
+
 def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis = QAPISchemaGenGolangVisitor(prefix)
     schema.visit(vis)
@@ -256,21 +276,31 @@ def get_struct_field(
     self: QAPISchemaGenGolangVisitor,
     qapi_name: str,
     qapi_type_name: str,
+    within_nullable_struct: bool,
     is_optional: bool,
     is_variant: bool,
-) -> dict[str:str]:
+) -> Tuple[dict[str:str], bool]:
 
     field = qapi_to_field_name(qapi_name)
     member_type = qapi_schema_type_to_go_type(qapi_type_name)
+    is_nullable = False
 
     optional = ""
     if is_optional:
-        if member_type not in self.accept_null_types:
+        if member_type in self.accept_null_types:
+            is_nullable = True
+        else:
             optional = ",omitempty"
 
     # Use pointer to type when field is optional
     isptr = "*" if is_optional and member_type[0] not in "*[" else ""
 
+    if within_nullable_struct:
+        # Within a struct which has a field of type that can hold JSON NULL,
+        # we have to _not_ use a pointer, otherwise the Marshal methods are
+        # not called.
+        isptr = "" if member_type in self.accept_null_types else isptr
+
     fieldtag = (
         '`json:"-"`' if is_variant else f'`json:"{qapi_name}{optional}"`'
     )
@@ -279,32 +309,202 @@ def get_struct_field(
         "type": f"{isptr}{member_type}",
         "tag": f"{fieldtag}",
     }
-    return arg
+    return arg, is_nullable
+
+
+# This helper is used whithin a struct that has members that accept JSON NULL.
+def map_and_set(
+    is_nullable: bool, field: str, field_is_optional: bool, name: str
+) -> Tuple[str, str]:
+
+    mapstr = ""
+    setstr = ""
+    if is_nullable:
+        mapstr = f"""
+\tif val, absent := s.{field}.ToAnyOrAbsent(); !absent {{
+\t\tm["{name}"] = val
+\t}}
+"""
+        setstr += f"""
+\tif _, absent := (&tmp.{field}).ToAnyOrAbsent(); !absent {{
+\t\ts.{field} = &tmp.{field}
+\t}}
+"""
+    elif field_is_optional:
+        mapstr = f"""
+\tif s.{field} != nil {{
+\t\tm["{name}"] = s.{field}
+\t}}
+"""
+        setstr = f"""\ts.{field} = tmp.{field}\n"""
+    else:
+        mapstr = f"""\tm["{name}"] = s.{field}\n"""
+        setstr = f"""\ts.{field} = tmp.{field}\n"""
+
+    return mapstr, setstr
+
+
+def recursive_base_nullable(
+    self: QAPISchemaGenGolangVisitor, base: Optional[QAPISchemaObjectType]
+) -> Tuple[List[dict[str:str]], str, str, str, str]:
+    fields: List[dict[str:str]] = []
+    map_members = ""
+    set_members = ""
+    map_special = ""
+    set_special = ""
+
+    if not base:
+        return fields, map_members, set_members, map_special, set_special
+
+    if base.base is not None:
+        embed_base = self.schema.lookup_entity(base.base.name)
+        (
+            fields,
+            map_members,
+            set_members,
+            map_special,
+            set_special,
+        ) = recursive_base_nullable(self, embed_base)
+
+    for member in base.local_members:
+        field, _ = get_struct_field(
+            self, member.name, member.type.name, True, member.optional, False
+        )
+        fields.append(field)
+
+        member_type = qapi_schema_type_to_go_type(member.type.name)
+        nullable = member_type in self.accept_null_types
+        field_name = qapi_to_field_name(member.name)
+        tomap, toset = map_and_set(
+            nullable, field_name, member.optional, member.name
+        )
+        if nullable:
+            map_special += tomap
+            set_special += toset
+        else:
+            map_members += tomap
+            set_members += toset
+
+    return fields, map_members, set_members, map_special, set_special
+
+
+# Helper function. This is executed when the QAPI schema has members
+# that could accept JSON NULL (e.g: StrOrNull in QEMU"s QAPI schema).
+# This struct will need to be extended with Marshal/Unmarshal methods to
+# properly handle such atypical members.
+#
+# Only the Marshallaing methods are generated but we do need to iterate over
+# all the members to properly set/check them in those methods.
+def struct_with_nullable_generate_marshal(
+    self: QAPISchemaGenGolangVisitor,
+    name: str,
+    base: Optional[QAPISchemaObjectType],
+    members: List[QAPISchemaObjectTypeMember],
+    variants: Optional[QAPISchemaVariants],
+) -> str:
+
+    (
+        fields,
+        map_members,
+        set_members,
+        map_special,
+        set_special,
+    ) = recursive_base_nullable(self, base)
+
+    if members:
+        for member in members:
+            field, _ = get_struct_field(
+                self,
+                member.name,
+                member.type.name,
+                True,
+                member.optional,
+                False,
+            )
+            fields.append(field)
+
+            member_type = qapi_schema_type_to_go_type(member.type.name)
+            nullable = member_type in self.accept_null_types
+            tomap, toset = map_and_set(
+                nullable,
+                qapi_to_field_name(member.name),
+                member.optional,
+                member.name,
+            )
+            if nullable:
+                map_special += tomap
+                set_special += toset
+            else:
+                map_members += tomap
+                set_members += toset
+
+    if variants:
+        for variant in variants.variants:
+            if variant.type.is_implicit():
+                continue
+
+            field, _ = get_struct_field(
+                self,
+                variant.name,
+                variant.type.name,
+                True,
+                variant.optional,
+                True,
+            )
+            fields.append(field)
+
+            member_type = qapi_schema_type_to_go_type(variant.type.name)
+            nullable = member_type in self.accept_null_types
+            tomap, toset = map_and_set(
+                nullable,
+                qapi_to_field_name(variant.name),
+                variant.optional,
+                variant.name,
+            )
+            if nullable:
+                map_special += tomap
+                set_special += toset
+            else:
+                map_members += tomap
+                set_members += toset
+
+    type_name = qapi_to_go_type_name(name)
+    struct = generate_struct_type("", fields, ident=1)[:-1]
+    return TEMPLATE_STRUCT_WITH_NULLABLE_MARSHAL.format(
+        struct=struct[1:],
+        type_name=type_name,
+        map_members=map_members,
+        map_special=map_special,
+        set_members=set_members,
+        set_special=set_special,
+    )
 
 
 def recursive_base(
     self: QAPISchemaGenGolangVisitor,
     base: Optional[QAPISchemaObjectType],
     discriminator: Optional[str] = None,
-) -> List[dict[str:str]]:
+) -> Tuple[List[dict[str:str]], bool]:
     fields: List[dict[str:str]] = []
+    with_nullable = False
 
     if not base:
-        return fields
+        return fields, with_nullable
 
     if base.base is not None:
         embed_base = self.schema.lookup_entity(base.base.name)
-        fields = recursive_base(self, embed_base, discriminator)
+        fields, with_nullable = recursive_base(self, embed_base, discriminator)
 
     for member in base.local_members:
         if discriminator and member.name == discriminator:
             continue
-        field = get_struct_field(
-            self, member.name, member.type.name, member.optional, False
+        field, nullable = get_struct_field(
+            self, member.name, member.type.name, False, member.optional, False
         )
         fields.append(field)
+        with_nullable = True if nullable else with_nullable
 
-    return fields
+    return fields, with_nullable
 
 
 # Helper function that is used for most of QAPI types
@@ -319,14 +519,20 @@ def qapi_to_golang_struct(
     variants: Optional[QAPISchemaVariants],
 ) -> str:
 
-    fields = recursive_base(self, base)
+    fields, with_nullable = recursive_base(self, base)
 
     if members:
         for member in members:
-            field = get_struct_field(
-                self, member.name, member.type.name, member.optional, False
+            field, nullable = get_struct_field(
+                self,
+                member.name,
+                member.type.name,
+                False,
+                member.optional,
+                False,
             )
             fields.append(field)
+            with_nullable = True if nullable else with_nullable
 
     if variants:
         fields.append({"comment": "Variants fields"})
@@ -334,13 +540,18 @@ def qapi_to_golang_struct(
             if variant.type.is_implicit():
                 continue
 
-            field = get_struct_field(
-                self, variant.name, variant.type.name, True, True
+            field, nullable = get_struct_field(
+                self, variant.name, variant.type.name, False, True, True
             )
             fields.append(field)
+            with_nullable = True if nullable else with_nullable
 
     type_name = qapi_to_go_type_name(name)
     content = generate_struct_type(type_name, fields)
+    if with_nullable:
+        content += struct_with_nullable_generate_marshal(
+            self, name, base, members, variants
+        )
     return content
 
 
@@ -465,7 +676,9 @@ def visit_begin(self, schema: QAPISchema) -> None:
         for target in self.target:
             self.target[target] = f"package {self.golang_package_name}\n"
 
-            if target == "helper":
+            if target == "struct":
+                imports = '\nimport "encoding/json"\n'
+            elif target == "helper":
                 imports = """\nimport (
 \t"encoding/json"
 \t"strings"
-- 
2.41.0


