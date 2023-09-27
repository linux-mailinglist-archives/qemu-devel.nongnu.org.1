Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED17B02DF
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSgB-0002Qb-EC; Wed, 27 Sep 2023 07:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSfz-0002Ow-Uf
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSfw-0001Z1-Cs
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695813951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAUPdE5jD/YH8iyHvAfYBP9FgZYvjuflEAbYCGCnSJY=;
 b=gFhZYnnrDLiA9RwYLne86ssDAyOJduIU70V1bH6zOLm07EIkwudRS8AZfjNBlyDMggtnFG
 qJkhziCv6VYlO7DQJ+KMKIXgRU732+PG1ui2sVTKk4SvHREvUjVqwG1X+NmLc2I9x/LfQ0
 PJlyT8/bPoa0rzybFMgf0n41ZTvJJU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-XdABruarPyaYtewfwFxPEQ-1; Wed, 27 Sep 2023 07:25:50 -0400
X-MC-Unique: XdABruarPyaYtewfwFxPEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5096801FA9
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:25:49 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CA0710F1BE9;
 Wed, 27 Sep 2023 11:25:48 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v1 2/9] qapi: golang: Generate qapi's alternate types in Go
Date: Wed, 27 Sep 2023 13:25:37 +0200
Message-ID: <20230927112544.85011-3-victortoso@redhat.com>
In-Reply-To: <20230927112544.85011-1-victortoso@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
accept JSON Null as a value like StrOrNull and BlockdevRefOrNull. For
this case, we translate Null with a boolean value in a field called
IsNull. This will be explained better in the documentation patch of
this series but the main rationale is around Marshaling to and from
JSON and Go data structures.

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
 scripts/qapi/golang.py | 188 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 87081cdd05..43dbdde14c 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -16,10 +16,11 @@
 from __future__ import annotations
 
 import os
-from typing import List, Optional
+from typing import Tuple, List, Optional
 
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternateType,
     QAPISchemaType,
     QAPISchemaVisitor,
     QAPISchemaEnumMember,
