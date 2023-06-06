Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23797723F33
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:19:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tme-0000BA-BM; Tue, 06 Jun 2023 06:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q6Tmb-00005y-VC
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:19:21 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q6TmZ-0007O2-8K
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686046759; x=1717582759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dC+lgwxg/JJaD9IXWM498G29WG/e8Pk7dHwJAztMx18=;
 b=neS6vFKa5xYOAJzxKSC1K0x/6K4NQhJ57x9eXrudIDXTMvblmKdDN+fQ
 AYDAjDMG/wc+qkiQEMLS0kv+xEYgYmC2pM0B0WnL1jMMv5DyFQ8G7w/Pn
 kYtBBoEaa4gaGrgxyb0hAA9RWm0fXffWaN0BK2wA2djrSschuNf749Nyz
 cN6hrSop9Mu29Wb5cSfLA9i/qI7vgv8IFFSj+tDYzSsdybq4J7U3I8V01
 hjD55lYBmmGmam0ycBYyb99jvf8RHFy5YkkurJPkcjY/bldBqPqDZ4C1z
 aOV4ZXI1nx7x8ingzNcz4FRzQq6SATYRX938HthdXU26rDErfFMUhdH+b Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="443004181"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; d="scan'208";a="443004181"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 03:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="709032931"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; d="scan'208";a="709032931"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga002.jf.intel.com with ESMTP; 06 Jun 2023 03:19:16 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	lei4.wang@intel.com
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2 2/2] qtest/migration-tests.c: use "-incoming defer" for
 postcopy tests
Date: Tue,  6 Jun 2023 18:19:10 +0800
Message-Id: <20230606101910.20456-3-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230606101910.20456-1-wei.w.wang@intel.com>
References: <20230606101910.20456-1-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=wei.w.wang@intel.com;
 helo=mga05.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The Postcopy preempt capability is expected to be set before incoming
starts, so change the postcopy tests to start with deferred incoming and
call migrate-incoming after the cap has been set.

Why the existing tests (without this patch) didn't fail?
There could be two reasons:
1) "backlog" specifies the number of pending connections. As long as the
   server accepts the connections faster than the clients side connecting,
   connection will succeed. For the preempt test, it uses only 2 channels,
   so very likely to not have pending connections.
2) per my tests (on kernel 6.2), the number of pending connections allowed
   is actually "backlog + 1", which is 2 in this case.
That said, the implementation of socket_start_incoming_migration_internal
expects "migrate defer" to be used, and for safety, change the test to
work with the expected usage.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0c355bbd9..cbdbc932de 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1143,10 +1143,11 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
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
 
@@ -1165,9 +1166,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 
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


