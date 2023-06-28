Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C78741B2A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd3P-0001Kc-Qr; Wed, 28 Jun 2023 17:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3G-0001J2-Cn
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3C-0008OM-OC
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfWfnfZbeffLlXkdXeufVqSw59USlbPvC7kn1pj2xSs=;
 b=PoVMqufgy1rcOu9SQqDW6DM2tu0ai0F2pQoe//itvCzX7t5gIafNEWrpKhYhJnOHFnMCFP
 zQywuwksnNPtzdANgB1p6uoQZcKeIXtgPyb7T6CzDxdCjvD+8XSgd2F/A08Ok0wesEe/kP
 mph5G5cb/4ECLxbhxqYkVqFwhHCoPNA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-7OwwT9ClMyOnD0hCY1d3wQ-1; Wed, 28 Jun 2023 17:50:08 -0400
X-MC-Unique: 7OwwT9ClMyOnD0hCY1d3wQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f8283a3a7aso19731cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989008; x=1690581008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfWfnfZbeffLlXkdXeufVqSw59USlbPvC7kn1pj2xSs=;
 b=jkmCjgHvai+lvk83vRvkFj4V6KbjDZpJp2ifUQw+US9D2JmOiIRhnGzJBf6Ar9uGbS
 JeGujXZhgX6yyhJdZXRCLZgibe9bOq+q9KYHAhRvDq41llGU6EujA7KD8Lg5+wsP4gJe
 lmHmiz1P7OyGl0BaBLAG6burDhJWgeU4Qdf//NggNdmmftaKG8yp+XVEXd39eR8/6N3Q
 eHBb9EMhyXDQ6Kxp/KBKTlwrn2c6CjVkjY+kpPGn0Di2DbykAetY2spkXj9QwJIF5A5l
 ytNsfJsP6w7Jm3O0/4CzWXZld622NkGFZCyHUiYNhf8r09crh7ynVBBh9GPJBtKkUh7K
 zyUQ==
X-Gm-Message-State: AC+VfDzBkUCKHV7DNMen4UbNFEf6k/VXbKm9Jhs4U7aiRJKohC+90Zda
 rf1glPqFe+/qh9Hnmbb7QM3FhCLQ022ZwSQ4o1Sa+hFIzuMbn4FRpohUaQuIUV7oZJhSMQ3At3j
 K+wkU/rwAj6uS2HhGlzrtlsyCcnd/BNmM2g/SYeJZXvPcWTB56qDFWPzlcY33vnPeZw9tPBoy
X-Received: by 2002:ac8:7f15:0:b0:3fd:e953:74ee with SMTP id
 f21-20020ac87f15000000b003fde95374eemr1295506qtk.2.1687989007704; 
 Wed, 28 Jun 2023 14:50:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6AOzX8wZX+USt9lobPJpAfcJi6INISrqchvVjGC//PCSOLWslTnHBwIj0ddjqnfsBVYO2SnA==
X-Received: by 2002:ac8:7f15:0:b0:3fd:e953:74ee with SMTP id
 f21-20020ac87f15000000b003fde95374eemr1295473qtk.2.1687989006946; 
 Wed, 28 Jun 2023 14:50:06 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w29-20020ac84d1d000000b004032d9209a0sm255552qtv.50.2023.06.28.14.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:50:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 3/7] migration: Refactor error handling in source return path
Date: Wed, 28 Jun 2023 17:49:58 -0400
Message-ID: <20230628215002.73546-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215002.73546-1-peterx@redhat.com>
References: <20230628215002.73546-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

rp_state.error was a boolean used to show error happened in return path
thread.  That's not only duplicating error reporting (migrate_set_error),
but also not good enough in that we only do error_report() and set it to
true, we never can keep a history of the exact error and show it in
query-migrate.

