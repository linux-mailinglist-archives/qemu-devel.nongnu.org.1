Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B773A922
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQKF-00045e-Lz; Thu, 22 Jun 2023 15:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKD-00043z-6y
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKB-0002o7-Ig
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687463435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6trTkE+Vcw/Da/asnTunTLTjljpC9Zt9lEdrJchDXtA=;
 b=HmpUrztGJ7gRXPRvsP5yWJ9Pt3cpUQV5Yu3z75gk1xCU2Qsajy3A1VBdWp7xH+NsaOb2ju
 PS3S8y1xVxrAqf1nvYfBthp8U4dF/s022El9vwPnQf5Ax/myKUJa9G4RtkQyOl3VlzhDEB
 tIvBq37w3mfEI+45niAtEpxxbKGdrDw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-y8E-3RayPWq2xTjZs1FDaw-1; Thu, 22 Jun 2023 15:50:28 -0400
X-MC-Unique: y8E-3RayPWq2xTjZs1FDaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE92C104458D;
 Thu, 22 Jun 2023 19:50:26 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32E43C00049;
 Thu, 22 Jun 2023 19:50:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 1/5] migration: Use proper indentation for migration.json
Date: Thu, 22 Jun 2023 21:50:15 +0200
Message-Id: <20230622195019.4396-2-quintela@redhat.com>
In-Reply-To: <20230622195019.4396-1-quintela@redhat.com>
References: <20230622195019.4396-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We broke it with dirtyrate limit patches.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json | 67 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 6ff39157ba..ad8cc57071 100644
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
+# @dirty-limit-throttle-time-per-round: Maximum throttle time (in
+#     microseconds) of virtual CPUs each dirty ring full round, which
+#     shows how MigrationCapability dirty-limit affects the guest
+#     during live migration. (since 8.1)
 #
-# @dirty-limit-ring-full-time: Estimated average dirty ring full time (in microseconds)
-#                              each dirty ring full round, note that the value equals
-#                              dirty ring memory size divided by average dirty page rate
-#                              of virtual CPU, which can be used to observe the average
-#                              memory load of virtual CPU indirectly. Note that zero
-#                              means guest doesn't dirty memory (since 8.1)
+# @dirty-limit-ring-full-time: Estimated average dirty ring full time
+#     (in microseconds) each dirty ring full round, note that the
+#     value equals dirty ring memory size divided by average dirty
+#     page rate of virtual CPU, which can be used to observe the
+#     average memory load of virtual CPU indirectly. Note that zero
+#     means guest doesn't dirty memory (since 8.1)
 #
 # Since: 0.14
 ##
@@ -510,14 +510,13 @@
 #     (since 7.1)
 #
 # @dirty-limit: If enabled, migration will use the dirty-limit algo to
-#               throttle down guest instead of auto-converge algo.
-#               Throttle algo only works when vCPU's dirtyrate greater
-#               than 'vcpu-dirty-limit', read processes in guest os
-#               aren't penalized any more, so this algo can improve
-#               performance of vCPU during live migration. This is an
-#               optional performance feature and should not affect the
-#               correctness of the existing auto-converge algo.
-#               (since 8.1)
+#     throttle down guest instead of auto-converge algo.  Throttle
+#     algo only works when vCPU's dirtyrate greater than
+#     'vcpu-dirty-limit', read processes in guest os aren't penalized
+#     any more, so this algo can improve performance of vCPU during
+#     live migration. This is an optional performance feature and
+#     should not affect the correctness of the existing auto-converge
+#     algo.  (since 8.1)
 #
 # Features:
 #
@@ -811,17 +810,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
-#                             live migration. Should be in the range 1 to 1000ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration. Should be in the range 1 to 1000ms,
+#     defaults to 1000ms. (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#                    Defaults to 1. (Since 8.1)
+#     Defaults to 1. (Since 8.1)
 #
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#            are experimental.
+#     are experimental.
 #
 # Since: 2.4
 ##
@@ -977,17 +976,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
-#                             live migration. Should be in the range 1 to 1000ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration. Should be in the range 1 to 1000ms,
+#     defaults to 1000ms. (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#                    Defaults to 1. (Since 8.1)
+#     Defaults to 1. (Since 8.1)
 #
 # Features:
 #
 # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#            are experimental.
+#     are experimental.
 #
 # TODO: either fuse back into MigrationParameters, or make
 #     MigrationParameters members mandatory
@@ -1180,17 +1179,17 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
-# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty limit during
-#                             live migration. Should be in the range 1 to 1000ms,
-#                             defaults to 1000ms. (Since 8.1)
+# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
+#     limit during live migration. Should be in the range 1 to 1000ms,
+#     defaults to 1000ms. (Since 8.1)
 #
 # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
-#                    Defaults to 1. (Since 8.1)
+#     Defaults to 1. (Since 8.1)
 #
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
-#            are experimental.
+# @unstable: Members @x-checkpoint-delay and
+#     @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
 ##
-- 
2.40.1


