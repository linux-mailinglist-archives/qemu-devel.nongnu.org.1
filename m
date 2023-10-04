Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9C7B79CD
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsS-0001gY-W5; Wed, 04 Oct 2023 04:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnws4-0008PC-7K; Wed, 04 Oct 2023 04:04:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnws0-0001UQ-ME; Wed, 04 Oct 2023 04:04:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1597275A5;
 Wed,  4 Oct 2023 11:02:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0FFFB2CBE0;
 Wed,  4 Oct 2023 11:02:27 +0300 (MSK)
Received: (nullmailer pid 2702828 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 26/45] migration: Fix race that dest preempt thread
 close too early
Date: Wed,  4 Oct 2023 11:01:47 +0300
Message-Id: <20231004080221.2702636-26-mjt@tls.msk.ru>
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

From: Peter Xu <peterx@redhat.com>

We hit intermit CI issue on failing at migration-test over the unit test
preempt/plain:

qemu-system-x86_64: Unable to read from socket: Connection reset by peer
Memory content inconsistency at 5b43000 first_byte = bd last_byte = bc current = 4f hit_edge = 1
**
ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)
(test program exited with status code -6)

Fabiano debugged into it and found that the preempt thread can quit even
without receiving all the pages, which can cause guest not receiving all
the pages and corrupt the guest memory.

To make sure preempt thread finished receiving all the pages, we can rely
on the page_requested_count being zero because preempt channel will only
receive requested page faults. Note, not all the faulted pages are required
to be sent via the preempt channel/thread; imagine the case when a
requested page is just queued into the background main channel for
migration, the src qemu will just still send it via the background channel.

Here instead of spinning over reading the count, we add a condvar so the
main thread can wait on it if that unusual case happened, without burning
the cpu for no good reason, even if the duration is short; so even if we
spin in this rare case is probably fine.  It's just better to not do so.

The condvar is only used when that special case is triggered.  Some memory
ordering trick is needed to guarantee it from happening (against the
preempt thread status field), so the main thread will always get a kick
when that triggers correctly.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/1886
Debugged-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230918172822.19052-2-farosas@suse.de>
(cherry picked from commit cf02f29e1e3843784630d04783e372fa541a77e5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index 5528acb65e..6a7122694a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -153,6 +153,7 @@ void migration_object_init(void)
     qemu_sem_init(&current_incoming->postcopy_qemufile_dst_done, 0);
 
     qemu_mutex_init(&current_incoming->page_request_mutex);
+    qemu_cond_init(&current_incoming->page_request_cond);
     current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
 
     migration_object_check(current_migration, &error_fatal);
@@ -367,7 +368,7 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
              * things like g_tree_lookup() will return TRUE (1) when found.
              */
             g_tree_insert(mis->page_requested, aligned, (gpointer)1);
-            mis->page_requested_count++;
+            qatomic_inc(&mis->page_requested_count);
             trace_postcopy_page_req_add(aligned, mis->page_requested_count);
         }
     }
diff --git a/migration/migration.h b/migration/migration.h
index 6eea18db36..9a30216895 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -196,7 +196,10 @@ struct MigrationIncomingState {
 
     /* A tree of pages that we requested to the source VM */
     GTree *page_requested;
-    /* For debugging purpose only, but would be nice to keep */
+    /*
+     * For postcopy only, count the number of requested page faults that
+     * still haven't been resolved.
+     */
     int page_requested_count;
     /*
      * The mutex helps to maintain the requested pages that we sent to the
@@ -210,6 +213,14 @@ struct MigrationIncomingState {
      * contains valid information.
      */
     QemuMutex page_request_mutex;
+    /*
+     * If postcopy preempt is enabled, there is a chance that the main
+     * thread finished loading its data before the preempt channel has
+     * finished loading the urgent pages.  If that happens, the two threads
+     * will use this condvar to synchronize, so the main thread will always
+     * wait until all pages received.
+     */
+    QemuCond page_request_cond;
 
     /*
      * Number of devices that have yet to approve switchover. When this reaches
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 29aea9456d..5408e028c6 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -599,6 +599,30 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     if (mis->preempt_thread_status == PREEMPT_THREAD_CREATED) {
         /* Notify the fast load thread to quit */
         mis->preempt_thread_status = PREEMPT_THREAD_QUIT;
+        /*
+         * Update preempt_thread_status before reading count.  Note: mutex
+         * lock only provide ACQUIRE semantic, and it doesn't stops this
+         * write to be reordered after reading the count.
+         */
+        smp_mb();
+        /*
+         * It's possible that the preempt thread is still handling the last
+         * pages to arrive which were requested by guest page faults.
+         * Making sure nothing is left behind by waiting on the condvar if
+         * that unlikely case happened.
+         */
+        WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
+            if (qatomic_read(&mis->page_requested_count)) {
+                /*
+                 * It is guaranteed to receive a signal later, because the
+                 * count>0 now, so it's destined to be decreased to zero
+                 * very soon by the preempt thread.
+                 */
+                qemu_cond_wait(&mis->page_request_cond,
+                               &mis->page_request_mutex);
+            }
+        }
+        /* Notify the fast load thread to quit */
         if (mis->postcopy_qemufile_dst) {
             qemu_file_shutdown(mis->postcopy_qemufile_dst);
         }
@@ -1277,8 +1301,20 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
          */
         if (g_tree_lookup(mis->page_requested, host_addr)) {
             g_tree_remove(mis->page_requested, host_addr);
-            mis->page_requested_count--;
+            int left_pages = qatomic_dec_fetch(&mis->page_requested_count);
+
             trace_postcopy_page_req_del(host_addr, mis->page_requested_count);
+            /* Order the update of count and read of preempt status */
+            smp_mb();
+            if (mis->preempt_thread_status == PREEMPT_THREAD_QUIT &&
+                left_pages == 0) {
+                /*
+                 * This probably means the main thread is waiting for us.
+                 * Notify that we've finished receiving the last requested
+                 * page.
+                 */
+                qemu_cond_signal(&mis->page_request_cond);
+            }
         }
         qemu_mutex_unlock(&mis->page_request_mutex);
         mark_postcopy_blocktime_end((uintptr_t)host_addr);
-- 
2.39.2


