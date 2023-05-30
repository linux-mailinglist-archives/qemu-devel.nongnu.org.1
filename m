Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216E715952
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 11:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3vG9-0002UL-8U; Tue, 30 May 2023 05:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3vG6-0002Rh-NP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:03:14 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3vG5-0006Hq-2N
 for qemu-devel@nongnu.org; Tue, 30 May 2023 05:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685437393; x=1716973393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Luiotjr8fGiSEYpJUsIrZ7CGuORIrNgVazrh83vAFw=;
 b=GP4vt1xG5VAePVKiynsA+sil43/mdrUupan6RL16fS1pwx+o9Thz1CQg
 FCLqRNmEMfgKyoHThGmJzv0bhqWzLA3JKjMWlo1D5KHD4+9xjD6Kf4Ill
 D+CTS0l+xPTF3jwtrErFNFm2fVFuJRcQ57g+GpuGdcQz48Gs+kG7E/9sH
 t4WJOyg3T1Vrnv5ShlMy2qiqHmWBKJvUsKGJHp8y7rsNhHpBp31dsXo9Z
 m4i5S/1PI1V+hTjGn4YSW6FAONMzrJj5FZYq7IlX4j1D+wxea10jGxViD
 j/3kthZhJxRcuQjHG5CBBI1RnH36Q3EaWsMm/wZbpMPXC73wONy9ZXjBH A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="358110394"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="358110394"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 02:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739435483"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; d="scan'208";a="739435483"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga001.jf.intel.com with ESMTP; 30 May 2023 02:03:10 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	lei4.wang@intel.com
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2 2/2] qtest/migration-tests.c: use "-incoming defer" for
 postcopy tests
Date: Tue, 30 May 2023 17:02:59 +0800
Message-Id: <20230530090259.189462-3-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230530090259.189462-1-wei.w.wang@intel.com>
References: <20230530090259.189462-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wei.w.wang@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The Postcopy preempt capability requires to be set before incoming
starts, so change the postcopy tests to start with deferred incoming and
call migrate-incoming after the cap has been set.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 tests/qtest/migration-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b99b49a314..31ce3d959c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1158,10 +1158,11 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
                                     QTestState **to_ptr,
                                     MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    g_autofree char *uri = NULL;
     QTestState *from, *to;
+    QDict *rsp;
 
-    if (test_migrate_start(&from, &to, uri, &args->start)) {
+    if (test_migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -1180,9 +1181,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
     migrate_ensure_non_converge(from);
 
+    rsp = wait_command(to, "{ 'execute': 'migrate-incoming',"
+                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    qobject_unref(rsp);
+
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
+    uri = migrate_get_socket_address(to, "socket-address");
     migrate_qmp(from, uri, "{}");
 
     wait_for_migration_pass(from);
-- 
2.27.0


