Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91A7B02E6
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSgH-0002So-NP; Wed, 27 Sep 2023 07:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSgA-0002Qi-6y
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSg6-0001g8-49
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695813961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fzVBihPpVNV5cVfGMBl+fBxOh7yT7S6KuXegwY+jes=;
 b=V0ZCdyDnMqVA6UMC6c+9YBvZA9LdRFf4dj8upTCSlOrihzhtjHTNK37wwolPaVTSpuvzQp
 LKkKXLH7QVIpZCkiwWFCXSw2+5ZkTaBEebTptg45n87q8sW2eF8V+G2sB5Y+gMuBrNT4lo
 Db3qwZRAWF8DAubOd05AlzPibyhcBwc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-691-4WOMpWIRMjue2PCn6pjKxg-1; Wed, 27 Sep 2023 07:25:58 -0400
X-MC-Unique: 4WOMpWIRMjue2PCn6pjKxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4141A101A53B
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:25:58 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28C2110EE402;
 Wed, 27 Sep 2023 11:25:56 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v1 8/9] qapi: golang: Add CommandResult type to Go
Date: Wed, 27 Sep 2023 13:25:43 +0200
Message-ID: <20230927112544.85011-9-victortoso@redhat.com>
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
    |     CommandId string     `json:"id,omitempty"`
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
 scripts/qapi/golang.py | 72 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 52a9124641..48ca0deab0 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -40,6 +40,15 @@
 '''
 
 TEMPLATE_HELPER = '''
+type QapiError struct {
+    Class       string `json:"class"`
+    Description string `json:"desc"`
+}
+
+func (err *QapiError) Error() string {
+    return fmt.Sprintf("%s: %s", err.Class, err.Description)
+}
+
 // Creates a decoder that errors on unknown Fields
 // Returns nil if successfully decoded @from payload to @into type
 // Returns error if failed to decode @from payload to @into type
@@ -254,12 +263,17 @@
 func (s *{type_name}) GetId() string {{
     return s.MessageId
 }}
+
+func (s *{type_name}) GetReturnType() CommandReturn {{
+    return &{cmd_ret_name}{{}}
+}}
 '''
 
 TEMPLATE_COMMAND = '''
 type Command interface {{
     GetId()         string
     GetName()       string
+    GetReturnType() CommandReturn
 }}
 
 func MarshalCommand(c Command) ([]byte, error) {{
@@ -292,6 +306,45 @@
 }}
 '''
 
+TEMPLATE_COMMAND_RETURN = '''
+type CommandReturn interface {
+    GetId()          string
+    GetCommandName() string
+    GetError()       error
+}
+'''
+
+TEMPLATE_COMMAND_RETURN_METHODS = '''
+type {cmd_ret_name} struct {{
+    MessageId  string                `json:"id,omitempty"`
+    Error     *QapiError             `json:"error,omitempty"`
+{result}
+}}
+
+func (r *{cmd_ret_name}) GetCommandName() string {{
+    return "{name}"
+}}
+
+func (r *{cmd_ret_name}) GetId() string {{
+    return r.MessageId
+}}
+
+func (r *{cmd_ret_name}) GetError() error {{
+    return r.Error
+}}
+
+{marshal_empty}
+'''
+
+TEMPLATE_COMMAND_RETURN_MARSHAL_EMPTY = '''
+func (r {cmd_ret_name}) MarshalJSON() ([]byte, error) {{
+    if r.Error != nil {{
+        type Alias {cmd_ret_name}
+        return json.Marshal(Alias(r))
+    }}
+    return []byte(`{{"return":{{}}}}`), nil
+}}'''
+
 def gen_golang(schema: QAPISchema,
                output_dir: str,
                prefix: str) -> None:
@@ -327,7 +380,7 @@ def qapi_to_go_type_name(name: str,
 
     name += ''.join(word.title() for word in words[1:])
 
-    types = ["event", "command"]
+    types = ["event", "command", "command return"]
     if meta in types:
         name = name[:-3] if name.endswith("Arg") else name
         name += meta.title().replace(" ", "")
@@ -783,6 +836,7 @@ def generate_template_command(commands: dict[str, str]) -> str:
     return &command.Args, nil
 '''
     content = TEMPLATE_COMMAND.format(cases=cases)
+    content += TEMPLATE_COMMAND_RETURN
     return content
 
 
@@ -926,6 +980,15 @@ def visit_command(self,
         type_name = qapi_to_go_type_name(name, info.defn_meta)
         self.commands[name] = type_name
 
+        cmd_ret_name = qapi_to_go_type_name(name, "command return")
+        marshal_empty = TEMPLATE_COMMAND_RETURN_MARSHAL_EMPTY.format(cmd_ret_name=cmd_ret_name)
+        result = ""
+        if ret_type:
+            marshal_empty = ""
+            ret_type_name = qapi_schema_type_to_go_type(ret_type.name)
+            isptr = "*" if ret_type_name[0] not in "*[" else ""
+            result = f'''Result    {isptr}{ret_type_name} `json:"return"`'''
+
         content = ""
         if boxed or not arg_type or not qapi_name_is_object(arg_type.name):
             args = "" if not arg_type else "\n" + arg_type.name
@@ -943,7 +1006,12 @@ def visit_command(self,
                                             arg_type.variants)
 
         content += TEMPLATE_COMMAND_METHODS.format(name=name,
-                                                   type_name=type_name)
+                                                   type_name=type_name,
+                                                   cmd_ret_name=cmd_ret_name)
+        content += TEMPLATE_COMMAND_RETURN_METHODS.format(name=name,
+                                                          cmd_ret_name=cmd_ret_name,
+                                                          result=result,
+                                                          marshal_empty=marshal_empty)
         self.target["command"] += content
 
     def visit_event(self, name, info, ifcond, features, arg_type, boxed):
-- 
2.41.0


