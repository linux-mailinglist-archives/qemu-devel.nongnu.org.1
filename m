Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E57763FF7
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOkSN-0006eD-0E; Wed, 26 Jul 2023 15:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qOkSK-0006YM-EM
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 15:45:56 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qOkSI-0007nS-Cm
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 15:45:56 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id D971911EF55;
 Wed, 26 Jul 2023 19:45:52 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Thu, 27 Jul 2023 01:27:50 +0800
Subject: [PATCH QEMU 1/2] qapi: Reformat and craft the migration doc comments
MIME-Version: 1.0
Message-ID: <169040075240.21656.5651891935411754498-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <169040075240.21656.5651891935411754498-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

Reformat migration doc comments to conform to current conventions
as commit a937b6aa739 (qapi: Reformat doc comments to conform to
current conventions).

Also, craft the dirty-limit capability comment.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
---
 qapi/migration.json | 66 +++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 6b49593d2f..5d5649c885 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -258,17 +258,17 @@
 #     blocked.  Present and non-empty when migration is blocked.
 #     (since 6.0)
 #
-# @dirty-limit-throttle-time-per-round: Maximum throttle time (in microsecon=
ds) of virtual
-#                                       CPUs each dirty ring full round, whi=
ch shows how
-#                                       MigrationCapability dirty-limit affe=
cts the guest
-#                                       during live migration. (since 8.1)
-#
-# @dirty-limit-ring-full-time: Estimated average dirty ring full time (in mi=
croseconds)
-#                              each dirty ring full round, note that the val=
ue equals
-#                              dirty ring memory size divided by average dir=
ty page rate
-#                              of virtual CPU, which can be used to observe =
the average
-#                              memory load of virtual CPU indirectly. Note t=
hat zero
-#                              means guest doesn't dirty memory (since 8.1)
+# @dirty-limit-throttle-time-per-round: Maximum throttle time
+#     (in microseconds) of virtual CPUs each dirty ring full round,
+#     which shows how MigrationCapability dirty-limit affects the
+#     guest during live migration.  (Since 8.1)
+#
+# @dirty-limit-ring-full-time: Estimated average dirty ring full
+#     time (in microseconds) each dirty ring full round. The value
+#     equals dirty ring memory size divided by average dirty page
+#     rate of the virtual CPU, which can be used to observe the
+#     average memory load of the virtual CPU indirectly. Note that
+#     zero means guest doesn't dirty memory.  (Since 8.1)
 #
 # Since: 0.14
 ##
@@ -519,15 +519,11 @@
 #     are present.  'return-path' capability must be enabled to use
 #     it.  (since 8.1)
 #
-# @dirty-limit: If enabled, migration will use the dirty-limit algo to
-#               throttle down guest instead of auto-converge algo.
-#               Throttle algo only works when vCPU's dirtyrate greater
-#               than 'vcpu-dirty-limit', read processes in guest os
-#               aren't penalized any more, so this algo can improve
-#               performance of vCPU during live migration. This is an
-#               optional performance feature and should not affect the
-#               correctness of the existing auto-converge algo.
-#               (since 8.1)
+# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
+#     keep their dirty page rate within @vcpu-dirty-limit.  This can
+#     improve responsiveness of large guests during live migration,
+#     and can result in more stable read performance.  Requires KVM
+#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
 #
 # Features:
 #
@@ -822,17 +818,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
-#                             live migration. Should be in the range 1 to 10=
00ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during  live migration. Should be in the range 1 to 1000ms,
+#     defaults to 1000ms.  (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#                    Defaults to 1. (Since 8.1)
+#     Defaults to 1.  (Since 8.1)
 #
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#            are experimental.
+#     are experimental.
 #
 # Since: 2.4
 ##
@@ -988,17 +984,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
-#                             live migration. Should be in the range 1 to 10=
00ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration. Should be in the range 1 to 1000ms,
+#     defaults to 1000ms.  (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#                    Defaults to 1. (Since 8.1)
+#     Defaults to 1.  (Since 8.1)
 #
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#            are experimental.
+#     are experimental.
 #
 # TODO: either fuse back into MigrationParameters, or make
 #     MigrationParameters members mandatory
@@ -1191,17 +1187,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
-#                             live migration. Should be in the range 1 to 10=
00ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration. Should be in the range 1 to 1000ms,
+#     defaults to 1000ms.  (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#                    Defaults to 1. (Since 8.1)
+#     Defaults to 1.  (Since 8.1)
 #
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#            are experimental.
+#     are experimental.
 #
 # Since: 2.4
 ##
--=20
2.38.5


