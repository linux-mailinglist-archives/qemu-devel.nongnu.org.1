Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9682C74E
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:32:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQ2f-00064A-96; Fri, 12 Jan 2024 17:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2M-0005p8-S5
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rOQ2K-00062W-5Q
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705098597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y3Gbc+zyMRhG9pjkc10QstAH0Hc+sEAF9qItxz4UW0Q=;
 b=PFjkCVWyvX9SGo/1UqS5yPHp+1g6pV5JgPq2PnPOI8RiZy7rZpkew81tYaeIHVFhxWmKCt
 0dsGaJ1m9dHuC2Jhc8OGWYQJJ9ruW1nusneJm3vMLOYyKGpGOVLEQJ05+CWqPt4lCU+ruL
 CAeERF3BHeNImjwRUZzjeU+M/oZozLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-O7scqpwHOdGJhHrYz2fZZg-1; Fri, 12 Jan 2024 17:29:50 -0500
X-MC-Unique: O7scqpwHOdGJhHrYz2fZZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF948811E9C;
 Fri, 12 Jan 2024 22:29:49 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.17.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98F9CC25AC8;
 Fri, 12 Jan 2024 22:29:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 10/19] qapi: use schema.resolve_type instead of
 schema.lookup_type
Date: Fri, 12 Jan 2024 17:29:36 -0500
Message-ID: <20240112222945.3033854-11-jsnow@redhat.com>
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

lookup_type() is capable of returning None, but some callers aren't
prepared for that and assume it will always succeed.

Use the must-not-fail variant resolve_type() instead, which guarantees
that the return type will not be None.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/introspect.py | 4 ++--
 scripts/qapi/schema.py     | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 67c7d89aae0..c38df61a6d5 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -227,10 +227,10 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
         # Map the various integer types to plain int
         if typ.json_type() == 'int':
-            typ = self._schema.lookup_type('int')
+            typ = self._schema.resolve_type('int')
         elif (isinstance(typ, QAPISchemaArrayType) and
               typ.element_type.json_type() == 'int'):
-            typ = self._schema.lookup_type('intList')
+            typ = self._schema.resolve_type('intList')
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index a77b51d1b96..35638c7708a 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -650,8 +650,7 @@ def check(self, schema, seen):
                     "discriminator '%s' is not a member of %s"
                     % (self._tag_name, base))
             # Here we do:
-            base_type = schema.lookup_type(self.tag_member.defined_in)
-            assert base_type
+            base_type = schema.resolve_type(self.tag_member.defined_in)
             if not base_type.is_implicit():
                 base = "base type '%s'" % self.tag_member.defined_in
             if not isinstance(self.tag_member.type, QAPISchemaEnumType):
-- 
2.43.0


