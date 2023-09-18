Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D457E7A50FD
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiI3C-0006x1-II; Mon, 18 Sep 2023 13:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI3A-0006wU-N1
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:28:44 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI38-0004Tl-P5
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:28:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F67B20040;
 Mon, 18 Sep 2023 17:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695058119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njiEasCiyDZ3zEQzv1te8rw2b1GzhzW8OUb87XFlTlc=;
 b=0qh31PKJwlln4m5d9gVjRlDEcfcJtGPKqim/wS+cxTBDpGRDtYg7jAQ3JkPfEx6W9bYEOi
 hHTMpKr8eDk+arLYBe26elORMyImrZ/pi7nd17TT04skgklrDvOw0hI3wHkUvyDmlGTHPq
 NhCdLy0+JbP7qc0JwB+A28cEojK1Jwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695058119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njiEasCiyDZ3zEQzv1te8rw2b1GzhzW8OUb87XFlTlc=;
 b=ID9m2BcJG57PSiqXtaby3/peTh4qP5PuoUMcuT1aHLZrFPV3LJAq2R1qt8RxCSEycq0gVI
 Nk8bBSQK1GyL+8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1545D1358A;
 Mon, 18 Sep 2023 17:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SCf4M8WICGUoGAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 17:28:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 7/8] migration: Replace the return path retry logic
Date: Mon, 18 Sep 2023 14:28:21 -0300
Message-Id: <20230918172822.19052-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918172822.19052-1-farosas@suse.de>
References: <20230918172822.19052-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace the return path retry logic with finishing and restarting the
thread. This fixes a race when resuming the migration that leads to a
segfault.

Currently when doing postcopy we consider that an IO error on the
return path file could be due to a network intermittency. We then keep
the thread alive but have it do cleanup of the 'from_dst_file' and
wait on the 'postcopy_pause_rp' semaphore. When the user issues a
migrate resume, a new return path is opened and the thread is allowed
to continue.

There's a race condition in the above mechanism. It is possible for
the new return path file to be setup *before* the cleanup code in the
return path thread has had a chance to run, leading to the *new* file
being closed and the pointer set to NULL. When the thread is released
after the resume, it tries to dereference 'from_dst_file' and crashes:

Thread 7 "return path" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffd1dbf700 (LWP 9611)]
0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
154         return f->last_error;

(gdb) bt
 #0  0x00005555560e4893 in qemu_file_get_error_obj (f=0x0, errp=0x0) at ../migration/qemu-file.c:154
 #1  0x00005555560e4983 in qemu_file_get_error (f=0x0) at ../migration/qemu-file.c:206
 #2  0x0000555555b9a1df in source_return_path_thread (opaque=0x555556e06000) at ../migration/migration.c:1876
 #3  0x000055555602e14f in qemu_thread_start (args=0x55555782e780) at ../util/qemu-thread-posix.c:541
 #4  0x00007ffff38d76ea in start_thread (arg=0x7fffd1dbf700) at pthread_create.c:477
 #5  0x00007ffff35efa6f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Here's the race (important bit is open_return_path happening before
migration_release_dst_files):

migration                 | qmp                         | return path
--------------------------+-----------------------------+---------------------------------
			    qmp_migrate_pause()
			     shutdown(ms->to_dst_file)
			      f->last_error = -EIO
migrate_detect_error()
 postcopy_pause()
  set_state(PAUSED)
  wait(postcopy_pause_sem)
			    qmp_migrate(resume)
			    migrate_fd_connect()
			     resume = state == PAUSED
			     open_return_path <-- TOO SOON!
			     set_state(RECOVER)
			     post(postcopy_pause_sem)
							(incoming closes to_src_file)
							res = qemu_file_get_error(rp)
							migration_release_dst_files()
							ms->rp_state.from_dst_file = NULL
  post(postcopy_pause_rp_sem)
							postcopy_pause_return_path_thread()
							  wait(postcopy_pause_rp_sem)
							rp = ms->rp_state.from_dst_file
							goto retry
							qemu_file_get_error(rp)
							SIGSEGV
-------------------------------------------------------------------------------------------

We can keep the retry logic without having the thread alive and
waiting. The only piece of data used by it is the 'from_dst_file' and
it is only allowed to proceed after a migrate resume is issued and the
semaphore released at migrate_fd_connect().

