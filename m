Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830C7E6B6E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:47:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Kl-0000y7-TG; Thu, 09 Nov 2023 08:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Ki-0000pF-MR; Thu, 09 Nov 2023 08:44:32 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Kg-0001HC-N4; Thu, 09 Nov 2023 08:44:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3A76E31B07;
 Thu,  9 Nov 2023 16:43:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 409C6344AE;
 Thu,  9 Nov 2023 16:43:04 +0300 (MSK)
Received: (nullmailer pid 1461809 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Lu Gao <lu.gao@verisilicon.com>,
 Jianxian Wen <jianxian.wen@verisilicon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 16/55] hw/sd/sdhci: Block Size Register bits [14:12] is
 lost
Date: Thu,  9 Nov 2023 16:42:20 +0300
Message-Id: <20231109134300.1461632-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Lu Gao <lu.gao@verisilicon.com>

Block Size Register bits [14:12] is SDMA Buffer Boundary, it is missed
in register write, but it is needed in SDMA transfer. e.g. it will be
used in sdhci_sdma_transfer_multi_blocks to calculate boundary_ variables.

Missing this field will cause wrong operation for different SDMA Buffer
Boundary settings.

Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Fixes: dfba99f17f ("hw/sdhci: Fix DMA Transfer Block Size field")
Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-ID: <20220321055618.4026-1-lu.gao@verisilicon.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit ae5f70baf549925080fcdbc6c1939c98a4a39246)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 362c2c86aa..1bf89a1155 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -321,6 +321,8 @@ static void sdhci_poweron_reset(DeviceState *dev)
 
 static void sdhci_data_transfer(void *opaque);
 
+#define BLOCK_SIZE_MASK (4 * KiB - 1)
+
 static void sdhci_send_command(SDHCIState *s)
 {
     SDRequest request;
@@ -371,7 +373,8 @@ static void sdhci_send_command(SDHCIState *s)
 
     sdhci_update_irq(s);
 
-    if (!timeout && s->blksize && (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
+    if (!timeout && (s->blksize & BLOCK_SIZE_MASK) &&
+        (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
         s->data_count = 0;
         sdhci_data_transfer(s);
     }
@@ -406,7 +409,6 @@ static void sdhci_end_transfer(SDHCIState *s)
 /*
  * Programmed i/o data transfer
  */
-#define BLOCK_SIZE_MASK (4 * KiB - 1)
 
 /* Fill host controller's read buffer with BLKSIZE bytes of data from card */
 static void sdhci_read_block_from_card(SDHCIState *s)
@@ -1154,7 +1156,8 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             s->sdmasysad = (s->sdmasysad & mask) | value;
             MASKED_WRITE(s->sdmasysad, mask, value);
             /* Writing to last byte of sdmasysad might trigger transfer */
-            if (!(mask & 0xFF000000) && s->blkcnt && s->blksize &&
+            if (!(mask & 0xFF000000) && s->blkcnt &&
+                (s->blksize & BLOCK_SIZE_MASK) &&
                 SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
                 if (s->trnmod & SDHC_TRNS_MULTI) {
                     sdhci_sdma_transfer_multi_blocks(s);
@@ -1168,7 +1171,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         if (!TRANSFERRING_DATA(s->prnsts)) {
             uint16_t blksize = s->blksize;
 
-            MASKED_WRITE(s->blksize, mask, extract32(value, 0, 12));
+            /*
+             * [14:12] SDMA Buffer Boundary
+             * [11:00] Transfer Block Size
+             */
+            MASKED_WRITE(s->blksize, mask, extract32(value, 0, 15));
             MASKED_WRITE(s->blkcnt, mask >> 16, value >> 16);
 
             /* Limit block size to the maximum buffer size */
-- 
2.39.2


