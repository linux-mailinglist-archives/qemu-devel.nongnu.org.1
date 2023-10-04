Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CB67B79CA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsy-0004uX-7u; Wed, 04 Oct 2023 04:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwsd-000325-2d; Wed, 04 Oct 2023 04:05:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwsZ-0002Ef-T1; Wed, 04 Oct 2023 04:05:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3104D275AB;
 Wed,  4 Oct 2023 11:02:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7861F2CBE5;
 Wed,  4 Oct 2023 11:02:28 +0300 (MSK)
Received: (nullmailer pid 2702844 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 31/45] migration: Consolidate return path closing code
Date: Wed,  4 Oct 2023 11:01:52 +0300
Message-Id: <20231004080221.2702636-31-mjt@tls.msk.ru>
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

We'll start calling the await_return_path_close_on_source() function
from other parts of the code, so move all of the related checks and
tracepoints into it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230918172822.19052-7-farosas@suse.de>
(cherry picked from commit d50f5dc075cbb891bfe4a9378600a4871264468a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index e2e4a7d8ae..ac4541b971 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2050,6 +2050,14 @@ static int open_return_path_on_source(MigrationState *ms,
 /* Returns 0 if the RP was ok, otherwise there was an error on the RP */
 static int await_return_path_close_on_source(MigrationState *ms)
 {
+    int ret;
+
+    if (!ms->rp_state.rp_thread_created) {
+        return 0;
+    }
+
+    trace_migration_return_path_end_before();
+
     /*
      * If this is a normal exit then the destination will send a SHUT
      * and the rp_thread will exit, however if there's an error we
@@ -2067,7 +2075,10 @@ static int await_return_path_close_on_source(MigrationState *ms)
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created = false;
     trace_await_return_path_close_on_source_close();
-    return ms->rp_state.error;
+
+    ret = ms->rp_state.error;
+    trace_migration_return_path_end_after(ret);
+    return ret;
 }
 
 static inline void
@@ -2363,20 +2374,8 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
 
-    /*
-     * If rp was opened we must clean up the thread before
-     * cleaning everything else up (since if there are no failures
-     * it will wait for the destination to send it's status in
-     * a SHUT command).
-     */
-    if (s->rp_state.rp_thread_created) {
-        int rp_error;
-        trace_migration_return_path_end_before();
-        rp_error = await_return_path_close_on_source(s);
-        trace_migration_return_path_end_after(rp_error);
-        if (rp_error) {
-            goto fail;
-        }
+    if (await_return_path_close_on_source(s)) {
+        goto fail;
     }
 
     if (qemu_file_get_error(s->to_dst_file)) {
-- 
2.39.2


