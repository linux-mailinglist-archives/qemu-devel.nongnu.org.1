Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 543D07CAD82
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPVE-0001S3-3b; Mon, 16 Oct 2023 11:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPVB-0001RR-Ve
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPVA-0003QU-85
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgrQoBPSf8gokHDUmPCR8C+NrpnHwKmccSAzfFPHncI=;
 b=Cg47Ak1bpmTO+7A9GwgmP0bQjXG6+q9SQP9SwnnEKRJj4ar2hlbrC8HOOe4HjqKVbyZOu3
 eJY/ydwSvJODV1zzhOWbrk3btw7TVpEWf83Yt5DJku4dwyvDSyJFxKop4NUYAB01tPw1Qm
 0ij3UFsrlOQIkHkvL6dqUNDdu8ur1+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-_CLmO6a_NoytUK4s5yuMxg-1; Mon, 16 Oct 2023 11:27:26 -0400
X-MC-Unique: _CLmO6a_NoytUK4s5yuMxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05495862F1E
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:26 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E061020111C6;
 Mon, 16 Oct 2023 15:27:23 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 10/11] qapi: golang: Add CommandResult type to Go
Date: Mon, 16 Oct 2023 17:27:03 +0200
Message-ID: <20231016152704.221611-11-victortoso@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
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

This patch adds a struct type in Go that will handle return values
for QAPI's command types.

The return value of a Command is, encouraged to be, QAPI's complex
types or an Array of those.

Every Command has a underlying CommandResult. The EmptyCommandReturn
is for those that don't expect any data e.g: `{ "return": {} }`.

All CommandReturn types implement the CommandResult interface.

Example:
qapi:
    | { 'command': 'query-sev', 'returns': 'SevInfo',
    |   'if': 'TARGET_I386' }

go:
    | type QuerySevCommandReturn struct {
    |     MessageId string     `json:"id,omitempty"`
    |     Result    *SevInfo   `json:"return"`
    |     Error     *QapiError `json:"error,omitempty"`
    | }

