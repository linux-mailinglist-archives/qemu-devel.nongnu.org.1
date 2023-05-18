Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7758B708684
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhBy-0006XT-Ao; Thu, 18 May 2023 13:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhBw-0006Un-4y
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhBt-0000gW-Ue
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684430005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V64qzVfvNHyaMOEqqJTame3ALpovwKOsQAtuvwBl3Cw=;
 b=Rj/SyigPsZWEl/oahc+qIW2UH33i8lGpPuaxbak/qpzF9cBXZ/qeSbiJil09UfCZxNzuEE
 DpnGtc25F+wCoNfC00oLHNPFGs4pQxmHnEnvCG3MjXZKMARJwYSnXffN+Kv+PX0FGBrULf
 3Qed1BzpWZbRJH7+TuI2VJBuH1NiOjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-2B-RWMPgNUC2HGad9Z_LIA-1; Thu, 18 May 2023 13:13:23 -0400
X-MC-Unique: 2B-RWMPgNUC2HGad9Z_LIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0576C185A7A4;
 Thu, 18 May 2023 17:13:22 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D3C640C6EC4;
 Thu, 18 May 2023 17:13:17 +0000 (UTC)
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
Subject: [PULL 02/12] migration: split migration_incoming_co
Date: Thu, 18 May 2023 19:12:54 +0200
Message-Id: <20230518171304.95006-3-quintela@redhat.com>
In-Reply-To: <20230518171304.95006-1-quintela@redhat.com>
References: <20230518171304.95006-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Originally, migration_incoming_co was introduced by
25d0c16f625feb3b6
   "migration: Switch to COLO process after finishing loadvm"
to be able to enter from COLO code to one specific yield point, added
by 25d0c16f625feb3b6.

Later in 923709896b1b0
 "migration: poll the cm event for destination qemu"
we reused this variable to wake the migration incoming coroutine from
RDMA code.

That was doubtful idea. Entering coroutines is a very fragile thing:
you should be absolutely sure which yield point you are going to enter.

I don't know how much is it safe to enter during qemu_loadvm_state()
which I think what RDMA want to do. But for sure RDMA shouldn't enter
the special COLO-related yield-point. As well, COLO code doesn't want
to enter during qemu_loadvm_state(), it want to enter it's own specific
yield-point.

As well, when in 8e48ac95865ac97d
 "COLO: Add block replication into colo process" we added
bdrv_invalidate_cache_all() call (now it's called activate_all())
it became possible to enter the migration incoming coroutine during
that call which is wrong too.

So, let't make these things separate and disjoint: loadvm_co for RDMA,
non-NULL during qemu_loadvm_state(), and colo_incoming_co for COLO,
non-NULL only around specific yield.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230515130640.46035-3-vsementsov@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.h | 9 ++++++++-
 migration/colo.c      | 4 ++--
 migration/migration.c | 8 ++++++--
 migration/rdma.c      | 5 ++---
 4 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 7721c7658b..48a46123a0 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -162,8 +162,15 @@ struct MigrationIncomingState {
 
     int state;
 
+    /*
+     * The incoming migration coroutine, non-NULL during qemu_loadvm_state().
+     * Used to wake the migration incoming coroutine from rdma code. How much is
+     * it safe - it's a question.
+     */
+    Coroutine *loadvm_co;
+
     /* The coroutine we should enter (back) after failover */
-    Coroutine *migration_incoming_co;
+    Coroutine *colo_incoming_co;
     QemuSemaphore colo_incoming_sem;
 
     /*
diff --git a/migration/colo.c b/migration/colo.c
index 6c7c313956..a688ac553a 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -145,8 +145,8 @@ static void secondary_vm_do_failover(void)
     qemu_sem_post(&mis->colo_incoming_sem);
 
     /* For Secondary VM, jump to incoming co */
-    if (mis->migration_incoming_co) {
-        qemu_coroutine_enter(mis->migration_incoming_co);
+    if (mis->colo_incoming_co) {
+        qemu_coroutine_enter(mis->colo_incoming_co);
     }
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 00d8ba8da0..a6f2f6cacd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -520,12 +520,14 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
 
-    mis->migration_incoming_co = qemu_coroutine_self();
     mis->largest_page_size = qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_ACTIVE);
+
+    mis->loadvm_co = qemu_coroutine_self();
     ret = qemu_loadvm_state(mis->from_src_file);
+    mis->loadvm_co = NULL;
 
     ps = postcopy_state_get();
     trace_process_incoming_migration_co_end(ret, ps);
@@ -566,7 +568,10 @@ process_incoming_migration_co(void *opaque)
 
         qemu_thread_create(&colo_incoming_thread, "COLO incoming",
              colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
+
+        mis->colo_incoming_co = qemu_coroutine_self();
         qemu_coroutine_yield();
+        mis->colo_incoming_co = NULL;
 
         qemu_mutex_unlock_iothread();
         /* Wait checkpoint incoming thread exit before free resource */
@@ -578,7 +583,6 @@ process_incoming_migration_co(void *opaque)
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
-    mis->migration_incoming_co = NULL;
     return;
 fail:
     local_err = NULL;
diff --git a/migration/rdma.c b/migration/rdma.c
index 2cd8f1cc66..2e4dcff1c9 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3342,9 +3342,8 @@ static void rdma_cm_poll_handler(void *opaque)
             }
         }
         rdma_ack_cm_event(cm_event);
-
-        if (mis->migration_incoming_co) {
-            qemu_coroutine_enter(mis->migration_incoming_co);
+        if (mis->loadvm_co) {
+            qemu_coroutine_enter(mis->loadvm_co);
         }
         return;
     }
-- 
2.40.1


