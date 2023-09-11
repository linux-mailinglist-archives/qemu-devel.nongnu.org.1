Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D263679AA84
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 19:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfkTp-0002ns-6X; Mon, 11 Sep 2023 13:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTl-0002mr-KV
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:41 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTi-0000Ax-RU
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2D022183F;
 Mon, 11 Sep 2023 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694452417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsROk6EVy4STMdPRXEStC03FsfSuYWtANPTfYLuwSvk=;
 b=qD1skM7d8QQ8Ocl9ghRE2vquQ70laO1notkffxocKhLWiVFtwRnsOfEsvKREq2QW1Du8AX
 IY4V3lWkFjq1LjrKWWNxQ0VDFKogI4YPGkYxxN7vi1oTnGUNdO2RlAlCF5AhBIuBtWm927
 RAUH8it/PG4smrvi9RIny+jVUeCsPQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694452417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsROk6EVy4STMdPRXEStC03FsfSuYWtANPTfYLuwSvk=;
 b=2v67M5xAvN4ieQD0MFTCVaU09qTjjC130SNWfNvGX5+/yjDbAhWAMDh7v1zWFR7qNylmGE
 o7NqKKsVCm2u/pCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E7CA139CC;
 Mon, 11 Sep 2023 17:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eHNVN79K/2QyIAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 11 Sep 2023 17:13:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v6 06/10] migration: Replace the return path retry logic
Date: Mon, 11 Sep 2023 14:13:16 -0300
Message-Id: <20230911171320.24372-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230911171320.24372-1-farosas@suse.de>
References: <20230911171320.24372-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
index 4edbee3a5d..7dfcbc3634 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1775,18 +1775,6 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
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
@@ -1870,7 +1858,6 @@ static void *source_return_path_thread(void *opaque)
     trace_source_return_path_thread_entry();
     rcu_register_thread();
 
-retry:
     while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
            migration_is_setup_or_active(ms->state)) {
         trace_source_return_path_thread_loop_top();
@@ -1992,26 +1979,7 @@ retry:
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
@@ -2022,8 +1990,7 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms,
-                                      bool create_thread)
+static int open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -2032,11 +1999,6 @@ static int open_return_path_on_source(MigrationState *ms,
 
     trace_open_return_path_on_source();
 
-    if (!create_thread) {
-        /* We're done */
-        return 0;
-    }
-
     qemu_thread_create(&ms->rp_state.rp_thread, "return path",
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
     ms->rp_state.rp_thread_created = true;
@@ -2076,6 +2038,7 @@ static int await_return_path_close_on_source(MigrationState *ms)
     trace_await_return_path_close_on_source_close();
 
     ret = ms->rp_state.error;
+    ms->rp_state.error = false;
     trace_migration_return_path_end_after(ret);
     return ret;
 }
@@ -2551,6 +2514,13 @@ static MigThrError postcopy_pause(MigrationState *s)
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
 
@@ -2568,12 +2538,6 @@ static MigThrError postcopy_pause(MigrationState *s)
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
@@ -3263,7 +3227,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s, !resume)) {
+        if (open_return_path_on_source(s)) {
             error_setg(&local_err, "Unable to open return-path for postcopy");
             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
             migrate_set_error(s, local_err);
@@ -3327,7 +3291,6 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rate_limit_sem);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
-    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
@@ -3347,7 +3310,6 @@ static void migration_instance_init(Object *obj)
     migrate_params_init(&ms->parameters);
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
-    qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
     qemu_sem_init(&ms->rate_limit_sem, 0);
diff --git a/migration/migration.h b/migration/migration.h
index 6eea18db36..36eb5ba70b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -382,7 +382,6 @@ struct MigrationState {
 
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
-    QemuSemaphore postcopy_pause_rp_sem;
     /*
      * Whether we abort the migration if decompression errors are
      * detected at the destination. It is left at false for qemu
-- 
2.35.3


