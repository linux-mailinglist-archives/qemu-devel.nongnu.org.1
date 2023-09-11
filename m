Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67979A79B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:27:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qff4d-0000og-SR; Mon, 11 Sep 2023 07:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qff4c-0000lv-46
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qff4Z-0007S1-5j
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694431638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DECap47/OC5AQKOT0cOi5siluVjihmC7MKGn67a6xM=;
 b=dYSwdgEF7k5eygANpGBdBDovzqEz/qTTEikjaEjhfmVy6L6/siGFM0eFelUwLxv/QU4hZn
 RHYjb0xseEZiGvirYBxozUJvu91jiqa5NW1X2Bun2rn4i5Yj6MmPjpU7wwnFliJ1IndO9S
 N8oQIp0euUvr7rgKO5pGMWnYufWNtvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-Qb6g9rnzOr2uYUfZ6_yI2Q-1; Mon, 11 Sep 2023 07:27:17 -0400
X-MC-Unique: Qb6g9rnzOr2uYUfZ6_yI2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD0D2816555
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 11:27:16 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.225.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 046832027046
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 11:27:15 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/11] qapi: scripts: add a generator for qapi's examples
Date: Mon, 11 Sep 2023 13:27:13 +0200
Message-ID: <20230911112713.78008-2-victortoso@redhat.com>
In-Reply-To: <20230911112713.78008-1-victortoso@redhat.com>
References: <20230911104017.65397-1-victortoso@redhat.com>
 <20230911112713.78008-1-victortoso@redhat.com>
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

This generator has two goals:
 1. Mechanical validation of QAPI examples
 2. Generate the examples in a JSON format to be consumed for extra
    validation.

The generator iterates over every Example section, parsing both server
and client messages. The generator prints any inconsistency found, for
example:

 |  Error: Extra data: line 1 column 39 (char 38)
 |  Location: cancel-vcpu-dirty-limit at qapi/migration.json:2017
 |  Data: {"execute": "cancel-vcpu-dirty-limit"},
 |      "arguments": { "cpu-index": 1 } }

The generator will output other JSON file with all the examples in the
QAPI module that they came from. This can be used to validate the
introspection between QAPI/QMP to language bindings, for example:

 | { "examples": [
 |   {
 |     "id": "ksuxwzfayw",
 |     "client": [
 |     {
 |       "sequence-order": 1
 |       "message-type": "command",
 |       "message":
 |       { "arguments":
 |         { "device": "scratch", "size": 1073741824 },
 |         "execute": "block_resize"
 |       },
 |    } ],
 |    "server": [
 |    {
 |      "sequence-order": 2
 |      "message-type": "return",
 |      "message": { "return": {} },
 |    } ]
 |    }
 |  ] }

Note that the order matters, as read by the Example section and
translated into "sequence-order". A language binding project can then
consume this files to Marshal and Unmarshal, comparing if the results
are what is to be expected.

RFC discussion:
    https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg04641.html

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/dumpexamples.py | 204 +++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py         |   5 +-
 2 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 scripts/qapi/dumpexamples.py

diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
new file mode 100644
index 0000000000..5a1c275bc8
--- /dev/null
+++ b/scripts/qapi/dumpexamples.py
@@ -0,0 +1,204 @@
+"""
+Dump examples for Developers
+"""
+# Copyright (c) 2023 Red Hat Inc.
+#
+# Authors:
+#  Victor Toso <victortoso@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+# Just for type hint on self
+from __future__ import annotations
+
+import os
+import json
+import random
+import string
+
+from typing import Dict, List, Optional
+
+from .schema import (
+    QAPISchema,
+    QAPISchemaType,
+    QAPISchemaVisitor,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaVariants,
+)
+from .source import QAPISourceInfo
+
+
+def gen_examples(schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str) -> None:
+    vis = QAPISchemaGenExamplesVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
+
+
+def get_id(random, size: int) -> str:
+    letters = string.ascii_lowercase
+    return ''.join(random.choice(letters) for i in range(size))
+
+
+def next_object(text, start, end, context) -> (Dict, bool):
+    # Start of json object
+    start = text.find("{", start)
+    end = text.rfind("}", start, end+1)
+
+    # try catch, pretty print issues
+    try:
+        ret = json.loads(text[start:end+1])
+    except Exception as e:
+        print("Error: {}\nLocation: {}\nData: {}\n".format(
+              str(e), context, text[start:end+1]))
+        return {}, True
+    else:
+        return ret, False
+
+
+def parse_text_to_dicts(text: str, context: str) -> (List[Dict], bool):
+    examples, clients, servers = [], [], []
+    failed = False
+
+    count = 1
+    c, s = text.find("->"), text.find("<-")
+    while c != -1 or s != -1:
+        if c == -1 or (s != -1 and s < c):
+            start, target = s, servers
+        else:
+            start, target = c, clients
+
+        # Find the client and server, if any
+        if c != -1:
+            c = text.find("->", start + 1)
+        if s != -1:
+            s = text.find("<-", start + 1)
+
+        # Find the limit of current's object.
+        # We first look for the next message, either client or server. If none
+        # is avaible, we set the end of the text as limit.
+        if c == -1 and s != -1:
+            end = s
+        elif c != -1 and s == -1:
+            end = c
+        elif c != -1 and s != -1:
+            end = (c < s) and c or s
+        else:
+            end = len(text) - 1
+
+        message, error = next_object(text, start, end, context)
+        if error:
+            failed = True
+
+        if len(message) > 0:
+            message_type = "return"
+            if "execute" in message:
+                message_type = "command"
+            elif "event" in message:
+                message_type = "event"
+
+            target.append({
+                "sequence-order": count,
+                "message-type": message_type,
+                "message": message
+            })
+            count += 1
+
+    examples.append({"client": clients, "server": servers})
+    return examples, failed
+
+
+def parse_examples_of(self: QAPISchemaGenExamplesVisitor,
+                      name: str):
+
+    assert(name in self.schema._entity_dict)
+    obj = self.schema._entity_dict[name]
+    assert((obj.doc is not None))
+    module_name = obj._module.name
+
+    # We initialize random with the name so that we get consistent example
+    # ids over different generations. The ids of a given example might
+    # change when adding/removing examples, but that's acceptable as the
+    # goal is just to grep $id to find what example failed at a given test
+    # with minimum chorn over regenerating.
+    random.seed(name, version=2)
+
+    for s in obj.doc.sections:
+        if s.name != "Example":
+            continue
+
+        if module_name not in self.target:
+            self.target[module_name] = []
+
+        context = f'''{name} at {obj.info.fname}:{obj.info.line}'''
+        examples, failed = parse_text_to_dicts(s.text, context)
+        if failed:
+            # To warn user that docs needs fixing
+            self.failed = True
+
+        for example in examples:
+            self.target[module_name].append({
+                    "id": get_id(random, 10),
+                    "client": example["client"],
+                    "server": example["server"]
+            })
+
+
+class QAPISchemaGenExamplesVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix: str):
+        super().__init__()
+        self.target = {}
+        self.schema = None
+        self.failed = False
+
+    def visit_begin(self, schema):
+        self.schema = schema
+
+    def visit_end(self):
+        self.schema = None
+        assert not self.failed, "Should fix the docs"
+
+    def write(self: QAPISchemaGenExamplesVisitor,
+              output_dir: str) -> None:
+        for filename, content in self.target.items():
+            pathname = os.path.join(output_dir, "examples", filename)
+            odir = os.path.dirname(pathname)
+            os.makedirs(odir, exist_ok=True)
+            result = {"examples": content}
+
+            with open(pathname, "w") as outfile:
+                outfile.write(json.dumps(result, indent=2, sort_keys=True))
+
+    def visit_command(self: QAPISchemaGenExamplesVisitor,
+                      name: str,
+                      info: Optional[QAPISourceInfo],
+                      ifcond: QAPISchemaIfCond,
+                      features: List[QAPISchemaFeature],
+                      arg_type: Optional[QAPISchemaObjectType],
+                      ret_type: Optional[QAPISchemaType],
+                      gen: bool,
+                      success_response: bool,
+                      boxed: bool,
+                      allow_oob: bool,
+                      allow_preconfig: bool,
+                      coroutine: bool) -> None:
+
+        if gen:
+            parse_examples_of(self, name)
+
+    def visit_event(self: QAPISchemaGenExamplesVisitor,
+                    name: str,
+                    info: Optional[QAPISourceInfo],
+                    ifcond: QAPISchemaIfCond,
+                    features: List[QAPISchemaFeature],
+                    arg_type: Optional[QAPISchemaObjectType],
+                    boxed: bool):
+
+        parse_examples_of(self, name)
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 7efdcc6b8d..9d71d78b55 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -13,6 +13,7 @@
 
 from .commands import gen_commands
 from .common import must_match
+from .dumpexamples import gen_examples
 from .error import QAPIError
 from .events import gen_events
 from .introspect import gen_introspect
@@ -54,7 +55,9 @@ def generate(schema_file: str,
     gen_commands(schema, output_dir, prefix, gen_tracing)
     gen_events(schema, output_dir, prefix)
     gen_introspect(schema, output_dir, prefix, unmask)
-
+    
+    if not test_schema:
+        gen_examples(schema, output_dir, prefix)
 
 def main() -> int:
     """
-- 
2.41.0


