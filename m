Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24433827766
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:26:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIh-0002yx-Ks; Mon, 08 Jan 2024 13:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIW-0002vS-IT
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIU-0002oS-Qu
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7DF/RSvyVVADnLk1YAAP5Rrf/OJ2tNRb9cb1fbx0Ok=;
 b=PnkSgqrZq23JLjyB8Qh2If0MgN58i+EKxsaookN8UOyq/MdfD1gQc8UbsIVv0hjgor3EjY
 gNUvYs5aP7BqjEholHymQ1WTHonm4xPGtxSpzwsqamC5BxMX6+BqlniLdOyxWb9hF3Td4Z
 ea2EGWUkpMvaXtvMIxoeeX5YTdlq5RE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-0UHXGZHyOY2K6lN52_hWFA-1; Mon, 08 Jan 2024 13:24:22 -0500
X-MC-Unique: 0UHXGZHyOY2K6lN52_hWFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 321B383B8E8;
 Mon,  8 Jan 2024 18:24:22 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 252813C2E;
 Mon,  8 Jan 2024 18:24:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/29] migration: adapt to new import path for qobject data
 type headers
Date: Mon,  8 Jan 2024 18:23:47 +0000
Message-ID: <20240108182405.1135436-12-berrange@redhat.com>
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
 migration/dirtyrate.c          | 2 +-
 migration/migration-hmp-cmds.c | 2 +-
 migration/migration.c          | 4 ++--
 migration/migration.h          | 2 +-
 migration/options.c            | 4 ++--
 migration/page_cache.c         | 2 +-
 migration/ram.c                | 2 +-
 migration/savevm.c             | 2 +-
 migration/vmstate.c            | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 62d86b8be2..a6ec21222d 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -25,7 +25,7 @@
 #include "dirtyrate.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "exec/memory.h"
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99710c8ffb..fda69726f6 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
 #include "qemu/cutils.h"
diff --git a/migration/migration.c b/migration/migration.c
index 3ce04b2aaf..2eb6341b49 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -43,8 +43,8 @@
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qerror.h"
+#include "qobject/qnull.h"
 #include "qemu/rcu.h"
 #include "block.h"
 #include "postcopy-ram.h"
diff --git a/migration/migration.h b/migration/migration.h
index cf2c9c88e0..e1e4b3e8d9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -17,7 +17,7 @@
 #include "exec/cpu-common.h"
 #include "hw/qdev-core.h"
 #include "qapi/qapi-types-migration.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine_int.h"
 #include "io/channel.h"
diff --git a/migration/options.c b/migration/options.c
index 8d8ec73ad9..66b980a102 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -18,8 +18,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qerror.h"
+#include "qobject/qnull.h"
 #include "sysemu/runstate.h"
 #include "migration/colo.h"
 #include "migration/misc.h"
diff --git a/migration/page_cache.c b/migration/page_cache.c
index 6d4f7a9bbc..f262f90675 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
 #include "page_cache.h"
diff --git a/migration/ram.c b/migration/ram.c
index 8c7886ab79..8cc1626351 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -47,7 +47,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qapi-commands-migration.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "trace.h"
 #include "exec/ram_addr.h"
 #include "exec/target_page.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index c8d08fa079..bdc30caf5b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -45,7 +45,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
 #include "exec/memory.h"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index ef26f26ccd..2e439a7336 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -15,7 +15,7 @@
 #include "migration/vmstate.h"
 #include "savevm.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
-- 
2.43.0


