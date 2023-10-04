Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBCF7B79B3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:09:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwso-0003nx-6t; Wed, 04 Oct 2023 04:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwsh-0003KM-FD; Wed, 04 Oct 2023 04:05:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwse-0002W4-Ky; Wed, 04 Oct 2023 04:05:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7FD0275AD;
 Wed,  4 Oct 2023 11:02:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F30EF2CBE7;
 Wed,  4 Oct 2023 11:02:28 +0300 (MSK)
Received: (nullmailer pid 2702850 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 33/45] migration: Move return path cleanup to main
 migration thread
Date: Wed,  4 Oct 2023 11:01:54 +0300
Message-Id: <20231004080221.2702636-33-mjt@tls.msk.ru>
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

Now that the return path thread is allowed to finish during a paused
migration, we can move the cleanup of the QEMUFiles to the main
migration thread.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230918172822.19052-9-farosas@suse.de>
(cherry picked from commit 36e9aab3c569d4c9ad780473596e18479838d1aa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index a0782c64a1..7a4c8beb5d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -98,6 +98,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
+static int await_return_path_close_on_source(MigrationState *s);
 
 static bool migration_needs_multiple_sockets(void)
 {
@@ -1178,6 +1179,12 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
+    /*
+     * We already cleaned up to_dst_file, so errors from the return
+     * path might be due to that, ignore them.
+     */
+    await_return_path_close_on_source(s);
+
     assert(!migration_is_active(s));
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
@@ -1986,7 +1993,6 @@ out:
     }
 
     trace_source_return_path_thread_end();
-    migration_release_dst_files(ms);
     rcu_unregister_thread();
     return NULL;
 }
@@ -2040,6 +2046,9 @@ static int await_return_path_close_on_source(MigrationState *ms)
 
     ret = ms->rp_state.error;
     ms->rp_state.error = false;
+
+    migration_release_dst_files(ms);
+
     trace_migration_return_path_end_after(ret);
     return ret;
 }
-- 
2.39.2


