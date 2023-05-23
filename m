Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA070DA49
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P86-0005LG-Oz; Tue, 23 May 2023 06:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P7y-0004zZ-Km; Tue, 23 May 2023 06:20:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P7w-00031s-6A; Tue, 23 May 2023 06:20:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ED52D7D3B;
 Tue, 23 May 2023 13:20:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2CE3572A2;
 Tue, 23 May 2023 13:20:15 +0300 (MSK)
Received: (nullmailer pid 86076 invoked by uid 1000);
 Tue, 23 May 2023 10:20:14 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 36/45] migration: Handle block device inactivation
 failures better
Date: Tue, 23 May 2023 13:17:13 +0300
Message-Id: <20230523102014.85954-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
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

From: Eric Blake <eblake@redhat.com>

Consider what happens when performing a migration between two host
machines connected to an NFS server serving multiple block devices to
the guest, when the NFS server becomes unavailable.  The migration
attempts to inactivate all block devices on the source (a necessary
step before the destination can take over); but if the NFS server is
non-responsive, the attempt to inactivate can itself fail.  When that
happens, the destination fails to get the migrated guest (good,
because the source wasn't able to flush everything properly):

  (qemu) qemu-kvm: load of migration failed: Input/output error

at which point, our only hope for the guest is for the source to take
back control.  With the current code base, the host outputs a message, but then appears to resume:

  (qemu) qemu-kvm: qemu_savevm_state_complete_precopy_non_iterable: bdrv_inactivate_all() failed (-1)

  (src qemu)info status
   VM status: running

but a second migration attempt now asserts:

  (src qemu) qemu-kvm: ../block.c:6738: int bdrv_inactivate_recurse(BlockDriverState *): Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

Whether the guest is recoverable on the source after the first failure
is debatable, but what we do not want is to have qemu itself fail due
to an assertion.  It looks like the problem is as follows:

In migration.c:migration_completion(), the source sets 'inactivate' to
true (since COLO is not enabled), then tries
savevm.c:qemu_savevm_state_complete_precopy() with a request to
inactivate block devices.  In turn, this calls
block.c:bdrv_inactivate_all(), which fails when flushing runs up
against the non-responsive NFS server.  With savevm failing, we are
now left in a state where some, but not all, of the block devices have
been inactivated; but migration_completion() then jumps to 'fail'
rather than 'fail_invalidate' and skips an attempt to reclaim those
those disks by calling bdrv_activate_all().  Even if we do attempt to
reclaim disks, we aren't taking note of failure there, either.

Thus, we have reached a state where the migration engine has forgotten
all state about whether a block device is inactive, because we did not
set s->block_inactive in enough places; so migration allows the source
to reach vm_start() and resume execution, violating the block layer
invariant that the guest CPUs should not be restarted while a device
is inactive.  Note that the code in migration.c:migrate_fd_cancel()
will also try to reactivate all block devices if s->block_inactive was
set, but because we failed to set that flag after the first failure,
the source assumes it has reclaimed all devices, even though it still
has remaining inactivated devices and does not try again.  Normally,
qmp_cont() will also try to reactivate all disks (or correctly fail if
the disks are not reclaimable because NFS is not yet back up), but the
auto-resumption of the source after a migration failure does not go
through qmp_cont().  And because we have left the block layer in an
inconsistent state with devices still inactivated, the later migration
attempt is hitting the assertion failure.

Since it is important to not resume the source with inactive disks,
this patch marks s->block_inactive before attempting inactivation,
rather than after succeeding, in order to prevent any vm_start() until
it has successfully reactivated all devices.

See also https://bugzilla.redhat.com/show_bug.cgi?id=2058982

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Acked-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
(cherry picked from commit 403d18ae384239876764bbfa111d6cc5dcb673d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index f485eea5fb..043d22e049 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3328,13 +3328,11 @@ static void migration_completion(MigrationState *s)
                                             MIGRATION_STATUS_DEVICE);
             }
             if (ret >= 0) {
+                s->block_inactive = inactivate;
                 qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
                 ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
                                                          inactivate);
             }
-            if (inactivate && ret >= 0) {
-                s->block_inactive = true;
-            }
         }
         qemu_mutex_unlock_iothread();
 
@@ -3402,6 +3400,7 @@ fail_invalidate:
         bdrv_activate_all(&local_err);
         if (local_err) {
             error_report_err(local_err);
+            s->block_inactive = true;
         } else {
             s->block_inactive = false;
         }
-- 
2.39.2


