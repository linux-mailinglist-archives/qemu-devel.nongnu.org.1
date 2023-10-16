Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C311B7CAD7F
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPVA-0001QK-Ey; Mon, 16 Oct 2023 11:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV9-0001QA-BT
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV6-0003Os-OQ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQGy5TjMdBg6u6xWtevXARjK4sxGVEsbnXBhD+3K21g=;
 b=iJWDnbSrrXD8EX9G5g+2t/HCciYV93eW/OUn4GEj6lfgxMAk8WKkE/h7R4gngm7a6XB/xK
 p0qi/dXFkN1kDsNiRkI/1w+7iFdwFr2AmCtpZYSl/Ba5VoTeJkP9bGZw6lnORgipa4p2BN
 sas8KuRFaU8ofxOV9sqBsmMAI5PceBU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-ho_fudUnOFiUa8izJ_3A4w-1; Mon, 16 Oct 2023 11:27:22 -0400
X-MC-Unique: ho_fudUnOFiUa8izJ_3A4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6F6E1C113E9
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:21 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C76D2022781;
 Mon, 16 Oct 2023 15:27:20 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 08/11] qapi: golang: Generate qapi's event types in Go
Date: Mon, 16 Oct 2023 17:27:01 +0200
Message-ID: <20231016152704.221611-9-victortoso@redhat.com>
In-Reply-To: <20231016152704.221611-1-victortoso@redhat.com>
References: <20231016152704.221611-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
 scripts/qapi/golang.py | 122 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index bc6206797a..81b320d6dd 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -215,6 +215,54 @@
 }}
 """
 
+TEMPLATE_EVENT = """
+type Timestamp struct {{
+\tSeconds      int64 `json:"seconds"`
+\tMicroseconds int64 `json:"microseconds"`
+}}
+
+type Event interface {{
+\tGetName() string
+\tGetTimestamp() Timestamp
+}}
+
+func MarshalEvent(e Event) ([]byte, error) {{
+\tm := make(map[string]any)
+\tm["event"] = e.GetName()
+\tm["timestamp"] = e.GetTimestamp()
+\tif bytes, err := json.Marshal(e); err != nil {{
+\t\treturn []byte{{}}, err
+\t}} else if len(bytes) > 2 {{
+\t\tm["data"] = e
+\t}}
+\treturn json.Marshal(m)
+}}
+
+func UnmarshalEvent(data []byte) (Event, error) {{
+\tbase := struct {{
+\t\tName             string    `json:"event"`
+\t\tMessageTimestamp Timestamp `json:"timestamp"`
+\t}}{{}}
+\tif err := json.Unmarshal(data, &base); err != nil {{
+\t\treturn nil, fmt.Errorf("Failed to decode event: %s", string(data))
+\t}}
+
+\tswitch base.Name {{{cases}
+\t}}
+\treturn nil, errors.New("Failed to recognize event")
+}}
+"""
+
+TEMPLATE_EVENT_METHODS = """
+func (s *{type_name}) GetName() string {{
+\treturn "{name}"
+}}
+
+func (s *{type_name}) GetTimestamp() Timestamp {{
+\treturn s.MessageTimestamp
+}}
+"""
+
 
 def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis = QAPISchemaGenGolangVisitor(prefix)
@@ -238,7 +286,7 @@ def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
 
-def qapi_to_go_type_name(name: str) -> str:
+def qapi_to_go_type_name(name: str, meta: Optional[str] = None) -> str:
     if qapi_name_is_object(name):
         name = name[6:]
 
@@ -253,6 +301,11 @@ def qapi_to_go_type_name(name: str) -> str:
 
     name += "".join(word.title() for word in words[1:])
 
+    types = ["event"]
+    if meta in types:
+        name = name[:-3] if name.endswith("Arg") else name
+        name += meta.title().replace(" ", "")
+
     return name
 
 
@@ -608,6 +661,15 @@ def qapi_to_golang_struct(
 
     discriminator = None if not variants else variants.tag_member.name
     fields, with_nullable = recursive_base(self, base, discriminator)
+    if info.defn_meta == "event":
+        fields.insert(
+            0,
+            {
+                "name": "MessageTimestamp",
+                "type": "Timestamp",
+                "tag": """`json:"-"`""",
+            },
+        )
 
     if members:
         for member in members:
@@ -651,7 +713,7 @@ def qapi_to_golang_struct(
                 fields.append(field)
                 with_nullable = True if nullable else with_nullable
 
-    type_name = qapi_to_go_type_name(name)
+    type_name = qapi_to_go_type_name(name, info.defn_meta)
     content = generate_struct_type(type_name, fields, ident)
     if with_nullable:
         content += struct_with_nullable_generate_marshal(
@@ -825,6 +887,28 @@ def generate_template_alternate(
     return content
 
 
+def generate_template_event(events: dict[str, Tuple[str, str]]) -> str:
+    cases = ""
+    content = ""
+    for name in sorted(events):
+        case_type, gocode = events[name]
+        content += gocode
+        cases += f"""
+\tcase "{name}":
+\t\tevent := struct {{
+\t\t\tData {case_type} `json:"data"`
+\t\t}}{{}}
+
+\t\tif err := json.Unmarshal(data, &event); err != nil {{
+\t\t\treturn nil, fmt.Errorf("Failed to unmarshal: %s", string(data))
+\t\t}}
+\t\tevent.Data.MessageTimestamp = base.MessageTimestamp
+\t\treturn &event.Data, nil
+"""
+    content += TEMPLATE_EVENT.format(cases=cases)
+    return content
+
+
 def generate_content_from_dict(data: dict[str, str]) -> str:
     content = ""
 
@@ -841,12 +925,14 @@ def __init__(self, _: str):
         types = (
             "alternate",
             "enum",
+            "event",
             "helper",
             "struct",
             "union",
         )
         self.target = dict.fromkeys(types, "")
         self.schema: QAPISchema
+        self.events: dict[str, Tuple[str, str]] = {}
         self.golang_package_name = "qapi"
         self.enums: dict[str, str] = {}
         self.alternates: dict[str, str] = {}
@@ -901,6 +987,7 @@ def visit_end(self) -> None:
         self.target["alternate"] += generate_content_from_dict(self.alternates)
         self.target["struct"] += generate_content_from_dict(self.structs)
         self.target["union"] += generate_content_from_dict(self.unions)
+        self.target["event"] += generate_template_event(self.events)
 
     def visit_object_type(
         self,
@@ -1027,7 +1114,36 @@ def visit_event(
         arg_type: Optional[QAPISchemaObjectType],
         boxed: bool,
     ) -> None:
-        pass
+        assert name == info.defn_name
+        assert name not in self.events
+        type_name = qapi_to_go_type_name(name, info.defn_meta)
+
+        if isinstance(arg_type, QAPISchemaObjectType):
+            content = qapi_to_golang_struct(
+                self,
+                name,
+                arg_type.info,
+                arg_type.ifcond,
+                arg_type.features,
+                arg_type.base,
+                arg_type.members,
+                arg_type.variants,
+            )
+        else:
+            args: List[dict[str:str]] = []
+            args.append(
+                {
+                    "name": "MessageTimestamp",
+                    "type": "Timestamp",
+                    "tag": """`json:"-"`""",
+                }
+            )
+            content = generate_struct_type(type_name, args)
+
+        content += TEMPLATE_EVENT_METHODS.format(
+            name=name, type_name=type_name
+        )
+        self.events[name] = (type_name, content)
 
     def write(self, output_dir: str) -> None:
         for module_name, content in self.target.items():
-- 
2.41.0


