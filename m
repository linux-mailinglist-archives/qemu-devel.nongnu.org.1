Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F37F9B3CE71
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 19:58:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNaQ-0001sd-Iy; Sat, 30 Aug 2025 11:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3TB-0005cn-WC
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us3TA-0005gl-6J
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 14:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756490698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/cobAJwGDXoAJ4ItSXx4mK66gP1Qq/p1TnARKbFAtM=;
 b=Remka6pqBauT4NNlHbY47UpLrGvW69vpz2G2VOEtOgL4xBgrUUYdXa7L5O8DK5BJ4zLrCA
 UF8fJwrIf7lax4Wt9n1qaKLdbaAvxgeAcdtZ0r9LiWxe4PeTbYQdepTS4zdR7YOHiq8xWk
 zgCqGHBZjcqPe4BrGitAulhU9eJZeK8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-xVYzwrrmN42N4zYGB54JbA-1; Fri,
 29 Aug 2025 14:04:54 -0400
X-MC-Unique: xVYzwrrmN42N4zYGB54JbA-1
X-Mimecast-MFC-AGG-ID: xVYzwrrmN42N4zYGB54JbA_1756490693
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F88A19560A5; Fri, 29 Aug 2025 18:04:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEFAB19560B4; Fri, 29 Aug 2025 18:04:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/14] util: convert error-report & log to message API for
 timestamp
Date: Fri, 29 Aug 2025 19:03:50 +0100
Message-ID: <20250829180354.2922145-11-berrange@redhat.com>
In-Reply-To: <20250829180354.2922145-1-berrange@redhat.com>
References: <20250829180354.2922145-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Both the error-report and log APIs can optional emit a timestamp
as a prefix on messages, with the '-msg timestamp=on' command
line flag is set.

Convert them to the new message API for formatting the context
prefix, guaranteeign they will have matching behaviour going
forward.

There is no change in output format for either logs or errors
with this conversion.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/error-report.h    |  1 -
 system/vl.c                    |  7 ++++++-
 tests/unit/test-error-report.c |  3 ++-
 util/error-report.c            | 18 ++++--------------
 util/log.c                     | 21 +++++++++------------
 5 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3ae2357fda..c8000778ec 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -70,7 +70,6 @@ void error_init(const char *argv0);
                               fmt, ##__VA_ARGS__);      \
     })
 
-extern bool message_with_timestamp;
 extern bool error_with_guestname;
 extern const char *error_guest_name;
 
diff --git a/system/vl.c b/system/vl.c
index a64fd90d4a..696dd92669 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -26,6 +26,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "qemu/message.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
 #include "exec/cpu-common.h"
@@ -813,8 +814,12 @@ static void realtime_init(void)
 
 static void configure_msg(QemuOpts *opts)
 {
-    message_with_timestamp = qemu_opt_get_bool(opts, "timestamp", false);
+    int flags = 0;
+    if (qemu_opt_get_bool(opts, "timestamp", false)) {
+        flags |= QMESSAGE_FORMAT_TIMESTAMP;
+    }
     error_with_guestname = qemu_opt_get_bool(opts, "guest-name", false);
+    qmessage_set_format(flags);
 }
 
 
diff --git a/tests/unit/test-error-report.c b/tests/unit/test-error-report.c
index 54319c86c9..78f8b57660 100644
--- a/tests/unit/test-error-report.c
+++ b/tests/unit/test-error-report.c
@@ -13,6 +13,7 @@
 
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/message.h"
 
 static void
 test_error_report_simple(void)
@@ -90,7 +91,7 @@ static void
 test_error_report_timestamp(void)
 {
     if (g_test_subprocess()) {
-        message_with_timestamp = true;
+        qmessage_set_format(QMESSAGE_FORMAT_TIMESTAMP);
         warn_report("warn");
         error_report("err");
         return;
diff --git a/util/error-report.c b/util/error-report.c
index 1b17c11de1..9ee164b1dd 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
+#include "qemu/message.h"
 
 /*
  * @report_type is the type of message: error, warning or
@@ -24,8 +25,6 @@ typedef enum {
     REPORT_TYPE_INFO,
 } report_type;
 
-/* Prepend timestamp to messages */
-bool message_with_timestamp;
 bool error_with_guestname;
 const char *error_guest_name;
 
@@ -169,13 +168,6 @@ static void print_loc(void)
     }
 }
 
-static char *
-real_time_iso8601(void)
-{
-    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-    return g_date_time_format_iso8601(dt);
-}
-
 /*
  * Print a message to current monitor if we have one, else to stderr.
  * @report_type is the type of message: error, warning or informational.
@@ -186,12 +178,10 @@ real_time_iso8601(void)
 G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
-    gchar *timestr;
+    g_autofree gchar *context = qmessage_context(QMESSAGE_CONTEXT_SKIP_MONITOR);
 
-    if (message_with_timestamp && !monitor_cur()) {
-        timestr = real_time_iso8601();
-        error_printf("%s ", timestr);
-        g_free(timestr);
+    if (context != NULL) {
+        error_printf("%s", context);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
diff --git a/util/log.c b/util/log.c
index 2642a55c59..fc900cde0c 100644
--- a/util/log.c
+++ b/util/log.c
@@ -22,6 +22,7 @@
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/message.h"
 #include "qemu/cutils.h"
 #include "trace/control.h"
 #include "qemu/thread.h"
@@ -152,25 +153,21 @@ static __thread bool incomplete;
 void qemu_log(const char *fmt, ...)
 {
     FILE *f;
-    g_autofree const char *timestr = NULL;
-
     /*
-     * Prepare the timestamp *outside* the logging
-     * lock so it better reflects when the message
-     * was emitted if we are delayed acquiring the
-     * mutex
+     * Prepare the context *outside* the logging
+     * lock so any timestamp better reflects when
+     * the message was emitted if we are delayed
+     * acquiring the mutex
      */
-    if (message_with_timestamp && !incomplete) {
-        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-        timestr = g_date_time_format_iso8601(dt);
-    }
+    g_autofree const char *context =
+        incomplete ? NULL : qmessage_context(0);
 
     f = qemu_log_trylock();
     if (f) {
         va_list ap;
 
-        if (timestr) {
-            fprintf(f, "%s ", timestr);
+        if (context != NULL) {
+            fwrite(context, 1, strlen(context), f);
         }
 
         va_start(ap, fmt);
-- 
2.50.1


