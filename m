Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA27CAD7B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPV2-0001Op-Me; Mon, 16 Oct 2023 11:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV1-0001Og-5d
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPUz-0003NN-23
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHlXgI+VVMp+F61yTuiBiQrJDMVgO3JvD1AGmcMEc1k=;
 b=M+q5odQRhP5hbNNKsS32E3TDnlKnfcP5Ah1ng6DtwSac4ZAf3ItOCnkJCLOhHjy5HKV+/8
 08V5AMa1za1Zo04xCU4SBBBwHX+3wAG6/Eqas0Tmlfen6queI2jfqm3FAn/WeMckFKUQ3/
 wzeEgIwS4fvkQUHK1k9Cqvr0pkkW9tM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-P0ARcD-UMlGA1C6q4yY2Jg-1; Mon, 16 Oct 2023 11:27:14 -0400
X-MC-Unique: P0ARcD-UMlGA1C6q4yY2Jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50EA429ABA24
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:14 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC2442022780;
 Mon, 16 Oct 2023 15:27:12 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 04/11] qapi: golang: Generate qapi's alternate types in Go
Date: Mon, 16 Oct 2023 17:26:57 +0200
Message-ID: <20231016152704.221611-5-victortoso@redhat.com>
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

This patch handles QAPI alternate types and generates data structures
in Go that handles it.

Alternate types are similar to Union but without a discriminator that
can be used to identify the underlying value on the wire. It is needed
to infer it. In Go, most of the types [*] are mapped as optional
fields and Marshal and Unmarshal methods will be handling the data
checks.

Example:

qapi:
  | { 'alternate': 'BlockdevRef',
  |   'data': { 'definition': 'BlockdevOptions',
  |             'reference': 'str' } }

go:
  | type BlockdevRef struct {
  |         Definition *BlockdevOptions
  |         Reference  *string
  | }

usage:
  | input := `{"driver":"qcow2","data-file":"/some/place/my-image"}`
  | k := BlockdevRef{}
  | err := json.Unmarshal([]byte(input), &k)
  | if err != nil {
  |     panic(err)
  | }
  | // *k.Definition.Qcow2.DataFile.Reference == "/some/place/my-image"

[*] The exception for optional fields as default is to Types that can
accept JSON Null as a value. For this case, we translate NULL to a
member type called IsNull, which is boolean in Go.  This will be
explained better in the documentation patch of this series but the
main rationale is around Marshaling to and from JSON and Go data
structures.

Example:

qapi:
 | { 'alternate': 'StrOrNull',
 |   'data': { 's': 'str',
 |             'n': 'null' } }

