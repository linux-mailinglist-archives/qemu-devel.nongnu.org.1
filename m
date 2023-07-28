Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E12A976869B
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 19:10:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9ap-00061F-Bi; Sun, 30 Jul 2023 12:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qQ9an-00060Y-BR
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:48:29 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qQ9al-0005zP-EJ
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:48:29 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 0B85D11EF26;
 Sun, 30 Jul 2023 16:48:26 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Fri, 28 Jul 2023 17:38:07 +0800
Subject: [PATCH QEMU v3 1/3] qapi: Reformat the dirty-limit migration doc
 comments
MIME-Version: 1.0
Message-ID: <169073570563.19893.2928364761104733482-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <169073570563.19893.2928364761104733482-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
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

Reformat the dirty-limit migration doc comments to conform
to current conventions as commit a937b6aa739 (qapi: Reformat
doc comments to conform to current conventions).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
---
 qapi/migration.json | 69 ++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 6b49593d2f..a74ade4d72 100644
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
+#     time (in microseconds) for each dirty ring full round. The
+#     value equals the dirty ring memory size divided by the average
+#     dirty page rate of the virtual CPU, which can be used to
+#     observe the average memory load of the virtual CPU indirectly.
+#     Note that zero means guest doesn't dirty memory.  (Since 8.1)
 #
 # Since: 0.14
 ##
@@ -519,15 +519,14 @@
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
+# @dirty-limit: If enabled, migration will use the dirty-limit
+#     algorithim to throttle down guest instead of auto-converge
+#     algorithim. Throttle algorithim only works when vCPU's dirtyrate
+#     greater than 'vcpu-dirty-limit', read processes in guest os
+#     aren't penalized any more, so this algorithim can improve
+#     performance of vCPU during live migration. This is an optional
+#     performance feature and should not affect the correctness of the
+#     existing auto-converge algorithim.  (Since 8.1)
 #
 # Features:
 #
@@ -822,17 +821,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
-#                             live migration. Should be in the range 1 to 10=
00ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration. Should be in the range 1 to 1000ms.
+#     Defaults to 1000ms.  (Since 8.1)
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
@@ -988,17 +987,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
-#                             live migration. Should be in the range 1 to 10=
00ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration. Should be in the range 1 to 1000ms.
+#     Defaults to 1000ms.  (Since 8.1)
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
@@ -1191,17 +1190,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit=
 during
-#                             live migration. Should be in the range 1 to 10=
00ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration. Should be in the range 1 to 1000ms.
+#     Defaults to 1000ms.  (Since 8.1)
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