To make this better, a few things done:

  - Use error_setg() rather than error_report() across the whole lifecycle
    of return path thread, keeping the error in an Error*.

  - Use migrate_set_error() to apply that captured error to the global
    migration object when error occured in this thread.

  - With above, no need to have mark_source_rp_bad(), remove it, alongside
    with rp_state.error itself.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h  |   1 -
 migration/ram.h        |   5 +-
 migration/migration.c  | 118 ++++++++++++++++++++---------------------
 migration/ram.c        |  41 +++++++-------
 migration/trace-events |   2 +-
 5 files changed, 82 insertions(+), 85 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index e48317ca97..d9c4b753b5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -290,7 +290,6 @@ struct MigrationState {
         /* Protected by qemu_file_lock */
         QEMUFile     *from_dst_file;
         QemuThread    rp_thread;
-        bool          error;
         /*
          * We can also check non-zero of rp_thread, but there's no "official"
          * way to do this, so this bool makes it slightly more elegant.
diff --git a/migration/ram.h b/migration/ram.h
index ea1f3c25b5..02a4af2db6 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -52,7 +52,8 @@ uint64_t ram_bytes_total(void);
 void mig_throttle_counter_reset(void);
 
 uint64_t ram_pagesize_summary(void);
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
+int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
+                         Error **errp);
 void ram_postcopy_migrated_memory_release(MigrationState *ms);
 /* For outgoing discard bitmap */
 void ram_postcopy_send_discard_bitmap(MigrationState *ms);
@@ -72,7 +73,7 @@ void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
 int64_t ramblock_recv_bitmap_send(QEMUFile *file,
                                   const char *block_name);
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb);
+int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
diff --git a/migration/migration.c b/migration/migration.c
index 39674a3981..f8c41c4d98 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1409,7 +1409,6 @@ void migrate_init(MigrationState *s)
     s->to_dst_file = NULL;
     s->state = MIGRATION_STATUS_NONE;
     s->rp_state.from_dst_file = NULL;
-    s->rp_state.error = false;
     s->mbps = 0.0;
     s->pages_per_second = 0.0;
     s->downtime = 0;
@@ -1724,16 +1723,6 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
     qemu_sem_post(&s->pause_sem);
 }
 
-/* migration thread support */
-/*
- * Something bad happened to the RP stream, mark an error
- * The caller shall print or trace something to indicate why
- */
-static void mark_source_rp_bad(MigrationState *s)
-{
-    s->rp_state.error = true;
-}
-
 static struct rp_cmd_args {
     ssize_t     len; /* -1 = variable */
     const char *name;
@@ -1754,7 +1743,7 @@ static struct rp_cmd_args {
  * and we don't need to send pages that have already been sent.
  */
 static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
-                                       ram_addr_t start, size_t len)
+                                        ram_addr_t start, size_t len, Error **errp)
 {
     long our_host_ps = qemu_real_host_page_size();
 
@@ -1766,15 +1755,12 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
      */
     if (!QEMU_IS_ALIGNED(start, our_host_ps) ||
         !QEMU_IS_ALIGNED(len, our_host_ps)) {
-        error_report("%s: Misaligned page request, start: " RAM_ADDR_FMT
-                     " len: %zd", __func__, start, len);
-        mark_source_rp_bad(ms);
+        error_setg(errp, "MIG_RP_MSG_REQ_PAGES: Misaligned page request, start:"
+                   RAM_ADDR_FMT " len: %zd", start, len);
         return;
     }
 
-    if (ram_save_queue_pages(rbname, start, len)) {
-        mark_source_rp_bad(ms);
-    }
+    ram_save_queue_pages(rbname, start, len, errp);
 }
 
 /* Return true to retry, false to quit */
@@ -1789,26 +1775,28 @@ static bool postcopy_pause_return_path_thread(MigrationState *s)
     return true;
 }
 
-static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
+static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
+                                         Error **errp)
 {
     RAMBlock *block = qemu_ram_block_by_name(block_name);
 
     if (!block) {
-        error_report("%s: invalid block name '%s'", __func__, block_name);
+        error_setg(errp, "MIG_RP_MSG_RECV_BITMAP has invalid block name '%s'",
+                   block_name);
         return -EINVAL;
     }
 
     /* Fetch the received bitmap and refresh the dirty bitmap */
-    return ram_dirty_bitmap_reload(s, block);
+    return ram_dirty_bitmap_reload(s, block, errp);
 }
 
