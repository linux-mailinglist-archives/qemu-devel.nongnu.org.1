Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1A827778
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:27:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIi-000301-Rc; Mon, 08 Jan 2024 13:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIc-0002xy-6r
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIa-0002s1-I1
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sf7uXD4qxglpqODLrxbmswXtvbKfOeIIGkMSY1n4eeg=;
 b=bJMEvACv32WhscYzbCXx4XukQqmREilTUoDNDwQYS6Nv8Tq2QiTTHmYCQIQvNy9e6OhKTp
 Zo8LOsijrhzbrMhL9b16u7AzDSNkzBRhwMemnTa0N30k2kBJXQitPY4+VSZ+h+8hEB5Rp+
 Qmj8aw7WK73TdmjuYgB9S47lwKX5fLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-F9g0qfVwPKmslSEFbgq1OQ-1; Mon, 08 Jan 2024 13:24:23 -0500
X-MC-Unique: F9g0qfVwPKmslSEFbgq1OQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BD0583B8E7;
 Mon,  8 Jan 2024 18:24:23 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8ED423C2E;
 Mon,  8 Jan 2024 18:24:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 12/29] monitor: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:48 +0000
Message-ID: <20240108182405.1135436-13-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/fds.c              | 2 +-
 monitor/hmp-cmds-target.c  | 2 +-
 monitor/hmp-cmds.c         | 2 +-
 monitor/hmp.c              | 4 ++--
 monitor/monitor-internal.h | 4 ++--
 monitor/monitor.c          | 2 +-
 monitor/qmp-cmds.c         | 2 +-
 monitor/qmp.c              | 6 +++---
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index d86c2c674c..0d4c54140e 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -26,7 +26,7 @@
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "sysemu/runstate.h"
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index d9fbcac08d..fb258e614c 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -28,7 +28,7 @@
 #include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/hw_accel.h"
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 871898ac46..ae05b41724 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "hw/intc/intc.h"
 #include "qemu/log.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 69c1b7e98a..707abfbe4e 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,8 +27,8 @@
 #include "hw/qdev-core.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 252de85681..92c8cb3b66 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -28,8 +28,8 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-types-control.h"
-#include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/json-parser.h"
+#include "qapi/qmp-registry.h"
+#include "qobject/json-parser.h"
 #include "qemu/readline.h"
 #include "sysemu/iothread.h"
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 01ede1babd..1c4ad4fd3d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -28,7 +28,7 @@
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-visit-control.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "sysemu/qtest.h"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index b0f948d337..a79262f68d 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -27,7 +27,7 @@
 #include "qapi/qapi-init-commands.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qapi/type-helpers.h"
 #include "hw/mem/memory-device.h"
 #include "hw/intc/intc.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 6eee450fe4..354941ea26 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -28,9 +28,9 @@
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
 #include "trace.h"
 
 /*
-- 
2.43.0