Move the retry logic to outside the thread by waiting for the thread
to finish before pausing the migration.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 60 ++++++++-----------------------------------
 migration/migration.h |  1 -
 2 files changed, 11 insertions(+), 50 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f6c0250d33..af78f7ee54 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1787,18 +1787,6 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
     }
 }
 
-/* Return true to retry, false to quit */
-static bool postcopy_pause_return_path_thread(MigrationState *s)
-{
-    trace_postcopy_pause_return_path();
-
-    qemu_sem_wait(&s->postcopy_pause_rp_sem);
-
-    trace_postcopy_pause_return_path_continued();
-
-    return true;
-}
-
 static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
 {
     RAMBlock *block = qemu_ram_block_by_name(block_name);
@@ -1882,7 +1870,6 @@ static void *source_return_path_thread(void *opaque)
     trace_source_return_path_thread_entry();
     rcu_register_thread();
 
-retry:
     while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
            migration_is_setup_or_active(ms->state)) {
         trace_source_return_path_thread_loop_top();
@@ -2004,26 +1991,7 @@ retry:
     }
 
 out:
-    res = qemu_file_get_error(rp);
-    if (res) {
-        if (res && migration_in_postcopy()) {
-            /*
-             * Maybe there is something we can do: it looks like a
-             * network down issue, and we pause for a recovery.
-             */
-            migration_release_dst_files(ms);
-            rp = NULL;
-            if (postcopy_pause_return_path_thread(ms)) {
-                /*
-                 * Reload rp, reset the rest.  Referencing it is safe since
-                 * it's reset only by us above, or when migration completes
-                 */
-                rp = ms->rp_state.from_dst_file;
-                ms->rp_state.error = false;
-                goto retry;
-            }
-        }
-
+    if (qemu_file_get_error(rp)) {
         trace_source_return_path_thread_bad_end();
         mark_source_rp_bad(ms);
     }
@@ -2034,8 +2002,7 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms,
-                                      bool create_thread)
+static int open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -2044,11 +2011,6 @@ static int open_return_path_on_source(MigrationState *ms,
 
     trace_open_return_path_on_source();
 
-    if (!create_thread) {
-        /* We're done */
-        return 0;
-    }
-
     qemu_thread_create(&ms->rp_state.rp_thread, "return path",
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
     ms->rp_state.rp_thread_created = true;
@@ -2088,6 +2050,7 @@ static int await_return_path_close_on_source(MigrationState *ms)
     trace_await_return_path_close_on_source_close();
 
     ret = ms->rp_state.error;
+    ms->rp_state.error = false;
     trace_migration_return_path_end_after(ret);
     return ret;
 }
@@ -2563,6 +2526,13 @@ static MigThrError postcopy_pause(MigrationState *s)
         qemu_file_shutdown(file);
         qemu_fclose(file);
 
+        /*
+         * We're already pausing, so ignore any errors on the return
+         * path and just wait for the thread to finish. It will be
+         * re-created when we resume.
+         */
+        await_return_path_close_on_source(s);
+
         migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_POSTCOPY_PAUSED);
 
@@ -2580,12 +2550,6 @@ static MigThrError postcopy_pause(MigrationState *s)
         if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
             /* Woken up by a recover procedure. Give it a shot */
 
-            /*
-             * Firstly, let's wake up the return path now, with a new
-             * return path channel.
-             */
-            qemu_sem_post(&s->postcopy_pause_rp_sem);
-
             /* Do the resume logic */
             if (postcopy_do_resume(s) == 0) {
                 /* Let's continue! */
@@ -3275,7 +3239,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s, !resume)) {
+        if (open_return_path_on_source(s)) {
             error_setg(&local_err, "Unable to open return-path for postcopy");
             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
             migrate_set_error(s, local_err);
@@ -3339,7 +3303,6 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rate_limit_sem);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
-    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
@@ -3359,7 +3322,6 @@ static void migration_instance_init(Object *obj)
     migrate_params_init(&ms->parameters);
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
-    qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
     qemu_sem_init(&ms->rate_limit_sem, 0);
diff --git a/migration/migration.h b/migration/migration.h
index cdaa10d515..972597f4de 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -393,7 +393,6 @@ struct MigrationState {
 
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
-    QemuSemaphore postcopy_pause_rp_sem;
     /*
      * Whether we abort the migration if decompression errors are
      * detected at the destination. It is left at false for qemu
-- 
2.35.3