-static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
+static int migrate_handle_rp_resume_ack(MigrationState *s,
+                                        uint32_t value, Error **errp)
 {
     trace_source_return_path_thread_resume_ack(value);
 
     if (value != MIGRATION_RESUME_ACK_VALUE) {
-        error_report("%s: illegal resume_ack value %"PRIu32,
-                     __func__, value);
+        error_setg(errp, "illegal resume_ack value %"PRIu32, value);
         return -1;
     }
 
@@ -1867,49 +1855,47 @@ static void *source_return_path_thread(void *opaque)
     uint32_t tmp32, sibling_error;
     ram_addr_t start = 0; /* =0 to silence warning */
     size_t  len = 0, expected_len;
+    Error *err = NULL;
     int res;
 
     trace_source_return_path_thread_entry();
     rcu_register_thread();
 
 retry:
-    while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
+    while (!migrate_has_error(ms) && !qemu_file_get_error(rp) &&
            migration_is_setup_or_active(ms->state)) {
         trace_source_return_path_thread_loop_top();
+
         header_type = qemu_get_be16(rp);
         header_len = qemu_get_be16(rp);
 
         if (qemu_file_get_error(rp)) {
-            mark_source_rp_bad(ms);
             goto out;
         }
 
         if (header_type >= MIG_RP_MSG_MAX ||
             header_type == MIG_RP_MSG_INVALID) {
-            error_report("RP: Received invalid message 0x%04x length 0x%04x",
-                         header_type, header_len);
-            mark_source_rp_bad(ms);
+            error_setg(&err, "Received invalid message 0x%04x length 0x%04x",
+                       header_type, header_len);
             goto out;
         }
 
         if ((rp_cmd_args[header_type].len != -1 &&
             header_len != rp_cmd_args[header_type].len) ||
             header_len > sizeof(buf)) {
-            error_report("RP: Received '%s' message (0x%04x) with"
-                         "incorrect length %d expecting %zu",
-                         rp_cmd_args[header_type].name, header_type, header_len,
-                         (size_t)rp_cmd_args[header_type].len);
-            mark_source_rp_bad(ms);
+            error_setg(&err, "Received '%s' message (0x%04x) with"
+                       "incorrect length %d expecting %zu",
+                       rp_cmd_args[header_type].name, header_type, header_len,
+                       (size_t)rp_cmd_args[header_type].len);
             goto out;
         }
 
         /* We know we've got a valid header by this point */
         res = qemu_get_buffer(rp, buf, header_len);
         if (res != header_len) {
-            error_report("RP: Failed reading data for message 0x%04x"
-                         " read %d expected %d",
-                         header_type, res, header_len);
-            mark_source_rp_bad(ms);
+            error_setg(&err, "Failed reading data for message 0x%04x"
+                       " read %d expected %d",
+                       header_type, res, header_len);
             goto out;
         }
 
@@ -1919,8 +1905,7 @@ retry:
             sibling_error = ldl_be_p(buf);
             trace_source_return_path_thread_shut(sibling_error);
             if (sibling_error) {
-                error_report("RP: Sibling indicated error %d", sibling_error);
-                mark_source_rp_bad(ms);
+                error_setg(&err, "Sibling indicated error %d", sibling_error);
             }
             /*
              * We'll let the main thread deal with closing the RP
@@ -1938,7 +1923,10 @@ retry:
         case MIG_RP_MSG_REQ_PAGES:
             start = ldq_be_p(buf);
             len = ldl_be_p(buf + 8);
-            migrate_handle_rp_req_pages(ms, NULL, start, len);
+            migrate_handle_rp_req_pages(ms, NULL, start, len, &err);
+            if (err) {
+                goto out;
+            }
             break;
 
         case MIG_RP_MSG_REQ_PAGES_ID:
@@ -1953,32 +1941,32 @@ retry:
                 expected_len += tmp32;
             }
             if (header_len != expected_len) {
-                error_report("RP: Req_Page_id with length %d expecting %zd",
-                             header_len, expected_len);
-                mark_source_rp_bad(ms);
+                error_setg(&err, "Req_Page_id with length %d expecting %zd",
+                           header_len, expected_len);
+                goto out;
+            }
+            migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len,
+                                        &err);
+            if (err) {
                 goto out;
             }
-            migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len);
             break;
 
         case MIG_RP_MSG_RECV_BITMAP:
             if (header_len < 1) {
-                error_report("%s: missing block name", __func__);
-                mark_source_rp_bad(ms);
+                error_setg(&err, "MIG_RP_MSG_RECV_BITMAP missing block name");
                 goto out;
             }
             /* Format: len (1B) + idstr (<255B). This ends the idstr. */
             buf[buf[0] + 1] = '\0';
-            if (migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1))) {
-                mark_source_rp_bad(ms);
+            if (migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1), &err)) {
                 goto out;
             }
             break;
 
         case MIG_RP_MSG_RESUME_ACK:
             tmp32 = ldl_be_p(buf);