go:
 | type StrOrNull struct {
 |     S      *string
 |     IsNull bool
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 301 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 298 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index dc12be7b03..3f6692df4b 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -13,10 +13,11 @@
 from __future__ import annotations
 
 import os
-from typing import List, Optional
+from typing import List, Optional, Tuple
 
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternateType,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
     QAPISchemaIfCond,
@@ -37,6 +38,77 @@
 )
 """
 
+TEMPLATE_HELPER = """
+// Creates a decoder that errors on unknown Fields
+// Returns nil if successfully decoded @from payload to @into type
+// Returns error if failed to decode @from payload to @into type
+func StrictDecode(into interface{}, from []byte) error {
+\tdec := json.NewDecoder(strings.NewReader(string(from)))
+\tdec.DisallowUnknownFields()
+
+\tif err := dec.Decode(into); err != nil {
+\t\treturn err
+\t}
+\treturn nil
+}
+"""
+
+TEMPLATE_ALTERNATE = """
+// Only implemented on Alternate types that can take JSON NULL as value.
+//
+// This is a helper for the marshalling code. It should return true only when
+// the Alternate is empty (no members are set), otherwise it returns false and
+// the member set to be Marshalled.
+type AbsentAlternate interface {
+\tToAnyOrAbsent() (any, bool)
+}
+"""
+
+TEMPLATE_ALTERNATE_NULLABLE_CHECK = """
+\t\t}} else if s.{var_name} != nil {{
+\t\t\treturn *s.{var_name}, false"""
+
+TEMPLATE_ALTERNATE_MARSHAL_CHECK = """
+\tif s.{var_name} != nil {{
+\t\treturn json.Marshal(s.{var_name})
+\t}} else """
+
+TEMPLATE_ALTERNATE_UNMARSHAL_CHECK = """
+\t// Check for {var_type}
+\t{{
+\t\ts.{var_name} = new({var_type})
+\t\tif err := StrictDecode(s.{var_name}, data); err == nil {{
+\t\t\treturn nil
+\t\t}}
+\t\ts.{var_name} = nil
+\t}}
+"""
+
+TEMPLATE_ALTERNATE_NULLABLE = """
+func (s *{name}) ToAnyOrAbsent() (any, bool) {{
+\tif s != nil {{
+\t\tif s.IsNull {{
+\t\t\treturn nil, false
+{absent_check_fields}
+\t\t}}
+\t}}
+
+\treturn nil, true
+}}
+"""
+
+TEMPLATE_ALTERNATE_METHODS = """
+func (s {name}) MarshalJSON() ([]byte, error) {{
+\t{marshal_check_fields}
+\treturn {marshal_return_default}
+}}
+
+func (s *{name}) UnmarshalJSON(data []byte) error {{
+{unmarshal_check_fields}
+\treturn fmt.Errorf("Can't convert to {name}: %s", string(data))
+}}
+"""
+
 
 def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis = QAPISchemaGenGolangVisitor(prefix)
@@ -44,10 +116,191 @@ def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis.write(output_dir)
 
 
+def qapi_to_field_name(name: str) -> str:
+    return name.title().replace("_", "").replace("-", "")
+
+
 def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
 
+def qapi_schema_type_to_go_type(qapitype: str) -> str:
+    schema_types_to_go = {
+        "str": "string",
+        "null": "nil",
+        "bool": "bool",
+        "number": "float64",
+        "size": "uint64",
+        "int": "int64",
+        "int8": "int8",
+        "int16": "int16",
+        "int32": "int32",
+        "int64": "int64",
+        "uint8": "uint8",
+        "uint16": "uint16",
+        "uint32": "uint32",
+        "uint64": "uint64",
+        "any": "any",
+        "QType": "QType",
+    }
+
+    prefix = ""
+    if qapitype.endswith("List"):
+        prefix = "[]"
+        qapitype = qapitype[:-4]
+
+    qapitype = schema_types_to_go.get(qapitype, qapitype)
+    return prefix + qapitype
+
+
+def qapi_field_to_go_field(
+    member_name: str, type_name: str
+) -> Tuple[str, str, str]:
+    # Nothing to generate on null types. We update some
+    # variables to handle json-null on marshalling methods.
+    if type_name == "null":
+        return "IsNull", "bool", ""
+
+    # This function is called on Alternate, so fields should be ptrs
+    return (
+        qapi_to_field_name(member_name),
+        qapi_schema_type_to_go_type(type_name),
+        "*",
+    )
+
+
+# Helper function for boxed or self contained structures.
+def generate_struct_type(
+    type_name, args: List[dict[str:str]] = None, ident: int = 0
+) -> str:
+    members = "{}"
+    base_ident = "\t" * ident
+    if args is not None:
+        # Most of the logic below is to mimic the gofmt tool.
+        # We calculate spaces between member and type and between
+        # the type and tag.  Note that gofmt considers comments as
+        # divider between ident blocks.
+        maxname, maxtype = 0, 0
+        blocks: tuple(int, int) = []
+        for arg in args:
+            if "comment" in arg:
+                blocks.append((maxname, maxtype))
+                maxname, maxtype = 0, 0
+                continue
+
+            if "type" not in arg:
+                continue
+
+            maxname = max(maxname, len(arg["name"]))
+            maxtype = max(maxtype, len(arg["type"]))
+
+        blocks.append((maxname, maxtype))
+        block = 0
+
+        maxname, maxtype = blocks[0]
+        members = " {\n"
+        for arg in args:
+            if "comment" in arg:
+                block += 1
+                maxname, maxtype = blocks[block]
+                members += f"""\t// {arg["comment"]}\n"""
+                continue
+
+            name2type = ""
+            if "type" in arg:
+                name2type = " " * (maxname - len(arg["name"]) + 1)
+            type2tag = ""
+            if "tag" in arg:
+                type2tag = " " * (maxtype - len(arg["type"]) + 1)
+
+            fident = "\t" * (ident + 1)
+            gotype = "" if "type" not in arg else arg["type"]
+            tag = "" if "tag" not in arg else arg["tag"]
+            name = arg["name"]
+            members += (
+                f"""{fident}{name}{name2type}{gotype}{type2tag}{tag}\n"""
+            )
+        members += f"{base_ident}}}\n"
+
+    with_type = f"\n{base_ident}type {type_name}" if len(type_name) > 0 else ""
+    return f"""{with_type} struct{members}"""
+
+
+def generate_template_alternate(
+    self: QAPISchemaGenGolangVisitor,
+    name: str,
+    variants: Optional[QAPISchemaVariants],
+) -> str:
+    absent_check_fields = ""
+    args: List[dict[str:str]] = []
+    # to avoid having to check accept_null_types
+    nullable = False
+    if name in self.accept_null_types:
+        # In QEMU QAPI schema, only StrOrNull and BlockdevRefOrNull.
+        nullable = True
+        marshal_return_default = """[]byte("{}"), nil"""
+        marshal_check_fields = """if s.IsNull {
+\t\treturn []byte("null"), nil
+\t} else """
+        unmarshal_check_fields = """
+\t// Check for json-null first
+\tif string(data) == "null" {
+\t\ts.IsNull = true
+\t\treturn nil
+\t}"""
+    else:
+        marshal_return_default = f'nil, errors.New("{name} has empty fields")'
+        marshal_check_fields = ""
+        unmarshal_check_fields = f"""
+\t// Check for json-null first
+\tif string(data) == "null" {{
+\t\treturn errors.New(`null not supported for {name}`)
+\t}}"""
+
+    if variants:
+        for var in variants.variants:
+            var_name, var_type, isptr = qapi_field_to_go_field(
+                var.name, var.type.name
+            )
+            args.append(
+                {
+                    "name": f"{var_name}",
+                    "type": f"{isptr}{var_type}",
+                }
+            )
+
+            # Null is special, handled first
+            if var.type.name == "null":
+                assert nullable
+                continue
+
+            if nullable:
+                absent_check_fields += (
+                    TEMPLATE_ALTERNATE_NULLABLE_CHECK.format(var_name=var_name)
+                )
+            marshal_check_fields += TEMPLATE_ALTERNATE_MARSHAL_CHECK[
+                2:
+            ].format(var_name=var_name)
+            unmarshal_check_fields += (
+                TEMPLATE_ALTERNATE_UNMARSHAL_CHECK.format(
+                    var_name=var_name, var_type=var_type
+                )
+            )
+
+    content = generate_struct_type(name, args)
+    if nullable:
+        content += TEMPLATE_ALTERNATE_NULLABLE.format(
+            name=name, absent_check_fields=absent_check_fields
+        )
+    content += TEMPLATE_ALTERNATE_METHODS.format(
+        name=name,
+        marshal_check_fields=marshal_check_fields[:-6],
+        marshal_return_default=marshal_return_default,
+        unmarshal_check_fields=unmarshal_check_fields[1:],
+    )
+    return content
+
+
 def generate_content_from_dict(data: dict[str, str]) -> str:
     content = ""
 
@@ -61,22 +314,60 @@ class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
     # pylint: disable=too-many-arguments
     def __init__(self, _: str):
         super().__init__()
-        types = ("enum",)
+        types = (
+            "alternate",
+            "enum",
+            "helper",
+        )
         self.target = dict.fromkeys(types, "")
         self.schema: QAPISchema
         self.golang_package_name = "qapi"
         self.enums: dict[str, str] = {}
+        self.alternates: dict[str, str] = {}
+        self.accept_null_types = []
 
     def visit_begin(self, schema: QAPISchema) -> None:
         self.schema = schema
 
+        # We need to be aware of any types that accept JSON NULL
+        for name, entity in self.schema._entity_dict.items():
+            if not isinstance(entity, QAPISchemaAlternateType):
+                # Assume that only Alternate types accept JSON NULL
+                continue
+
+            for var in entity.variants.variants:
+                if var.type.name == "null":
+                    self.accept_null_types.append(name)
+                    break
+
         # Every Go file needs to reference its package name
+        # and most have some imports too.
         for target in self.target:
             self.target[target] = f"package {self.golang_package_name}\n"
 
+            if target == "helper":
+                imports = """\nimport (
+\t"encoding/json"
+\t"strings"
+)
+"""
+            else:
+                imports = """\nimport (
+\t"encoding/json"
+\t"errors"
+\t"fmt"
+)
+"""
+            if target != "enum":
+                self.target[target] += imports
+
+        self.target["helper"] += TEMPLATE_HELPER
+        self.target["alternate"] += TEMPLATE_ALTERNATE
+
     def visit_end(self) -> None:
         del self.schema
         self.target["enum"] += generate_content_from_dict(self.enums)
+        self.target["alternate"] += generate_content_from_dict(self.alternates)
 
     def visit_object_type(
         self,
@@ -98,7 +389,11 @@ def visit_alternate_type(
         features: List[QAPISchemaFeature],
         variants: QAPISchemaVariants,
     ) -> None:
-        pass
+        assert name not in self.alternates
+
+        self.alternates[name] = generate_template_alternate(
+            self, name, variants
+        )
 
     def visit_enum_type(
         self,
-- 
2.41.0


