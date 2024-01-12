Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E34FF82C741
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:31:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQ2j-0006CK-7r; Fri, 12 Jan 2024 17:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2P-0005pp-Gu
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2J-00063F-I0
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705098598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fgi5fW6fhsdEJueh5NdVJ1BXW3ext3pLY93BajstAWA=;
 b=K7GopWbJV2EEi1uVhRD4QDLzy3HTnDJqeTeRqhitzZc7SBHW2cFunB87ndrKVbtC2kYny/
 YJDTcf42mJk83yLOfdzmOUMzRYFtgoAfnbvfTYSpk1J0lqadVE3OmX7tch2fTJv3UOr7yU
 FHh64j1e8Yq0+fsKHZAWRSealoErSF4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-knS6JtjpO5-eqaXqB4h0Iw-1; Fri, 12 Jan 2024 17:29:47 -0500
X-MC-Unique: knS6JtjpO5-eqaXqB4h0Iw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80B241025874;
 Fri, 12 Jan 2024 22:29:47 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.17.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B6A0C25AC8;
 Fri, 12 Jan 2024 22:29:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 03/19] qapi: create QAPISchemaDefinition
Date: Fri, 12 Jan 2024 17:29:29 -0500
Message-ID: <20240112222945.3033854-4-jsnow@redhat.com>
In-Reply-To: <20240112222945.3033854-1-jsnow@redhat.com>
References: <20240112222945.3033854-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Include entities don't have names, but we generally expect "entities" to
have names. Reclassify all entities with names as *definitions*, leaving
the nameless include entities as QAPISchemaEntity instances.

This is primarily to help simplify typing around expectations of what
callers expect for properties of an "entity".

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 117 ++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 47 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index b7830672e57..e39ed972a80 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -55,14 +55,14 @@ def is_present(self):
 
 
 class QAPISchemaEntity:
-    meta: Optional[str] = None
+    """
+    QAPISchemaEntity represents all schema entities.
 
-    def __init__(self, name: str, info, doc, ifcond=None, features=None):
-        assert name is None or isinstance(name, str)
-        for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
-            f.set_defined_in(name)
-        self.name = name
+    Notably, this includes both named and un-named entities, such as
+    include directives. Entities with names are represented by the
+    more specific sub-class `QAPISchemaDefinition` instead.
+    """
+    def __init__(self, info):
         self._module = None
         # For explicitly defined entities, info points to the (explicit)
         # definition.  For builtins (and their arrays), info is None.
@@ -70,14 +70,50 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
         # triggered the implicit definition (there may be more than one
         # such place).
         self.info = info
+        self._checked = False
+
+    def __repr__(self):
+        return "<%s at 0x%x>" % (type(self).__name__, id(self))
+
+    def check(self, schema):
+        # pylint: disable=unused-argument
+        self._checked = True
+
+    def connect_doc(self, doc=None):
+        pass
+
+    def check_doc(self):
+        pass
+
+    def _set_module(self, schema, info):
+        assert self._checked
+        fname = info.fname if info else QAPISchemaModule.BUILTIN_MODULE_NAME
+        self._module = schema.module_by_fname(fname)
+        self._module.add_entity(self)
+
+    def set_module(self, schema):
+        self._set_module(schema, self.info)
+
+    def visit(self, visitor):
+        # pylint: disable=unused-argument
+        assert self._checked
+
+
+class QAPISchemaDefinition(QAPISchemaEntity):
+    meta: Optional[str] = None
+
+    def __init__(self, name: str, info, doc, ifcond=None, features=None):
+        assert isinstance(name, str)
+        super().__init__(info)
+        for f in features or []:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_defined_in(name)
+        self.name = name
         self.doc = doc
         self._ifcond = ifcond or QAPISchemaIfCond()
         self.features = features or []
-        self._checked = False
 
     def __repr__(self):
-        if self.name is None:
-            return "<%s at 0x%x>" % (type(self).__name__, id(self))
         return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
                                     id(self))
 
@@ -102,15 +138,6 @@ def check_doc(self):
         if self.doc:
             self.doc.check()
 
-    def _set_module(self, schema, info):
-        assert self._checked
-        fname = info.fname if info else QAPISchemaModule.BUILTIN_MODULE_NAME
-        self._module = schema.module_by_fname(fname)
-        self._module.add_entity(self)
-
-    def set_module(self, schema):
-        self._set_module(schema, self.info)
-
     @property
     def ifcond(self):
         assert self._checked
@@ -119,10 +146,6 @@ def ifcond(self):
     def is_implicit(self):
         return not self.info
 
-    def visit(self, visitor):
-        # pylint: disable=unused-argument
-        assert self._checked
-
     def describe(self):
         assert self.meta
         return "%s '%s'" % (self.meta, self.name)
@@ -222,7 +245,7 @@ def visit(self, visitor):
 
 class QAPISchemaInclude(QAPISchemaEntity):
     def __init__(self, sub_module, info):
-        super().__init__(None, info, None)
+        super().__init__(info)
         self._sub_module = sub_module
 
     def visit(self, visitor):
@@ -230,7 +253,7 @@ def visit(self, visitor):
         visitor.visit_include(self._sub_module.name, self.info)
 
 
-class QAPISchemaType(QAPISchemaEntity):
+class QAPISchemaType(QAPISchemaDefinition):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
     def c_type(self):
@@ -801,7 +824,7 @@ def __init__(self, name, info, typ, ifcond=None):
         super().__init__(name, info, typ, False, ifcond)
 
 
