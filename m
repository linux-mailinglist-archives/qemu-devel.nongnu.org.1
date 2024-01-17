Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE40B8303F4
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:54:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3Xw-0007MQ-2H; Wed, 17 Jan 2024 05:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ3Xt-0007KP-A4
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:53:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ3Xr-0006ce-3n
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705488798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RmmCpy8hDgcpodcKdhJifxotv7eYT4sLp1cbu4JzJY=;
 b=SfOj8HivqnCEOis75a2kBpzawnTNdJMKWWiOjgdqVJzy5GVijKHn+pVwLWEC0VcuehTs9T
 NRWzfQ9JnoEADQsiWDpHPjUc9hHxvopq8NTghU6IBI+auhxmzfTjnkb/tCTV4Dckv6Ss5R
 9oQGTP0nh06LyTDwlPOqkEju0Dc900c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-r-SXnmEkPX-C92pRYNBgPQ-1; Wed, 17 Jan 2024 05:53:14 -0500
X-MC-Unique: r-SXnmEkPX-C92pRYNBgPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F4C987DC03;
 Wed, 17 Jan 2024 10:53:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9977640C6EB9;
 Wed, 17 Jan 2024 10:53:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99E3721E66F1; Wed, 17 Jan 2024 11:53:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 13/19] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
In-Reply-To: <87v87smer8.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 17 Jan 2024 11:32:43 +0100")
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-14-jsnow@redhat.com>
 <87zfz5c28s.fsf@pond.sub.org>
 <CAFn=p-bZPJNU9uLBOW1Uqts7kX-+9+dvSNRxwf+VD5hoCHJq9A@mail.gmail.com>
 <CAFn=p-bky_eAv9Z2V0zQ-_J7EygvYANa4UnxLTB9omMN-AbvbA@mail.gmail.com>
 <87bk9tfwvb.fsf@pond.sub.org>
 <CAFn=p-ZsQnwMtDEN70UdTz75bN6FgzxPbM0yNicOoULpPtV97A@mail.gmail.com>
 <87le8onzif.fsf@pond.sub.org> <87v87smer8.fsf@pond.sub.org>
Date: Wed, 17 Jan 2024 11:53:12 +0100
Message-ID: <87ttnckz8n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Still more...

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 658c288f8f..4a2e62d919 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -328,7 +328,8 @@ def visit_object_type(self, name, info, ifcond, features,
                       + self._nodes_for_sections(doc)
                       + self._nodes_for_if_section(ifcond))
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self, name, info, ifcond, features,
+                             alternatives):
         doc = self._cur_doc
         self._add_doc('Alternate',
                       self._nodes_for_members(doc, 'Members')
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index c38df61a6d..e5cea8004e 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -26,6 +26,7 @@
 from .gen import QAPISchemaMonolithicCVisitor
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
     QAPISchemaArrayType,
     QAPISchemaBuiltinType,
     QAPISchemaEntity,
@@ -343,12 +344,12 @@ def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
     def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         self._gen_tree(
             name, 'alternate',
             {'members': [Annotated({'type': self._use_type(m.type)},
                                    m.ifcond)
-                         for m in variants.variants]},
+                         for m in alternatives.variants]},
             ifcond, features
         )
 
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 0d9a70ab4c..f18aac7199 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -187,7 +187,8 @@ def visit_object_type_flat(self, name, info, ifcond, features,
                                members, variants):
         pass
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self, name, info, ifcond, features,
+                             alternatives):
         pass
 
     def visit_command(self, name, info, ifcond, features,
@@ -563,8 +564,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
 
     def __init__(self, name, info, doc, ifcond, features, variants):
         super().__init__(name, info, doc, ifcond, features)
-        assert isinstance(variants, QAPISchemaVariants)
-        assert variants.tag_member
+        assert isinstance(variants, QAPISchemaAlternatives)
         variants.set_defined_in(name)
         variants.tag_member.set_defined_in(self.name)
         self.variants = variants
@@ -625,19 +625,12 @@ def visit(self, visitor):
             self.name, self.info, self.ifcond, self.features, self.variants)
 
 