-            if (migrate_handle_rp_resume_ack(ms, tmp32)) {
-                mark_source_rp_bad(ms);
+            if (migrate_handle_rp_resume_ack(ms, tmp32, &err)) {
                 goto out;
             }
             break;
@@ -1989,6 +1977,19 @@ retry:
     }
 
 out:
+    if (err) {
+        /*
+         * Collect any error in return-path thread and report it to the
+         * migration state object.
+         */
+        migrate_set_error(ms, err);
+        /*
+         * We lost ownership to Error*, clear it, prepared to capture the
+         * next error.
+         */
+        err = NULL;
+    }
+
     res = qemu_file_get_error(rp);
     if (res) {
         if (res && migration_in_postcopy()) {
@@ -2004,13 +2005,11 @@ out:
                  * it's reset only by us above, or when migration completes
                  */
                 rp = ms->rp_state.from_dst_file;
-                ms->rp_state.error = false;
                 goto retry;
             }
         }
 
         trace_source_return_path_thread_bad_end();
-        mark_source_rp_bad(ms);
     }
 
     trace_source_return_path_thread_end();
@@ -2043,8 +2042,7 @@ static int open_return_path_on_source(MigrationState *ms,
     return 0;
 }
 
-/* Returns 0 if the RP was ok, otherwise there was an error on the RP */
-static int await_return_path_close_on_source(MigrationState *ms)
+static void await_return_path_close_on_source(MigrationState *ms)
 {
     /*
      * If this is a normal exit then the destination will send a SHUT and the
@@ -2057,13 +2055,11 @@ static int await_return_path_close_on_source(MigrationState *ms)
          * waiting for the destination.
          */
         qemu_file_shutdown(ms->rp_state.from_dst_file);
-        mark_source_rp_bad(ms);
     }
     trace_await_return_path_close_on_source_joining();
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created = false;
     trace_await_return_path_close_on_source_close();
-    return ms->rp_state.error;
 }
 
 static inline void
@@ -2366,11 +2362,11 @@ static void migration_completion(MigrationState *s)
      * a SHUT command).
      */
     if (s->rp_state.rp_thread_created) {
-        int rp_error;
         trace_migration_return_path_end_before();
-        rp_error = await_return_path_close_on_source(s);
-        trace_migration_return_path_end_after(rp_error);
-        if (rp_error) {
+        await_return_path_close_on_source(s);
+        trace_migration_return_path_end_after();
+        /* If return path has error, should have been set here */
+        if (migrate_has_error(s)) {
             goto fail;
         }
     }
diff --git a/migration/ram.c b/migration/ram.c
index ba4890563d..567b179fb9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1922,7 +1922,8 @@ static void migration_page_queue_free(RAMState *rs)
  * @start: starting address from the start of the RAMBlock
  * @len: length (in bytes) to send
  */
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
+int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
+                         Error **errp)
 {
     RAMBlock *ramblock;
     RAMState *rs = ram_state;
@@ -1939,7 +1940,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
              * Shouldn't happen, we can't reuse the last RAMBlock if
              * it's the 1st request.
              */
-            error_report("ram_save_queue_pages no previous block");
+            error_setg(errp, "MIG_RP_MSG_REQ_PAGES has no previous block");
             return -1;
         }
     } else {
@@ -1947,16 +1948,17 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
 
         if (!ramblock) {
             /* We shouldn't be asked for a non-existent RAMBlock */
-            error_report("ram_save_queue_pages no block '%s'", rbname);
+            error_setg(errp, "MIG_RP_MSG_REQ_PAGES has no block '%s'", rbname);
             return -1;
         }
         rs->last_req_rb = ramblock;
     }
     trace_ram_save_queue_pages(ramblock->idstr, start, len);
     if (!offset_in_ramblock(ramblock, start + len - 1)) {
-        error_report("%s request overrun start=" RAM_ADDR_FMT " len="
-                     RAM_ADDR_FMT " blocklen=" RAM_ADDR_FMT,
-                     __func__, start, len, ramblock->used_length);
+        error_setg(errp, "MIG_RP_MSG_REQ_PAGES request overrun, "
+                   "start=" RAM_ADDR_FMT " len="
+                   RAM_ADDR_FMT " blocklen=" RAM_ADDR_FMT,
+                   start, len, ramblock->used_length);
         return -1;
     }
 
