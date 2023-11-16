Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA27ED905
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQP-0005Jn-Lp; Wed, 15 Nov 2023 20:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQJ-0005GL-L1
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQF-000206-D4
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oK5TLvGHeEz6GjH3xnyCpoO4sbbIXKIwxy0cQYHdnKU=;
 b=dlazBobFX5fhJ1/b2hDjl3r7HQON6JUgVDe2mNb5vzWH21p6B9oEM1w3lidjjxoASueq6V
 OmPfJbq8DDDhTTytzvtqrVaU/PCQGifPgN/zKD2z8CSoKgb65F8MUhxa/LOs+aaTmtU91H
 +RY7eYQGn8Xj9sGQqiPovIovNtRJDaU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-D7I6cy5ZNd-imEiGH6G__g-1; Wed,
 15 Nov 2023 20:43:54 -0500
X-MC-Unique: D7I6cy5ZNd-imEiGH6G__g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A656E3813F43;
 Thu, 16 Nov 2023 01:43:54 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66600C15881;
 Thu, 16 Nov 2023 01:43:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 10/19] qapi/schema: make QAPISchemaArrayType.element_type
 non-Optional
Date: Wed, 15 Nov 2023 20:43:41 -0500
Message-ID: <20231116014350.653792-11-jsnow@redhat.com>
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

This field should always be present and defined. Change this to be a
runtime @property that can emit an error if it's called prior to
check().

This helps simplify typing by avoiding the need to interrogate the value
for None at multiple callsites.

RFC: Yes, this is a slightly different technique than the one I used for
QAPISchemaObjectTypeMember.type; I think I prefer this one as being a
little less hokey, but it is more SLOC. Dealer's choice for which style
wins out -- now you have an example of both.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index c9a194103e1..462acb2bb61 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -366,7 +366,16 @@ def __init__(self, name, info, element_type):
         super().__init__(name, info, None)
         assert isinstance(element_type, str)
         self._element_type_name = element_type
-        self.element_type = None
+        self._element_type: Optional[QAPISchemaType] = None
+
+    @property
+    def element_type(self) -> QAPISchemaType:
+        if self._element_type is None:
+            raise RuntimeError(
+                "QAPISchemaArray has no element_type until "
+                "after check() has been run."
+            )
+        return self._element_type
 
     def need_has_if_optional(self):
         # When FOO is an array, we still need has_FOO to distinguish
@@ -375,7 +384,7 @@ def need_has_if_optional(self):
 
     def check(self, schema):
         super().check(schema)
-        self.element_type = schema.resolve_type(
+        self._element_type = schema.resolve_type(
             self._element_type_name, self.info,
             self.info and self.info.defn_meta)
         assert not isinstance(self.element_type, QAPISchemaArrayType)
-- 
2.41.0


