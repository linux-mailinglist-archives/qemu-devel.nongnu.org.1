Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF049EE4C3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 12:07:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLh1n-0008Pt-NF; Thu, 12 Dec 2024 06:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLh1l-0008Pd-0E
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:06:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLh1i-0003JC-N4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734001598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/bwMY6Mn/smQQOpvu3RHneR0VzkgUccGHWcP9erI/I=;
 b=JS8xtf8pCirlK3qK8oBf/1Jg2uFyJ21dpU+Bt2rEOCPHWqqXETx7zC3R96QFvfcBqprNpa
 XRW1bcwOKtvibhrwBPJ93LZZCcVLMXtxQ4y3ovLzxhYXDbRO+O+yPPeo0RcFQ7jehe3HlT
 PvmufeknXcDSmZaoVrLnVOIQ/evxuPU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-0WIJpf0jN_eq-N0gQOhJuA-1; Thu,
 12 Dec 2024 06:06:36 -0500
X-MC-Unique: 0WIJpf0jN_eq-N0gQOhJuA-1
X-Mimecast-MFC-AGG-ID: 0WIJpf0jN_eq-N0gQOhJuA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D73E619560AB; Thu, 12 Dec 2024 11:06:35 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.114])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E73E1956086; Thu, 12 Dec 2024 11:06:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 4/4] qapi: expose all schema features to code
Date: Thu, 12 Dec 2024 11:06:16 +0000
Message-ID: <20241212110616.3147676-5-berrange@redhat.com>
In-Reply-To: <20241212110616.3147676-1-berrange@redhat.com>
References: <20241212110616.3147676-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This replaces use of the constants from the QapiSpecialFeatures
enum, with constants from the auto-generate QapiFeatures enum
in qapi-features.h

The 'deprecated' and 'unstable' features still have a little bit of
special handling, being force defined to be the 1st + 2nd features
in the enum, regardless of whether they're used in the schema. This
retains compatibility with common code that references the features
via the QapiSpecialFeatures constants.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build                              |  1 +
 scripts/qapi/commands.py                 |  1 +
 scripts/qapi/features.py                 | 51 ++++++++++++++++++++++++
 scripts/qapi/gen.py                      |  6 +--
 scripts/qapi/main.py                     |  2 +
 scripts/qapi/schema.py                   | 30 +++++++++++++-
 scripts/qapi/types.py                    |  7 +++-
 scripts/qapi/visit.py                    |  3 +-
 tests/meson.build                        |  2 +
 tests/qapi-schema/features-too-many.err  |  2 +
 tests/qapi-schema/features-too-many.json | 13 ++++++
 tests/qapi-schema/features-too-many.out  |  0
 tests/qapi-schema/meson.build            |  1 +
 13 files changed, 112 insertions(+), 7 deletions(-)
 create mode 100644 scripts/qapi/features.py
 create mode 100644 tests/qapi-schema/features-too-many.err
 create mode 100644 tests/qapi-schema/features-too-many.json
 create mode 100644 tests/qapi-schema/features-too-many.out

diff --git a/meson.build b/meson.build
index 147097c652..3815878b23 100644
--- a/meson.build
+++ b/meson.build
@@ -3444,6 +3444,7 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
+                     meson.current_source_dir() / 'scripts/qapi/features.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
 ]
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index d629d2d97e..bf88bfc442 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -355,6 +355,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-commands.h"
 #include "%(prefix)sqapi-init-commands.h"
