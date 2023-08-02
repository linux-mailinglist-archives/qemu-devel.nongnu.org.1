Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79176C72F
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6TV-0005Wi-0R; Wed, 02 Aug 2023 03:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6TP-0005Vi-Te
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qR6TO-00023j-7g
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690962045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ufpZRCzKaHE4CSInvF8HRg3U30lPMJFxYDD3UpeHOw=;
 b=cm0c2l9P8EoPFruAvgj1prbHSqOkqUaqKef7eR9W1fZDX8ROVKHB2Up08MxDFsISySTQTq
 Kw2YGNkbcLc7/h88l8/1pGmR2WS+YfBBfGLp3DGuYxqKuDc0uQSqKrMD9RxiGTp2zoQ2hk
 /FvdHgQr4/ZzOArBLwWxCVzqMVMxtSk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-s29mGt-6MHelPWAJdIv5TQ-1; Wed, 02 Aug 2023 03:40:43 -0400
X-MC-Unique: s29mGt-6MHelPWAJdIv5TQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2B423C0C49C;
 Wed,  2 Aug 2023 07:40:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B25301121325;
 Wed,  2 Aug 2023 07:40:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9905021E692B; Wed,  2 Aug 2023 09:40:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PULL 1/3] qapi: Reformat the dirty-limit migration doc comments
Date: Wed,  2 Aug 2023 09:40:39 +0200
Message-ID: <20230802074041.418954-2-armbru@redhat.com>
In-Reply-To: <20230802074041.418954-1-armbru@redhat.com>
References: <20230802074041.418954-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hyman Huang(黄勇) <yong.huang@smartx.com>

Reformat the dirty-limit migration doc comments to conform
to current conventions as commit a937b6aa739 (qapi: Reformat
doc comments to conform to current conventions).

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Message-ID: <169073570563.19893.2928364761104733482-1@git.sr.ht>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Whitespace tidied up]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/migration.json | 67 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 6b49593d2f..dffa60fd91 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -258,17 +258,17 @@
 #     blocked.  Present and non-empty when migration is blocked.
 #     (since 6.0)
 #
-# @dirty-limit-throttle-time-per-round: Maximum throttle time (in microseconds) of virtual
-#                                       CPUs each dirty ring full round, which shows how
-#                                       MigrationCapability dirty-limit affects the guest
-#                                       during live migration. (since 8.1)
+# @dirty-limit-throttle-time-per-round: Maximum throttle time
+#     (in microseconds) of virtual CPUs each dirty ring full round,
+#     which shows how MigrationCapability dirty-limit affects the
+#     guest during live migration.  (Since 8.1)
 #
-# @dirty-limit-ring-full-time: Estimated average dirty ring full time (in microseconds)
-#                              each dirty ring full round, note that the value equals
-#                              dirty ring memory size divided by average dirty page rate
-#                              of virtual CPU, which can be used to observe the average
-#                              memory load of virtual CPU indirectly. Note that zero
-#                              means guest doesn't dirty memory (since 8.1)
+# @dirty-limit-ring-full-time: Estimated average dirty ring full time
+#     (in microseconds) for each dirty ring full round.  The value
+#     equals the dirty ring memory size divided by the average dirty
+#     page rate of the virtual CPU, which can be used to observe the
+#     average memory load of the virtual CPU indirectly.  Note that
+#     zero means guest doesn't dirty memory.  (Since 8.1)
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
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
-#                             live migration. Should be in the range 1 to 1000ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration.  Should be in the range 1 to 1000ms.
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
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
-#                             live migration. Should be in the range 1 to 1000ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration.  Should be in the range 1 to 1000ms.
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
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
-#                             live migration. Should be in the range 1 to 1000ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration.  Should be in the range 1 to 1000ms.
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
-- 
2.41.0


