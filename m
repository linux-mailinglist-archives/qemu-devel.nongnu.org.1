Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D4793D75
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 15:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdsIm-0002Jv-HY; Wed, 06 Sep 2023 09:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qdsI5-00022b-D6; Wed, 06 Sep 2023 09:09:54 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qdsI1-0004M8-PG; Wed, 06 Sep 2023 09:09:53 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C529442B26;
 Wed,  6 Sep 2023 15:09:38 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, srowe@mose.org.uk, mike.maslenkin@gmail.com,
 qemu-block@nongnu.org, t.lamprecht@proxmox.com, a.lauterer@proxmox.com,
 philmd@linaro.org, kwolf@redhat.com
Subject: [PATCH v2 2/2] tests/qtest: ahci-test: add test exposing reset issue
 with pending callback
Date: Wed,  6 Sep 2023 15:09:22 +0200
Message-Id: <20230906130922.142845-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906130922.142845-1-f.ebner@proxmox.com>
References: <20230906130922.142845-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Before commit "hw/ide: reset: cancel async DMA operation before
resetting state", this test would fail, because a reset with a
pending write operation would lead to an unsolicited write to the
first sector of the disk.

The test writes a pattern to the beginning of the disk and verifies
that it is still intact after a reset with a pending operation. It
also checks that the pending operation actually completes correctly.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
    * Move variable declarations to the beginning of the function.
    * Use g_autofree for malloced buffers.
    * Group toghether with other reset test (hope I did it correctly).
    * Use ahci_boot_and_enable() and enable throttling to make test
      work independently of environment.

 tests/qtest/ahci-test.c | 86 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index abab761c26..2615c9f65c 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1424,6 +1424,89 @@ static void test_reset(void)
     ahci_shutdown(ahci);
 }
 
+static void test_reset_pending_callback(void)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    uint8_t port;
+    uint64_t ptr1;
+    uint64_t ptr2;
+
+    int bufsize = 4 * 1024;
+    int speed = bufsize + (bufsize / 2);
+    int offset1 = 0;
+    int offset2 = bufsize / AHCI_SECTOR_SIZE;
+
+    g_autofree unsigned char *tx1 = g_malloc(bufsize);
+    g_autofree unsigned char *tx2 = g_malloc(bufsize);
+    g_autofree unsigned char *rx1 = g_malloc0(bufsize);
+    g_autofree unsigned char *rx2 = g_malloc0(bufsize);
+
+    /* Uses throttling to make test independent of specific environment. */
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,file=%s,"
+                                "cache=writeback,format=%s,"
+                                "throttling.bps-write=%d "
+                                "-M q35 "
+                                "-device ide-hd,drive=drive0 ",
+                                tmp_path, imgfmt, speed);
+
+    port = ahci_port_select(ahci);
+    ahci_port_clear(ahci, port);
+
+    ptr1 = ahci_alloc(ahci, bufsize);
+    ptr2 = ahci_alloc(ahci, bufsize);
+
+    g_assert(ptr1 && ptr2);
+
+    /* Need two different patterns. */
+    do {
+        generate_pattern(tx1, bufsize, AHCI_SECTOR_SIZE);
+        generate_pattern(tx2, bufsize, AHCI_SECTOR_SIZE);
+    } while (memcmp(tx1, tx2, bufsize) == 0);
+
+    qtest_bufwrite(ahci->parent->qts, ptr1, tx1, bufsize);
+    qtest_bufwrite(ahci->parent->qts, ptr2, tx2, bufsize);
+
+    /* Write to beginning of disk to check it wasn't overwritten later. */
+    ahci_guest_io(ahci, port, CMD_WRITE_DMA_EXT, ptr1, bufsize, offset1);
+
+    /* Issue asynchronously to get a pending callback during reset. */
+    cmd = ahci_command_create(CMD_WRITE_DMA_EXT);
+    ahci_command_adjust(cmd, offset2, ptr2, bufsize, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
+
+    ahci_command_free(cmd);
+
+    /* Wait for throttled write to finish. */
+    sleep(1);
+
+    /* Start again. */
+    ahci_clean_mem(ahci);
+    ahci_pci_enable(ahci);
+    ahci_hba_enable(ahci);
+    port = ahci_port_select(ahci);
+    ahci_port_clear(ahci, port);
+
+    /* Read and verify. */
+    ahci_guest_io(ahci, port, CMD_READ_DMA_EXT, ptr1, bufsize, offset1);
+    qtest_bufread(ahci->parent->qts, ptr1, rx1, bufsize);
+    g_assert_cmphex(memcmp(tx1, rx1, bufsize), ==, 0);
+
+    ahci_guest_io(ahci, port, CMD_READ_DMA_EXT, ptr2, bufsize, offset2);
+    qtest_bufread(ahci->parent->qts, ptr2, rx2, bufsize);
+    g_assert_cmphex(memcmp(tx2, rx2, bufsize), ==, 0);
+
+    ahci_free(ahci, ptr1);
+    ahci_free(ahci, ptr2);
+
+    ahci_clean_mem(ahci);
+
+    ahci_shutdown(ahci);
+}
+
 static void test_ncq_simple(void)
 {
     AHCIQState *ahci;
@@ -1945,7 +2028,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ahci/migrate/dma/halted", test_migrate_halted_dma);
 
     qtest_add_func("/ahci/max", test_max);
-    qtest_add_func("/ahci/reset", test_reset);
+    qtest_add_func("/ahci/reset/simple", test_reset);
+    qtest_add_func("/ahci/reset/pending_callback", test_reset_pending_callback);
 
     qtest_add_func("/ahci/io/ncq/simple", test_ncq_simple);
     qtest_add_func("/ahci/migrate/ncq/simple", test_migrate_ncq);
-- 
2.39.2



