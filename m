Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 821F678CFF4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nS-0000yI-Dc; Tue, 29 Aug 2023 19:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U6-0006Lj-VC
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U3-0000gE-5l
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdKS8z7xAB9LImRiAMESm5ufmMTyU1i9XZnD0iZK6a8=;
 b=LL01/Bkdn3FS4qmtSqqe2NtUv5sClo5KZpHz3+EZU4m6yGFDcJ4X6jofDzmUX0+SV3X1EU
 0OkgUMtN3elfWaOQZWHwOixTna/QV+DkdbQ6hxJuOAGi/fIaJpuSk+LOuuHSivCVqpnNKr
 zPM3Zx5VeHRdVZk48JAlTr0nlFN49io=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-0K0SX9DePbK1krwnPUOiFA-1; Tue, 29 Aug 2023 17:42:44 -0400
X-MC-Unique: 0K0SX9DePbK1krwnPUOiFA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76f1cc68e65so39577885a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345364; x=1693950164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdKS8z7xAB9LImRiAMESm5ufmMTyU1i9XZnD0iZK6a8=;
 b=KvV0FzyERCK0DRL8Ut9whQESA8ZKGzr/wW8uzxpOkMMGOrB8Kd1LVSazFkM8UGpUS+
 ezCxDM5n/tqlaYf5gOpbydyk166ROxNbHIjhxvNnqihmdDrO6bpt/O9oiBtNxJKURg4Z
 V060KMbuUro4JQRwXD680bwCjJ+GTfUe9uUIWTUdCJOiABaJm2vLTEzONU20NLW7JcNO
 Yb8DR+xJq0+haXCC0GsBpmxU2/TZMzWxJPJQEKek/bQYDK7V8iFdQGs7yRU+Q2k4It2q
 a0E0gTErZv8g470LjCS3mgArXWab7G+3AKbo48MVwF3fDzPdr1quu9BxHwmJEB5WM2pD
 t2iQ==
X-Gm-Message-State: AOJu0YxvFi1qBtY4CBeR6waGK0PBHL4vv6kaqkdVAwuZdmV7Fd4PkvmM
 SjDpez34PeQEHUAeZnR5T0i3HRAdQifpwfdnNkbJr+RCoU5uHIReGxJrgZSs/q5bzPrWO2VaqQc
 NsqaMDudMwGJ6RTEkmQntyQd6YKD8Z9CXKA77XxwIW2G9/EK2oHcTB3u3znDiqI2FIV9P9PGu
X-Received: by 2002:a05:622a:1aa2:b0:412:944:542f with SMTP id
 s34-20020a05622a1aa200b004120944542fmr265414qtc.2.1693345363867; 
 Tue, 29 Aug 2023 14:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqvlFuY8x96Z5tra1v8rXsb0ngVM4pBxaz/Vu9DPOPGABT8kds3IBDhBQ0KAQKjVSgKpDMAg==
X-Received: by 2002:a05:622a:1aa2:b0:412:944:542f with SMTP id
 s34-20020a05622a1aa200b004120944542fmr265398qtc.2.1693345363328; 
 Tue, 29 Aug 2023 14:42:43 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:42 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 4/9] migration: Refactor error handling in source return path