-class QAPISchemaVariants:
-    def __init__(self, tag_name, info, tag_member, variants):
-        # Unions pass tag_name but not tag_member.
-        # Alternates pass tag_member but not tag_name.
-        # After check(), tag_member is always set.
-        assert bool(tag_member) != bool(tag_name)
-        assert (isinstance(tag_name, str) or
-                isinstance(tag_member, QAPISchemaObjectTypeMember))
+class QAPISchemaVariantsBase:
+    def __init__(self, info, variants):
         for v in variants:
             assert isinstance(v, QAPISchemaVariant)
-        self._tag_name = tag_name
         self.info = info
-        self.tag_member = tag_member
+        self.tag_member = None
         self.variants = variants
 
     def set_defined_in(self, name):
@@ -645,66 +638,68 @@ def set_defined_in(self, name):
             v.set_defined_in(name)
 
     def check(self, schema, seen):
-        if self._tag_name:      # union
-            self.tag_member = seen.get(c_name(self._tag_name))
-            base = "'base'"
-            # Pointing to the base type when not implicit would be
-            # nice, but we don't know it here
-            if not self.tag_member or self._tag_name != self.tag_member.name:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator '%s' is not a member of %s"
-                    % (self._tag_name, base))
-            # Here we do:
-            base_type = schema.resolve_type(self.tag_member.defined_in)
-            if not base_type.is_implicit():
-                base = "base type '%s'" % self.tag_member.defined_in
-            if not isinstance(self.tag_member.type, QAPISchemaEnumType):
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must be of enum type"
-                    % (self._tag_name, base))
-            if self.tag_member.optional:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must not be optional"
-                    % (self._tag_name, base))
-            if self.tag_member.ifcond.is_present():
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must not be conditional"
-                    % (self._tag_name, base))
-        else:                   # alternate
-            assert isinstance(self.tag_member.type, QAPISchemaEnumType)
-            assert not self.tag_member.optional
-            assert not self.tag_member.ifcond.is_present()
-        if self._tag_name:      # union
-            # branches that are not explicitly covered get an empty type
-            cases = {v.name for v in self.variants}
-            for m in self.tag_member.type.members:
-                if m.name not in cases:
-                    v = QAPISchemaVariant(m.name, self.info,
-                                          'q_empty', m.ifcond)
-                    v.set_defined_in(self.tag_member.defined_in)
-                    self.variants.append(v)
-        if not self.variants:
-            raise QAPISemError(self.info, "union has no branches")
         for v in self.variants:
             v.check(schema)
-            # Union names must match enum values; alternate names are
-            # checked separately. Use 'seen' to tell the two apart.
-            if seen:
-                if v.name not in self.tag_member.type.member_names():
-                    raise QAPISemError(
-                        self.info,
-                        "branch '%s' is not a value of %s"
-                        % (v.name, self.tag_member.type.describe()))
-                if not isinstance(v.type, QAPISchemaObjectType):
-                    raise QAPISemError(
-                        self.info,
-                        "%s cannot use %s"
-                        % (v.describe(self.info), v.type.describe()))
-                v.type.check(schema)
+
+
+class QAPISchemaVariants(QAPISchemaVariantsBase):
+    def __init__(self, info, variants, tag_name):
+        assert isinstance(tag_name, str)
+        super().__init__(info, variants)
+        self._tag_name = tag_name
+
+    def check(self, schema, seen):
+        self.tag_member = seen.get(c_name(self._tag_name))
+        base = "'base'"
+        # Pointing to the base type when not implicit would be
+        # nice, but we don't know it here
+        if not self.tag_member or self._tag_name != self.tag_member.name:
+            raise QAPISemError(
+                self.info,
+                "discriminator '%s' is not a member of %s"
+                % (self._tag_name, base))
+        # Here we do:
+        base_type = schema.resolve_type(self.tag_member.defined_in)
+        if not base_type.is_implicit():
+            base = "base type '%s'" % self.tag_member.defined_in
+        if not isinstance(self.tag_member.type, QAPISchemaEnumType):
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must be of enum type"
+                % (self._tag_name, base))
+        if self.tag_member.optional:
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must not be optional"
+                % (self._tag_name, base))
+        if self.tag_member.ifcond.is_present():
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must not be conditional"
+                % (self._tag_name, base))
+        # branches that are not explicitly covered get an empty type
+        cases = {v.name for v in self.variants}
+        for m in self.tag_member.type.members:
+            if m.name not in cases:
+                v = QAPISchemaVariant(m.name, self.info,
+                                      'q_empty', m.ifcond)
+                v.set_defined_in(self.tag_member.defined_in)
+                self.variants.append(v)
+        if not self.variants:
+            raise QAPISemError(self.info, "union has no branches")
+        super().check(schema, seen)
+        for v in self.variants:
+            if v.name not in self.tag_member.type.member_names():
+                raise QAPISemError(
+                    self.info,
+                    "branch '%s' is not a value of %s"
+                    % (v.name, self.tag_member.type.describe()))
+            if not isinstance(v.type, QAPISchemaObjectType):
+                raise QAPISemError(
+                    self.info,
+                    "%s cannot use %s"
+                    % (v.describe(self.info), v.type.describe()))
+            v.type.check(schema)
 
     def check_clash(self, info, seen):
         for v in self.variants:
