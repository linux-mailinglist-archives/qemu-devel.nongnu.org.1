Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8147ED908
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQK-0005Gc-Sp; Wed, 15 Nov 2023 20:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQI-0005Ep-3J
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQC-0001zV-Sn
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYLkqBBvaIhpzJOuU0P3RkHpLlo+uQ+r8gLb/DfUIYQ=;
 b=QbcyyOkXeWfc/0HRttLGxQZ/eEsbSSd1SlK7y4fNfCpiL2NvCO56Ue9g5Ew0aOm+k1z2tF
 vTmD084M5kfffOlkIaRqGEQTI/bIKXE2OstJXmzp2ui05Hr9QJG8CxpqUlI5ZWAP1/oETW
 fEuqZybopxyBabCZghKQl1589jfAsoM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-d-EWvkQQNhOZ5xqTmAOxwA-1; Wed,
 15 Nov 2023 20:43:54 -0500
X-MC-Unique: d-EWvkQQNhOZ5xqTmAOxwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 040ED1C05EC9;
 Thu, 16 Nov 2023 01:43:54 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B58F7C15881;
 Thu, 16 Nov 2023 01:43:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 08/19] qapi/schema: add static typing and assertions to
 lookup_type()
Date: Wed, 15 Nov 2023 20:43:39 -0500
Message-ID: <20231116014350.653792-9-jsnow@redhat.com>
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

This function is a bit hard to type as-is; mypy needs some assertions to
assist with the type narrowing.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index a1094283828..3308f334872 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -968,8 +968,12 @@ def lookup_entity(self, name, typ=None):
             return None
         return ent
 
-    def lookup_type(self, name):
-        return self.lookup_entity(name, QAPISchemaType)
+    def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
+        typ = self.lookup_entity(name, QAPISchemaType)
+        if typ is None:
+            return None
+        assert isinstance(typ, QAPISchemaType)
+        return typ
 
     def resolve_type(self, name, info, what):
         typ = self.lookup_type(name)
-- 
2.41.0


