Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F587D038
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Mar 2024 16:26:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9P5-0007k9-MY; Fri, 15 Mar 2024 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9P3-0007ih-5X
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9On-0001zU-By
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8npiLTFMuduECFC2ourzvsVERqD+gsO3aIOhM79oL4=;
 b=C+iABSjc4UE+LYvqcp8JkFXIasFkk33s1YdO5+ywJs2j5CqNg37lFDVHdiwZ7V6d6+w5v9
 3WmDJyXCkIC7k4o1nc5+JedMeDn9NU+O+TQV79t3c0I0EspYLfD5a1dKyF1dEqLonn8AkI
 hgL5o9T5KmwsP87KnyUdqb0ra0gNC2k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-TiXZb0aaMPmciMrmOamofg-1; Fri,
 15 Mar 2024 11:23:06 -0400
X-MC-Unique: TiXZb0aaMPmciMrmOamofg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DC353803526;
 Fri, 15 Mar 2024 15:23:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D58EC04222;
 Fri, 15 Mar 2024 15:23:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 277FB21E66D8; Fri, 15 Mar 2024 16:23:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 25/25] qapi: Dumb down QAPISchema.lookup_entity()
Date: Fri, 15 Mar 2024 16:23:01 +0100
Message-ID: <20240315152301.3621858-26-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

QAPISchema.lookup_entity() takes an optional type argument, a subtype
of QAPISchemaDefinition, and returns that type or None.  Callers can
use this to save themselves an isinstance() test.

The only remaining user of this convenience feature is .lookup_type().
But we don't actually save anything anymore there: we still the
isinstance() to help mypy over the hump.

Drop the .lookup_entity() argument, and adjust .lookup_type().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index a6180f93c6..5924947fc3 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1157,20 +1157,14 @@ def _def_definition(self, defn: QAPISchemaDefinition) -> None:
                 defn.info, "%s is already defined" % other_defn.describe())
         self._entity_dict[defn.name] = defn
 
-    def lookup_entity(
-        self,
-        name: str,
-        typ: Optional[type] = None,
-    ) -> Optional[QAPISchemaDefinition]:
-        ent = self._entity_dict.get(name)
-        if typ and not isinstance(ent, typ):
-            return None
-        return ent
+    def lookup_entity(self,name: str) -> Optional[QAPISchemaEntity]:
+        return self._entity_dict.get(name)
 
     def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
-        typ = self.lookup_entity(name, QAPISchemaType)
-        assert typ is None or isinstance(typ, QAPISchemaType)
-        return typ
+        typ = self.lookup_entity(name)
+        if isinstance(typ, QAPISchemaType):
+            return typ
+        return None
 
     def resolve_type(
         self,
-- 
2.44.0


