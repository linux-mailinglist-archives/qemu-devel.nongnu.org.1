Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1627B02DC
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSgF-0002RM-ET; Wed, 27 Sep 2023 07:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSg3-0002PN-B0
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSg1-0001f8-1x
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695813955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wEdD3oUQ1Me33qV1xhUdRwIKVbJ+g3b+cRlu+QgXspI=;
 b=ZDN4QiFqqNXr4vtSY1sHTVXUBMsPu1w7DyQjZeSYvHhzcLqJ9xJujIzCkxW72CJ5kN/t5/
 n1//6XA1M2N1gQBBPDJmzhWLpE321djxk2uLMQWymGpaSS57CIgn1K28411Rd2hViiJPVc
 tuTM2hBiYz0J2EqXJG42/UwneaJ92mc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-UANJskxDNe6zhw59FoYTRw-1; Wed, 27 Sep 2023 07:25:54 -0400
X-MC-Unique: UANJskxDNe6zhw59FoYTRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF3648039C1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:25:53 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DABBB10F1BE9;
 Wed, 27 Sep 2023 11:25:52 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v1 5/9] qapi: golang: Generate qapi's union types in Go
Date: Wed, 27 Sep 2023 13:25:40 +0200
Message-ID: <20230927112544.85011-6-victortoso@redhat.com>
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

This patch handles QAPI union types and generates the equivalent data
structures and methods in Go to handle it.

The QAPI union type has two types of fields: The @base and the
@Variants members. The @base fields can be considered common members
for the union while only one field maximum is set for the @Variants.

In the QAPI specification, it defines a @discriminator field, which is
an Enum type. The purpose of the  @discriminator is to identify which
@variant type is being used.

Not that @discriminator's enum might have more values than the union's
data struct. This is fine. The union does not need to handle all cases
of the enum, but it should accept them without error. For this
specific case, we keep the @discriminator field in every union type.

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
 |     Protocol  DisplayProtocol    `json:"protocol"`
 |     Password  string             `json:"password"`
 |     Connected *SetPasswordAction `json:"connected,omitempty"`
 |
 |     // Variants fields
 |     Vnc *SetPasswordOptionsVnc `json:"-"`
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 170 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 8320af99b6..343c9c9b95 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -52,6 +52,17 @@
     }
     return nil
 }
+
+// This helper is used to move struct's fields into a map.
+// This function is useful to merge JSON objects.
+func unwrapToMap(m map[string]any, data any) error {
+	if bytes, err := json.Marshal(&data); err != nil {
+		return fmt.Errorf("unwrapToMap: %s", err)
+	} else if err := json.Unmarshal(bytes, &m); err != nil {
+		return fmt.Errorf("unwrapToMap: %s, data=%s", err, string(bytes))
+	}
+	return nil
+}
 '''
 
 TEMPLATE_ALTERNATE = '''