-class QAPISchemaCommand(QAPISchemaEntity):
+class QAPISchemaCommand(QAPISchemaDefinition):
     meta = 'command'
 
     def __init__(self, name, info, doc, ifcond, features,
@@ -872,7 +895,7 @@ def visit(self, visitor):
             self.coroutine)
 
 
-class QAPISchemaEvent(QAPISchemaEntity):
+class QAPISchemaEvent(QAPISchemaDefinition):
     meta = 'event'
 
     def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
@@ -943,11 +966,12 @@ def __init__(self, fname):
         self.check()
 
     def _def_entity(self, ent):
+        self._entity_list.append(ent)
+
+    def _def_definition(self, ent):
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
-        self._entity_list.append(ent)
-        if ent.name is None:
-            return
+        self._def_entity(ent)
         # TODO reject names that differ only in '_' vs. '.'  vs. '-',
         # because they're liable to clash in generated C.
         other_ent = self._entity_dict.get(ent.name)
@@ -1001,7 +1025,7 @@ def _def_include(self, expr: QAPIExpression):
             QAPISchemaInclude(self._make_module(include), expr.info))
 
     def _def_builtin_type(self, name, json_type, c_type):
-        self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
+        self._def_definition(QAPISchemaBuiltinType(name, json_type, c_type))
         # Instantiating only the arrays that are actually used would
         # be nice, but we can't as long as their generated code
         # (qapi-builtin-types.[ch]) may be shared by some other
@@ -1027,15 +1051,15 @@ def _def_predefineds(self):
             self._def_builtin_type(*t)
         self.the_empty_object_type = QAPISchemaObjectType(
             'q_empty', None, None, None, None, None, [], None)
-        self._def_entity(self.the_empty_object_type)
+        self._def_definition(self.the_empty_object_type)
 
         qtypes = ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist',
                   'qbool']
         qtype_values = self._make_enum_members(
             [{'name': n} for n in qtypes], None)
 
-        self._def_entity(QAPISchemaEnumType('QType', None, None, None, None,
-                                            qtype_values, 'QTYPE'))
+        self._def_definition(QAPISchemaEnumType('QType', None, None, None,
+                                                None, qtype_values, 'QTYPE'))
 
     def _make_features(self, features, info):
         if features is None:
@@ -1057,7 +1081,7 @@ def _make_enum_members(self, values, info):
     def _make_array_type(self, element_type, info):
         name = element_type + 'List'    # reserved by check_defn_name_str()
         if not self.lookup_type(name):
-            self._def_entity(QAPISchemaArrayType(name, info, element_type))
+            self._def_definition(QAPISchemaArrayType(name, info, element_type))
         return name
 
     def _make_implicit_object_type(self, name, info, ifcond, role, members):
@@ -1072,7 +1096,7 @@ def _make_implicit_object_type(self, name, info, ifcond, role, members):
             # later.
             pass
         else:
-            self._def_entity(QAPISchemaObjectType(
+            self._def_definition(QAPISchemaObjectType(
                 name, info, None, ifcond, None, None, members, None))
         return name
 
@@ -1083,7 +1107,7 @@ def _def_enum_type(self, expr: QAPIExpression):
         ifcond = QAPISchemaIfCond(expr.get('if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
-        self._def_entity(QAPISchemaEnumType(
+        self._def_definition(QAPISchemaEnumType(
             name, info, expr.doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
 
@@ -1111,7 +1135,7 @@ def _def_struct_type(self, expr: QAPIExpression):
         info = expr.info
         ifcond = QAPISchemaIfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
-        self._def_entity(QAPISchemaObjectType(
+        self._def_definition(QAPISchemaObjectType(
             name, info, expr.doc, ifcond, features, base,
             self._make_members(data, info),
             None))
@@ -1141,7 +1165,7 @@ def _def_union_type(self, expr: QAPIExpression):
                                info)
             for (key, value) in data.items()]
         members: List[QAPISchemaObjectTypeMember] = []
-        self._def_entity(
+        self._def_definition(
             QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
                                  base, members,
                                  QAPISchemaVariants(
@@ -1160,7 +1184,7 @@ def _def_alternate_type(self, expr: QAPIExpression):
                                info)
             for (key, value) in data.items()]
         tag_member = QAPISchemaObjectTypeMember('type', info, 'QType', False)
-        self._def_entity(
+        self._def_definition(
             QAPISchemaAlternateType(
                 name, info, expr.doc, ifcond, features,
                 QAPISchemaVariants(None, info, tag_member, variants)))
@@ -1185,11 +1209,10 @@ def _def_command(self, expr: QAPIExpression):
         if isinstance(rets, list):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
-        self._def_entity(QAPISchemaCommand(name, info, expr.doc, ifcond,
-                                           features, data, rets,
-                                           gen, success_response,
-                                           boxed, allow_oob, allow_preconfig,
-                                           coroutine))
+        self._def_definition(
+            QAPISchemaCommand(name, info, expr.doc, ifcond, features, data,
+                              rets, gen, success_response, boxed, allow_oob,
+                              allow_preconfig, coroutine))
 
     def _def_event(self, expr: QAPIExpression):
         name = expr['event']
@@ -1202,8 +1225,8 @@ def _def_event(self, expr: QAPIExpression):
             data = self._make_implicit_object_type(
                 name, info, ifcond,
                 'arg', self._make_members(data, info))
-        self._def_entity(QAPISchemaEvent(name, info, expr.doc, ifcond,
-                                         features, data, boxed))
+        self._def_definition(QAPISchemaEvent(name, info, expr.doc, ifcond,
+                                             features, data, boxed))
 
     def _def_exprs(self, exprs):
         for expr in exprs:
-- 
2.43.0


