Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAC9049B0
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jun 2024 05:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHEn6-0006UG-Av; Tue, 11 Jun 2024 23:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sHEn4-0006U8-Fu
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 23:36:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sHEn1-0007NB-VP
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 23:36:50 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axz+vGF2lml90FAA--.8012S3;
 Wed, 12 Jun 2024 11:36:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxNMXFF2lm5a8cAA--.59802S2; 
 Wed, 12 Jun 2024 11:36:37 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/loongarch/virt: Remove unused assignment
Date: Wed, 12 Jun 2024 11:36:37 +0800
Message-Id: <20240612033637.167787-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxNMXFF2lm5a8cAA--.59802S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

There is abuse usage about local variable gap. Remove
duplicated assignment and solve Coverity reported error.

Resolves: Coverity CID 1546441
Fixes: 3cc451cbce ("hw/loongarch: Refine fwcfg memory map")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 66cef201ab..2fe08583b8 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1054,7 +1054,6 @@ static void fw_cfg_add_memory(MachineState *ms)
         memmap_add_entry(base, gap, 1);
         size -= gap;
         base = VIRT_HIGHMEM_BASE;
-        gap = ram_size - VIRT_LOWMEM_SIZE;
     }
 
     if (size) {
@@ -1067,17 +1066,17 @@ static void fw_cfg_add_memory(MachineState *ms)
     }
 
     /* add fw_cfg memory map of other nodes */
-    size = ram_size - numa_info[0].node_mem;
-    gap  = VIRT_LOWMEM_BASE + VIRT_LOWMEM_SIZE;
-    if (base < gap && (base + size) > gap) {
+    if (numa_info[0].node_mem < gap && ram_size > gap) {
         /*
          * memory map for the maining nodes splited into two part
-         *   lowram:  [base, +(gap - base))
-         *   highram: [VIRT_HIGHMEM_BASE, +(size - (gap - base)))
+         * lowram:  [base, +(gap - numa_info[0].node_mem))
+         * highram: [VIRT_HIGHMEM_BASE, +(ram_size - gap))
          */
-        memmap_add_entry(base, gap - base, 1);
-        size -= gap - base;
+        memmap_add_entry(base, gap - numa_info[0].node_mem, 1);
+        size = ram_size - gap;
         base = VIRT_HIGHMEM_BASE;
+    } else {
+        size = ram_size - numa_info[0].node_mem;
     }
 
    if (size)

base-commit: 80e8f0602168f451a93e71cbb1d59e93d745e62e
-- 
2.39.3


