Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2398BCC9E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 May 2024 13:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7p-00034M-Qe; Mon, 06 May 2024 07:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7h-0002p1-8A
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7a-0003ff-0G
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8RSpZZLrRS8WOQQUR42C1CPkY6YivCRHFnCrRmGr9E=;
 b=DiHgB3oYDhGmADNBtiCB2sh4KRtpDR2YYUQKE9jd9h4UC8t3zILNLFPBmtmx8cUG5VBVQl
 uAfPSDBeQ3LMFfhk2PazE/akahcP7i5sPABKhk0VL4wBD5PjtLZqK3It4QE+I8JUmP1Uks
 KBAOoJTImp6gHpYlJOmF7buooDYEdy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ogNOqIK0OZuLcqG4sVsRLQ-1; Mon, 06 May 2024 07:02:56 -0400
X-MC-Unique: ogNOqIK0OZuLcqG4sVsRLQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96B0718065AE;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5864CEC683;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A80021E5D29; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 4/7] qapi: Rename QAPISchemaObjectType.variants to .branches
Date: Mon,  6 May 2024 13:02:47 +0200
Message-ID: <20240506110254.3965097-8-armbru@redhat.com>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
References: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

A previous commit narrowed the type of QAPISchemaObjectType.variants
from QAPISchemaVariants to QAPISchemaBranches.  Rename it to
.branches.

Same for .__init__() parameter @variants.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/commands.py |  2 +-
 scripts/qapi/events.py   |  2 +-
 scripts/qapi/gen.py      |  2 +-
 scripts/qapi/schema.py   | 36 ++++++++++++++++++------------------
 scripts/qapi/types.py    |  2 +-
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index d1fdf4182c..79951a841f 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -64,7 +64,7 @@ def gen_call(name: str,
         assert arg_type
         argstr = '&arg, '
     elif arg_type:
-        assert not arg_type.variants
+        assert not arg_type.branches
         for memb in arg_type.members:
             assert not memb.ifcond.is_present()
             if memb.need_has():
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 3cf01e96b6..d1f639981a 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -51,7 +51,7 @@ def gen_param_var(typ: QAPISchemaObjectType) -> str:
 
     Initialize it with the function arguments defined in `gen_event_send`.
     """
-    assert not typ.variants
+    assert not typ.branches
     ret = mcgen('''
     %(c_name)s param = {
 ''',
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 5412716617..6a8abe0041 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -118,7 +118,7 @@ def build_params(arg_type: Optional[QAPISchemaObjectType],
         ret += '%s arg' % arg_type.c_param_type()
         sep = ', '
     elif arg_type:
-        assert not arg_type.variants
+        assert not arg_type.branches
         for memb in arg_type.members:
             assert not memb.ifcond.is_present()
             ret += sep
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 2b67992aee..c9ff794d0c 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -524,20 +524,20 @@ def __init__(
         features: Optional[List[QAPISchemaFeature]],
         base: Optional[str],
         local_members: List[QAPISchemaObjectTypeMember],
-        variants: Optional[QAPISchemaBranches],
+        branches: Optional[QAPISchemaBranches],
     ):
-        # struct has local_members, optional base, and no variants
-        # union has base, variants, and no local_members
+        # struct has local_members, optional base, and no branches
+        # union has base, branches, and no local_members
         super().__init__(name, info, doc, ifcond, features)
-        self.meta = 'union' if variants else 'struct'
+        self.meta = 'union' if branches else 'struct'
         for m in local_members:
             m.set_defined_in(name)
-        if variants is not None:
-            variants.set_defined_in(name)
+        if branches is not None:
+            branches.set_defined_in(name)
         self._base_name = base
         self.base = None
         self.local_members = local_members
-        self.variants = variants
+        self.branches = branches
         self.members: List[QAPISchemaObjectTypeMember]
         self._check_complete = False
 
@@ -561,7 +561,7 @@ def check(self, schema: QAPISchema) -> None:
             self.base = schema.resolve_type(self._base_name, self.info,
                                             "'base'")
             if (not isinstance(self.base, QAPISchemaObjectType)
-                    or self.base.variants):
+                    or self.base.branches):
                 raise QAPISemError(
                     self.info,
                     "'base' requires a struct type, %s isn't"
@@ -577,9 +577,9 @@ def check(self, schema: QAPISchema) -> None:
         # Cast down to the subtype.
         members = cast(List[QAPISchemaObjectTypeMember], list(seen.values()))
 
-        if self.variants:
-            self.variants.check(schema, seen)
-            self.variants.check_clash(self.info, seen)
+        if self.branches:
+            self.branches.check(schema, seen)
+            self.branches.check_clash(self.info, seen)
 
         self.members = members
         self._check_complete = True  # mark completed
@@ -595,8 +595,8 @@ def check_clash(
         assert self._checked
         for m in self.members:
             m.check_clash(info, seen)
-        if self.variants:
-            self.variants.check_clash(info, seen)
+        if self.branches:
+            self.branches.check_clash(info, seen)
 
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
@@ -612,7 +612,7 @@ def is_implicit(self) -> bool:
         return self.name.startswith('q_')
 
     def is_empty(self) -> bool:
-        return not self.members and not self.variants
+        return not self.members and not self.branches
 
     def has_conditional_members(self) -> bool:
         return any(m.ifcond.is_present() for m in self.members)
@@ -635,10 +635,10 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_object_type(
             self.name, self.info, self.ifcond, self.features,
-            self.base, self.local_members, self.variants)
+            self.base, self.local_members, self.branches)
         visitor.visit_object_type_flat(
             self.name, self.info, self.ifcond, self.features,
-            self.members, self.variants)
+            self.members, self.branches)
 
 
 class QAPISchemaAlternateType(QAPISchemaType):
@@ -1035,7 +1035,7 @@ def check(self, schema: QAPISchema) -> None:
                     "command's 'data' cannot take %s"
                     % arg_type.describe())
             self.arg_type = arg_type
-            if self.arg_type.variants and not self.boxed:
+            if self.arg_type.branches and not self.boxed:
                 raise QAPISemError(
                     self.info,
                     "command's 'data' can take %s only with 'boxed': true"
@@ -1103,7 +1103,7 @@ def check(self, schema: QAPISchema) -> None:
                     "event's 'data' cannot take %s"
                     % typ.describe())
             self.arg_type = typ
-            if self.arg_type.variants and not self.boxed:
+            if self.arg_type.branches and not self.boxed:
                 raise QAPISemError(
                     self.info,
                     "event's 'data' can take %s only with 'boxed': true"
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 69f5f6ffd0..0dd0b00ada 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -171,7 +171,7 @@ def gen_object(name: str, ifcond: QAPISchemaIfCond,
         if not isinstance(obj, QAPISchemaObjectType):
             continue
         ret += gen_object(obj.name, obj.ifcond, obj.base,
-                          obj.local_members, obj.variants)
+                          obj.local_members, obj.branches)
 
     ret += mcgen('''
 
-- 
2.44.0


