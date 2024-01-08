Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2767827769
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:26:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIi-0002zY-5c; Mon, 08 Jan 2024 13:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIa-0002xF-63
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIY-0002rH-D5
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ztuRVzi5SgFqRtpdxAKUj2Y81s6mBo0mhG6sRum4Xoo=;
 b=C079OdustdPJPmr9UWnKmhjsez4KbKEoHH67hWdfPuvNc3EogRVVU54AVCUw+WFeO37aAx
 w8mxpDzBd9DFVrXn7wkUkb1pK1xl7Js1dk536zT8f4g2KqhUfJOxwJfWlnAIrSjA4PKWD3
 pLxowlUndMFOBdGW4KgXjeJhqHznX3A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-RifNenbwOJ225UazgzjciA-1; Mon,
 08 Jan 2024 13:24:26 -0500
X-MC-Unique: RifNenbwOJ225UazgzjciA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0A6D3C025C3;
 Mon,  8 Jan 2024 18:24:25 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E59D73C2E;
 Mon,  8 Jan 2024 18:24:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/29] qapi: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:50 +0000
Message-ID: <20240108182405.1135436-15-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/opts-visitor.c           |  2 +-
 qapi/qapi-clone-visitor.c     |  2 +-
 qapi/qapi-dealloc-visitor.c   |  2 +-
 qapi/qapi-forward-visitor.c   | 16 ++++++++--------
 qapi/qapi-util.c              |  2 +-
 qapi/qapi-visit-core.c        |  2 +-
 qapi/qmp-dispatch.c           |  8 ++++----
 qapi/qmp-event.c              |  6 +++---
 qapi/qmp-registry.c           |  2 +-
 qapi/qobject-input-visitor.c  | 16 ++++++++--------
 qapi/qobject-output-visitor.c | 12 ++++++------
 qapi/string-input-visitor.c   |  4 ++--
 12 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 8f1efab8b9..110e916123 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qapi/opts-visitor.h"
 #include "qemu/queue.h"
 #include "qemu/option_int.h"
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index c45c5caa3b..af195b4c60 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -12,7 +12,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 
 struct QapiCloneVisitor {
     Visitor visitor;
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index ef283f2966..57a2c904bb 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qapi/visitor-impl.h"
 
 struct QapiDeallocVisitor
diff --git a/qapi/qapi-forward-visitor.c b/qapi/qapi-forward-visitor.c
index e36d9bc9ba..54a0044ff8 100644
--- a/qapi/qapi-forward-visitor.c
+++ b/qapi/qapi-forward-visitor.c
@@ -14,14 +14,14 @@
 #include "qapi/forward-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 
 struct ForwardFieldVisitor {
diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
index 63596e11c5..4b6e596a33 100644
--- a/qapi/qapi-util.c
+++ b/qapi/qapi-util.c
@@ -14,7 +14,7 @@
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qemu/ctype.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 
 CompatPolicy compat_policy;
 
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 6c13510a2b..326821ed91 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -15,7 +15,7 @@
 #include "qemu/osdep.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qapi/visitor.h"
 #include "qapi/visitor-impl.h"
 #include "trace.h"
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 555528b6bb..902481b14c 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -16,12 +16,12 @@
 #include "block/aio.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qapi/qmp-registry.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qmp/qbool.h"
+#include "qobject/qbool.h"
 #include "qemu/coroutine.h"
 #include "qemu/main-loop.h"
 
diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 0fe0d0a5a6..11cb6ace99 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -14,9 +14,9 @@
 #include "qemu/osdep.h"
 
 #include "qapi/qmp-event.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
 
 static void timestamp_put(QDict *qdict)
 {
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index 485bc5e6fc..ac989074ed 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options,
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 3e8aca6b15..0f06e54561 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -19,14 +19,14 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/keyval.h"
 
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 74770edd73..13d3ae95b7 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -17,12 +17,12 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 typedef struct QStackEntry {
     QObject *value;
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 197139c1c0..28c217fbbd 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -14,8 +14,8 @@
 #include "qapi/error.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/visitor-impl.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qerror.h"
+#include "qobject/qnull.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 
-- 
2.43.0


