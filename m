Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB78077083D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzw9-0002F0-TE; Fri, 04 Aug 2023 14:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzw4-0002D7-M9; Fri, 04 Aug 2023 14:54:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzw2-00084g-Ly; Fri, 04 Aug 2023 14:54:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5882818405;
 Fri,  4 Aug 2023 21:54:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B21301B87D;
 Fri,  4 Aug 2023 21:53:56 +0300 (MSK)
Received: (nullmailer pid 1874200 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 16/36] hw/arm/smmu: Handle big-endian hosts correctly
Date: Fri,  4 Aug 2023 21:53:29 +0300
Message-Id: <20230804185350.1874133-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The implementation of the SMMUv3 has multiple places where it reads a
data structure from the guest and directly operates on it without
doing a guest-to-host endianness conversion.  Since all SMMU data
structures are little-endian, this means that the SMMU doesn't work
on a big-endian host.  In particular, this causes the Avocado test
  machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
to fail on an s390x host.

Add appropriate byte-swapping on reads and writes of guest in-memory
data structures so that the device works correctly on big-endian
hosts.

As part of this we constrain queue_read() to operate only on Cmd
structs and queue_write() on Evt structs, because in practice these
are the only data structures the two functions are used with, and we
need to know what the data structure is to be able to byte-swap its
parts correctly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20230717132641.764660-1-peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org
(cherry picked from commit c6445544d4cea2628fbad3bad09f3d3a03c749d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e09b9c13b7..bbca3a8db3 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -193,8 +193,7 @@ static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
     dma_addr_t addr = baseaddr + index * sizeof(*pte);
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = dma_memory_read(&address_space_memory, addr, pte, sizeof(*pte),
-                          MEMTXATTRS_UNSPECIFIED);
+    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
 
     if (ret != MEMTX_OK) {
         info->type = SMMU_PTW_ERR_WALK_EABT;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index daa80e9c7b..ce7091ff8e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -98,20 +98,34 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
     trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
 }
 
-static inline MemTxResult queue_read(SMMUQueue *q, void *data)
+static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
 {
     dma_addr_t addr = Q_CONS_ENTRY(q);
+    MemTxResult ret;
+    int i;
 
-    return dma_memory_read(&address_space_memory, addr, data, q->entry_size,
-                           MEMTXATTRS_UNSPECIFIED);
+    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
+                          MEMTXATTRS_UNSPECIFIED);
+    if (ret != MEMTX_OK) {
+        return ret;
+    }
+    for (i = 0; i < ARRAY_SIZE(cmd->word); i++) {
+        le32_to_cpus(&cmd->word[i]);
+    }
+    return ret;
 }
 
-static MemTxResult queue_write(SMMUQueue *q, void *data)
+static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
 {
     dma_addr_t addr = Q_PROD_ENTRY(q);
     MemTxResult ret;
+    Evt evt = *evt_in;
+    int i;
 
-    ret = dma_memory_write(&address_space_memory, addr, data, q->entry_size,
+    for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
+        cpu_to_le32s(&evt.word[i]);
+    }
+    ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
                            MEMTXATTRS_UNSPECIFIED);
     if (ret != MEMTX_OK) {
         return ret;
@@ -290,7 +304,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
                         SMMUEventInfo *event)
 {
-    int ret;
+    int ret, i;
 
     trace_smmuv3_get_ste(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
@@ -303,6 +317,9 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
         event->u.f_ste_fetch.addr = addr;
         return -EINVAL;
     }
+    for (i = 0; i < ARRAY_SIZE(buf->word); i++) {
+        le32_to_cpus(&buf->word[i]);
+    }
     return 0;
 
 }
@@ -312,7 +329,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
                        CD *buf, SMMUEventInfo *event)
 {
     dma_addr_t addr = STE_CTXPTR(ste);
-    int ret;
+    int ret, i;
 
     trace_smmuv3_get_cd(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
@@ -325,6 +342,9 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
         event->u.f_ste_fetch.addr = addr;
         return -EINVAL;
     }
+    for (i = 0; i < ARRAY_SIZE(buf->word); i++) {
+        le32_to_cpus(&buf->word[i]);
+    }
     return 0;
 }
 
@@ -406,7 +426,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         return -EINVAL;
     }
     if (s->features & SMMU_FEATURE_2LVL_STE) {
-        int l1_ste_offset, l2_ste_offset, max_l2_ste, span;
+        int l1_ste_offset, l2_ste_offset, max_l2_ste, span, i;
         dma_addr_t l1ptr, l2ptr;
         STEDesc l1std;
 
@@ -430,6 +450,9 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
             event->u.f_ste_fetch.addr = l1ptr;
             return -EINVAL;
         }
+        for (i = 0; i < ARRAY_SIZE(l1std.word); i++) {
+            le32_to_cpus(&l1std.word[i]);
+        }
 
         span = L1STD_SPAN(&l1std);
 
-- 
2.39.2


