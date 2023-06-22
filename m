Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E52B739563
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 04:16:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC9pS-0005YN-Hr; Wed, 21 Jun 2023 22:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9pE-0005Qd-Vp
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC9pD-0004oW-8e
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 22:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687400010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBYn87bb9I1f9KUD77mIUek71xIJdcNhfmFCCVLtKX8=;
 b=BewHzzX83ruEbVEoHNaBXv/sKoxTJ3cGs1prVCHFnjFM03KpRHQPRcXE0o5WiR3qsKV8vt
 3WeWk1AAeJpk0FMJkAx8o0tq8Hm3ot24pVcZ55gYIiyrR8Avfh/M5+SfCDk7A+mioylIwT
 BCY/qGvS/Vr8YGUm3PtzntCY39y+mfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-eOwQccumMLi7JxlHIv2Oiw-1; Wed, 21 Jun 2023 22:13:29 -0400
X-MC-Unique: eOwQccumMLi7JxlHIv2Oiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B999B810BB2;
 Thu, 22 Jun 2023 02:13:28 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.193.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A987112132C;
 Thu, 22 Jun 2023 02:13:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 02/30] migration/multifd: Protect accesses to migration_threads
Date: Thu, 22 Jun 2023 04:12:52 +0200
Message-Id: <20230622021320.66124-3-quintela@redhat.com>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

This doubly linked list is common for all the multifd and migration
threads so we need to avoid concurrent access.

Add a mutex to protect the data from concurrent access. This fixes a
crash when removing two MigrationThread objects from the list at the
same time during cleanup of multifd threads.

Fixes: 671326201d ("migration: Introduce interface query-migrationthreads")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230607161306.31425-3-farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/threadinfo.h |  2 --
 migration/threadinfo.c | 15 ++++++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/migration/threadinfo.h b/migration/threadinfo.h
index 8aa6999d58..2f356ff312 100644
--- a/migration/threadinfo.h
+++ b/migration/threadinfo.h
@@ -10,8 +10,6 @@
  *  See the COPYING file in the top-level directory.
  */
 
-#include "qemu/queue.h"
-#include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 
diff --git a/migration/threadinfo.c b/migration/threadinfo.c
index 3dd9b14ae6..262990dd75 100644
--- a/migration/threadinfo.c
+++ b/migration/threadinfo.c
@@ -10,23 +10,35 @@
  *  See the COPYING file in the top-level directory.
  */
 
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "qemu/lockable.h"
 #include "threadinfo.h"
 
+QemuMutex migration_threads_lock;
 static QLIST_HEAD(, MigrationThread) migration_threads;
 
+static void __attribute__((constructor)) migration_threads_init(void)
+{
+    qemu_mutex_init(&migration_threads_lock);
+}
+
 MigrationThread *migration_threads_add(const char *name, int thread_id)
 {
     MigrationThread *thread =  g_new0(MigrationThread, 1);
     thread->name = name;
     thread->thread_id = thread_id;
 
-    QLIST_INSERT_HEAD(&migration_threads, thread, node);
+    WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
+        QLIST_INSERT_HEAD(&migration_threads, thread, node);
+    }
 
     return thread;
 }
 
 void migration_threads_remove(MigrationThread *thread)
 {
+    QEMU_LOCK_GUARD(&migration_threads_lock);
     if (thread) {
         QLIST_REMOVE(thread, node);
         g_free(thread);
@@ -39,6 +51,7 @@ MigrationThreadInfoList *qmp_query_migrationthreads(Error **errp)
     MigrationThreadInfoList **tail = &head;
     MigrationThread *thread = NULL;
 
+    QEMU_LOCK_GUARD(&migration_threads_lock);
     QLIST_FOREACH(thread, &migration_threads, node) {
         MigrationThreadInfo *info = g_new0(MigrationThreadInfo, 1);
         info->name = g_strdup(thread->name);
-- 
2.40.1


