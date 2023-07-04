Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22C746A70
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaHn-0000S1-5T; Tue, 04 Jul 2023 03:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGaHb-0000PJ-7k
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGaHY-0006hR-HV
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688455023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RysB1AS1/QaguR1e1QrNkMenhrfrDs5Ggmy1o/mZjPY=;
 b=drN9WpHqjzWngnUBc5Glz5p48mEAI3l9zyHocR9tbw/X9MZxKngaK0m3VtoabZaz8hnXUp
 S6jcPlFqyMD6Z94Q3BscF9Y9ZWZM+90OZHaDMsdvl31cYsWICZ0jDR1wtgBaLKoqdUxnnX
 L3c6HTz89/3sh0vi0/rmxoGxMgyhjW4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-LsgbqaJ4O2ibza8mRMPtCA-1; Tue, 04 Jul 2023 03:17:02 -0400
X-MC-Unique: LsgbqaJ4O2ibza8mRMPtCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E26AB858EED
 for <qemu-devel@nongnu.org>; Tue,  4 Jul 2023 07:17:01 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F37F52023439;
 Tue,  4 Jul 2023 07:17:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/3] tests/qtest: Move mkimg() and have_qemu_img() from libqos
 to libqtest
Date: Tue,  4 Jul 2023 09:16:54 +0200
Message-Id: <20230704071655.75381-3-thuth@redhat.com>
In-Reply-To: <20230704071655.75381-1-thuth@redhat.com>
References: <20230704071655.75381-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

These two functions can be useful for other qtests beside the
qos-test, too, so move them to libqtest instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqos/libqos.h |  2 --
 tests/qtest/libqtest.h      | 20 ++++++++++++++
 tests/qtest/libqos/libqos.c | 49 +---------------------------------
 tests/qtest/libqtest.c      | 52 +++++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 50 deletions(-)

diff --git a/tests/qtest/libqos/libqos.h b/tests/qtest/libqos/libqos.h
index 12d05b2365..c04950e2b1 100644
--- a/tests/qtest/libqos/libqos.h
+++ b/tests/qtest/libqos/libqos.h
@@ -27,8 +27,6 @@ QOSState *qtest_boot(QOSOps *ops, const char *cmdline_fmt, ...)
     G_GNUC_PRINTF(2, 3);
 void qtest_common_shutdown(QOSState *qs);
 void qtest_shutdown(QOSState *qs);
-bool have_qemu_img(void);
-void mkimg(const char *file, const char *fmt, unsigned size_mb);
 void mkqcow2(const char *file, unsigned size_mb);
 void migrate(QOSState *from, QOSState *to, const char *uri);
 void prepare_blkdebug_script(const char *debug_fn, const char *event);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 913acc3d5c..3a71bc45fc 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -994,4 +994,24 @@ bool qtest_qom_get_bool(QTestState *s, const char *path, const char *property);
  */
 pid_t qtest_pid(QTestState *s);
 
+/**
+ * have_qemu_img:
+ *
+ * Returns: true if "qemu-img" is available.
+ */
+bool have_qemu_img(void);
+
+/**
+ * mkimg:
+ * @file: File name of the image that should be created
+ * @fmt: Format, e.g. "qcow2" or "raw"
+ * @size_mb: Size of the image in megabytes
+ *
+ * Create a disk image with qemu-img. Note that the QTEST_QEMU_IMG
+ * environment variable must point to the qemu-img file.
+ *
+ * Returns: true if the image has been created successfully.
+ */
+bool mkimg(const char *file, const char *fmt, unsigned size_mb);
+
 #endif
diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c
index 5ffda080ec..5c0fa1f7c5 100644
--- a/tests/qtest/libqos/libqos.c
+++ b/tests/qtest/libqos/libqos.c
@@ -137,56 +137,9 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
     migrate_allocator(&from->alloc, &to->alloc);
 }
 
-bool have_qemu_img(void)
-{
-    char *rpath;
-    const char *path = getenv("QTEST_QEMU_IMG");
-    if (!path) {
-        return false;
-    }
-
-    rpath = realpath(path, NULL);
-    if (!rpath) {
-        return false;
-    } else {
-        free(rpath);
-        return true;
-    }
-}
-
-void mkimg(const char *file, const char *fmt, unsigned size_mb)
-{
-    gchar *cli;
-    bool ret;
-    int rc;
-    GError *err = NULL;
-    char *qemu_img_path;
-    gchar *out, *out2;
-    char *qemu_img_abs_path;
-
-    qemu_img_path = getenv("QTEST_QEMU_IMG");
-    g_assert(qemu_img_path);
-    qemu_img_abs_path = realpath(qemu_img_path, NULL);
-    g_assert(qemu_img_abs_path);
-
-    cli = g_strdup_printf("%s create -f %s %s %uM", qemu_img_abs_path,
-                          fmt, file, size_mb);
-    ret = g_spawn_command_line_sync(cli, &out, &out2, &rc, &err);
-    if (err || !g_spawn_check_exit_status(rc, &err)) {
-        fprintf(stderr, "%s\n", err->message);
-        g_error_free(err);
-    }
-    g_assert(ret && !err);
-
-    g_free(out);
-    g_free(out2);
-    g_free(cli);
-    free(qemu_img_abs_path);
-}
-
 void mkqcow2(const char *file, unsigned size_mb)
 {
-    return mkimg(file, "qcow2", size_mb);
+    g_assert_true(mkimg(file, "qcow2", size_mb));
 }
 
 void prepare_blkdebug_script(const char *debug_fn, const char *event)
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 79152f0ec3..c22dfc30d3 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1742,3 +1742,55 @@ bool qtest_qom_get_bool(QTestState *s, const char *path, const char *property)
 
     return b;
 }
+
+bool have_qemu_img(void)
+{
+    char *rpath;
+    const char *path = getenv("QTEST_QEMU_IMG");
+    if (!path) {
+        return false;
+    }
+
+    rpath = realpath(path, NULL);
+    if (!rpath) {
+        return false;
+    } else {
+        free(rpath);
+        return true;
+    }
+}
+
+bool mkimg(const char *file, const char *fmt, unsigned size_mb)
+{
+    gchar *cli;
+    bool ret;
+    int rc;
+    GError *err = NULL;
+    char *qemu_img_path;
+    gchar *out, *out2;
+    char *qemu_img_abs_path;
+
+    qemu_img_path = getenv("QTEST_QEMU_IMG");
+    if (!qemu_img_path) {
+        return false;
+    }
+    qemu_img_abs_path = realpath(qemu_img_path, NULL);
+    if (!qemu_img_abs_path) {
+        return false;
+    }
+
+    cli = g_strdup_printf("%s create -f %s %s %uM", qemu_img_abs_path,
+                          fmt, file, size_mb);
+    ret = g_spawn_command_line_sync(cli, &out, &out2, &rc, &err);
+    if (err || !g_spawn_check_exit_status(rc, &err)) {
+        fprintf(stderr, "%s\n", err->message);
+        g_error_free(err);
+    }
+
+    g_free(out);
+    g_free(out2);
+    g_free(cli);
+    free(qemu_img_abs_path);
+
+    return ret && !err;
+}
-- 
2.39.3


