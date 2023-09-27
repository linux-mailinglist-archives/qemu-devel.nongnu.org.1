Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 821FC7B02E0
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSg7-0002PE-JP; Wed, 27 Sep 2023 07:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSfy-0002Od-BO
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSfw-0001Yv-D0
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695813950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00JI1RwlBBmXYEiPlKOJV34H262RZWf9bT/B+xvDdOk=;
 b=L2eDBakVUL2TjnwooN+Eg/3rFJ1b9kjvUPA+b6n04n0uNlq7ldkO4a6Ef4mr1xihchj3El
 r/6Rccmb24GMXgf8i8xG1p2902krtjKy0X0RLWnRc9sk+YVpsxaOcmZmWVQl6dpOMND77Z
 XJFq8SJrcSshn+bwga+iB7SA3JWWoPM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-FK9fyarUOV-QclxpqbwM1w-1; Wed, 27 Sep 2023 07:25:48 -0400
X-MC-Unique: FK9fyarUOV-QclxpqbwM1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4816C8039CF
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:25:48 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3305F1054FC2;
 Wed, 27 Sep 2023 11:25:47 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v1 1/9] qapi: golang: Generate qapi's enum types in Go
Date: Wed, 27 Sep 2023 13:25:36 +0200
Message-ID: <20230927112544.85011-2-victortoso@redhat.com>
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

This patch handles QAPI enum types and generates its equivalent in Go.

Basically, Enums are being handled as strings in Golang.

1. For each QAPI enum, we will define a string type in Go to be the
   assigned type of this specific enum.

2. Naming: CamelCase will be used in any identifier that we want to
   export [0], which is everything.

[0] https://go.dev/ref/spec#Exported_identifiers

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
 scripts/qapi/golang.py | 140 +++++++++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py   |   2 +
 2 files changed, 142 insertions(+)
 create mode 100644 scripts/qapi/golang.py

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
new file mode 100644
index 0000000000..87081cdd05
--- /dev/null
+++ b/scripts/qapi/golang.py
@@ -0,0 +1,140 @@
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
+# due QAPISchemaVisitor interface
+# pylint: disable=too-many-arguments
+
+# Just for type hint on self
+from __future__ import annotations
+
+import os
+from typing import List, Optional
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
+TEMPLATE_ENUM = '''
+type {name} string
+const (
+{fields}
+)
+'''
+
+
+def gen_golang(schema: QAPISchema,
+               output_dir: str,
+               prefix: str) -> None:
+    vis = QAPISchemaGenGolangVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
+
+
+def qapi_to_field_name_enum(name: str) -> str:
+    return name.title().replace("-", "")
+
+
+class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
+
+    def __init__(self, _: str):
+        super().__init__()
+        types = ["enum"]
+        self.target = {name: "" for name in types}
+        self.schema = None
+        self.golang_package_name = "qapi"
+
+    def visit_begin(self, schema):
+        self.schema = schema
+
+        # Every Go file needs to reference its package name
+        for target in self.target:
+            self.target[target] = f"package {self.golang_package_name}\n"
+
+    def visit_end(self):
+        self.schema = None
+
+    def visit_object_type(self: QAPISchemaGenGolangVisitor,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: QAPISchemaIfCond,
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          variants: Optional[QAPISchemaVariants]
+                          ) -> None:
+        pass
+
+    def visit_alternate_type(self: QAPISchemaGenGolangVisitor,
+                             name: str,
+                             info: Optional[QAPISourceInfo],
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             variants: QAPISchemaVariants
+                             ) -> None:
+        pass
+
+    def visit_enum_type(self: QAPISchemaGenGolangVisitor,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: QAPISchemaIfCond,
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]
+                        ) -> None:
+
+        value = qapi_to_field_name_enum(members[0].name)
+        fields = ""
+        for member in members:
+            value = qapi_to_field_name_enum(member.name)
+            fields += f'''\t{name}{value} {name} = "{member.name}"\n'''
+
+        self.target["enum"] += TEMPLATE_ENUM.format(name=name, fields=fields[:-1])
+
+    def visit_array_type(self, name, info, ifcond, element_type):
+        pass
+
+    def visit_command(self,
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
+        pass
+
+    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
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
+            with open(pathname, "w", encoding="ascii") as outfile:
+                outfile.write(content)
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 316736b6a2..cdbb3690fd 100644
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
@@ -54,6 +55,7 @@ def generate(schema_file: str,
     gen_events(schema, output_dir, prefix)
     gen_introspect(schema, output_dir, prefix, unmask)
 
+    gen_golang(schema, output_dir, prefix)
 
 def main() -> int:
     """
-- 
2.41.0


