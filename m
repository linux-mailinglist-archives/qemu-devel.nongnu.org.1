Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD2C8B0433
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXpC-0001Go-V7; Wed, 24 Apr 2024 04:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXop-0000QR-Ek
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXod-0006OE-Jh
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sW/1LPbGvCQulJkoaMsEee1B55s3T0QllG3s+V3Hx0M=;
 b=P+aqXrUbRZYNi6qDtgMrw70YC+LuGueGfsxf17KzVNE7t4LKhK69K380LMPnPNLKhECzzW
 qFJVcQUU/nBbefkta2EzTTimPIdyb8GbFNxLUWTK5YUeQiSiLIbrFTzbP1lJ6s9CAbyjA4
 C82nc7WUm7oXRhqIGESwWRNq8sqsMA4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-HGAFIeVtOeapZkPvD-Sswg-1; Wed,
 24 Apr 2024 04:17:14 -0400
X-MC-Unique: HGAFIeVtOeapZkPvD-Sswg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7625A3C108D3;
 Wed, 24 Apr 2024 08:17:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CEE42166B34;
 Wed, 24 Apr 2024 08:17:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11FF021F9811; Wed, 24 Apr 2024 10:17:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 23/25] qapi/schema: remove unnecessary asserts
Date: Wed, 24 Apr 2024 10:17:08 +0200
Message-ID: <20240424081710.2907748-24-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

From: John Snow <jsnow@redhat.com>

With strict typing enabled, these runtime statements aren't necessary
anymore; we can prove them statically.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240315152301.3621858-24-armbru@redhat.com>
---
 scripts/qapi/schema.py | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index ef4d6a7def..e52930a48a 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -123,10 +123,8 @@ def __init__(
         ifcond: Optional[QAPISchemaIfCond] = None,
         features: Optional[List[QAPISchemaFeature]] = None,
     ):
-        assert isinstance(name, str)
         super().__init__(info)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self.name = name
         self.doc = doc
@@ -163,7 +161,6 @@ def is_implicit(self) -> bool:
         return not self.info
 
     def describe(self) -> str:
-        assert self.meta
         return "%s '%s'" % (self.meta, self.name)
 
 
@@ -377,7 +374,6 @@ def check(self, schema: QAPISchema) -> None:
                     f"feature '{feat.name}' is not supported for types")
 
     def describe(self) -> str:
-        assert self.meta
         return "%s type '%s'" % (self.meta, self.name)
 
 
@@ -386,7 +382,6 @@ class QAPISchemaBuiltinType(QAPISchemaType):
 
     def __init__(self, name: str, json_type: str, c_type: str):
         super().__init__(name, None, None)
-        assert not c_type or isinstance(c_type, str)
         assert json_type in ('string', 'number', 'int', 'boolean', 'null',
                              'value')
         self._json_type_name = json_type
@@ -429,9 +424,7 @@ def __init__(
     ):
         super().__init__(name, info, doc, ifcond, features)
         for m in members:
-            assert isinstance(m, QAPISchemaEnumMember)
             m.set_defined_in(name)
-        assert prefix is None or isinstance(prefix, str)
         self.members = members
         self.prefix = prefix
 
@@ -474,7 +467,6 @@ def __init__(
         self, name: str, info: Optional[QAPISourceInfo], element_type: str
     ):
         super().__init__(name, info, None)
-        assert isinstance(element_type, str)
         self._element_type_name = element_type
         self.element_type: QAPISchemaType
 
@@ -519,7 +511,6 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
                                  self.element_type)
 
     def describe(self) -> str:
-        assert self.meta
         return "%s type ['%s']" % (self.meta, self._element_type_name)
 
 
@@ -539,12 +530,9 @@ def __init__(
         # union has base, variants, and no local_members
         super().__init__(name, info, doc, ifcond, features)
         self.meta = 'union' if variants else 'struct'
-        assert base is None or isinstance(base, str)
         for m in local_members:
-            assert isinstance(m, QAPISchemaObjectTypeMember)
             m.set_defined_in(name)
         if variants is not None:
-            assert isinstance(variants, QAPISchemaVariants)
             variants.set_defined_in(name)
         self._base_name = base
         self.base = None
@@ -666,7 +654,6 @@ def __init__(
         variants: QAPISchemaVariants,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert isinstance(variants, QAPISchemaVariants)
         assert variants.tag_member
         variants.set_defined_in(name)
         variants.tag_member.set_defined_in(self.name)
@@ -742,8 +729,6 @@ def __init__(
         assert bool(tag_member) != bool(tag_name)
         assert (isinstance(tag_name, str) or
                 isinstance(tag_member, QAPISchemaObjectTypeMember))
-        for v in variants:
-            assert isinstance(v, QAPISchemaVariant)
         self._tag_name = tag_name
         self.info = info
         self._tag_member = tag_member
@@ -858,7 +843,6 @@ def __init__(
         info: Optional[QAPISourceInfo],
         ifcond: Optional[QAPISchemaIfCond] = None,
     ):
-        assert isinstance(name, str)
         self.name = name
         self.info = info
         self.ifcond = ifcond or QAPISchemaIfCond()
@@ -926,7 +910,6 @@ def __init__(
     ):
         super().__init__(name, info, ifcond)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self.features = features or []
 
@@ -955,10 +938,7 @@ def __init__(
         features: Optional[List[QAPISchemaFeature]] = None,
     ):
         super().__init__(name, info, ifcond)
-        assert isinstance(typ, str)
-        assert isinstance(optional, bool)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self._type_name = typ
         self.type: QAPISchemaType  # set during check()
@@ -966,7 +946,6 @@ def __init__(
         self.features = features or []
 
     def need_has(self) -> bool:
-        assert self.type
         return self.optional and self.type.need_has_if_optional()
 
     def check(self, schema: QAPISchema) -> None:
@@ -1017,8 +996,6 @@ def __init__(
         coroutine: bool,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert not arg_type or isinstance(arg_type, str)
-        assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name = arg_type
         self.arg_type: Optional[QAPISchemaObjectType] = None
         self._ret_type_name = ret_type
@@ -1058,7 +1035,6 @@ def check(self, schema: QAPISchema) -> None:
             if self.name not in self.info.pragma.command_returns_exceptions:
                 typ = self.ret_type
                 if isinstance(typ, QAPISchemaArrayType):
-                    assert typ
                     typ = typ.element_type
                 if not isinstance(typ, QAPISchemaObjectType):
                     raise QAPISemError(
@@ -1096,7 +1072,6 @@ def __init__(
         boxed: bool,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name = arg_type
         self.arg_type: Optional[QAPISchemaObjectType] = None
         self.boxed = boxed
-- 
2.44.0


