Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E94708682
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:14:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhCF-0006uH-UG; Thu, 18 May 2023 13:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhCE-0006t8-9Z
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhCC-0000kX-6k
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684430022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYAXHMO9BDXAE1XcJTehLSfKXo8OzzhXB5VgtZQ4Tdo=;
 b=VoeMBlT5ZvUUg3DRrRx/gyONjvPkfi4x7i7Hpv/wBC7D1CwGOLRXa6IYeKuCYyYsfmWzko
 HQHdZwOZmmYfTnIQuX5hIxyAwfYfCnKPTsW4t0O6BGSUqqMfyWNY78cB4PsphPvJdCGzyv
 4Btua2HUts3YKRW8maTpRmdhtP5/dbg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-DddOgGCwM_-DPHPakBE87g-1; Thu, 18 May 2023 13:13:41 -0400
X-MC-Unique: DddOgGCwM_-DPHPakBE87g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA3E03C0E210;
 Thu, 18 May 2023 17:13:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5436D4078908;
 Thu, 18 May 2023 17:13:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Juan Quintela <quintela@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/12] migration: process_incoming_migration_co(): move colo
 part to colo
Date: Thu, 18 May 2023 19:12:55 +0200
Message-Id: <20230518171304.95006-4-quintela@redhat.com>
In-Reply-To: <20230518171304.95006-1-quintela@redhat.com>
References: <20230518171304.95006-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Let's make better public interface for COLO: instead of
colo_process_incoming_thread and not trivial logic around creating the
thread let's make simple colo_incoming_co(), hiding implementation from
generic code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230515130640.46035-4-vsementsov@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/colo.h |  9 ++++++++-
 migration/colo.c         | 39 ++++++++++++++++++++++++++++++++++++++-
 migration/migration.c    | 28 ++--------------------------
 stubs/colo.c             |  6 ++----
 4 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 7ef315473e..eaac07f26d 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -28,7 +28,6 @@ bool migration_in_colo_state(void);
 int migration_incoming_enable_colo(void);
 void migration_incoming_disable_colo(void);
 bool migration_incoming_colo_enabled(void);
-void *colo_process_incoming_thread(void *opaque);
 bool migration_incoming_in_colo_state(void);
 
 COLOMode get_colo_mode(void);
@@ -44,5 +43,13 @@ void colo_do_failover(void);
  */
 void colo_checkpoint_delay_set(void);
 
+/*
+ * Starts COLO incoming process. Called from process_incoming_migration_co()
+ * after loading the state.
+ *
+ * Called with BQL locked, may temporary release BQL.
+ */
+int coroutine_fn colo_incoming_co(void);
+
 void colo_shutdown(void);
 #endif
diff --git a/migration/colo.c b/migration/colo.c
index a688ac553a..72f4f7b37e 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -817,7 +817,7 @@ void colo_shutdown(void)
     }
 }
 
-void *colo_process_incoming_thread(void *opaque)
+static void *colo_process_incoming_thread(void *opaque)
 {
     MigrationIncomingState *mis = opaque;
     QEMUFile *fb = NULL;
@@ -918,3 +918,40 @@ out:
     rcu_unregister_thread();
     return NULL;
 }
+
+int coroutine_fn colo_incoming_co(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    Error *local_err = NULL;
+    QemuThread th;
+
+    assert(qemu_mutex_iothread_locked());
+
+    if (!migration_incoming_colo_enabled()) {
+        return 0;
+    }
+
+    /* Make sure all file formats throw away their mutable metadata */
+    bdrv_activate_all(&local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
+    qemu_thread_create(&th, "COLO incoming", colo_process_incoming_thread,
+                       mis, QEMU_THREAD_JOINABLE);
+
+    mis->colo_incoming_co = qemu_coroutine_self();
+    qemu_coroutine_yield();
+    mis->colo_incoming_co = NULL;
+
+    qemu_mutex_unlock_iothread();
+    /* Wait checkpoint incoming thread exit before free resource */
+    qemu_thread_join(&th);
+    qemu_mutex_lock_iothread();
+
+    /* We hold the global iothread lock, so it is safe here */
+    colo_release_ram_cache();
+
+    return 0;
+}
diff --git a/migration/migration.c b/migration/migration.c
index a6f2f6cacd..039bba4804 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -511,7 +511,6 @@ process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
-    Error *local_err = NULL;
 
     assert(mis->from_src_file);
 
@@ -555,37 +554,14 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
 
-    /* we get COLO info, and know if we are in COLO mode */
-    if (migration_incoming_colo_enabled()) {
-        QemuThread colo_incoming_thread;
-
-        /* Make sure all file formats throw away their mutable metadata */
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-            goto fail;
-        }
-
-        qemu_thread_create(&colo_incoming_thread, "COLO incoming",
-             colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
-
-        mis->colo_incoming_co = qemu_coroutine_self();
-        qemu_coroutine_yield();
-        mis->colo_incoming_co = NULL;
-
-        qemu_mutex_unlock_iothread();
-        /* Wait checkpoint incoming thread exit before free resource */
-        qemu_thread_join(&colo_incoming_thread);
-        qemu_mutex_lock_iothread();
-        /* We hold the global iothread lock, so it is safe here */
-        colo_release_ram_cache();
+    if (colo_incoming_co() < 0) {
+        goto fail;
     }
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
     return;
 fail:
-    local_err = NULL;
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     qemu_fclose(mis->from_src_file);
diff --git a/stubs/colo.c b/stubs/colo.c
index cf9816d368..f33379d0fd 100644
--- a/stubs/colo.c
+++ b/stubs/colo.c
@@ -10,11 +10,9 @@ void colo_shutdown(void)
 {
 }
 
-void *colo_process_incoming_thread(void *opaque)
+int coroutine_fn colo_incoming_co(void)
 {
-    error_report("Impossible happend: trying to start COLO thread when COLO "
-                 "module is not built in");
-    abort();
+    return 0;
 }
 
 void colo_checkpoint_delay_set(void)
-- 
2.40.1