+#include "%(prefix)sqapi-features.h"
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 {
diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
new file mode 100644
index 0000000000..f32f9fe5f4
--- /dev/null
+++ b/scripts/qapi/features.py
@@ -0,0 +1,51 @@
+"""
+QAPI features generator
+
+Copyright 2024 Red Hat
+
+This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+
+from typing import Dict
+
+from .common import c_enum_const, c_name
+from .gen import QAPISchemaMonolithicCVisitor
+from .schema import (
+    QAPISchema,
+    QAPISchemaFeature,
+)
+
+
+class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
+
+    def __init__(self, prefix: str):
+        super().__init__(
+            prefix, 'qapi-features',
+            ' * Schema-defined QAPI features',
+            __doc__)
+
+        self.features: Dict[str, QAPISchemaFeature] = {}
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        self.features = schema.features()
+        self._genh.add("#include \"qapi/util.h\"\n\n")
+
+    def visit_end(self) -> None:
+        self._genh.add("typedef enum {\n")
+        for f in self.features:
+            self._genh.add(f"    {c_enum_const('qapi_feature', f.name)}")
+            if f.name in QAPISchemaFeature.SPECIAL_NAMES:
+                self._genh.add(f" = {c_enum_const('qapi', f.name)},\n")
+            else:
+                self._genh.add(",\n")
+
+        self._genh.add("} " + c_name('QapiFeature') + ";\n")
+
+
+def gen_features(schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str) -> None:
+    vis = QAPISchemaGenFeatureVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index b51f8d955e..d3c56d45c8 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -42,9 +42,9 @@
 
 
 def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
-    featenum = [f"1u << {c_enum_const('qapi', feat.name)}"
-                for feat in features if feat.is_special()]
-    return ' | '.join(featenum) or '0'
+    feats = [f"1u << {c_enum_const('qapi_feature', feat.name)}"
+             for feat in features]
+    return ' | '.join(feats) or '0'
 
 
 class QAPIGen:
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 316736b6a2..2b9a2c0c02 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -18,6 +18,7 @@
 from .introspect import gen_introspect
 from .schema import QAPISchema
 from .types import gen_types
+from .features import gen_features
 from .visit import gen_visit
 
 
@@ -49,6 +50,7 @@ def generate(schema_file: str,
 
     schema = QAPISchema(schema_file)
     gen_types(schema, output_dir, prefix, builtins)
+    gen_features(schema, output_dir, prefix)
     gen_visit(schema, output_dir, prefix, builtins)
     gen_commands(schema, output_dir, prefix, gen_tracing)
     gen_events(schema, output_dir, prefix)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e97c978d38..39c91af245 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -933,8 +933,11 @@ def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
 class QAPISchemaFeature(QAPISchemaMember):
     role = 'feature'
 
+    # Features which are standardized across all schemas
+    SPECIAL_NAMES = ['deprecated', 'unstable']
+
     def is_special(self) -> bool:
-        return self.name in ('deprecated', 'unstable')
+        return self.name in QAPISchemaFeature.SPECIAL_NAMES
 
 
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
@@ -1138,6 +1141,16 @@ def __init__(self, fname: str):
         self._entity_list: List[QAPISchemaEntity] = []
         self._entity_dict: Dict[str, QAPISchemaDefinition] = {}
         self._module_dict: Dict[str, QAPISchemaModule] = OrderedDict()
+        # NB, values in the dict will identify the first encountered
+        #     usage of a named feature only
+        self._feature_dict: Dict[str, QAPISchemaFeature] = OrderedDict()
+
+        # All schemas get the names defined in the QapiSpecialFeature enum.
+        # Use of OrderedDict ensures they are emitted first when generating
+        # the enum definition, thus matching QapiSpecialFeature.
+        for f in QAPISchemaFeature.SPECIAL_NAMES:
+            self._feature_dict[f] = QAPISchemaFeature(f, None)
+
         self._schema_dir = os.path.dirname(fname)
         self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
         self._make_module(fname)
@@ -1147,6 +1160,9 @@ def __init__(self, fname: str):
         self._def_exprs(exprs)
         self.check()
 
+    def features(self) -> List[QAPISchemaFeature]:
+        return self._feature_dict.values()
+
     def _def_entity(self, ent: QAPISchemaEntity) -> None:
         self._entity_list.append(ent)
 
@@ -1258,6 +1274,12 @@ def _make_features(
     ) -> List[QAPISchemaFeature]:
         if features is None:
             return []
+
+        for f in features:
+            feat = QAPISchemaFeature(f['name'], info)
+            if feat.name not in self._feature_dict:
+                self._feature_dict[feat.name] = feat
+
         return [QAPISchemaFeature(f['name'], info,
                                   QAPISchemaIfCond(f.get('if')))
                 for f in features]
@@ -1485,6 +1507,12 @@ def check(self) -> None:
         for doc in self.docs:
             doc.check()
 
+        features = list(self._feature_dict.values())
+        if len(features) > 64:
+            raise QAPISemError(
+                features[64].info,
+                "Maximum of 64 schema features is permitted")
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_begin(self)
         for mod in self._module_dict.values():
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index ade6b7a3d7..5294e5ea3b 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -308,11 +308,14 @@ def _begin_user_module(self, name: str) -> None:
 #include "qapi/dealloc-visitor.h"
 #include "%(types)s.h"
 #include "%(visit)s.h"
+#include "%(prefix)sqapi-features.h"
 ''',
-                                      types=types, visit=visit))
+                                      types=types, visit=visit,
+                                      prefix=self._prefix))
         self._genh.preamble_add(mcgen('''
 #include "qapi/qapi-builtin-types.h"
-'''))
+''',
+                                      prefix=self._prefix))
 
     def visit_begin(self, schema: QAPISchema) -> None:
         # gen_object() is recursive, ensure it doesn't visit the empty type
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 8dbf4ef1c3..2d678c281d 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -360,8 +360,9 @@ def _begin_user_module(self, name: str) -> None:
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "%(visit)s.h"
+#include "%(prefix)sqapi-features.h"
 ''',
-                                      visit=visit))
+                                      visit=visit, prefix=self._prefix))
         self._genh.preamble_add(mcgen('''
 #include "qapi/qapi-builtin-visit.h"
 #include "%(types)s.h"
diff --git a/tests/meson.build b/tests/meson.build
index 907a4c1c98..a4ede66d0d 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -16,6 +16,8 @@ test_qapi_outputs = [
   'test-qapi-events-sub-sub-module.h',
   'test-qapi-events.c',
   'test-qapi-events.h',
+  'test-qapi-features.c',
+  'test-qapi-features.h',
   'test-qapi-init-commands.c',
   'test-qapi-init-commands.h',
   'test-qapi-introspect.c',
diff --git a/tests/qapi-schema/features-too-many.err b/tests/qapi-schema/features-too-many.err
new file mode 100644
index 0000000000..bbbd6e5202
--- /dev/null
+++ b/tests/qapi-schema/features-too-many.err
@@ -0,0 +1,2 @@
+features-too-many.json: In command 'go-fish':
+features-too-many.json:2: Maximum of 64 schema features is permitted
diff --git a/tests/qapi-schema/features-too-many.json b/tests/qapi-schema/features-too-many.json
new file mode 100644
index 0000000000..aab0a0b5f1
--- /dev/null
+++ b/tests/qapi-schema/features-too-many.json
@@ -0,0 +1,13 @@
+# Max 64 features, with 2 specials, so 63rd custom is invalid
+{ 'command': 'go-fish',
+  'features': [
+      'f00', 'f01', 'f02', 'f03', 'f04', 'f05', 'f06', 'f07',
+      'f08', 'f09', 'f0a', 'f0b', 'f0c', 'f0d', 'f0e', 'f0f',
+      'f10', 'f11', 'f12', 'f13', 'f14', 'f15', 'f16', 'f17',
+      'f18', 'f19', 'f1a', 'f1b', 'f1c', 'f1d', 'f1e', 'f1f',
+      'f20', 'f21', 'f22', 'f23', 'f24', 'f25', 'f26', 'f27',
+      'f28', 'f29', 'f2a', 'f2b', 'f2c', 'f2d', 'f2e', 'f2f',
+      'f30', 'f31', 'f32', 'f33', 'f34', 'f35', 'f36', 'f37',
+      'f38', 'f39', 'f3a', 'f3b', 'f3c', 'f3d', 'f3e'
+  ]
+}
diff --git a/tests/qapi-schema/features-too-many.out b/tests/qapi-schema/features-too-many.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 0f479d9317..9577178b6f 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -105,6 +105,7 @@ schemas = [
   'event-case.json',
   'event-member-invalid-dict.json',
   'event-nest-struct.json',
+  'features-too-many.json',
   'features-bad-type.json',
   'features-deprecated-type.json',
   'features-duplicate-name.json',
-- 
2.46.0