Date: Tue, 29 Aug 2023 17:42:30 -0400
Message-ID: <20230829214235.69309-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829214235.69309-1-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h  |   1 -
 migration/ram.h        |   5 +-
 migration/migration.c  | 122 +++++++++++++++++++++--------------------
 migration/ram.c        |  41 +++++++-------
 migration/trace-events |   2 +-
 5 files changed, 89 insertions(+), 82 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 1ba38eecfa..a5c95e4d43 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -297,7 +297,6 @@ struct MigrationState {
         /* Protected by qemu_file_lock */
         QEMUFile     *from_dst_file;
         QemuThread    rp_thread;
-        bool          error;
         /*
          * We can also check non-zero of rp_thread, but there's no "official"
          * way to do this, so this bool makes it slightly more elegant.
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
index 84c17dfbbb..def9d119b1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1424,7 +1424,6 @@ void migrate_init(MigrationState *s)
     s->to_dst_file = NULL;
     s->state = MIGRATION_STATUS_NONE;
     s->rp_state.from_dst_file = NULL;
-    s->rp_state.error = false;
     s->mbps = 0.0;
     s->pages_per_second = 0.0;
     s->downtime = 0;
@@ -1743,14 +1742,14 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
     qemu_sem_post(&s->pause_sem);
 }
 
-/* migration thread support */
-/*
- * Something bad happened to the RP stream, mark an error
- * The caller shall print or trace something to indicate why
- */
-static void mark_source_rp_bad(MigrationState *s)
+void migration_rp_wait(MigrationState *s)
 {
-    s->rp_state.error = true;
+    qemu_sem_wait(&s->rp_state.rp_sem);
+}
+
+void migration_rp_kick(MigrationState *s)
+{
+    qemu_sem_post(&s->rp_state.rp_sem);
 }
 
 static struct rp_cmd_args {
@@ -1774,7 +1773,7 @@ static struct rp_cmd_args {
  * and we don't need to send pages that have already been sent.
  */
 static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
-                                       ram_addr_t start, size_t len)
+                                        ram_addr_t start, size_t len, Error **errp)
 {
     long our_host_ps = qemu_real_host_page_size();
 
@@ -1786,15 +1785,12 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
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
@@ -1809,26 +1805,28 @@ static bool postcopy_pause_return_path_thread(MigrationState *s)
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
 
@@ -1887,49 +1885,47 @@ static void *source_return_path_thread(void *opaque)
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
 
@@ -1939,8 +1935,7 @@ retry:
             sibling_error = ldl_be_p(buf);
             trace_source_return_path_thread_shut(sibling_error);
             if (sibling_error) {
-                error_report("RP: Sibling indicated error %d", sibling_error);
-                mark_source_rp_bad(ms);
+                error_setg(&err, "Sibling indicated error %d", sibling_error);
             }
             /*
              * We'll let the main thread deal with closing the RP
@@ -1958,7 +1953,10 @@ retry:
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
@@ -1973,32 +1971,32 @@ retry:
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
@@ -2014,6 +2012,19 @@ retry:
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
@@ -2029,13 +2040,11 @@ out:
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
@@ -2068,8 +2077,7 @@ static int open_return_path_on_source(MigrationState *ms,
     return 0;
 }
 
-/* Returns 0 if the RP was ok, otherwise there was an error on the RP */
-static int await_return_path_close_on_source(MigrationState *ms)
+static void await_return_path_close_on_source(MigrationState *ms)
 {
     /*
      * If this is a normal exit then the destination will send a SHUT and the
@@ -2082,13 +2090,11 @@ static int await_return_path_close_on_source(MigrationState *ms)
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
@@ -2391,11 +2397,11 @@ static void migration_completion(MigrationState *s)
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
index fc7fe0e6e8..814c59c17b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1963,7 +1963,8 @@ static void migration_page_queue_free(RAMState *rs)
  * @start: starting address from the start of the RAMBlock
  * @len: length (in bytes) to send
  */
-int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
+int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
+                         Error **errp)
 {
     RAMBlock *ramblock;
     RAMState *rs = ram_state;
@@ -1980,7 +1981,7 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
              * Shouldn't happen, we can't reuse the last RAMBlock if
              * it's the 1st request.
              */
-            error_report("ram_save_queue_pages no previous block");
+            error_setg(errp, "MIG_RP_MSG_REQ_PAGES has no previous block");
             return -1;
         }
     } else {
@@ -1988,16 +1989,17 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
 
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
 
@@ -2029,9 +2031,9 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
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
@@ -4165,7 +4167,7 @@ static void ram_dirty_bitmap_reload_notify(MigrationState *s)
  * This is only used when the postcopy migration is paused but wants
  * to resume from a middle point.
  */
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
+int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
 {
     int ret = -EINVAL;
     /* from_dst_file is always valid because we're within rp_thread */
@@ -4177,8 +4179,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
 
     if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        error_report("%s: incorrect state %s", __func__,
-                     MigrationStatus_str(s->state));
+        error_setg(errp, "Reload bitmap in incorrect state %s",
+                   MigrationStatus_str(s->state));
         return -EINVAL;
     }
 
@@ -4195,9 +4197,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
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
@@ -4207,16 +4208,16 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
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
index 4666f19325..20cd17ffe8 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -164,7 +164,7 @@ migration_completion_postcopy_end_after_complete(void) ""
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


