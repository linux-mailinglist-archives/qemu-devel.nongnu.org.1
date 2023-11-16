Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F807ED901
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:48:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQY-0005LI-Bs; Wed, 15 Nov 2023 20:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQL-0005In-3y
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQF-000208-HB
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXJzx/jpVoPhmJMyDwQ8ccRKvqe6ESeYERwYom9inLk=;
 b=Ow6rXgaBaVsA59YbAe7uc1uP5jKzjur9n0Cp+XCrdEJzLOdnY108IbCK8Qp3guB8Zn5CmB
 j481prJjXrWtPqgNZHpMvLdg8J6LSQdBO/6xOWKz0imZw2UVYuNZfpLJxx5I2HxWwAKSFQ
 ndo0mQ+29PUuklU0mwdI/b8yG7a25As=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-Mt4ACs1HMxGBvCyWTu9jfg-1; Wed, 15 Nov 2023 20:43:55 -0500
X-MC-Unique: Mt4ACs1HMxGBvCyWTu9jfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05BA1101A529;
 Thu, 16 Nov 2023 01:43:55 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6CE3C15881;
 Thu, 16 Nov 2023 01:43:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 11/19] qapi/schema: fix QAPISchemaArrayType.check's call to
 resolve_type
Date: Wed, 15 Nov 2023 20:43:42 -0500
Message-ID: <20231116014350.653792-12-jsnow@redhat.com>
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

There's more conditionals in here than we can reasonably pack into a
terse little statement, so break it apart into something more explicit.

(When would a built-in array ever cause a QAPISemError? I don't know,
maybe never - but the type system wasn't happy all the same.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 462acb2bb61..164d86c4064 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -384,9 +384,16 @@ def need_has_if_optional(self):
 
     def check(self, schema):
         super().check(schema)
+
+        if self.info:
+            assert self.info.defn_meta  # guaranteed to be set by expr.py
+            what = self.info.defn_meta
+        else:
+            what = 'built-in array'
+
         self._element_type = schema.resolve_type(
-            self._element_type_name, self.info,
-            self.info and self.info.defn_meta)
+            self._element_type_name, self.info, what
+        )
         assert not isinstance(self.element_type, QAPISchemaArrayType)
 
     def set_module(self, schema):
-- 
2.41.0


