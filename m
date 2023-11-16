Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F087ED8F7
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:46:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQz-0005Ph-V9; Wed, 15 Nov 2023 20:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQO-0005Jr-HV
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQK-00023Y-Rr
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M2mScccsI/m2XDWoGf9Kl1sVKUo1rs7PmXyaA/Q5qx4=;
 b=AiXWpI+gHJ4f4KMWaAn/Iu2s6GKCV4HKqnth6+c5klDbEUoX99ZccVeBBqbiaEQVKo/Q+X
 iai71ix6AsAvJBWS4UxjZgVfa8J3pnmxYYo6nmASETvkYweilaehLw5aH/WbIrQIxjWvRU
 09519wqeBTNoJjrgKiKaHYAH1Wz7DEM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-saj6Tb3DNkOMQtibDYCpDQ-1; Wed, 15 Nov 2023 20:43:58 -0500
X-MC-Unique: saj6Tb3DNkOMQtibDYCpDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBD57811E7D;
 Thu, 16 Nov 2023 01:43:57 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 778EBC15881;
 Thu, 16 Nov 2023 01:43:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 19/19] qapi/schema: refactor entity lookup helpers
Date: Wed, 15 Nov 2023 20:43:50 -0500
Message-ID: <20231116014350.653792-20-jsnow@redhat.com>
In-Reply-To: <20231116014350.653792-1-jsnow@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

This is not a clear win, but I was confused and I couldn't help myself.

Before:

lookup_entity(self, name: str, typ: Optional[type] = None
              ) -> Optional[QAPISchemaEntity]: ...

lookup_type(self, name: str) -> Optional[QAPISchemaType]: ...

resolve_type(self, name: str, info: Optional[QAPISourceInfo],
             what: Union[str, Callable[[Optional[QAPISourceInfo]], str]]
             ) -> QAPISchemaType: ...

After:

get_entity(self, name: str) -> Optional[QAPISchemaEntity]: ...
get_typed_entity(self, name: str, typ: Type[_EntityType]
                 ) -> Optional[_EntityType]: ...
lookup_type(self, name: str) -> QAPISchemaType: ...
resolve_type(self, name: str, info: Optional[QAPISourceInfo],
             what: Union[str, Callable[[Optional[QAPISourceInfo]], str]]
             ) -> QAPISchemaType: ...

In essence, any function that can return a None value becomes "get ..."
to encourage association with the dict.get() function which has the same
behavior. Any function named "lookup" or "resolve" by contrast is no
longer allowed to return a None value.

This means that any callers to resolve_type or lookup_type don't have to
check that the function worked, they can just assume it did.

Callers to resolve_type will be greeted with a QAPISemError if something
has gone wrong, as they have in the past. Callers to lookup_type will be
greeted with a KeyError if the entity does not exist, or a TypeError if
it does, but is the wrong type.

get_entity and get_typed_entity remain for any callers who are
specifically interested in the negative case. These functions have only
a single caller each.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py     |  2 +-
 scripts/qapi/introspect.py |  8 ++----
 scripts/qapi/schema.py     | 52 ++++++++++++++++++++++++--------------
 3 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8f3b9997a15..96deadbf7fc 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -508,7 +508,7 @@ def run(self):
             vis.visit_begin(schema)
             for doc in schema.docs:
                 if doc.symbol:
-                    vis.symbol(doc, schema.lookup_entity(doc.symbol))
+                    vis.symbol(doc, schema.get_entity(doc.symbol))
                 else:
                     vis.freeform(doc)
             return vis.get_document_nodes()
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 42981bce163..67c7d89aae0 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -227,14 +227,10 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
         # Map the various integer types to plain int
         if typ.json_type() == 'int':
-            tmp = self._schema.lookup_type('int')
-            assert tmp is not None
-            typ = tmp
+            typ = self._schema.lookup_type('int')
         elif (isinstance(typ, QAPISchemaArrayType) and
               typ.element_type.json_type() == 'int'):
