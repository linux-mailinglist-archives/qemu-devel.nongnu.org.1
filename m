Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A30726592
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:14:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vn1-0004oc-A2; Wed, 07 Jun 2023 12:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6vmy-0004o4-Qt
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:13:36 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6vmi-0001Nr-C0
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:13:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 54B521FDB0;
 Wed,  7 Jun 2023 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686154396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMnVssq3mMDRLdbsZJ0F9sZ1VmTW+4ZZNRrtl+SOTCU=;
 b=s7D44a72/MzEnDtKgwjv9pVxoG4cUkGQMtHSP/H1thzfH93eDgeajsHwxPFLG8Nvg4VgH6
 Iv9fvJH1bW0TP0HPIHft1DJMbTKmRiMPR/hZ+lkCyoKpIc+3gg4dJKNOk/7r4pvx3DqLMv
 1woG6yYjvUfx9ZKbym1cksYYYE3uC2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686154396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMnVssq3mMDRLdbsZJ0F9sZ1VmTW+4ZZNRrtl+SOTCU=;
 b=2AmmUQSOBXbD7nCzwuGoxEUC0IABHPlgp8sVC93Shx7GnVkWFSsrk7Vp2HvlCNHlgJ36HS
 Ep2jzAzYIkTkEADA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7044113776;
 Wed,  7 Jun 2023 16:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mGZ7DZqsgGSfRgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 07 Jun 2023 16:13:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 2/3] migration/multifd: Protect accesses to
 migration_threads
Date: Wed,  7 Jun 2023 13:13:05 -0300
Message-Id: <20230607161306.31425-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230607161306.31425-1-farosas@suse.de>
References: <20230607161306.31425-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This doubly linked list is common for all the multifd and migration
threads so we need to avoid concurrent access.

Add a mutex to protect the data from concurrent access. This fixes a
crash when removing two MigrationThread objects from the list at the
same time during cleanup of multifd threads.

Fixes: 671326201d ("migration: Introduce interface query-migrationthreads")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/threadinfo.c | 15 ++++++++++++++-
 migration/threadinfo.h |  2 --
 2 files changed, 14 insertions(+), 3 deletions(-)

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
 
-- 
2.35.3


