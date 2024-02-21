Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1274D85EB3F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 22:48:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuR9-0000hx-Cz; Wed, 21 Feb 2024 16:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuR6-0000f3-Kj; Wed, 21 Feb 2024 16:47:28 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuR4-0007K2-H0; Wed, 21 Feb 2024 16:47:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 03AC84F85D;
 Thu, 22 Feb 2024 00:47:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A2820869DE;
 Thu, 22 Feb 2024 00:47:23 +0300 (MSK)
Received: (nullmailer pid 2339826 invoked by uid 1000);
 Wed, 21 Feb 2024 21:47:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 01/33] migration: Fix use-after-free of migration
 state object
Date: Thu, 22 Feb 2024 00:46:44 +0300
Message-Id: <20240221214723.2339742-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fabiano Rosas <farosas@suse.de>

We're currently allowing the process_incoming_migration_bh bottom-half
to run without holding a reference to the 'current_migration' object,
which leads to a segmentation fault if the BH is still live after
migration_shutdown() has dropped the last reference to
current_migration.

In my system the bug manifests as migrate_multifd() returning true
when it shouldn't and multifd_load_shutdown() calling
multifd_recv_terminate_threads() which crashes due to an uninitialized
multifd_recv_state.

Fix the issue by holding a reference to the object when scheduling the
BH and dropping it before returning from the BH. The same is already
done for the cleanup_bh at migrate_fd_cleanup_schedule().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1969
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240119233922.32588-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 27eb8499edb2bc952c29ddae0bdac9fc959bf7b1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index c8ca7927b4..9b496cce1d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -572,6 +572,7 @@ static void process_incoming_migration_bh(void *opaque)
                       MIGRATION_STATUS_COMPLETED);
     qemu_bh_delete(mis->bh);
     migration_incoming_state_destroy();
+    object_unref(OBJECT(migrate_get_current()));
 }
 
 static void coroutine_fn
@@ -638,6 +639,7 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
+    object_ref(OBJECT(migrate_get_current()));
     qemu_bh_schedule(mis->bh);
     mis->migration_incoming_co = NULL;
     return;
-- 
2.39.2


