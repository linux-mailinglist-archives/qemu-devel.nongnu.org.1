Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9D82776A
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:26:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIo-00032y-3P; Mon, 08 Jan 2024 13:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIl-00031u-Km
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIj-0002wx-TL
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Te3VAg2q1Z0QU69Ozhj7Hs1LMEbM7/wmXnrazX9/D0I=;
 b=g0E93bHS3lZeD7t0JJql2MVmAXadtcodEkhsRffkSwYdbQOcoUuV+BN04E65IOKKUOVpAY
 F3Fj3GXKkfiw58ZUFHwQ0Le37GtZE7rhQMly5lmMCuY1exhCyj3S0URCRt1WWilvtrnAAQ
 kk1M4XWFbqmckn6gyovummj4fYHlazo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-_CXC9NsHMxqH43nTYzxqVg-1; Mon, 08 Jan 2024 13:24:38 -0500
X-MC-Unique: _CXC9NsHMxqH43nTYzxqVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA8FD83B8E5;
 Mon,  8 Jan 2024 18:24:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9760E3C2E;
 Mon,  8 Jan 2024 18:24:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 23/29] system: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:59 +0000
Message-ID: <20240108182405.1135436-24-berrange@redhat.com>
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
 system/balloon.c           | 2 +-
 system/cpus.c              | 2 +-
 system/device_tree.c       | 2 +-
 system/dirtylimit.c        | 2 +-
 system/qdev-monitor.c      | 8 ++++----
 system/rtc.c               | 2 +-
 system/runstate-hmp-cmds.c | 2 +-
 system/tpm.c               | 2 +-
 system/vl.c                | 8 ++++----
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/system/balloon.c b/system/balloon.c
index fda7af832e..0b6220d1d6 100644
--- a/system/balloon.c
+++ b/system/balloon.c
@@ -30,7 +30,7 @@
 #include "sysemu/balloon.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "trace.h"
 
 static QEMUBalloonEvent *balloon_event_fn;
diff --git a/system/cpus.c b/system/cpus.c
index a444a747f0..f1df174d9a 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -29,7 +29,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "exec/gdbstub.h"
 #include "sysemu/hw_accel.h"
 #include "exec/cpu-common.h"
diff --git a/system/device_tree.c b/system/device_tree.c
index eb5166ca36..045cfece3e 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -28,7 +28,7 @@
 #include "hw/boards.h"
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "monitor/hmp.h"
 
 #include <libfdt.h>
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 495c7a7082..6ffeff7cdb 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qapi/qapi-commands-migration.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "sysemu/dirtyrate.h"
 #include "sysemu/dirtylimit.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5..a66abd4c4c 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -25,10 +25,10 @@
 #include "sysemu/arch_init.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
-#include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qstring.h"
+#include "qapi/qmp-registry.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/system/rtc.c b/system/rtc.c
index 4904581abe..7fb9ec1e4c 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index 2df670f0c0..be1d676992 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/accel.h"
 
 void hmp_info_status(Monitor *mon, const QDict *qdict)
diff --git a/system/tpm.c b/system/tpm.c
index 7164ea7ff1..fe6782e620 100644
--- a/system/tpm.c
+++ b/system/tpm.c
@@ -16,7 +16,7 @@
 
 #include "qapi/error.h"
 #include "qapi/qapi-commands-tpm.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/tpm.h"
 #include "qemu/config-file.h"
diff --git a/system/vl.c b/system/vl.c
index 6b87bfa32c..810ab180aa 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -31,9 +31,9 @@
 #include "hw/qdev-properties.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
+#include "qobject/qjson.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
@@ -129,7 +129,7 @@
 #include "qapi/qapi-visit-qom.h"
 #include "qapi/qapi-commands-ui.h"
 #include "block/qdict.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "sysemu/iothread.h"
 #include "qemu/guest-random.h"
 #include "qemu/keyval.h"
-- 
2.43.0


