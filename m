Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EFC7B79CC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwvr-00028o-CX; Wed, 04 Oct 2023 04:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwse-0003Ao-I9; Wed, 04 Oct 2023 04:05:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwsb-0002Hy-TM; Wed, 04 Oct 2023 04:05:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 77155275AC;
 Wed,  4 Oct 2023 11:02:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id ADEB42CBE6;
 Wed,  4 Oct 2023 11:02:28 +0300 (MSK)
Received: (nullmailer pid 2702847 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 32/45] migration: Replace the return path retry logic
Date: Wed,  4 Oct 2023 11:01:53 +0300
Message-Id: <20231004080221.2702636-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fabiano Rosas <farosas@suse.de>

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
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230918172822.19052-8-farosas@suse.de>
(cherry picked from commit ef796ee93b313ed2f0b427ef30320417387d2ad5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index ac4541b971..a0782c64a1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1776,18 +1776,6 @@ static void migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
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
@@ -1871,7 +1859,6 @@ static void *source_return_path_thread(void *opaque)
     trace_source_return_path_thread_entry();
     rcu_register_thread();
 
-retry:
     while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
            migration_is_setup_or_active(ms->state)) {
         trace_source_return_path_thread_loop_top();
@@ -1993,26 +1980,7 @@ retry:
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
@@ -2023,8 +1991,7 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms,
-                                      bool create_thread)
+static int open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -2033,11 +2000,6 @@ static int open_return_path_on_source(MigrationState *ms,
 
     trace_open_return_path_on_source();
 
-    if (!create_thread) {
-        /* We're done */
-        return 0;
-    }
-
     qemu_thread_create(&ms->rp_state.rp_thread, "return path",
                        source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
     ms->rp_state.rp_thread_created = true;
@@ -2077,6 +2039,7 @@ static int await_return_path_close_on_source(MigrationState *ms)
     trace_await_return_path_close_on_source_close();
 
     ret = ms->rp_state.error;
+    ms->rp_state.error = false;
     trace_migration_return_path_end_after(ret);
     return ret;
 }
@@ -2552,6 +2515,13 @@ static MigThrError postcopy_pause(MigrationState *s)
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
 
@@ -2569,12 +2539,6 @@ static MigThrError postcopy_pause(MigrationState *s)
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
@@ -3264,7 +3228,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s, !resume)) {
+        if (open_return_path_on_source(s)) {
             error_setg(&local_err, "Unable to open return-path for postcopy");
             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
             migrate_set_error(s, local_err);
@@ -3328,7 +3292,6 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rate_limit_sem);
     qemu_sem_destroy(&ms->pause_sem);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
-    qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
@@ -3348,7 +3311,6 @@ static void migration_instance_init(Object *obj)
     migrate_params_init(&ms->parameters);
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
-    qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
     qemu_sem_init(&ms->rate_limit_sem, 0);
diff --git a/migration/migration.h b/migration/migration.h
index 9a30216895..1034d617bf 100644
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
2.39.2


