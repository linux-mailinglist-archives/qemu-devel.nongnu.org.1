Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE377B02E8
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:28:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSgG-0002Rg-O6; Wed, 27 Sep 2023 07:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSg4-0002QD-TN
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSg3-0001fS-4L
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695813957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ghb3L7rr25oPc3vl9o1Af/irNvvAXlxz5WJK2LcKuoY=;
 b=LSCeHtDr/V1o0wX0N6P8ejQNQWYDYoaZUJ7EDM5fddLAgQxGhGdvJFJp+frZrtr6K+qqtl
 S3A+jWbrE7peSeoYMG2xCLo6mMTJB+btEYRY3eZirE0F/373oqlYfqaOBbEMUkgIvEDp1D
 fc8o9cqtdGyLjA1X/9sVJAl5PcSnoAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-TdczFD_wO4Ce2dQN4Xi5hQ-1; Wed, 27 Sep 2023 07:25:55 -0400
X-MC-Unique: TdczFD_wO4Ce2dQN4Xi5hQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6003A800B35
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:25:55 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FB8F10D14C7;
 Wed, 27 Sep 2023 11:25:54 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v1 6/9] qapi: golang: Generate qapi's event types in Go
Date: Wed, 27 Sep 2023 13:25:41 +0200
Message-ID: <20230927112544.85011-7-victortoso@redhat.com>
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

This patch handles QAPI event types and generates data structures in
Go that handles it.

We also define a Event interface and two helper functions MarshalEvent
and UnmarshalEvent.

Example:
qapi:
 | { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
 |   'data': { '*id': 'str', 'size': 'size', 'qom-path' : 'str'} }

go:
 | type MemoryDeviceSizeChangeEvent struct {
 |         MessageTimestamp Timestamp `json:"-"`
 |         Id               *string   `json:"id,omitempty"`
 |         Size             uint64    `json:"size"`
 |         QomPath          string    `json:"qom-path"`
 | }

