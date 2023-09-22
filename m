Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C57AA6E1
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 04:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjVW6-0007jH-Ez; Thu, 21 Sep 2023 22:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lu.Gao@verisilicon.com>)
 id 1qjVW4-0007j6-6C
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 22:03:36 -0400
Received: from shasxm03.verisilicon.com ([101.89.135.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <Lu.Gao@verisilicon.com>)
 id 1qjVW1-0006Do-JA
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 22:03:35 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; d=Verisilicon.com; s=default;
 c=simple/simple; t=1695348204; h=from:subject:to:date:message-id;
 bh=0QbQLO+OUlplmTbYN3dywkswCU3ozmnGYJ6+VQuto10=;
 b=OsMPdXX8Y00CVVsHl9+qXJ7+hjiWrmHO/JnvZmR74XhfpXJKj80N/miJySeBNzox8hEeDGYcdqz
 ZrQe7fiwJO4nNL+B7NFyBic21A49n9srI9zI4SRT1qXsVNG/aVlS7OMek2SQetNqaM/voD3vCFCtW
 6xV+GqcF1ZZUJK3ObOw=
Received: from coding0919.verisilicon.com (192.168.103.179) by
 SHASXM03.verisilicon.com (10.10.128.202) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 22 Sep 2023 10:03:24 +0800
From: Lu Gao <lu.gao@verisilicon.com>
To: <qemu-devel@nongnu.org>
CC: Lu Gao <lu.gao@verisilicon.com>, Jianxian Wen
 <jianxian.wen@verisilicon.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Bin Meng <bin.meng@windriver.com>, "open list:SD
 (Secure Card)" <qemu-block@nongnu.org>
Subject: [PATCH v2] hw/sd/sdhci: Block Size Register bits [14:12] is lost
Date: Fri, 22 Sep 2023 10:03:12 +0800
Message-ID: <20230922020312.30828-1-lu.gao@verisilicon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [192.168.103.179]
Received-SPF: pass client-ip=101.89.135.44;
 envelope-from=Lu.Gao@verisilicon.com; helo=shasxm03.verisilicon.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Block Size Register bits [14:12] is SDMA Buffer Boundary, it is missed
in register write, but it is needed in SDMA transfer. e.g. it will be
used in sdhci_sdma_transfer_multi_blocks to calculate boundary_ variables.

Missing this field will cause wrong operation for different SDMA Buffer
Boundary settings.

Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Fixes: dfba99f17f ("hw/sdhci: Fix DMA Transfer Block Size field")

Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
Reviewed-by: Philippe Mathieu-Daudé? <f4bug@amsat.org>
---
v2:
 - Add fixes information and reviewed-by information

 hw/sd/sdhci.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 5564765a9b..40473b0db0 100644
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
2.17.1