usage:
    | // One can use QuerySevCommandReturn directly or
    | // command's interface GetReturnType() instead.
    |
    | input := `{ "return": { "enabled": true, "api-major" : 0,` +
    |                        `"api-minor" : 0, "build-id" : 0,` +
    |                        `"policy" : 0, "state" : "running",` +
    |                        `"handle" : 1 } } `
    |
    | ret := QuerySevCommandReturn{}
    | err := json.Unmarshal([]byte(input), &ret)
    | if ret.Error != nil {
    |     // Handle command failure {"error": { ...}}
    | } else if ret.Result != nil {
    |     // ret.Result.Enable == true
    | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 104 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 624bc2af4d..6471ddeb52 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -39,6 +39,15 @@
 """
 
 TEMPLATE_HELPER = """
+type QAPIError struct {
+\tClass       string `json:"class"`
+\tDescription string `json:"desc"`
+}
+
+func (err *QAPIError) Error() string {
+\treturn err.Description
+}
+
 // Creates a decoder that errors on unknown Fields
 // Returns nil if successfully decoded @from payload to @into type
 // Returns error if failed to decode @from payload to @into type
@@ -271,12 +280,17 @@
 func (s *{type_name}) GetId() string {{
 \treturn s.MessageId
 }}
+
+func (s *{type_name}) GetReturnType() CommandReturn {{
+\treturn &{cmd_ret_name}{{}}
+}}
 """
 
 TEMPLATE_COMMAND = """
 type Command interface {{
 \tGetId() string
 \tGetName() string
+\tGetReturnType() CommandReturn
 }}
 
 func MarshalCommand(c Command) ([]byte, error) {{
@@ -308,6 +322,37 @@
 }}
 """
 
+TEMPLATE_COMMAND_RETURN = """
+type CommandReturn interface {
+\tGetId() string
+\tGetCommandName() string
+\tGetError() error
+}
+"""
+
+TEMPLATE_COMMAND_RETURN_METHODS = """
+func (r *{cmd_ret_name}) GetCommandName() string {{
+\treturn "{name}"
+}}
+
+func (r *{cmd_ret_name}) GetId() string {{
+\treturn r.MessageId
+}}
+
+func (r *{cmd_ret_name}) GetError() error {{
+\treturn r.Error
+}}{marshal_empty}
+"""
+
+TEMPLATE_COMMAND_RETURN_MARSHAL_EMPTY = """
+func (r {cmd_ret_name}) MarshalJSON() ([]byte, error) {{
+\tif r.Error != nil {{
+\t\ttype Alias {cmd_ret_name}
+\t\treturn json.Marshal(Alias(r))
+\t}}
+\treturn []byte(`{{"return":{{}}}}`), nil
+}}"""
+
 
 def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis = QAPISchemaGenGolangVisitor(prefix)
@@ -346,7 +391,7 @@ def qapi_to_go_type_name(name: str, meta: Optional[str] = None) -> str:
 
     name += "".join(word.title() for word in words[1:])
 
-    types = ["event", "command"]
+    types = ["event", "command", "command return"]
     if meta in types:
         name = name[:-3] if name.endswith("Arg") else name
         name += meta.title().replace(" ", "")
@@ -943,18 +988,19 @@ def generate_template_command(commands: dict[str, Tuple[str, str]]) -> str:
         case_type, gocode = commands[name]
         content += gocode
         cases += f"""
-case "{name}":
-    command := struct {{
-        Args {case_type} `json:"arguments"`
-    }}{{}}
-
-    if err := json.Unmarshal(data, &command); err != nil {{
-        return nil, fmt.Errorf("Failed to unmarshal: %s", string(data))
-    }}
-    command.Args.MessageId = base.MessageId
-    return &command.Args, nil
+\tcase "{name}":
+\t\tcommand := struct {{
+\t\t\tArgs {case_type} `json:"arguments"`
+\t\t}}{{}}
+
+\t\tif err := json.Unmarshal(data, &command); err != nil {{
+\t\t\treturn nil, fmt.Errorf("Failed to unmarshal: %s", string(data))
+\t\t}}
+\t\tcommand.Args.MessageId = base.MessageId
+\t\treturn &command.Args, nil
 """
     content += TEMPLATE_COMMAND.format(cases=cases)
+    content += TEMPLATE_COMMAND_RETURN
     return content
 
 
@@ -1182,6 +1228,34 @@ def visit_command(
 
         type_name = qapi_to_go_type_name(name, info.defn_meta)
 
+        cmd_ret_name = qapi_to_go_type_name(name, "command return")
+        marshal_empty = TEMPLATE_COMMAND_RETURN_MARSHAL_EMPTY.format(
+            cmd_ret_name=cmd_ret_name
+        )
+        retargs: List[dict[str:str]] = [
+            {
+                "name": "MessageId",
+                "type": "string",
+                "tag": """`json:"id,omitempty"`""",
+            },
+            {
+                "name": "Error",
+                "type": "*QAPIError",
+                "tag": """`json:"error,omitempty"`""",
+            },
+        ]
+        if ret_type:
+            marshal_empty = ""
+            ret_type_name = qapi_schema_type_to_go_type(ret_type.name)
+            isptr = "*" if ret_type_name[0] not in "*[" else ""
+            retargs.append(
+                {
+                    "name": "Result",
+                    "type": f"{isptr}{ret_type_name}",
+                    "tag": """`json:"return"`""",
+                }
+            )
+
         content = ""
         if boxed or not arg_type or not qapi_name_is_object(arg_type.name):
             args: List[dict[str:str]] = []
@@ -1213,7 +1287,13 @@ def visit_command(
             )
 
         content += TEMPLATE_COMMAND_METHODS.format(
-            name=name, type_name=type_name
+            name=name, type_name=type_name, cmd_ret_name=cmd_ret_name
+        )
+        content += generate_struct_type(cmd_ret_name, retargs)
+        content += TEMPLATE_COMMAND_RETURN_METHODS.format(
+            name=name,
+            cmd_ret_name=cmd_ret_name,
+            marshal_empty=marshal_empty,
         )
         self.commands[name] = (type_name, content)
 
-- 
2.41.0