-            tmp = self._schema.lookup_type('intList')
-            assert tmp is not None
-            typ = tmp
+            typ = self._schema.lookup_type('intList')
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index b5f377e68b8..5813136e78b 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -26,6 +26,8 @@
     Dict,
     List,
     Optional,
+    Type,
+    TypeVar,
     Union,
     cast,
 )
@@ -767,7 +769,6 @@ def check(
             # Here we do:
             assert self.tag_member.defined_in
             base_type = schema.lookup_type(self.tag_member.defined_in)
-            assert base_type
             if not base_type.is_implicit():
                 base = "base type '%s'" % self.tag_member.defined_in
             if not isinstance(self.tag_member.type, QAPISchemaEnumType):
@@ -1111,6 +1112,12 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
             self.arg_type, self.boxed)
 
 
+# Used for type-dependent type lookup return values.
+_EntityType = TypeVar(   # pylint: disable=invalid-name
+    '_EntityType', bound=QAPISchemaEntity
+)
+
+
 class QAPISchema:
     def __init__(self, fname: str):
         self.fname = fname
@@ -1155,22 +1162,28 @@ def _def_entity(self, ent: QAPISchemaEntity) -> None:
                 ent.info, "%s is already defined" % other_ent.describe())
         self._entity_dict[ent.name] = ent
 
-    def lookup_entity(
+    def get_entity(self, name: str) -> Optional[QAPISchemaEntity]:
+        return self._entity_dict.get(name)
+
+    def get_typed_entity(
         self,
         name: str,
-        typ: Optional[type] = None,
-    ) -> Optional[QAPISchemaEntity]:
-        ent = self._entity_dict.get(name)
-        if typ and not isinstance(ent, typ):
-            return None
+        typ: Type[_EntityType]
+    ) -> Optional[_EntityType]:
+        ent = self.get_entity(name)
+        if ent is not None and not isinstance(ent, typ):
+            etype = type(ent).__name__
+            ttype = typ.__name__
+            raise TypeError(
+                f"Entity '{name}' is of type '{etype}', not '{ttype}'."
+            )
         return ent
 
-    def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
-        typ = self.lookup_entity(name, QAPISchemaType)
-        if typ is None:
-            return None
-        assert isinstance(typ, QAPISchemaType)
-        return typ
+    def lookup_type(self, name: str) -> QAPISchemaType:
+        ent = self.get_typed_entity(name, QAPISchemaType)
+        if ent is None:
+            raise KeyError(f"Entity '{name}' is not defined.")
+        return ent
 
     def resolve_type(
         self,
@@ -1178,13 +1191,14 @@ def resolve_type(
         info: Optional[QAPISourceInfo],
         what: Union[str, Callable[[Optional[QAPISourceInfo]], str]],
     ) -> QAPISchemaType:
-        typ = self.lookup_type(name)
-        if not typ:
+        try:
+            return self.lookup_type(name)
+        except (KeyError, TypeError) as err:
             if callable(what):
                 what = what(info)
             raise QAPISemError(
-                info, "%s uses unknown type '%s'" % (what, name))
-        return typ
+                info, "%s uses unknown type '%s'" % (what, name)
+            ) from err
 
     def _module_name(self, fname: str) -> str:
         if QAPISchemaModule.is_system_module(fname):
@@ -1279,7 +1293,7 @@ def _make_array_type(
         self, element_type: str, info: Optional[QAPISourceInfo]
     ) -> str:
         name = element_type + 'List'    # reserved by check_defn_name_str()
-        if not self.lookup_type(name):
+        if not self.get_entity(name):
             self._def_entity(QAPISchemaArrayType(name, info, element_type))
         return name
 
@@ -1295,7 +1309,7 @@ def _make_implicit_object_type(
             return None
         # See also QAPISchemaObjectTypeMember.describe()
         name = 'q_obj_%s-%s' % (name, role)
-        typ = self.lookup_entity(name, QAPISchemaObjectType)
+        typ = self.get_typed_entity(name, QAPISchemaObjectType)
         if typ:
             # The implicit object type has multiple users.  This can
             # only be a duplicate definition, which will be flagged
-- 
2.41.0


