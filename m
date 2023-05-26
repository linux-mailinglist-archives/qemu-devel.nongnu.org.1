Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6989D71261C
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2W6O-0001eE-Gf; Fri, 26 May 2023 07:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q2W6M-0001e5-1B
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:59:22 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q2W6K-0001lE-7i
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:59:21 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CC41A4737D;
 Fri, 26 May 2023 13:59:14 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: andrey.gruzdev@virtuozzo.com, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com
Subject: [PATCH] migration: stop tracking ram writes when cancelling
 background migration
Date: Fri, 26 May 2023 13:59:08 +0200
Message-Id: <20230526115908.196171-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, it is only done when the iteration finishes successfully.
Not cleaning up the userfaultfd write protection can lead to
symptoms/issues such as the process hanging in memmove or GDB not
being able to attach.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

For the success case, the stuff in between the old call and new call
site should not depend on tracking to already be stopped, right?
AFAICS, it's just some QEMU file operations and manipulation of
migration state and counters, but I have only limited knowledge, so I
thought I'd better ask :)

 migration/migration.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5de7f734b9..60583699f7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2400,13 +2400,6 @@ static void bg_migration_completion(MigrationState *s)
 {
     int current_active_state = s->state;
 
-    /*
-     * Stop tracking RAM writes - un-protect memory, un-register UFFD
-     * memory ranges, flush kernel wait queues and wake up threads
-     * waiting for write fault to be resolved.
-     */
-    ram_write_tracking_stop();
-
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         /*
          * By this moment we have RAM content saved into the migration stream.
@@ -2788,6 +2781,13 @@ static void migration_iteration_finish(MigrationState *s)
 
 static void bg_migration_iteration_finish(MigrationState *s)
 {
+    /*
+     * Stop tracking RAM writes - un-protect memory, un-register UFFD
+     * memory ranges, flush kernel wait queues and wake up threads
+     * waiting for write fault to be resolved.
+     */
+    ram_write_tracking_stop();
+
     qemu_mutex_lock_iothread();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
-- 
2.39.2



