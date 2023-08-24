Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8448B787075
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:40:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZAYF-00064E-Ku; Thu, 24 Aug 2023 09:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qZAY4-00062J-5S; Thu, 24 Aug 2023 09:38:57 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qZAY1-0006Od-MQ; Thu, 24 Aug 2023 09:38:55 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 17F8543C40;
 Thu, 24 Aug 2023 15:38:41 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 srowe@mose.org.uk, mike.maslenkin@gmail.com, qemu-block@nongnu.org,
 t.lamprecht@proxmox.com, a.lauterer@proxmox.com
Subject: [POC 2/2] add test exposing AHCI reset issue
Date: Thu, 24 Aug 2023 15:38:31 +0200
Message-Id: <20230824133831.617833-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824133831.617833-1-f.ebner@proxmox.com>
References: <20230824133831.617833-1-f.ebner@proxmox.com>
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

Fails without the previous commit "hw/ide: reset: cancel async DMA
operation before reseting state".

I haven't ever written such a test before, but I wanted something to
expose the problem more easily. It hardcodes the behavior that the
pending write actually is done during reset, which might not be ideal.
It could just check that the first sector is still intact instead.

If I should make this a proper test, I'd be happy about some guidance,
but not sure if required for such a specific one-off issue. After all,
a different variation of the bug might have written to some other
sector not covered by this test.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qtest/ahci-test.c | 81 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index abab761c26..3ebeb4e255 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1401,6 +1401,84 @@ static void test_max(void)
     ahci_shutdown(ahci);
 }
 
+static void test_reset_with_pending_callback(void)
+{
+    AHCIQState *ahci;
+
+    ahci = ahci_boot(NULL);
+    ahci_test_pci_spec(ahci);
+    ahci_pci_enable(ahci);
+
+    int bufsize = 512 * 1024;
+    int offset1 = 0;
+    int offset2 = bufsize / AHCI_SECTOR_SIZE;
+
+    ahci_test_hba_spec(ahci);
+    ahci_hba_enable(ahci);
+    ahci_test_identify(ahci);
+
+    uint8_t port = ahci_port_select(ahci);
+    ahci_port_clear(ahci, port);
+
+    unsigned char *tx1 = g_malloc(bufsize);
+    unsigned char *tx2 = g_malloc(bufsize);
+    unsigned char *rx1 = g_malloc0(bufsize);
+    unsigned char *rx2 = g_malloc0(bufsize);
+    uint64_t ptr1 = ahci_alloc(ahci, bufsize);
+    uint64_t ptr2 = ahci_alloc(ahci, bufsize);
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
+    AHCICommand *cmd = ahci_command_create(CMD_WRITE_DMA_EXT);
+    ahci_command_adjust(cmd, offset2, ptr2, bufsize, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
+
+    ahci_command_free(cmd);
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
+    g_free(tx1);
+    g_free(tx2);
+    g_free(rx1);
+    g_free(rx2);
+
+    ahci_clean_mem(ahci);
+
+    ahci_shutdown(ahci);
+}
+
 static void test_reset(void)
 {
     AHCIQState *ahci;
@@ -1915,6 +1993,9 @@ int main(int argc, char **argv)
     g_assert(fd >= 0);
     close(fd);
 
+    qtest_add_func("/ahci/reset_with_pending_callback",
+                   test_reset_with_pending_callback);
+
     /* Run the tests */
     qtest_add_func("/ahci/sanity",     test_sanity);
     qtest_add_func("/ahci/pci_spec",   test_pci_spec);
-- 
2.39.2



