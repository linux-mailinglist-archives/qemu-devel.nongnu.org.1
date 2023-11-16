Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCE37ED907
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQu-0005Oi-QY; Wed, 15 Nov 2023 20:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQO-0005KQ-Ue
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQI-00022N-3H
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6FJzfXk8Xh4RUkNFX52+G4sAFZOc9b8NvO/oKrBAZA=;
 b=eGnWob7t+ZeurHioi3gXU7LZ1HZNSNR8piIw4i5MQ+0XvMIS/yTPN4/oXpNkimlLGvdCk3
 pJ5D2+2ysUid/j0LOx4TvSebqKg7xuZGnuNX9p7RV9hQ7U9+TMQidDpa7kVsNVUTBMjrTr
 zQVYt5e6CaYXI8i6KC25yD3X1AjV08Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-2KPuCeexMNS0BXGCVs0OyQ-1; Wed,
 15 Nov 2023 20:43:57 -0500
X-MC-Unique: 2KPuCeexMNS0BXGCVs0OyQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66B143C11CC3;
 Thu, 16 Nov 2023 01:43:57 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 264B7C15881;
 Thu, 16 Nov 2023 01:43:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 18/19] qapi/schema: remove unnecessary asserts
Date: Wed, 15 Nov 2023 20:43:49 -0500
Message-ID: <20231116014350.653792-19-jsnow@redhat.com>
In-Reply-To: <20231116014350.653792-1-jsnow@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

With strict typing enabled, these runtime statements aren't necessary
anymore.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 5d19b59def0..b5f377e68b8 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -78,9 +78,7 @@ def __init__(
         ifcond: Optional[QAPISchemaIfCond] = None,
         features: Optional[List[QAPISchemaFeature]] = None,
     ):
-        assert name is None or isinstance(name, str)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self.name = name
         self._module: Optional[QAPISchemaModule] = None
@@ -145,7 +143,6 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
         assert self._checked
 
     def describe(self) -> str:
-        assert self.meta
         return "%s '%s'" % (self.meta, self.name)
 
 
@@ -359,7 +356,6 @@ def check(self, schema: QAPISchema) -> None:
                     f"feature '{feat.name}' is not supported for types")
 
     def describe(self) -> str:
-        assert self.meta
         return "%s type '%s'" % (self.meta, self.name)
 
 
@@ -368,7 +364,6 @@ class QAPISchemaBuiltinType(QAPISchemaType):
 
     def __init__(self, name: str, json_type: str, c_type: str):
         super().__init__(name, None, None)
-        assert not c_type or isinstance(c_type, str)
         assert json_type in ('string', 'number', 'int', 'boolean', 'null',
                              'value')
         self._json_type_name = json_type
@@ -411,9 +406,7 @@ def __init__(
     ):
         super().__init__(name, info, doc, ifcond, features)
         for m in members:
-            assert isinstance(m, QAPISchemaEnumMember)
             m.set_defined_in(name)
-        assert prefix is None or isinstance(prefix, str)
         self.members = members
         self.prefix = prefix
 
@@ -456,7 +449,6 @@ def __init__(
         self, name: str, info: Optional[QAPISourceInfo], element_type: str
     ):
         super().__init__(name, info, None)
-        assert isinstance(element_type, str)
         self._element_type_name = element_type
         self._element_type: Optional[QAPISchemaType] = None
 
@@ -517,7 +509,6 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
                                  self.element_type)
 
     def describe(self) -> str:
-        assert self.meta
         return "%s type ['%s']" % (self.meta, self._element_type_name)
 
 
@@ -537,12 +528,9 @@ def __init__(
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
@@ -856,7 +841,6 @@ def __init__(
         info: Optional[QAPISourceInfo],
         ifcond: Optional[QAPISchemaIfCond] = None,
     ):
-        assert isinstance(name, str)
         self.name = name
         self.info = info
         self.ifcond = ifcond or QAPISchemaIfCond()
@@ -924,7 +908,6 @@ def __init__(
     ):
         super().__init__(name, info, ifcond)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self.features = features or []
 
@@ -953,10 +936,7 @@ def __init__(
         features: Optional[List[QAPISchemaFeature]] = None,
     ):
         super().__init__(name, info, ifcond)
-        assert isinstance(typ, str)
-        assert isinstance(optional, bool)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self._type_name = typ
         self.type: QAPISchemaType  # set during check(). Kind of hokey.
@@ -1015,8 +995,6 @@ def __init__(
         coroutine: bool,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert not arg_type or isinstance(arg_type, str)
-        assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name = arg_type
         self.arg_type: Optional[QAPISchemaObjectType] = None
         self._ret_type_name = ret_type
@@ -1093,7 +1071,6 @@ def __init__(
         boxed: bool,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name = arg_type
         self.arg_type: Optional[QAPISchemaObjectType] = None
         self.boxed = boxed
-- 
2.41.0


