Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F7C7ED8F5
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 02:45:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RQa-0005M8-Uw; Wed, 15 Nov 2023 20:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQJ-0005GP-N5
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r3RQE-0001zw-2D
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 20:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700099037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbiChjSL/2Si4PQ35HQcRARm4HUx3rnT4JAXvzmVC2A=;
 b=LMzcP+xbLjGQU4lJ9Vo9wxgWNTcGSaF51/XLXUZrkveez/uLdcN4wBZPfGMFCfCgHXRxiJ
 w1pqxs+f9jQ9T528oZKxM2T8ji+siVcWHysb4iGfzxn1TSHY8ILvchBin4WAwjPm28SFgA
 qV83lCHQVqGmz2ugNq32Xux9KLFTHOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-_LK-HtIcNYyX7P_NWkR8kQ-1; Wed, 15 Nov 2023 20:43:53 -0500
X-MC-Unique: _LK-HtIcNYyX7P_NWkR8kQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 504D7101A529;
 Thu, 16 Nov 2023 01:43:53 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.32.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA8DC15881;
 Thu, 16 Nov 2023 01:43:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 06/19] qapi/schema: adjust type narrowing for mypy's benefit
Date: Wed, 15 Nov 2023 20:43:37 -0500
Message-ID: <20231116014350.653792-7-jsnow@redhat.com>
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

We already take care to perform some type narrowing for arg_type and
ret_type, but not in a way where mypy can utilize the result. A simple
change to use a temporary variable helps the medicine go down.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 4600a566005..a1094283828 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -825,13 +825,14 @@ def __init__(self, name, info, doc, ifcond, features,
     def check(self, schema):
         super().check(schema)
         if self._arg_type_name:
-            self.arg_type = schema.resolve_type(
+            arg_type = schema.resolve_type(
                 self._arg_type_name, self.info, "command's 'data'")
-            if not isinstance(self.arg_type, QAPISchemaObjectType):
+            if not isinstance(arg_type, QAPISchemaObjectType):
                 raise QAPISemError(
                     self.info,
                     "command's 'data' cannot take %s"
-                    % self.arg_type.describe())
+                    % arg_type.describe())
+            self.arg_type = arg_type
             if self.arg_type.variants and not self.boxed:
                 raise QAPISemError(
                     self.info,
@@ -848,8 +849,7 @@ def check(self, schema):
             if self.name not in self.info.pragma.command_returns_exceptions:
                 typ = self.ret_type
                 if isinstance(typ, QAPISchemaArrayType):
-                    typ = self.ret_type.element_type
-                    assert typ
+                    typ = typ.element_type
                 if not isinstance(typ, QAPISchemaObjectType):
                     raise QAPISemError(
                         self.info,
@@ -885,13 +885,14 @@ def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
     def check(self, schema):
         super().check(schema)
         if self._arg_type_name:
-            self.arg_type = schema.resolve_type(
+            typ = schema.resolve_type(
                 self._arg_type_name, self.info, "event's 'data'")
-            if not isinstance(self.arg_type, QAPISchemaObjectType):
+            if not isinstance(typ, QAPISchemaObjectType):
                 raise QAPISemError(
                     self.info,
                     "event's 'data' cannot take %s"
-                    % self.arg_type.describe())
+                    % typ.describe())
+            self.arg_type = typ
             if self.arg_type.variants and not self.boxed:
                 raise QAPISemError(
                     self.info,
-- 
2.41.0