@@ -1988,9 +1990,9 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
         assert(len % page_size == 0);
         while (len) {
             if (ram_save_host_page_urgent(pss)) {
-                error_report("%s: ram_save_host_page_urgent() failed: "
-                             "ramblock=%s, start_addr=0x"RAM_ADDR_FMT,
-                             __func__, ramblock->idstr, start);
+                error_setg(errp, "ram_save_host_page_urgent() failed: "
+                           "ramblock=%s, start_addr=0x"RAM_ADDR_FMT,
+                           ramblock->idstr, start);
                 ret = -1;
                 break;
             }
@@ -4124,7 +4126,7 @@ static void ram_dirty_bitmap_reload_notify(MigrationState *s)
  * This is only used when the postcopy migration is paused but wants
  * to resume from a middle point.
  */
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
+int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
 {
     int ret = -EINVAL;
     /* from_dst_file is always valid because we're within rp_thread */
@@ -4136,8 +4138,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
 
     if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        error_report("%s: incorrect state %s", __func__,
-                     MigrationStatus_str(s->state));
+        error_setg(errp, "Reload bitmap in incorrect state %s",
+                   MigrationStatus_str(s->state));
         return -EINVAL;
     }
 
@@ -4154,9 +4156,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
     /* The size of the bitmap should match with our ramblock */
     if (size != local_size) {
-        error_report("%s: ramblock '%s' bitmap size mismatch "
-                     "(0x%"PRIx64" != 0x%"PRIx64")", __func__,
-                     block->idstr, size, local_size);
+        error_setg(errp, "ramblock '%s' bitmap size mismatch (0x%"PRIx64
+                   " != 0x%"PRIx64")", block->idstr, size, local_size);
         ret = -EINVAL;
         goto out;
     }
@@ -4166,16 +4167,16 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
     ret = qemu_file_get_error(file);
     if (ret || size != local_size) {
-        error_report("%s: read bitmap failed for ramblock '%s': %d"
-                     " (size 0x%"PRIx64", got: 0x%"PRIx64")",
-                     __func__, block->idstr, ret, local_size, size);
+        error_setg(errp, "read bitmap failed for ramblock '%s': %d"
+                   " (size 0x%"PRIx64", got: 0x%"PRIx64")",
+                   block->idstr, ret, local_size, size);
         ret = -EIO;
         goto out;
     }
 
     if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
-        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIx64,
-                     __func__, block->idstr, end_mark);
+        error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
+                   block->idstr, end_mark);
         ret = -EINVAL;
         goto out;
     }
diff --git a/migration/trace-events b/migration/trace-events
index cdaef7a1ea..98aa46c780 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -161,7 +161,7 @@ migration_completion_postcopy_end_after_complete(void) ""
 migration_rate_limit_pre(int ms) "%d ms"
 migration_rate_limit_post(int urgent) "urgent: %d"
 migration_return_path_end_before(void) ""
-migration_return_path_end_after(int rp_error) "%d"
+migration_return_path_end_after(void) ""
 migration_thread_after_loop(void) ""
 migration_thread_file_err(void) ""
 migration_thread_setup_complete(void) ""
-- 
2.41.0