@@ -38,6 +39,76 @@
 )
 '''
 
+TEMPLATE_HELPER = '''
+// Creates a decoder that errors on unknown Fields
+// Returns nil if successfully decoded @from payload to @into type
+// Returns error if failed to decode @from payload to @into type
+func StrictDecode(into interface{}, from []byte) error {
+    dec := json.NewDecoder(strings.NewReader(string(from)))
+    dec.DisallowUnknownFields()
+
+    if err := dec.Decode(into); err != nil {
+        return err
+    }
+    return nil
+}
+'''
+
+TEMPLATE_ALTERNATE = '''
+// Only implemented on Alternate types that can take JSON NULL as value.
+//
+// This is a helper for the marshalling code. It should return true only when
+// the Alternate is empty (no members are set), otherwise it returns false and
+// the member set to be Marshalled.
+type AbsentAlternate interface {
+	ToAnyOrAbsent() (any, bool)
+}
+'''
+
+TEMPLATE_ALTERNATE_NULLABLE_CHECK = '''
+    }} else if s.{var_name} != nil {{
+        return *s.{var_name}, false'''
+
+TEMPLATE_ALTERNATE_MARSHAL_CHECK = '''
+    if s.{var_name} != nil {{
+        return json.Marshal(s.{var_name})
+    }} else '''
+
+TEMPLATE_ALTERNATE_UNMARSHAL_CHECK = '''
+    // Check for {var_type}
+    {{
+        s.{var_name} = new({var_type})
+        if err := StrictDecode(s.{var_name}, data); err == nil {{
+            return nil
+        }}
+        s.{var_name} = nil
+    }}
+'''
+
+TEMPLATE_ALTERNATE_NULLABLE = '''
+func (s *{name}) ToAnyOrAbsent() (any, bool) {{
+    if s != nil {{
+        if s.IsNull {{
+            return nil, false
+{absent_check_fields}
+        }}
+    }}
+
+    return nil, true
+}}
+'''
+
+TEMPLATE_ALTERNATE_METHODS = '''
+func (s {name}) MarshalJSON() ([]byte, error) {{
+    {marshal_check_fields}
+    return {marshal_return_default}
+}}
+
+func (s *{name}) UnmarshalJSON(data []byte) error {{
+    {unmarshal_check_fields}
+    return fmt.Errorf("Can't convert to {name}: %s", string(data))
+}}
+'''
 
 def gen_golang(schema: QAPISchema,
                output_dir: str,
@@ -46,27 +117,135 @@ def gen_golang(schema: QAPISchema,
     schema.visit(vis)
     vis.write(output_dir)
 
+def qapi_to_field_name(name: str) -> str:
+    return name.title().replace("_", "").replace("-", "")
 
 def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
+def qapi_schema_type_to_go_type(qapitype: str) -> str:
+    schema_types_to_go = {
+            'str': 'string', 'null': 'nil', 'bool': 'bool', 'number':
+            'float64', 'size': 'uint64', 'int': 'int64', 'int8': 'int8',
+            'int16': 'int16', 'int32': 'int32', 'int64': 'int64', 'uint8':
+            'uint8', 'uint16': 'uint16', 'uint32': 'uint32', 'uint64':
+            'uint64', 'any': 'any', 'QType': 'QType',
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
+def qapi_field_to_go_field(member_name: str, type_name: str) -> Tuple[str, str, str]:
+    # Nothing to generate on null types. We update some
+    # variables to handle json-null on marshalling methods.
+    if type_name == "null":
+        return "IsNull", "bool", ""
+
+    # This function is called on Alternate, so fields should be ptrs
+    return qapi_to_field_name(member_name), qapi_schema_type_to_go_type(type_name), "*"
+
+# Helper function for boxed or self contained structures.
+def generate_struct_type(type_name, args="") -> str:
+    args = args if len(args) == 0 else f"\n{args}\n"
+    with_type = f"\ntype {type_name}" if len(type_name) > 0 else ""
+    return f'''{with_type} struct {{{args}}}
+'''
+
+def generate_template_alternate(self: QAPISchemaGenGolangVisitor,
+                                name: str,
+                                variants: Optional[QAPISchemaVariants]) -> str:
+    absent_check_fields = ""
+    variant_fields = ""
+    # to avoid having to check accept_null_types
+    nullable = False
+    if name in self.accept_null_types:
+        # In QEMU QAPI schema, only StrOrNull and BlockdevRefOrNull.
+        nullable = True
+        marshal_return_default = '''[]byte("{}"), nil'''
+        marshal_check_fields = '''
+        if s.IsNull {
+            return []byte("null"), nil
+        } else '''
+        unmarshal_check_fields = '''
+        // Check for json-null first
+            if string(data) == "null" {
+                s.IsNull = true
+                return nil
+            }
+        '''
+    else:
+        marshal_return_default = f'nil, errors.New("{name} has empty fields")'
+        marshal_check_fields = ""
+        unmarshal_check_fields = f'''
+            // Check for json-null first
+            if string(data) == "null" {{
+                return errors.New(`null not supported for {name}`)
+            }}
+        '''
+
+    for var in variants.variants:
+        var_name, var_type, isptr = qapi_field_to_go_field(var.name, var.type.name)
+        variant_fields += f"\t{var_name} {isptr}{var_type}\n"
+
+        # Null is special, handled first
+        if var.type.name == "null":
+            assert nullable
+            continue
+
+        if nullable:
+            absent_check_fields += TEMPLATE_ALTERNATE_NULLABLE_CHECK.format(var_name=var_name)[1:]
+        marshal_check_fields += TEMPLATE_ALTERNATE_MARSHAL_CHECK.format(var_name=var_name)
+        unmarshal_check_fields += TEMPLATE_ALTERNATE_UNMARSHAL_CHECK.format(var_name=var_name,
+                                                                            var_type=var_type)[1:]
+
+    content = generate_struct_type(name, variant_fields)
+    if nullable:
+        content += TEMPLATE_ALTERNATE_NULLABLE.format(name=name,
+                                                      absent_check_fields=absent_check_fields)
+    content += TEMPLATE_ALTERNATE_METHODS.format(name=name,
+                                                 marshal_check_fields=marshal_check_fields[1:-5],
+                                                 marshal_return_default=marshal_return_default,
+                                                 unmarshal_check_fields=unmarshal_check_fields[1:])
+    return content
+
 
 class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
 
     def __init__(self, _: str):
         super().__init__()
-        types = ["enum"]
+        types = ["alternate", "enum", "helper"]
         self.target = {name: "" for name in types}
+        self.objects_seen = {}
         self.schema = None
         self.golang_package_name = "qapi"
+        self.accept_null_types = []
 
     def visit_begin(self, schema):
         self.schema = schema
 
+        # We need to be aware of any types that accept JSON NULL
+        for name, entity in self.schema._entity_dict.items():
+            if not isinstance(entity, QAPISchemaAlternateType):
+                # Assume that only Alternate types accept JSON NULL
+                continue
+
+            for var in  entity.variants.variants:
+                if var.type.name == 'null':
+                    self.accept_null_types.append(name)
+                    break
+
         # Every Go file needs to reference its package name
         for target in self.target:
             self.target[target] = f"package {self.golang_package_name}\n"
 
+        self.target["helper"] += TEMPLATE_HELPER
+        self.target["alternate"] += TEMPLATE_ALTERNATE
+
     def visit_end(self):
         self.schema = None
 
@@ -88,7 +267,10 @@ def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
                              features: List[QAPISchemaFeature],
                              variants: QAPISchemaVariants
                              ) -> None:
-        pass
+        assert name not in self.objects_seen
+        self.objects_seen[name] = True
+
+        self.target["alternate"] += generate_template_alternate(self, name, variants)
 
     def visit_enum_type(self: QAPISchemaGenGolangVisitor,
                         name: str,
-- 
2.41.0


