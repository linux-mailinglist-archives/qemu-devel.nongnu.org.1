Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98656833366
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 10:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR82k-00081k-Ix; Sat, 20 Jan 2024 04:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rR82i-00080Z-6c
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:53:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rR82g-000633-DF
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705744413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPjvbtvG4s60pZA7OovXeTzYsB0aBIBak1bvGdJ+5xQ=;
 b=Rh7+N8IBhQaaLf/QjrssNMN6kS2N20cAi4CrpQxkSuM9Nz31Lle8ModW8AtZvrCLFmLSuC
 HJzSUpk83hJH1xu0HossRPUqkUAvB90uT8HhSqVa6onXG2vez4pqVevKyXFhKspWarB8Tk
 nnCkE2BVu/YOBeNkGIjgc38+ZcuefSg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-_IOdWkFJMXCYJYWkXCFNrQ-1; Sat,
 20 Jan 2024 04:53:29 -0500
X-MC-Unique: _IOdWkFJMXCYJYWkXCFNrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3DC729AC033;
 Sat, 20 Jan 2024 09:53:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 736592166B33;
 Sat, 20 Jan 2024 09:53:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5841F21E66FB; Sat, 20 Jan 2024 10:53:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	peter.maydell@linaro.org,
	jsnow@redhat.com
Subject: [PATCH 3/7] qapi: Fix dangling references to
 docs/devel/qapi-code-gen.txt
Date: Sat, 20 Jan 2024 10:53:23 +0100
Message-ID: <20240120095327.666239-4-armbru@redhat.com>
In-Reply-To: <20240120095327.666239-1-armbru@redhat.com>
References: <20240120095327.666239-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

Conversion of docs/devel/qapi-code-gen.txt to ReST left several
dangling references behind.  Fix them to point to
docs/devel/qapi-code-gen.rst.

Fixes: f7aa076dbdfc (docs: convert qapi-code-gen.txt to ReST)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/writing-monitor-commands.rst | 2 +-
 qapi/introspect.json                    | 4 ++--
 include/qapi/visitor.h                  | 2 +-
 include/qemu/yank.h                     | 2 +-
 qapi/qapi-util.c                        | 2 +-
 util/yank.c                             | 2 +-
 scripts/qapi/parser.py                  | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
index 3b3d5517a2..b6ee4fa063 100644
--- a/docs/devel/writing-monitor-commands.rst
+++ b/docs/devel/writing-monitor-commands.rst
@@ -8,7 +8,7 @@ This document doesn't discuss QMP protocol level details, nor does it dive
 into the QAPI framework implementation.
 
 For an in-depth introduction to the QAPI framework, please refer to
-docs/devel/qapi-code-gen.txt.  For the QMP protocol, see the
+:doc:`qapi-code-gen`.  For the QMP protocol, see the
 :doc:`/interop/qmp-spec`.
 
 New commands may be implemented in QMP only.  New HMP commands should be
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 9173e60fdd..ebc4e199d2 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -260,8 +260,8 @@
 # Additional SchemaInfo members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
-#     members' wire encoding is distinct, see
-#     docs/devel/qapi-code-gen.txt section Alternate types.
+#     members' wire encoding is distinct, see :doc:`qapi-code-gen`
+#     section Alternate types.
 #
 # On the wire, this can be any of the members.
 #
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index d53a84c9ba..27b85d4700 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -39,7 +39,7 @@
  * limitations; see the documentation for each visitor for more
  * details on what it supports.  Also, see visitor-impl.h for the
  * callback contracts implemented by each visitor, and
- * docs/devel/qapi-code-gen.txt for more about the QAPI code
+ * docs/devel/qapi-code-gen.rst for more about the QAPI code
  * generator.
  *
  * All of the visitors are created via:
diff --git a/include/qemu/yank.h b/include/qemu/yank.h
index 1907150933..3d88af6996 100644
--- a/include/qemu/yank.h
+++ b/include/qemu/yank.h
@@ -45,7 +45,7 @@ void yank_unregister_instance(const YankInstance *instance);
  * yank_register_function: Register a yank function
  *
  * This registers a yank function. All limitations of qmp oob commands apply
- * to the yank function as well. See docs/devel/qapi-code-gen.txt under
+ * to the yank function as well. See docs/devel/qapi-code-gen.rst under
  * "An OOB-capable command handler must satisfy the following conditions".
  *
  * This function is thread-safe.
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 63596e11c5..65a7d18437 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -112,7 +112,7 @@ bool qapi_bool_parse(const char *name, const char *value, bool *obj, Error **err
  * It may be prefixed by __RFQDN_ (downstream extension), where RFQDN
  * may contain only letters, digits, hyphen and period.
  * The special exception for enumeration names is not implemented.
- * See docs/devel/qapi-code-gen.txt for more on QAPI naming rules.
+ * See docs/devel/qapi-code-gen.rst for more on QAPI naming rules.
  * Keep this consistent with scripts/qapi-gen.py!
  * If @complete, the parse fails unless it consumes @str completely.
  * Return its length on success, -1 on failure.
diff --git a/util/yank.c b/util/yank.c
index abf47c346d..eaac50539c 100644
--- a/util/yank.c
+++ b/util/yank.c
@@ -35,7 +35,7 @@ typedef struct YankInstanceEntry YankInstanceEntry;
 /*
  * This lock protects the yank_instance_list below. Because it's taken by
  * OOB-capable commands, it must be "fast", i.e. it may only be held for a
- * bounded, short time. See docs/devel/qapi-code-gen.txt for additional
+ * bounded, short time. See docs/devel/qapi-code-gen.rst for additional
  * information.
  */
 static QemuMutex yank_lock;
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index bf31018aef..48cd55a38c 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -71,7 +71,7 @@ class QAPISchemaParser:
     Parse QAPI schema source.
 
     Parse a JSON-esque schema file and process directives.  See
-    qapi-code-gen.txt section "Schema Syntax" for the exact syntax.
+    qapi-code-gen.rst section "Schema Syntax" for the exact syntax.
     Grammatical validation is handled later by `expr.check_exprs()`.
 
     :param fname: Source file name.
-- 
2.43.0


