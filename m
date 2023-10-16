Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B617CAD7A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPVC-0001Rd-Qa; Mon, 16 Oct 2023 11:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPVA-0001R3-TE
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV7-0003P5-Os
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TXkfFruFFgTQQNNqLYJayJdnGYrkzbuvhCKUHzwzgI=;
 b=IE4q5epwRdmT9ylgJx5pOd75pejB2DPzIS90Sl9pHpOGQjVpq16TZKvgHkQbyFQ7/RKZi1
 dhdwaLgOpEIyII8LoaKKPPUd53k08DNPbj2qjsvqiOPnz2cHv9x/AC9Qsklgd7ZV0/dbHd
 6GwxAT9ubrDAoq26ZZEAOJ/dayQXSVQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-689--QZff7uHNe6VDk0HPx5UHA-1; Mon, 16 Oct 2023 11:27:23 -0400
X-MC-Unique: -QZff7uHNe6VDk0HPx5UHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FA271C113E9
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:23 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1579A20296DB;
 Mon, 16 Oct 2023 15:27:21 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 09/11] qapi: golang: Generate qapi's command types in Go
Date: Mon, 16 Oct 2023 17:27:02 +0200
Message-ID: <20231016152704.221611-10-victortoso@redhat.com>
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

This patch handles QAPI command types and generates data structures in
Go that decodes from QMP JSON Object to Go data structure and vice
versa.

Similar to Event, this patch adds a Command interface and two helper
functions MarshalCommand and UnmarshalCommand.

At the time of this writing, it generates 209 structures.

Example:
qapi:
 | { 'command': 'set_password',
 |   'boxed': true,
 |   'data': 'SetPasswordOptions' }

go:
 | type SetPasswordCommand struct {
 |     SetPasswordOptions
 |     MessageId string `json:"-"`
 | }

usage:
 | input := `{"execute":"set_password",` +
 |          `"arguments":{"protocol":"vnc",` +
 |          `"password":"secret"}}`
 |
 | c, err := UnmarshalCommand([]byte(input))
 | if err != nil {
 |     panic(err)
 | }
 |
 | if c.GetName() == `set_password` {
 |         m := c.(*SetPasswordCommand)
 |         // m.Password == "secret"
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 116 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 81b320d6dd..624bc2af4d 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -263,6 +263,51 @@
 }}
 """
 
+TEMPLATE_COMMAND_METHODS = """
+func (c *{type_name}) GetName() string {{
+\treturn "{name}"
+}}
+
+func (s *{type_name}) GetId() string {{
+\treturn s.MessageId
+}}
+"""
+
+TEMPLATE_COMMAND = """
+type Command interface {{
+\tGetId() string
+\tGetName() string
+}}
+
+func MarshalCommand(c Command) ([]byte, error) {{
+\tm := make(map[string]any)
+\tm["execute"] = c.GetName()
+\tif id := c.GetId(); len(id) > 0 {{
+\t\tm["id"] = id
+\t}}
+\tif bytes, err := json.Marshal(c); err != nil {{
+\t\treturn []byte{{}}, err
+\t}} else if len(bytes) > 2 {{
+\t\tm["arguments"] = c
+\t}}
+\treturn json.Marshal(m)
+}}
+
+func UnmarshalCommand(data []byte) (Command, error) {{
+\tbase := struct {{
+\t\tMessageId string `json:"id,omitempty"`
+\t\tName      string `json:"execute"`
+\t}}{{}}
+\tif err := json.Unmarshal(data, &base); err != nil {{
+\t\treturn nil, fmt.Errorf("Failed to decode command: %s", string(data))
+\t}}
+
+\tswitch base.Name {{{cases}
+\t}}
+\treturn nil, errors.New("Failed to recognize command")
+}}
+"""
+
 
 def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis = QAPISchemaGenGolangVisitor(prefix)
@@ -301,7 +346,7 @@ def qapi_to_go_type_name(name: str, meta: Optional[str] = None) -> str:
 
     name += "".join(word.title() for word in words[1:])
 
-    types = ["event"]
+    types = ["event", "command"]
     if meta in types:
         name = name[:-3] if name.endswith("Arg") else name
         name += meta.title().replace(" ", "")
@@ -670,6 +715,10 @@ def qapi_to_golang_struct(
                 "tag": """`json:"-"`""",
             },
         )
+    elif info.defn_meta == "command":
+        fields.insert(
+            0, {"name": "MessageId", "type": "string", "tag": """`json:"-"`"""}
+        )
 
     if members:
         for member in members:
@@ -887,6 +936,28 @@ def generate_template_alternate(
     return content
 
 
+def generate_template_command(commands: dict[str, Tuple[str, str]]) -> str:
+    cases = ""
+    content = ""
+    for name in sorted(commands):
+        case_type, gocode = commands[name]
+        content += gocode
+        cases += f"""
+case "{name}":
+    command := struct {{
+        Args {case_type} `json:"arguments"`
+    }}{{}}
+
+    if err := json.Unmarshal(data, &command); err != nil {{
+        return nil, fmt.Errorf("Failed to unmarshal: %s", string(data))
+    }}
+    command.Args.MessageId = base.MessageId
+    return &command.Args, nil
+"""
+    content += TEMPLATE_COMMAND.format(cases=cases)
+    return content
+
+
 def generate_template_event(events: dict[str, Tuple[str, str]]) -> str:
     cases = ""
     content = ""
@@ -924,6 +995,7 @@ def __init__(self, _: str):
         super().__init__()
         types = (
             "alternate",
+            "command",
             "enum",
             "event",
             "helper",
@@ -933,6 +1005,7 @@ def __init__(self, _: str):
         self.target = dict.fromkeys(types, "")
         self.schema: QAPISchema
         self.events: dict[str, Tuple[str, str]] = {}
+        self.commands: dict[str, Tuple[str, str]] = {}
         self.golang_package_name = "qapi"
         self.enums: dict[str, str] = {}
         self.alternates: dict[str, str] = {}
@@ -988,6 +1061,7 @@ def visit_end(self) -> None:
         self.target["struct"] += generate_content_from_dict(self.structs)
         self.target["union"] += generate_content_from_dict(self.unions)
         self.target["event"] += generate_template_event(self.events)
+        self.target["command"] += generate_template_command(self.commands)
 
     def visit_object_type(
         self,
@@ -1103,7 +1177,45 @@ def visit_command(
         allow_preconfig: bool,
         coroutine: bool,
     ) -> None:
-        pass
+        assert name == info.defn_name
+        assert name not in self.commands
+
+        type_name = qapi_to_go_type_name(name, info.defn_meta)
+
+        content = ""
+        if boxed or not arg_type or not qapi_name_is_object(arg_type.name):
+            args: List[dict[str:str]] = []
+            if arg_type:
+                args.append(
+                    {
+                        "name": f"{arg_type.name}",
+                    }
+                )
+            args.append(
+                {
+                    "name": "MessageId",
+                    "type": "string",
+                    "tag": """`json:"-"`""",
+                }
+            )
+            content = generate_struct_type(type_name, args)
+        else:
+            assert isinstance(arg_type, QAPISchemaObjectType)
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
+
+        content += TEMPLATE_COMMAND_METHODS.format(
+            name=name, type_name=type_name
+        )
+        self.commands[name] = (type_name, content)
 
     def visit_event(
         self,
-- 
2.41.0


