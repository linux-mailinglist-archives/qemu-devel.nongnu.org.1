Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50098A451E0
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 02:03:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn5oB-0004Ex-Nl; Tue, 25 Feb 2025 20:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tn5nd-0003rH-OP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 20:01:22 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tn5nX-0004yT-Gg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 20:01:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740531675; x=1772067675;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jd+DdY5eY77B7kVpkL1NpFZ69YDj7OrP1FP6uOvMgB8=;
 b=o/x70lEpq2sD/P4usaVmso8pOb60TDaiiyQFp3FKJGYNhYCBPZJGgdyc
 oKCTr0x6yeC1ScznAabDBYgXYx0/IQlhtLVoO93e9o9gVVNDqjGSd3s79
 FFQPtE95xMV7WUTQPm39h2int9JL2Y40SSY/l3F3DKXOxhPf6YKerRTK/
 FkdDZcQdhGvS+V8tccAZ5aL39ibAmw3+r18Kd+swcLBwWHvIMioofuLIm
 6r2qBYrd9PRgFrwrny/f3bMO02QNpgOjVfHetpAsM40pLY2SA8a+ou5PD
 H7ZM7f37IhDMjOXfsLR50i4ljlSoEiLGigEdJJX45qYaHEL8foSN5vdRi g==;
X-CSE-ConnectionGUID: f0N1Df3uRtKUIMq79vN59g==
X-CSE-MsgGUID: HLYAI4VxRXWjS5ZQv8fxAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="179156084"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; d="scan'208";a="179156084"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 10:01:10 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F8F8E6881
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:01:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 452BFBDC94
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:01:08 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id A85861A006C;
 Wed, 26 Feb 2025 09:01:07 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 6/6] migration: Add qtest for migration over RDMA
Date: Wed, 26 Feb 2025 09:02:38 +0800
Message-ID: <20250226010238.727348-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250226010238.727348-1-lizhijian@fujitsu.com>
References: <20250226010238.727348-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=lizhijian@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This qtest requires there is a RDMA(RoCE) link in the host.
In order to make the test work smoothly, introduce a
scripts/rdma-migration-helper.sh to
- setup a new Soft-RoCE(aka RXE) if it's root
- detect existing RoCE link

Test will be skipped if there is no available RoCE link.
 # Start of rdma tests
 # Running /x86_64/migration/precopy/rdma/plain
 ok 1 /x86_64/migration/precopy/rdma/plain # SKIP
 There is no available rdma link to run RDMA migration test.
 To enable the test:
 (1) Run 'scripts/rdma-migration-helper.sh setup' with root and rerun the test
 or
 (2) Run the test with root privilege

 # End of rdma tests

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 MAINTAINERS                           |  1 +
 scripts/rdma-migration-helper.sh      | 41 +++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 64 +++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100755 scripts/rdma-migration-helper.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 3848d37a38d..15360fcdc4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3480,6 +3480,7 @@ R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
+F: scripts/rdma-migration-helper.sh
 
 Migration dirty limit and dirty page rate
 M: Hyman Huang <yong.huang@smartx.com>
diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
new file mode 100755
index 00000000000..66557d9e267
--- /dev/null
+++ b/scripts/rdma-migration-helper.sh
@@ -0,0 +1,41 @@
+#!/bin/bash
+
+# Copied from blktests
+get_ipv4_addr()
+{
+    ip -4 -o addr show dev "$1" |
+        sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
+        tr -d '\n'
+}
+
+has_soft_rdma()
+{
+    rdma link | grep -q " netdev $1[[:blank:]]*\$"
+}
+
+rdma_rxe_setup_detect()
+{
+    (
+        cd /sys/class/net &&
+            for i in *; do
+                [ -e "$i" ] || continue
+                [ "$i" = "lo" ] && continue
+                [ "$(<"$i/addr_len")" = 6 ] || continue
+                [ "$(<"$i/carrier")" = 1 ] || continue
+
+                has_soft_rdma "$i" && break
+                [ "$operation" = "setup" ] &&
+                    rdma link add "${i}_rxe" type rxe netdev "$i" && break
+            done
+        has_soft_rdma "$i" || return
+        get_ipv4_addr "$i"
+    )
+}
+
+operation=${1:-setup}
+
+if [ "$operation" == "setup" ] || [ "$operation" == "detect" ]; then
+    rdma_rxe_setup_detect
+else
+    echo "Usage: $0 [setup | detect]"
+fi
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index ba273d10b9a..bf97f4e9325 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -99,6 +99,66 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
+#ifdef CONFIG_RDMA
+
+#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
+static int new_rdma_link(char *buffer)
+{
+    const char *argument = (geteuid() == 0) ? "setup" : "detect";
+    char cmd[1024];
+
+    snprintf(cmd, sizeof(cmd), "%s %s", RDMA_MIGRATION_HELPER, argument);
+
+    FILE *pipe = popen(cmd, "r");
+    if (pipe == NULL) {
+        perror("Failed to run script");
+        return -1;
+    }
+
+    int idx = 0;
+    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
+        idx += strlen(buffer);
+    }
+
+    int status = pclose(pipe);
+    if (status == -1) {
+        perror("Error reported by pclose()");
+        return -1;
+    } else if (WIFEXITED(status)) {
+        return WEXITSTATUS(status);
+    }
+
+    return -1;
+}
+
+static void test_precopy_rdma_plain(void)
+{
+    char buffer[128] = {};
+
+    if (new_rdma_link(buffer)) {
+        g_test_skip("\nThere is no available rdma link to run RDMA migration test.\n"
+                    "To enable the test:\n"
+                    "(1) Run \'" RDMA_MIGRATION_HELPER " setup\' with root and rerun the test\n"
+                    "or\n"
+                    "(2) Run the test with root privilege\n");
+        return;
+    }
+
+    /*
+     * TODO: query a free port instead of hard code.
+     * 29200=('R'+'D'+'M'+'A')*100
+     **/
+    g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
+
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    test_precopy_common(&args);
+}
+#endif
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -1124,6 +1184,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
                        test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
+#ifdef CONFIG_RDMA
+    migration_test_add("/migration/precopy/rdma/plain",
+                       test_precopy_rdma_plain);
+#endif
 }
 
 void migration_test_add_precopy(MigrationTestEnv *env)
-- 
2.44.0


