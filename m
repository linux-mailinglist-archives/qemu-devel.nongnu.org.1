Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0027C5E7C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:37:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfvi-0005Cz-1l; Wed, 11 Oct 2023 16:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvg-0005CN-I3
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfve-0002zB-6l
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u1x5haXn7atDjonP8E/33bwDgNkkf+VsBPQsfRc84qY=;
 b=JNqAxyL7Q/LzQw3F3JZSyiY0ch6lxHX8MN1Om92/SwmDxch+13k4zkYjDJ+RTr540w3Cac
 OvltdM+uXFB+71MTkYkKlpIn+kJgGjgD0D04PrloCPXc3gF5qYPIrCvUOOr+MjYssEahDs
 Y482XhQuMVBnu66f5ehm/mSKR7eBsZA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-bk25NGRlONObM-Tlads72w-1; Wed, 11 Oct 2023 16:35:34 -0400
X-MC-Unique: bk25NGRlONObM-Tlads72w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCFE71C09A46;
 Wed, 11 Oct 2023 20:35:33 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D49AF492B06;
 Wed, 11 Oct 2023 20:35:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 03/13] migration/rdma: Unfold ram_control_after_iterate()
Date: Wed, 11 Oct 2023 22:35:17 +0200
Message-ID: <20231011203527.9061-4-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-1-quintela@redhat.com>
References: <20231011203527.9061-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Once there:
- Remove unused data parameter
- unfold it in its callers
- change all callers to call qemu_rdma_registration_stop()
- We need to call QIO_CHANNEL_RDMA() after we check for migrate_rdma()

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>

---

This function has goto's.  So I don't change the place where we
declare variables, althought I think that it is correct, just don't
start that discussion.
---
 migration/qemu-file.h |  2 --
 migration/rdma.h      |  3 +++
 migration/qemu-file.c | 12 ------------
 migration/ram.c       | 17 ++++++++++++++---
 migration/rdma.c      |  9 ++++-----
 5 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index d6a370c569..35e671a01e 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -55,7 +55,6 @@ typedef int (QEMURamSaveFunc)(QEMUFile *f,
                               size_t size);
 
 typedef struct QEMUFileHooks {
-    QEMURamHookFunc *after_ram_iterate;
     QEMURamHookFunc *hook_ram_load;
     QEMURamSaveFunc *save_page;
 } QEMUFileHooks;
@@ -126,7 +125,6 @@ void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 
-void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data);
 
 /* Whenever this is found in the data stream, the flags
diff --git a/migration/rdma.h b/migration/rdma.h
index 670c67a8cb..c13b94c782 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -25,8 +25,11 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp);
 
 #ifdef CONFIG_RDMA
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
+int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags);
 #else
 static inline
 int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
+static inline
+int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
 #endif
 #endif
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 5e2d73fd68..e7dba2a849 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -298,18 +298,6 @@ void qemu_fflush(QEMUFile *f)
     f->iovcnt = 0;
 }
 
-void ram_control_after_iterate(QEMUFile *f, uint64_t flags)
-{
-    int ret = 0;
-
-    if (f->hooks && f->hooks->after_ram_iterate) {
-        ret = f->hooks->after_ram_iterate(f, flags, NULL);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
-        }
-    }
-}
-
 void ram_control_load_hook(QEMUFile *f, uint64_t flags, void *data)
 {
     if (f->hooks && f->hooks->hook_ram_load) {
diff --git a/migration/ram.c b/migration/ram.c
index ab590a983f..15bd4ad697 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3067,7 +3067,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     if (ret < 0) {
         qemu_file_set_error(f, ret);
     }
-    ram_control_after_iterate(f, RAM_CONTROL_SETUP);
+
+    ret = qemu_rdma_registration_stop(f, RAM_CONTROL_SETUP);
+    if (ret < 0) {
+        qemu_file_set_error(f, ret);
+    }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
     migration_ops->ram_save_target_page = ram_save_target_page_legacy;
@@ -3186,7 +3190,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      * Must occur before EOS (or any QEMUFile operation)
      * because of RDMA protocol.
      */
-    ram_control_after_iterate(f, RAM_CONTROL_ROUND);
+    ret = qemu_rdma_registration_stop(f, RAM_CONTROL_ROUND);
+    if (ret < 0) {
+        qemu_file_set_error(f, ret);
+    }
 
 out:
     if (ret >= 0
@@ -3259,7 +3266,11 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         qemu_mutex_unlock(&rs->bitmap_mutex);
 
         ram_flush_compressed_data(rs);
-        ram_control_after_iterate(f, RAM_CONTROL_FINISH);
+
+        int ret = qemu_rdma_registration_stop(f, RAM_CONTROL_FINISH);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+        }
     }
 
     if (ret < 0) {
diff --git a/migration/rdma.c b/migration/rdma.c
index a8bfc052c4..99c0914a23 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3878,20 +3878,20 @@ int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
  * Inform dest that dynamic registrations are done for now.
  * First, flush writes, if any.
  */
-static int qemu_rdma_registration_stop(QEMUFile *f,
-                                       uint64_t flags, void *data)
+int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags)
 {
-    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    QIOChannelRDMA *rioc;
     Error *err = NULL;
     RDMAContext *rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
     int ret;
 
-    if (migration_in_postcopy()) {
+    if (!migrate_rdma() || migration_in_postcopy()) {
         return 0;
     }
 
     RCU_READ_LOCK_GUARD();
+    rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     rdma = qatomic_rcu_read(&rioc->rdmaout);
     if (!rdma) {
         return -1;
@@ -3999,7 +3999,6 @@ static const QEMUFileHooks rdma_read_hooks = {
 };
 
 static const QEMUFileHooks rdma_write_hooks = {
-    .after_ram_iterate  = qemu_rdma_registration_stop,
     .save_page          = qemu_rdma_save_page,
 };
 
-- 
2.41.0


