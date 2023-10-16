Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6037CAD80
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPVB-0001RA-MV; Mon, 16 Oct 2023 11:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPVA-0001QQ-73
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV4-0003OD-Eq
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VN2D5VIv43LVpcgbIT61yTuwgmtO1gFfl/efbQbmf6I=;
 b=b18zorm+ese9TpyiuWlnyoUjT2+pI6Qc8Vg7RzRah0x1p8bsUNwEvpo1N7xXXLZKzbtV+K
 +mIzNjmSuJfxqhQWne12OsVxFTw+cbdfsa9r0FX4PC3OYEHhPI99yBGEpqc4hZJnPFuE7S
 RchkagpFgUYUq4801JiDTRopQYacUFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-Ds_0tkevMwqRtiUCSsvy9g-1; Mon, 16 Oct 2023 11:27:20 -0400
X-MC-Unique: Ds_0tkevMwqRtiUCSsvy9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDEE8185A7B2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:19 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 613C220296DB;
 Mon, 16 Oct 2023 15:27:18 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 07/11] qapi: golang: Generate qapi's union types in Go
Date: Mon, 16 Oct 2023 17:27:00 +0200
Message-ID: <20231016152704.221611-8-victortoso@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This patch handles QAPI union types and generates the equivalent data
structures and methods in Go to handle it.

The QAPI union type has two types of fields: The @base and the
@Variants members. The @base fields can be considered common members
for the union while only one field maximum is set for the @Variants.

In the QAPI specification, it defines a @discriminator field, which is
an Enum type. The purpose of the  @discriminator is to identify which
@variant type is being used.

For the @discriminator's enum that are not handled by the QAPI Union,
we add in the Go struct a separate block as "Unbranched enum fields".
The rationale for this extra block is to allow the user to pass that
enum value under the discriminator, without extra payload.

The union types implement the Marshaler and Unmarshaler interfaces to
seamless decode from JSON objects to Golang structs and vice versa.

qapi:
 | { 'union': 'SetPasswordOptions',
 |   'base': { 'protocol': 'DisplayProtocol',
 |             'password': 'str',
 |             '*connected': 'SetPasswordAction' },
 |   'discriminator': 'protocol',
 |   'data': { 'vnc': 'SetPasswordOptionsVnc' } }

go:
 | type SetPasswordOptions struct {
 | 	Password  string             `json:"password"`
 | 	Connected *SetPasswordAction `json:"connected,omitempty"`
 | 	// Variants fields
 | 	Vnc *SetPasswordOptionsVnc `json:"-"`
 | 	// Unbranched enum fields
 | 	Spice bool `json:"-"`
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 228 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 217 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 6a7e37dd90..bc6206797a 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -51,6 +51,17 @@
 \t}
 \treturn nil
 }
+
+// This helper is used to move struct's fields into a map.
+// This function is useful to merge JSON objects.
+func unwrapToMap(m map[string]any, data any) error {
+\tif bytes, err := json.Marshal(&data); err != nil {
+\t\treturn fmt.Errorf("unwrapToMap: %s", err)
+\t} else if err := json.Unmarshal(bytes, &m); err != nil {
+\t\treturn fmt.Errorf("unwrapToMap: %s, data=%s", err, string(bytes))
+\t}
+\treturn nil
+}
 """
 
 TEMPLATE_ALTERNATE = """
