Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A84997CCE0E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqeN-0000L5-Pq; Tue, 17 Oct 2023 16:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeK-00009c-N0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeH-0000l9-OG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697574401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFY4GDW0Mm9hz64aNzZXY2peH2lKsL7Jq4tRyZFatlM=;
 b=HbeUtHManwCqP3pKZ01F/uX1wSMKUFCJH3tXAzIf6dMV//SJz/R/JKGS8uS2ky5Hu89e5J
 uyVDfDjPOxasM6RQ1xSP6LNJuyYNCk3tzh86IDVa1E32eyhFl8xrTM3jbxAVC34JTPU4iD
 9rhpcCOY+p8n8DYJEsbAlVfRl52u8YQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-26mXbPNeO6e7R9MWesgSqA-1; Tue, 17 Oct 2023 16:26:37 -0400
X-MC-Unique: 26mXbPNeO6e7R9MWesgSqA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-776fbd054e2so102250685a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 13:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697574397; x=1698179197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFY4GDW0Mm9hz64aNzZXY2peH2lKsL7Jq4tRyZFatlM=;
 b=RnHMKAfr3vdq+Mit/raffRtD4cAb/lGuDJrq3y9erCOxrnbSSyQA9UO4vaaAEqEYca
 At5jgo1nAXgHMdHCYpNgcfTYIicUywLBOzVQgX3xH6aQVg+nOIUw9mYvrLrOeemcMbmt
 SZA0v0TZIU/bIMitGh5YSRIpeK1V2cvtUvWI1TdSXjJP2DR1xVJyNV0ye0cM3tpzlYad
 QqJKGKw8riUmZn4IZyfP+1nYyzHBE/Ez328olCBnTAeXIEQQn+cXoAuaeZT5cGNuomiX
 XUQqAptEkTDe2CzqSnMqeeVYW/jET+HXwg02hbx/w8HrDUuSFf9PGamsANeaRNSfzxul
 5cqg==
X-Gm-Message-State: AOJu0YwI5LpviPtnt33SWH9F7LdjtlhabnRNP+heDODuq4VShvZA2k3a
 RWxvuXHuFflNoMKVuTXkgdBSXpMZF0R2uY96GrhaO6//eFtcPq3aEhHsewaVx56oY2LJV+1UDkM
 L16toxNg8GsB/uI2cmAwAFrDRmRYyHxHwiT4Nq3bQuMe2LeAmGStYgCQD3igIhu2jmdAzxZWn
X-Received: by 2002:a05:620a:8a15:b0:76f:167a:cc5d with SMTP id
 qt21-20020a05620a8a1500b0076f167acc5dmr3015766qkn.7.1697574396649; 
 Tue, 17 Oct 2023 13:26:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyI/j6+MmZE1r7qoZHn7PkfSrBV/X1mR7sMIszVePJrM49IqyTO6RQvnamZNu2JZHTyERFRA==
X-Received: by 2002:a05:620a:8a15:b0:76f:167a:cc5d with SMTP id
 qt21-20020a05620a8a1500b0076f167acc5dmr3015746qkn.7.1697574396103; 
 Tue, 17 Oct 2023 13:26:36 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s17-20020ae9f711000000b0076f16e98851sm931879qkg.102.2023.10.17.13.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:26:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 1/5] migration: Refactor error handling in source return
 path
Date: Tue, 17 Oct 2023 16:26:29 -0400
Message-ID: <20231017202633.296756-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017202633.296756-1-peterx@redhat.com>
References: <20231017202633.296756-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

rp_state.error was a boolean used to show error happened in return path
thread.  That's not only duplicating error reporting (migrate_set_error),
but also not good enough in that we only do error_report() and set it to
true, we never can keep a history of the exact error and show it in
query-migrate.

To make this better, a few things done:

  - Use error_setg() rather than error_report() across the whole lifecycle
    of return path thread, keeping the error in an Error*.

  - With above, no need to have mark_source_rp_bad(), remove it, alongside
    with rp_state.error itself.

  - Use migrate_set_error() to apply that captured error to the global
    migration object when error occured in this thread.

  - Do the same when detected qemufile error in source return path