@@ -713,6 +708,19 @@ def check_clash(self, info, seen):
             v.type.check_clash(info, dict(seen))
 
 
+class QAPISchemaAlternatives(QAPISchemaVariantsBase):
+    def __init__(self, info, variants, tag_member):
+        assert isinstance(tag_member, QAPISchemaObjectTypeMember)
+        super().__init__(info, variants)
+        self.tag_member = tag_member
+
+    def check(self, schema, seen):
+        super().check(schema, seen)
+        assert isinstance(self.tag_member.type, QAPISchemaEnumType)
+        assert not self.tag_member.optional
+        assert not self.tag_member.ifcond.is_present()
+
+
 class QAPISchemaMember:
     """ Represents object members, enum members and features """
     role = 'member'
@@ -1184,7 +1192,7 @@ def _def_union_type(self, expr: QAPIExpression):
             QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
                                  base, members,
                                  QAPISchemaVariants(
-                                     tag_name, info, None, variants)))
+                                     info, variants, tag_name)))
 
     def _def_alternate_type(self, expr: QAPIExpression):
         name = expr['alternate']
@@ -1202,7 +1210,7 @@ def _def_alternate_type(self, expr: QAPIExpression):
         self._def_definition(
             QAPISchemaAlternateType(
                 name, info, expr.doc, ifcond, features,
-                QAPISchemaVariants(None, info, tag_member, variants)))
+                QAPISchemaAlternatives(info, variants, tag_member)))
 
     def _def_command(self, expr: QAPIExpression):
         name = expr['command']
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index c39d054d2c..05da30b855 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -23,6 +23,7 @@
 )
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
     QAPISchemaIfCond,
@@ -369,11 +370,11 @@ def visit_alternate_type(self,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
         self._genh.add(gen_object(name, ifcond, None,
-                                  [variants.tag_member], variants))
+                                  [alternatives.tag_member], alternatives))
         with ifcontext(ifcond, self._genh, self._genc):
             self._gen_type_cleanup(name)
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index c56ea4d724..725bfcef50 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -28,6 +28,7 @@
 )
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
     QAPISchemaEnumMember,
     QAPISchemaEnumType,
     QAPISchemaFeature,
@@ -222,7 +223,8 @@ def gen_visit_enum(name: str) -> str:
                  c_name=c_name(name))
 
 
-def gen_visit_alternate(name: str, variants: QAPISchemaVariants) -> str:
+def gen_visit_alternate(name: str,
+                        alternatives: QAPISchemaAlternatives) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -244,7 +246,7 @@ def gen_visit_alternate(name: str, variants: QAPISchemaVariants) -> str:
 ''',
                 c_name=c_name(name))
 
-    for var in variants.variants:
+    for var in alternatives.variants:
         ret += var.ifcond.gen_if()
         ret += mcgen('''
     case %(case)s:
@@ -414,10 +416,10 @@ def visit_alternate_type(self,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
-            self._genc.add(gen_visit_alternate(name, variants))
+            self._genc.add(gen_visit_alternate(name, alternatives))
 
 
 def gen_visit(schema: QAPISchema,
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 14f7b62a44..b66ceb81b8 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -61,9 +61,10 @@ def visit_object_type(self, name, info, ifcond, features,
         self._print_if(ifcond)
         self._print_features(features)
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self, name, info, ifcond, features,
+                             alternatives):
         print('alternate %s' % name)
-        self._print_variants(variants)
+        self._print_variants(alternatives)
         self._print_if(ifcond)
         self._print_features(features)
 