@@ -130,6 +141,81 @@
 """
 
 
+TEMPLATE_UNION_CHECK_VARIANT_FIELD = """
+\tif s.{field} != nil && err == nil {{
+\t\tif len(bytes) != 0 {{
+\t\t\terr = errors.New(`multiple variant fields set`)
+\t\t}} else if err = unwrapToMap(m, s.{field}); err == nil {{
+\t\t\tm["{discriminator}"] = {go_enum_value}
+\t\t\tbytes, err = json.Marshal(m)
+\t\t}}
+\t}}
+"""
+
+TEMPLATE_UNION_CHECK_UNBRANCHED_FIELD = """
+\tif s.{field} && err == nil {{
+\t\tif len(bytes) != 0 {{
+\t\t\terr = errors.New(`multiple variant fields set`)
+\t\t}} else {{
+\t\t\tm["{discriminator}"] = {go_enum_value}
+\t\t\tbytes, err = json.Marshal(m)
+\t\t}}
+\t}}
+"""
+
+TEMPLATE_UNION_DRIVER_VARIANT_CASE = """
+\tcase {go_enum_value}:
+\t\ts.{field} = new({member_type})
+\t\tif err := json.Unmarshal(data, s.{field}); err != nil {{
+\t\t\ts.{field} = nil
+\t\t\treturn err
+\t\t}}"""
+
+TEMPLATE_UNION_DRIVER_UNBRANCHED_CASE = """
+\tcase {go_enum_value}:
+\t\ts.{field} = true
+"""
+
+TEMPLATE_UNION_METHODS = """
+func (s {type_name}) MarshalJSON() ([]byte, error) {{
+\tvar bytes []byte
+\tvar err error
+\tm := make(map[string]any)
+\t{{
+\t\ttype Alias {type_name}
+\t\tv := Alias(s)
+\t\tunwrapToMap(m, &v)
+\t}}
+{check_fields}
+\tif err != nil {{
+\t\treturn nil, fmt.Errorf("marshal {type_name} due:'%s' struct='%+v'", err, s)
+\t}} else if len(bytes) == 0 {{
+\t\treturn nil, fmt.Errorf("marshal {type_name} unsupported, struct='%+v'", s)
+\t}}
+\treturn bytes, nil
+}}
+
+func (s *{type_name}) UnmarshalJSON(data []byte) error {{
+{base_type_def}
+\ttmp := struct {{
+\t\t{base_type_name}
+\t}}{{}}
+
+\tif err := json.Unmarshal(data, &tmp); err != nil {{
+\t\treturn err
+\t}}
+{base_type_assign_unmarshal}
+\tswitch tmp.{discriminator} {{
+{driver_cases}
+\tdefault:
+\t\treturn fmt.Errorf("unmarshal {type_name} received unrecognized value '%s'",
+\t\t\ttmp.{discriminator})
+\t}}
+\treturn nil
+}}
+"""
+
+
 def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis = QAPISchemaGenGolangVisitor(prefix)
     schema.visit(vis)
@@ -511,15 +597,17 @@ def recursive_base(
 def qapi_to_golang_struct(
     self: QAPISchemaGenGolangVisitor,
     name: str,
-    _: Optional[QAPISourceInfo],
+    info: Optional[QAPISourceInfo],
     __: QAPISchemaIfCond,
     ___: List[QAPISchemaFeature],
     base: Optional[QAPISchemaObjectType],
     members: List[QAPISchemaObjectTypeMember],
     variants: Optional[QAPISchemaVariants],
+    ident: int = 0,
 ) -> str:
 
-    fields, with_nullable = recursive_base(self, base)
+    discriminator = None if not variants else variants.tag_member.name
+    fields, with_nullable = recursive_base(self, base, discriminator)
 
     if members:
         for member in members:
@@ -534,20 +622,37 @@ def qapi_to_golang_struct(
             fields.append(field)
             with_nullable = True if nullable else with_nullable
 
+    exists = {}
     if variants:
         fields.append({"comment": "Variants fields"})
         for variant in variants.variants:
             if variant.type.is_implicit():
                 continue
 
+            exists[variant.name] = True
             field, nullable = get_struct_field(
                 self, variant.name, variant.type.name, False, True, True
             )
             fields.append(field)
             with_nullable = True if nullable else with_nullable
 
+    if info.defn_meta == "union" and variants:
+        enum_name = variants.tag_member.type.name
+        enum_obj = self.schema.lookup_entity(enum_name)
+        if len(exists) != len(enum_obj.members):
+            fields.append({"comment": "Unbranched enum fields"})
+            for member in enum_obj.members:
+                if member.name in exists:
+                    continue
+
+                field, nullable = get_struct_field(
+                    self, member.name, "bool", False, False, True
+                )
+                fields.append(field)
+                with_nullable = True if nullable else with_nullable
+
     type_name = qapi_to_go_type_name(name)
-    content = generate_struct_type(type_name, fields)
+    content = generate_struct_type(type_name, fields, ident)
     if with_nullable:
         content += struct_with_nullable_generate_marshal(
             self, name, base, members, variants
@@ -555,6 +660,96 @@ def qapi_to_golang_struct(
     return content
 
 
+def qapi_to_golang_methods_union(
+    self: QAPISchemaGenGolangVisitor,
+    name: str,
+    base: Optional[QAPISchemaObjectType],
+    variants: Optional[QAPISchemaVariants],
+) -> str:
+
+    type_name = qapi_to_go_type_name(name)
+
+    assert base
+    base_type_assign_unmarshal = ""
+    base_type_name = qapi_to_go_type_name(base.name)
+    base_type_def = qapi_to_golang_struct(
+        self,
+        base.name,
+        base.info,
+        base.ifcond,
+        base.features,
+        base.base,
+        base.members,
+        base.variants,
+        ident=1,
+    )
+
+    discriminator = qapi_to_field_name(variants.tag_member.name)
+    for member in base.local_members:
+        field = qapi_to_field_name(member.name)
+        if field == discriminator:
+            continue
+        base_type_assign_unmarshal += f"""
+\ts.{field} = tmp.{field}"""
+
+    driver_cases = ""
+    check_fields = ""
+    exists = {}
+    enum_name = variants.tag_member.type.name
+    if variants:
+        for var in variants.variants:
+            if var.type.is_implicit():
+                continue
+
+            field = qapi_to_field_name(var.name)
+            enum_value = qapi_to_field_name_enum(var.name)
+            member_type = qapi_schema_type_to_go_type(var.type.name)
+            go_enum_value = f"""{enum_name}{enum_value}"""
+            exists[go_enum_value] = True
+
+            check_fields += TEMPLATE_UNION_CHECK_VARIANT_FIELD.format(
+                field=field,
+                discriminator=variants.tag_member.name,
+                go_enum_value=go_enum_value,
+            )
+            driver_cases += TEMPLATE_UNION_DRIVER_VARIANT_CASE.format(
+                go_enum_value=go_enum_value,
+                field=field,
+                member_type=member_type,
+            )
+
+    enum_obj = self.schema.lookup_entity(enum_name)
+    if len(exists) != len(enum_obj.members):
+        for member in enum_obj.members:
+            value = qapi_to_field_name_enum(member.name)
+            go_enum_value = f"""{enum_name}{value}"""
+
+            if go_enum_value in exists:
+                continue
+
+            field = qapi_to_field_name(member.name)
+
+            check_fields += TEMPLATE_UNION_CHECK_UNBRANCHED_FIELD.format(
+                field=field,
+                discriminator=variants.tag_member.name,
+                go_enum_value=go_enum_value,
+            )
+            driver_cases += TEMPLATE_UNION_DRIVER_UNBRANCHED_CASE.format(
+                go_enum_value=go_enum_value,
+                field=field,
+            )
+
+    return TEMPLATE_UNION_METHODS.format(
+        type_name=type_name,
+        check_fields=check_fields[1:],
+        base_type_def=base_type_def[1:],
+        base_type_name=base_type_name,
+        base_type_assign_unmarshal=base_type_assign_unmarshal,
+        discriminator=discriminator,
+        driver_cases=driver_cases[1:],
+    )
+
+
 def generate_template_alternate(
     self: QAPISchemaGenGolangVisitor,
     name: str,
@@ -648,6 +843,7 @@ def __init__(self, _: str):
             "enum",
             "helper",
             "struct",
+            "union",
         )
         self.target = dict.fromkeys(types, "")
         self.schema: QAPISchema
@@ -655,6 +851,7 @@ def __init__(self, _: str):
         self.enums: dict[str, str] = {}
         self.alternates: dict[str, str] = {}
         self.structs: dict[str, str] = {}
+        self.unions: dict[str, str] = {}
         self.accept_null_types = []
 
     def visit_begin(self, schema: QAPISchema) -> None:
@@ -681,6 +878,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
             elif target == "helper":
                 imports = """\nimport (
 \t"encoding/json"
+\t"fmt"
 \t"strings"
 )
 """
@@ -702,6 +900,7 @@ def visit_end(self) -> None:
         self.target["enum"] += generate_content_from_dict(self.enums)
         self.target["alternate"] += generate_content_from_dict(self.alternates)
         self.target["struct"] += generate_content_from_dict(self.structs)
+        self.target["union"] += generate_content_from_dict(self.unions)
 
     def visit_object_type(
         self,
@@ -713,11 +912,11 @@ def visit_object_type(
         members: List[QAPISchemaObjectTypeMember],
         variants: Optional[QAPISchemaVariants],
     ) -> None:
-        # Do not handle anything besides struct.
+        # Do not handle anything besides struct and unions.
         if (
             name == self.schema.the_empty_object_type.name
             or not isinstance(name, str)
-            or info.defn_meta not in ["struct"]
+            or info.defn_meta not in ["struct", "union"]
         ):
             return
 
@@ -725,9 +924,6 @@ def visit_object_type(
         if qapi_name_is_base(name):
             return
 
-        # Safety checks.
-        assert name not in self.structs
-
         # visit all inner objects as well, they are not going to be
         # called by python's generator.
         if variants:
@@ -744,9 +940,19 @@ def visit_object_type(
                 )
 
         # Save generated Go code to be written later
-        self.structs[name] = qapi_to_golang_struct(
-            self, name, info, ifcond, features, base, members, variants
-        )
+        if info.defn_meta == "struct":
+            assert name not in self.structs
+            self.structs[name] = qapi_to_golang_struct(
+                self, name, info, ifcond, features, base, members, variants
+            )
+        else:
+            assert name not in self.unions
+            self.unions[name] = qapi_to_golang_struct(
+                self, name, info, ifcond, features, base, members, variants
+            )
+            self.unions[name] += qapi_to_golang_methods_union(
+                self, name, base, variants
+            )
 
     def visit_alternate_type(
         self,
-- 
2.41.0


