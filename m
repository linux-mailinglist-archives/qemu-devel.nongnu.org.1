Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC242B5201E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 20:16:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPBp-0008HW-R0; Wed, 10 Sep 2025 14:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBi-00089v-LA
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBg-0004kE-5c
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXwL0r/tjoy05r/8F/g9cS3d2URvCgjgPUpPVhxoyGM=;
 b=b8f2kuvoDilgv3lcRmGmZQO4jdEnR71/U0zYzYBsLZYh/ONtNDQLfEW2QZCdswTu3CysFA
 zZZP1LotStWfeAbekP2vukwvXp0byNgl1gbRuO1pFsR8awrY2rNtM4g1BltgCLFKl+w/PN
 xcVc9EbDh5QtIgsdV/wi1jn9Hw7ZY9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-iQ9rIKKqPgGrn5beHaetKA-1; Wed,
 10 Sep 2025 14:04:51 -0400
X-MC-Unique: iQ9rIKKqPgGrn5beHaetKA-1
X-Mimecast-MFC-AGG-ID: iQ9rIKKqPgGrn5beHaetKA_1757527490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 486D2180057F; Wed, 10 Sep 2025 18:04:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EF491800578; Wed, 10 Sep 2025 18:04:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 11/20] monitor: move error_vprintf() back to error-report.c
Date: Wed, 10 Sep 2025 19:03:48 +0100
Message-ID: <20250910180357.320297-12-berrange@redhat.com>
In-Reply-To: <20250910180357.320297-1-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This conceptually reverts 397d30e9401d2da96dbdf0ce49805d6d4bb68833.
The discussion around stubs in that commit does not appear to be
important to the current state of the codebase.

This makes the error_vprintf() impl source file match that
of error_printf(), and also match the header where it is declared.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor.c              | 13 -------------
 stubs/monitor-core.c           |  5 +++++
 tests/unit/test-util-sockets.c |  1 +
 util/error-report.c            | 13 +++++++++++++
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 03dbe5d131..e1e5dbfcbe 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -268,19 +268,6 @@ void monitor_printc(Monitor *mon, int c)
     monitor_printf(mon, "'");
 }
 
-/*
- * Print to current monitor if we have one, else to stderr.
- */
-int error_vprintf(const char *fmt, va_list ap)
-{
-    Monitor *cur_mon = monitor_cur();
-
-    if (cur_mon && !monitor_cur_is_qmp()) {
-        return monitor_vprintf(cur_mon, fmt, ap);
-    }
-    return vfprintf(stderr, fmt, ap);
-}
-
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 1894cdfe1f..b498a0f1af 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -7,6 +7,11 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
+bool monitor_cur_is_qmp(void)
+{
+    return false;
+}
+
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
     return NULL;
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index ee66d727c3..bd48731ea2 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -72,6 +72,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
  * otherwise we get duplicate syms at link time.
  */
 Monitor *monitor_cur(void) { return cur_mon; }
+bool monitor_cur_is_qmp(void) { return false; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
 
diff --git a/util/error-report.c b/util/error-report.c
index 1b17c11de1..79b6f23e64 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -29,6 +29,19 @@ bool message_with_timestamp;
 bool error_with_guestname;
 const char *error_guest_name;
 
+/*
+ * Print to current monitor if we have one, else to stderr.
+ */
+int error_vprintf(const char *fmt, va_list ap)
+{
+    Monitor *cur_mon = monitor_cur();
+
+    if (cur_mon && !monitor_cur_is_qmp()) {
+        return monitor_vprintf(cur_mon, fmt, ap);
+    }
+    return vfprintf(stderr, fmt, ap);
+}
+
 int error_printf(const char *fmt, ...)
 {
     va_list ap;
-- 
2.50.1