@@ -131,6 +142,62 @@
 }}
 '''
 
+TEMPLATE_UNION_CHECK_FIELD = '''
+if s.{field} != nil && err == nil {{
+    if len(bytes) != 0 {{
+        err = errors.New(`multiple variant fields set`)
+    }} else if err = unwrapToMap(m, s.{field}); err == nil {{
+        s.{discriminator} = {go_enum_value}
+        m["{member_name}"] = {go_enum_value}
+        bytes, err = json.Marshal(m)
+    }}
+}}
+'''
+
+TEMPLATE_UNION_DRIVER_CASE = '''
+case {go_enum_value}:
+    s.{field} = new({member_type})
+    if err := json.Unmarshal(data, s.{field}); err != nil {{
+        s.{field} = nil
+        return err
+    }}'''
+
+TEMPLATE_UNION_METHODS = '''
+func (s {type_name}) MarshalJSON() ([]byte, error) {{
+    var bytes []byte
+    var err error
+    type Alias {type_name}
+    v := Alias(s)
+    m := make(map[string]any)
+    unwrapToMap(m, &v)
+    {check_fields}
+    {check_non_fields_marshal}
+    if err != nil {{
+        return nil, fmt.Errorf("error: marshal: {type_name}: reason='%s', struct='%+v'", err, s)
+    }} else if len(bytes) == 0 {{
+        return nil, fmt.Errorf("error: marshal: {type_name} unsupported, struct='%+v'", s)
+     }}
+     return bytes, nil
+}}
+
+func (s *{type_name}) UnmarshalJSON(data []byte) error {{{base_type_def}
+    tmp := struct {{
+        {base_type_name}
+    }}{{}}
+
+    if err := json.Unmarshal(data, &tmp); err != nil {{
+        return err
+    }}
+    {base_type_assign_unmarshal}
+    switch tmp.{discriminator} {{
+    {driver_cases}
+    {check_non_fields_unmarshal}
+    }}
+    return nil
+}}
+'''
+
+
 def gen_golang(schema: QAPISchema,
                output_dir: str,
                prefix: str) -> None:
@@ -428,6 +495,98 @@ def qapi_to_golang_struct(self: QAPISchemaGenGolangVisitor,
                                                          variants)
     return content
 
+def qapi_to_golang_methods_union(self: QAPISchemaGenGolangVisitor,
+                                 name: str,
+                                 base: Optional[QAPISchemaObjectType],
+                                 variants: Optional[QAPISchemaVariants]
+                                 ) -> str:
+
+    type_name = qapi_to_go_type_name(name)
+
+    assert base
+    base_type_assign_unmarshal = ""
+    base_type_name = qapi_to_go_type_name(base.name)
+    base_type_def = qapi_to_golang_struct(self,
+                                          base.name,
+                                          base.info,
+                                          base.ifcond,
+                                          base.features,
+                                          base.base,
+                                          base.members,
+                                          base.variants)
+    for member in base.local_members:
+        field = qapi_to_field_name(member.name)
+        base_type_assign_unmarshal += f'''s.{field} = tmp.{field}
+'''
+
+    driver_cases = ""
+    check_fields = ""
+    exists = {}
+    enum_name = variants.tag_member.type.name
+    discriminator = qapi_to_field_name(variants.tag_member.name)
+    if variants:
+        for var in variants.variants:
+            if var.type.is_implicit():
+                continue
+
+            field = qapi_to_field_name(var.name)
+            enum_value = qapi_to_field_name_enum(var.name)
+            member_type = qapi_schema_type_to_go_type(var.type.name)
+            go_enum_value = f'''{enum_name}{enum_value}'''
+            exists[go_enum_value] = True
+
+            check_fields += TEMPLATE_UNION_CHECK_FIELD.format(field=field,
+                                                             discriminator=discriminator,
+                                                             member_name=variants.tag_member.name,
+                                                             go_enum_value=go_enum_value)
+            driver_cases += TEMPLATE_UNION_DRIVER_CASE.format(go_enum_value=go_enum_value,
+                                                             field=field,
+                                                             member_type=member_type)
+
+    check_non_fields_marshal = ""
+    check_non_fields_unmarshal = ""
+    enum_obj = self.schema.lookup_entity(enum_name)
+    if len(exists) != len(enum_obj.members):
+        driver_cases += '''\ndefault:'''
+        check_non_fields_marshal = '''
+    // Check for valid values without field members
+    if len(bytes) == 0 && err == nil &&
+        ('''
+        check_non_fields_unmarshal = '''
+    // Check for valid values without field members
+    if '''
+
+        for member in enum_obj.members:
+            value = qapi_to_field_name_enum(member.name)
+            go_enum_value = f'''{enum_name}{value}'''
+
+            if go_enum_value in exists:
+                continue
+
+            check_non_fields_marshal += f'''s.{discriminator} == {go_enum_value} ||\n'''
+            check_non_fields_unmarshal += f'''tmp.{discriminator} != {go_enum_value} &&\n'''
+
+        check_non_fields_marshal = f'''{check_non_fields_marshal[:-3]}) {{
+        type Alias {type_name}
+        bytes, err = json.Marshal(Alias(s))
+    }}
+'''
+        check_non_fields_unmarshal = f'''{check_non_fields_unmarshal[1:-3]} {{
+        return fmt.Errorf("error: unmarshal: {type_name}: received unrecognized value: '%s'",
+            tmp.{discriminator})
+    }}
+'''
+
+    return TEMPLATE_UNION_METHODS.format(type_name=type_name,
+                                         check_fields=check_fields,
+                                         check_non_fields_marshal=check_non_fields_marshal,
+                                         base_type_def=base_type_def,
+                                         base_type_name=base_type_name,
+                                         base_type_assign_unmarshal=base_type_assign_unmarshal,
+                                         discriminator=discriminator,
+                                         driver_cases=driver_cases[1:],
+                                         check_non_fields_unmarshal=check_non_fields_unmarshal)
+
 def generate_template_alternate(self: QAPISchemaGenGolangVisitor,
                                 name: str,
                                 variants: Optional[QAPISchemaVariants]) -> str:
@@ -490,7 +649,7 @@ class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
 
     def __init__(self, _: str):
         super().__init__()
-        types = ["alternate", "enum", "helper", "struct"]
+        types = ["alternate", "enum", "helper", "struct", "union"]
         self.target = {name: "" for name in types}
         self.objects_seen = {}
         self.schema = None
@@ -530,10 +689,10 @@ def visit_object_type(self: QAPISchemaGenGolangVisitor,
                           members: List[QAPISchemaObjectTypeMember],
                           variants: Optional[QAPISchemaVariants]
                           ) -> None:
-        # Do not handle anything besides struct.
+        # Do not handle anything besides struct and unions.
         if (name == self.schema.the_empty_object_type.name or
                 not isinstance(name, str) or
-                info.defn_meta not in ["struct"]):
+                info.defn_meta not in ["struct", "union"]):
             return
 
         # Base structs are embed
@@ -566,6 +725,11 @@ def visit_object_type(self: QAPISchemaGenGolangVisitor,
                                                              base,
                                                              members,
                                                              variants)
+        if info.defn_meta == "union":
+            self.target[info.defn_meta] += qapi_to_golang_methods_union(self,
+                                                                        name,
+                                                                        base,
+                                                                        variants)
 
     def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
                              name: str,
-- 
2.41.0


