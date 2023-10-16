Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C17CAD81
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:28:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPV5-0001Pb-RJ; Mon, 16 Oct 2023 11:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV4-0001P5-0m
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qsPV2-0003Nw-7P
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697470039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OS9AUxYYgnBbAzSPXkQ8K0I3OKG8OP9x7Ue/6OtBTOM=;
 b=SyQc6fNTtzFgEe/UkSO33V4DUuaLkee7fHnjRVgHz+4WU8yyfu+NGR6xDpyxnpJycUCq3/
 BWSn+CkEABetHVXvWW2Q5Fc2uZOi1zP3c05cE1RH+MsguH5IV4+mryF+cnMjplx7u6jnvC
 6d8MC9BcgiU48l4dtMnl1LIAheCTgwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-zlR6ONJGMrSHkzx19ZOqmQ-1; Mon, 16 Oct 2023 11:27:12 -0400
X-MC-Unique: zlR6ONJGMrSHkzx19ZOqmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7858610264C1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 15:27:12 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 169452022780;
 Mon, 16 Oct 2023 15:27:10 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v2 03/11] qapi: golang: Generate qapi's enum types in Go
Date: Mon, 16 Oct 2023 17:26:56 +0200
Message-ID: <20231016152704.221611-4-victortoso@redhat.com>
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

This patch handles QAPI enum types and generates its equivalent in Go.
We sort the output based on enum's type name.

Enums are being handled as strings in Golang.

1. For each QAPI enum, we will define a string type in Go to be the
   assigned type of this specific enum.

2. Naming: CamelCase will be used in any identifier that we want to
   export, which is everything.

Example:

qapi:
  | { 'enum': 'DisplayProtocol',
  |   'data': [ 'vnc', 'spice' ] }

go:
  | type DisplayProtocol string
  |
  | const (
  |     DisplayProtocolVnc   DisplayProtocol = "vnc"
  |     DisplayProtocolSpice DisplayProtocol = "spice"
  | )

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 173 +++++++++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py   |   3 +
 2 files changed, 176 insertions(+)
 create mode 100644 scripts/qapi/golang.py

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
new file mode 100644
index 0000000000..dc12be7b03
--- /dev/null
+++ b/scripts/qapi/golang.py
@@ -0,0 +1,173 @@
+"""
+Golang QAPI generator
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
+from typing import List, Optional
+
+from .schema import (
+    QAPISchema,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
+    QAPISchemaVisitor,
+)
+from .source import QAPISourceInfo
+
+
+TEMPLATE_ENUM = """
+type {name} string
+
+const (
+{fields}
+)
+"""
+
+
+def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
+    vis = QAPISchemaGenGolangVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
+
+
+def qapi_to_field_name_enum(name: str) -> str:
+    return name.title().replace("-", "")
+
+
+def generate_content_from_dict(data: dict[str, str]) -> str:
+    content = ""
+
+    for name in sorted(data):
+        content += data[name]
+
+    return content
+
+
+class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
+    # pylint: disable=too-many-arguments
+    def __init__(self, _: str):
+        super().__init__()
+        types = ("enum",)
+        self.target = dict.fromkeys(types, "")
+        self.schema: QAPISchema
+        self.golang_package_name = "qapi"
+        self.enums: dict[str, str] = {}
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        self.schema = schema
+
+        # Every Go file needs to reference its package name
+        for target in self.target:
+            self.target[target] = f"package {self.golang_package_name}\n"
+
+    def visit_end(self) -> None:
+        del self.schema
+        self.target["enum"] += generate_content_from_dict(self.enums)
+
+    def visit_object_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        base: Optional[QAPISchemaObjectType],
+        members: List[QAPISchemaObjectTypeMember],
+        variants: Optional[QAPISchemaVariants],
+    ) -> None:
+        pass
+
+    def visit_alternate_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        variants: QAPISchemaVariants,
+    ) -> None:
+        pass
+
+    def visit_enum_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        members: List[QAPISchemaEnumMember],
+        prefix: Optional[str],
+    ) -> None:
+        assert name not in self.enums
+
+        maxname = 0
+        for member in members:
+            enum_name = f"{name}{qapi_to_field_name_enum(member.name)}"
+            maxname = max(maxname, len(enum_name))
+
+        fields = ""
+        for member in members:
+            enum_name = f"{name}{qapi_to_field_name_enum(member.name)}"
+            name2type = " " * (maxname - len(enum_name) + 1)
+            fields += f"""\t{enum_name}{name2type}{name} = "{member.name}"\n"""
+
+        self.enums[name] = TEMPLATE_ENUM.format(name=name, fields=fields[:-1])
+
+    def visit_array_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        element_type: QAPISchemaType,
+    ) -> None:
+        pass
+
+    def visit_command(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[QAPISchemaObjectType],
+        ret_type: Optional[QAPISchemaType],
+        gen: bool,
+        success_response: bool,
+        boxed: bool,
+        allow_oob: bool,
+        allow_preconfig: bool,
+        coroutine: bool,
+    ) -> None:
+        pass
+
+    def visit_event(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[QAPISchemaObjectType],
+        boxed: bool,
+    ) -> None:
+        pass
+
+    def write(self, output_dir: str) -> None:
+        for module_name, content in self.target.items():
+            go_module = module_name + "s.go"
+            go_dir = "go"
+            pathname = os.path.join(output_dir, go_dir, go_module)
+            odir = os.path.dirname(pathname)
+            os.makedirs(odir, exist_ok=True)
+
+            with open(pathname, "w", encoding="utf8") as outfile:
+                outfile.write(content)
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index fe65c1a17a..07c29bcbe9 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -15,6 +15,7 @@
 from .common import must_match
 from .error import QAPIError
 from .events import gen_events
+from .golang import gen_golang
 from .introspect import gen_introspect
 from .schema import QAPISchema
 from .types import gen_types
@@ -56,6 +57,8 @@ def generate(
     gen_events(schema, output_dir, prefix)
     gen_introspect(schema, output_dir, prefix, unmask)
 
+    gen_golang(schema, output_dir, prefix)
+
 
 def main() -> int:
     """
-- 
2.41.0