We need to re-export qemu_file_get_error_obj() to do the last one.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h  |   1 -
 migration/qemu-file.h  |   1 +
 migration/ram.h        |   5 +-
 migration/migration.c  | 121 ++++++++++++++++++-----------------------
 migration/qemu-file.c  |   2 +-
 migration/ram.c        |  41 +++++++-------
 migration/trace-events |   4 +-
 7 files changed, 80 insertions(+), 95 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index ae82004892..1d1ac13adb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -308,7 +308,6 @@ struct MigrationState {
         /* Protected by qemu_file_lock */
         QEMUFile     *from_dst_file;
         QemuThread    rp_thread;
-        bool          error;
         /*
          * We can also check non-zero of rp_thread, but there's no "official"
          * way to do this, so this bool makes it slightly more elegant.
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a29c37b0d0..25a1a8052f 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -87,6 +87,7 @@ int coroutine_mixed_fn qemu_peek_byte(QEMUFile *f, int offset);
 void qemu_file_skip(QEMUFile *f, int size);
 int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
+int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
 void qemu_file_set_error(QEMUFile *f, int ret);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
diff --git a/migration/ram.h b/migration/ram.h
index 145c915ca7..14ed666d58 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -51,7 +51,8 @@ uint64_t ram_bytes_total(void);
 void mig_throttle_counter_reset(void);
 
 uint64_t ram_pagesize_summary(void);
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
+int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
+                         Error **errp);
 void ram_postcopy_migrated_memory_release(MigrationState *ms);
 /* For outgoing discard bitmap */
 void ram_postcopy_send_discard_bitmap(MigrationState *ms);
@@ -71,7 +72,7 @@ void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
 int64_t ramblock_recv_bitmap_send(QEMUFile *file,
                                   const char *block_name);
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb);
+int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
diff --git a/migration/migration.c b/migration/migration.c
index 6ba5e145ac..3123c4a873 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -99,7 +99,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
-static int close_return_path_on_source(MigrationState *s);
+static bool close_return_path_on_source(MigrationState *s);
 
 static bool migration_needs_multiple_sockets(void)
 {
@@ -1430,7 +1430,6 @@ int migrate_init(MigrationState *s, Error **errp)
     s->to_dst_file = NULL;
     s->state = MIGRATION_STATUS_NONE;
     s->rp_state.from_dst_file = NULL;
-    s->rp_state.error = false;
     s->mbps = 0.0;
     s->pages_per_second = 0.0;
     s->downtime = 0;
@@ -1755,16 +1754,6 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
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
 void migration_rp_wait(MigrationState *s)
 {
     qemu_sem_wait(&s->rp_state.rp_sem);
@@ -1795,8 +1784,9 @@ static struct rp_cmd_args {
  * We're allowed to send more than requested (e.g. to round to our page size)
  * and we don't need to send pages that have already been sent.
  */
-static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
-                                       ram_addr_t start, size_t len)
+static void
+migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
+                            ram_addr_t start, size_t len, Error **errp)
 {
     long our_host_ps = qemu_real_host_page_size();
 
@@ -1808,37 +1798,36 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
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
 
@@ -1897,48 +1886,46 @@ static void *source_return_path_thread(void *opaque)
     uint32_t tmp32, sibling_error;
     ram_addr_t start = 0; /* =0 to silence warning */
     size_t  len = 0, expected_len;
+    Error *err = NULL;
     int res;
 
     trace_source_return_path_thread_entry();
     rcu_register_thread();
 
-    while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
-           migration_is_setup_or_active(ms->state)) {
+    while (migration_is_setup_or_active(ms->state)) {
         trace_source_return_path_thread_loop_top();
+
         header_type = qemu_get_be16(rp);
         header_len = qemu_get_be16(rp);
 
         if (qemu_file_get_error(rp)) {
-            mark_source_rp_bad(ms);
+            qemu_file_get_error_obj(rp, &err);
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
 
@@ -1948,8 +1935,7 @@ static void *source_return_path_thread(void *opaque)
             sibling_error = ldl_be_p(buf);
             trace_source_return_path_thread_shut(sibling_error);
             if (sibling_error) {
-                error_report("RP: Sibling indicated error %d", sibling_error);
-                mark_source_rp_bad(ms);
+                error_setg(&err, "Sibling indicated error %d", sibling_error);
             }
             /*
              * We'll let the main thread deal with closing the RP
@@ -1967,7 +1953,10 @@ static void *source_return_path_thread(void *opaque)
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
@@ -1982,32 +1971,32 @@ static void *source_return_path_thread(void *opaque)
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
@@ -2023,13 +2012,15 @@ static void *source_return_path_thread(void *opaque)
     }
 
 out:
-    if (qemu_file_get_error(rp)) {
+    if (err) {
+        migrate_set_error(ms, err);
+        error_free(err);
         trace_source_return_path_thread_bad_end();
-        mark_source_rp_bad(ms);
     }
 
     trace_source_return_path_thread_end();
     rcu_unregister_thread();
+
     return NULL;
 }
 
@@ -2051,12 +2042,11 @@ static int open_return_path_on_source(MigrationState *ms)
     return 0;
 }
 
-static int close_return_path_on_source(MigrationState *ms)
+/* Return true if error detected, or false otherwise */
+static bool close_return_path_on_source(MigrationState *ms)
 {
-    int ret;
-
     if (!ms->rp_state.rp_thread_created) {
-        return 0;
+        return false;
     }
 
     trace_migration_return_path_end_before();
@@ -2074,18 +2064,13 @@ static int close_return_path_on_source(MigrationState *ms)
         }
     }
 
-    trace_await_return_path_close_on_source_joining();
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created = false;
-    trace_await_return_path_close_on_source_close();
-
-    ret = ms->rp_state.error;
-    ms->rp_state.error = false;
-
     migration_release_dst_files(ms);
+    trace_migration_return_path_end_after();
 
-    trace_migration_return_path_end_after(ret);
-    return ret;
+    /* Return path will persist the error in MigrationState when quit */
+    return migrate_has_error(ms);
 }
 
 static inline void
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 3fb25148d1..5b8fd8bee1 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -140,7 +140,7 @@ QEMUFile *qemu_file_new_input(QIOChannel *ioc)
  *
  * If errp is specified, a verbose error message will be copied over.
  */
-static int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
+int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
 {
     if (!f->last_error) {
         return 0;
diff --git a/migration/ram.c b/migration/ram.c
index c844151ee9..544c5b63cf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1955,7 +1955,8 @@ static void migration_page_queue_free(RAMState *rs)
  * @start: starting address from the start of the RAMBlock
  * @len: length (in bytes) to send
  */
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
+int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
+                         Error **errp)
 {
     RAMBlock *ramblock;
     RAMState *rs = ram_state;
@@ -1972,7 +1973,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
              * Shouldn't happen, we can't reuse the last RAMBlock if
              * it's the 1st request.
              */
-            error_report("ram_save_queue_pages no previous block");
+            error_setg(errp, "MIG_RP_MSG_REQ_PAGES has no previous block");
             return -1;
         }
     } else {
@@ -1980,16 +1981,17 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
 
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
 
@@ -2021,9 +2023,9 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
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
@@ -4186,7 +4188,7 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
  * This is only used when the postcopy migration is paused but wants
  * to resume from a middle point.
  */
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
+int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
 {
     int ret = -EINVAL;
     /* from_dst_file is always valid because we're within rp_thread */
@@ -4200,8 +4202,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
 
     if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        error_report("%s: incorrect state %s", __func__,
-                     MigrationStatus_str(s->state));
+        error_setg(errp, "Reload bitmap in incorrect state %s",
+                   MigrationStatus_str(s->state));
         return -EINVAL;
     }
 
@@ -4218,9 +4220,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
     /* The size of the bitmap should match with our ramblock */
     if (size != local_size) {
-        error_report("%s: ramblock '%s' bitmap size mismatch "
-                     "(0x%"PRIx64" != 0x%"PRIx64")", __func__,
-                     block->idstr, size, local_size);
+        error_setg(errp, "ramblock '%s' bitmap size mismatch (0x%"PRIx64
+                   " != 0x%"PRIx64")", block->idstr, size, local_size);
         return -EINVAL;
     }
 
@@ -4229,15 +4230,15 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
     ret = qemu_file_get_error(file);
     if (ret || size != local_size) {
-        error_report("%s: read bitmap failed for ramblock '%s': %d"
-                     " (size 0x%"PRIx64", got: 0x%"PRIx64")",
-                     __func__, block->idstr, ret, local_size, size);
+        error_setg(errp, "read bitmap failed for ramblock '%s': %d"
+                   " (size 0x%"PRIx64", got: 0x%"PRIx64")",
+                   block->idstr, ret, local_size, size);
         return -EIO;
     }
 
     if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
-        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIx64,
-                     __func__, block->idstr, end_mark);
+        error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
+                   block->idstr, end_mark);
         return -EINVAL;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index fa9486dffe..d50e8ed87e 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -148,8 +148,6 @@ multifd_tls_outgoing_handshake_complete(void *ioc) "ioc=%p"
 multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
 
 # migration.c
-await_return_path_close_on_source_close(void) ""
-await_return_path_close_on_source_joining(void) ""
 migrate_set_state(const char *new_state) "new state %s"
 migrate_fd_cleanup(void) ""
 migrate_fd_error(const char *error_desc) "error=%s"
@@ -166,7 +164,7 @@ migration_completion_postcopy_end_after_complete(void) ""
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