usage:
 | input := `{"event":"MEMORY_DEVICE_SIZE_CHANGE",` +
 | `"timestamp":{"seconds":1588168529,"microseconds":201316},` +
 | `"data":{"id":"vm0","size":1073741824,"qom-path":"/machine/unattached/device[2]"}}`
 | e, err := UnmarshalEvent([]byte(input)
 | if err != nil {
 |     panic(err)
 | }
 | if e.GetName() == `MEMORY_DEVICE_SIZE_CHANGE` {
 |     m := e.(*MemoryDeviceSizeChangeEvent)
 |     // m.QomPath == "/machine/unattached/device[2]"
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 105 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 343c9c9b95..ff3b1dd020 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -197,6 +197,55 @@
 }}
 '''
 
+TEMPLATE_EVENT = '''
+type Timestamp struct {{
+    Seconds      int64 `json:"seconds"`
+    Microseconds int64 `json:"microseconds"`
+}}
+
+type Event interface {{
+    GetName()      string
+    GetTimestamp() Timestamp
+}}
+
+func MarshalEvent(e Event) ([]byte, error) {{
+    m := make(map[string]any)
+    m["event"] = e.GetName()
+    m["timestamp"] = e.GetTimestamp()
+    if bytes, err := json.Marshal(e); err != nil {{
+        return []byte{{}}, err
+    }} else if len(bytes) > 2 {{
+        m["data"] = e
+    }}
+    return json.Marshal(m)
+}}
+
+func UnmarshalEvent(data []byte) (Event, error) {{
+    base := struct {{
+        Name             string    `json:"event"`
+        MessageTimestamp Timestamp `json:"timestamp"`
+    }}{{}}
+    if err := json.Unmarshal(data, &base); err != nil {{
+        return nil, fmt.Errorf("Failed to decode event: %s", string(data))
+    }}
+
+    switch base.Name {{
+    {cases}
+    }}
+    return nil, errors.New("Failed to recognize event")
+}}
+'''
+
+TEMPLATE_EVENT_METHODS = '''
+func (s *{type_name}) GetName() string {{
+    return "{name}"
+}}
+
+func (s *{type_name}) GetTimestamp() Timestamp {{
+    return s.MessageTimestamp
+}}
+'''
+
 
 def gen_golang(schema: QAPISchema,
                output_dir: str,
@@ -217,7 +266,8 @@ def qapi_to_field_name(name: str) -> str:
 def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
-def qapi_to_go_type_name(name: str) -> str:
+def qapi_to_go_type_name(name: str,
+                         meta: Optional[str] = None) -> str:
     if qapi_name_is_object(name):
         name = name[6:]
 
@@ -232,6 +282,11 @@ def qapi_to_go_type_name(name: str) -> str:
 
     name += ''.join(word.title() for word in words[1:])
 
+    types = ["event"]
+    if meta in types:
+        name = name[:-3] if name.endswith("Arg") else name
+        name += meta.title().replace(" ", "")
+
     return name
 
 def qapi_schema_type_to_go_type(qapitype: str) -> str:
@@ -455,7 +510,7 @@ def recursive_base(self: QAPISchemaGenGolangVisitor,
 # Helper function that is used for most of QAPI types
 def qapi_to_golang_struct(self: QAPISchemaGenGolangVisitor,
                           name: str,
-                          _: Optional[QAPISourceInfo],
+                          info: Optional[QAPISourceInfo],
                           __: QAPISchemaIfCond,
                           ___: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
@@ -464,6 +519,8 @@ def qapi_to_golang_struct(self: QAPISchemaGenGolangVisitor,
 
 
     fields, with_nullable = recursive_base(self, base)
+    if info.defn_meta == "event":
+        fields += f'''\tMessageTimestamp Timestamp `json:"-"`\n{fields}'''
 
     if members:
         for member in members:
@@ -485,7 +542,7 @@ def qapi_to_golang_struct(self: QAPISchemaGenGolangVisitor,
             fields += field
             with_nullable = True if nullable else with_nullable
 
-    type_name = qapi_to_go_type_name(name)
+    type_name = qapi_to_go_type_name(name, info.defn_meta)
     content = generate_struct_type(type_name, fields)
     if with_nullable:
         content += struct_with_nullable_generate_marshal(self,
@@ -644,15 +701,34 @@ def generate_template_alternate(self: QAPISchemaGenGolangVisitor,
                                                  unmarshal_check_fields=unmarshal_check_fields[1:])
     return content
 
+def generate_template_event(events: dict[str, str]) -> str:
+    cases = ""
+    for name in sorted(events):
+        case_type = events[name]
+        cases += f'''
+case "{name}":
+    event := struct {{
+        Data {case_type} `json:"data"`
+    }}{{}}
+
+    if err := json.Unmarshal(data, &event); err != nil {{
+        return nil, fmt.Errorf("Failed to unmarshal: %s", string(data))
+    }}
+    event.Data.MessageTimestamp = base.MessageTimestamp
+    return &event.Data, nil
+'''
+    return TEMPLATE_EVENT.format(cases=cases)
+
 
 class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
 
     def __init__(self, _: str):
         super().__init__()
-        types = ["alternate", "enum", "helper", "struct", "union"]
+        types = ["alternate", "enum", "event", "helper", "struct", "union"]
         self.target = {name: "" for name in types}
         self.objects_seen = {}
         self.schema = None
+        self.events = {}
         self.golang_package_name = "qapi"
         self.accept_null_types = []
 
@@ -679,6 +755,7 @@ def visit_begin(self, schema):
 
     def visit_end(self):
         self.schema = None
+        self.target["event"] += generate_template_event(self.events)
 
     def visit_object_type(self: QAPISchemaGenGolangVisitor,
                           name: str,
@@ -779,7 +856,25 @@ def visit_command(self,
         pass
 
     def visit_event(self, name, info, ifcond, features, arg_type, boxed):
-        pass
+        assert name == info.defn_name
+        type_name = qapi_to_go_type_name(name, info.defn_meta)
+        self.events[name] = type_name
+
+        if isinstance(arg_type, QAPISchemaObjectType):
+            content = qapi_to_golang_struct(self,
+                                            name,
+                                            arg_type.info,
+                                            arg_type.ifcond,
+                                            arg_type.features,
+                                            arg_type.base,
+                                            arg_type.members,
+                                            arg_type.variants)
+        else:
+            args = '''MessageTimestamp Timestamp `json:"-"`'''
+            content = generate_struct_type(type_name, args)
+
+        content += TEMPLATE_EVENT_METHODS.format(name=name, type_name=type_name)
+        self.target["event"] += content
 
     def write(self, output_dir: str) -> None:
         for module_name, content in self.target.items():
-- 
2.41.0


