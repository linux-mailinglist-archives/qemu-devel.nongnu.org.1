Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFF771FFBB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:51:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52Lm-0007C9-Ee; Fri, 02 Jun 2023 06:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52Ld-0007AS-0q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52La-0002Kx-9H
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685702969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+nE9rNIJBj109SfbBmE2f54T6hGgPff3hRdd/+2AB4=;
 b=ix8O96OFPH96e2iQMiyfQtZFPvx9HZG4T81ZLW4saPS9XA2TFI41dJNpP+3uLu1uSpUAJM
 DdboCspX6V9FXTF1nw4PttbiwSPj+HOU8hmUYzdSg8f2wcopA+IXTe4dFd/JKor44t7Mjh
 UbR6DFEDfpq0D5bNBVfBSctnoZRA2Xo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-_fl7x3lvNR65-vDKC1kzcg-1; Fri, 02 Jun 2023 06:49:20 -0400
X-MC-Unique: _fl7x3lvNR65-vDKC1kzcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A574B800BFF
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 10:49:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A3BE40CFD00;
 Fri,  2 Jun 2023 10:49:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/10] tests/qtest: switch to using event callbacks for STOP
 event
Date: Fri,  2 Jun 2023 12:49:05 +0200
Message-Id: <20230602104910.35157-6-quintela@redhat.com>
In-Reply-To: <20230602104910.35157-1-quintela@redhat.com>
References: <20230602104910.35157-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Change the migration test to use the new qtest event callback to watch
for the stop event. This ensures that we only watch for the STOP event
on the source QEMU. The previous code would set the single 'got_stop'
flag when either source or dest QEMU got the STOP event.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230601161347.1803440-6-berrange@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-helpers.h |  3 ++-
 tests/qtest/migration-helpers.c | 19 +++++++++----------
 tests/qtest/migration-test.c    |  4 ++++
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 2e51a6e195..fa69d1780a 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -15,7 +15,8 @@
 
 #include "libqtest.h"
 
-extern bool got_stop;
+bool migrate_watch_for_stop(QTestState *who, const char *name,
+                            QDict *event, void *opaque);
 
 #ifndef _WIN32
 G_GNUC_PRINTF(3, 4)
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e26fdcb132..7ceadecf84 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -23,15 +23,17 @@
  */
 #define MIGRATION_STATUS_WAIT_TIMEOUT 120
 
-bool got_stop;
-
-static void check_stop_event(QTestState *who)
+bool migrate_watch_for_stop(QTestState *who, const char *name,
+                            QDict *event, void *opaque)
 {
-    QDict *event = qtest_qmp_event_ref(who, "STOP");
-    if (event) {
-        got_stop = true;
-        qobject_unref(event);
+    bool *seen = opaque;
+
+    if (g_str_equal(name, "STOP")) {
+        *seen = true;
+        return true;
     }
+
+    return false;
 }
 
 #ifndef _WIN32
@@ -48,7 +50,6 @@ QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...)
     va_end(ap);
 
     resp = qtest_qmp_receive(who);
-    check_stop_event(who);
 
     g_assert(!qdict_haskey(resp, "error"));
     g_assert(qdict_haskey(resp, "return"));
@@ -73,8 +74,6 @@ QDict *wait_command(QTestState *who, const char *command, ...)
     resp = qtest_vqmp(who, command, ap);
     va_end(ap);
 
-    check_stop_event(who);
-
     g_assert(!qdict_haskey(resp, "error"));
     g_assert(qdict_haskey(resp, "return"));
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 822516286d..0af72c37c2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -43,6 +43,7 @@
 unsigned start_address;
 unsigned end_address;
 static bool uffd_feature_thread_id;
+static bool got_stop;
 
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -703,6 +704,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  ignore_stderr);
     if (!args->only_target) {
         *from = qtest_init(cmd_source);
+        qtest_qmp_set_event_callback(*from,
+                                     migrate_watch_for_stop,
+                                     &got_stop);
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg%s%s "
-- 
2.40.1


