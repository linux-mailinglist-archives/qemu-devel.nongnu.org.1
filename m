Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9455819FAA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:18:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwSH-0007ql-Sb; Wed, 20 Dec 2023 08:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRi-0007oH-Kr
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRf-0002MN-Vo
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HTGeNDp6XMMBKf/2pbtpwhQy6zMd8BzI4nhaucjvvGA=; b=FRhC/v+MjoToCWLTKXe9IPIIGj
 lKO5UfG1YXw5jcEdzB6e+dithsnHyrgE5keV0I6HAJJ913DYAQZJG/SM0lbfrNyObEr/CwmMn66fr
 1LHU2lrBooSakDD+UokoGkXOtja6ZsYwcHqLj/rtTXzrM0gLk43PiLHZmeQgwsdglzY1J4CuKuvdh
 lqTrw4+/5ypxJdFwJkNTKkpbJzOoB7FH77r/CN9SKymKz+zukAmMVsbDfYwjid5G2FI/LnEZ5TsZu
 uN+jjjJsiBDlofJZu39hIQ/nlmE+jSTobZd5hERi2hdisf2M9MsaOlocCmPmhSLb/oD9BpRPBzIw1
 bLiw7JADfCaCcfPJIy2SCWFmps108a30AQzBdUs1HKGhPGiG5s3H6jEgN2IOoxd8EPyb06T7r6meY
 uFXymvTyN5uXfyHFqSAfwJ+RnKN8k10EmsYtKXB3wbvnKEFVc2mjG+oJP0WqL8qWKES9tiMAWy76f
 mrHObzRPY/Fq34EqRXhTep4S5wAMER+/SBITCGd8aqYcrKHUrkqakLVWI6NNd+KWvu11wJbKeiHBh
 sDhs3iq+rAL0yG98fI0Gw7XGlFFmFMjYgFCAiOiTighsDJZDYRtUeIBVm5SBw3kwqZ9vNuNL1cgB7
 VANOerFD9BIKT3zzs2mqfBO8Naqajx86Qq2t6lonk=;
Received: from host86-147-134-9.range86-147.btcentralplus.com ([86.147.134.9]
 helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rFwRH-0001qt-DN; Wed, 20 Dec 2023 13:16:43 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 20 Dec 2023 13:16:35 +0000
Message-Id: <20231220131641.592826-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.147.134.9
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 05/11] next-cube.c: update and improve dma_ops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Rename dma_ops to next_dma_ops and the read/write functions to next_dma_read()
and next_dma_write() respectively, mark next_dma_ops as DEVICE_BIG_ENDIAN and
also improve the consistency of the val variable in next_dma_read() and
next_dma_write().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 100 ++++++++++++++++++++++++++++----------------
 1 file changed, 63 insertions(+), 37 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 8ed9bac26d..be4091ffd7 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -491,59 +491,63 @@ static const MemoryRegionOps next_scr_ops = {
 #define NEXTDMA_NEXT_INIT    0x4200
 #define NEXTDMA_SIZE         0x4204
 
-static void dma_writel(void *opaque, hwaddr addr, uint64_t value,
-                       unsigned int size)
+static void next_dma_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned int size)
 {
     NeXTState *next_state = NEXT_MACHINE(opaque);
 
     switch (addr) {
     case NEXTDMA_ENRX(NEXTDMA_CSR):
-        if (value & DMA_DEV2M) {
+        if (val & DMA_DEV2M) {
             next_state->dma[NEXTDMA_ENRX].csr |= DMA_DEV2M;
         }
 
-        if (value & DMA_SETENABLE) {
+        if (val & DMA_SETENABLE) {
             /* DPRINTF("SCSI DMA ENABLE\n"); */
             next_state->dma[NEXTDMA_ENRX].csr |= DMA_ENABLE;
         }
-        if (value & DMA_SETSUPDATE) {
+        if (val & DMA_SETSUPDATE) {
             next_state->dma[NEXTDMA_ENRX].csr |= DMA_SUPDATE;
         }
-        if (value & DMA_CLRCOMPLETE) {
+        if (val & DMA_CLRCOMPLETE) {
             next_state->dma[NEXTDMA_ENRX].csr &= ~DMA_COMPLETE;
         }
 
-        if (value & DMA_RESET) {
+        if (val & DMA_RESET) {
             next_state->dma[NEXTDMA_ENRX].csr &= ~(DMA_COMPLETE | DMA_SUPDATE |
                                                   DMA_ENABLE | DMA_DEV2M);
         }
         /* DPRINTF("RXCSR \tWrite: %x\n",value); */
         break;
+
     case NEXTDMA_ENRX(NEXTDMA_NEXT_INIT):
-        next_state->dma[NEXTDMA_ENRX].next_initbuf = value;
+        next_state->dma[NEXTDMA_ENRX].next_initbuf = val;
         break;
+
     case NEXTDMA_ENRX(NEXTDMA_NEXT):
-        next_state->dma[NEXTDMA_ENRX].next = value;
+        next_state->dma[NEXTDMA_ENRX].next = val;
         break;
+
     case NEXTDMA_ENRX(NEXTDMA_LIMIT):
-        next_state->dma[NEXTDMA_ENRX].limit = value;
+        next_state->dma[NEXTDMA_ENRX].limit = val;
         break;
+
     case NEXTDMA_SCSI(NEXTDMA_CSR):
-        if (value & DMA_DEV2M) {
+        if (val & DMA_DEV2M) {
             next_state->dma[NEXTDMA_SCSI].csr |= DMA_DEV2M;
         }
-        if (value & DMA_SETENABLE) {
+        if (val & DMA_SETENABLE) {
             /* DPRINTF("SCSI DMA ENABLE\n"); */
             next_state->dma[NEXTDMA_SCSI].csr |= DMA_ENABLE;
         }
-        if (value & DMA_SETSUPDATE) {
+        if (val & DMA_SETSUPDATE) {
             next_state->dma[NEXTDMA_SCSI].csr |= DMA_SUPDATE;
         }
-        if (value & DMA_CLRCOMPLETE) {
+        if (val & DMA_CLRCOMPLETE) {
             next_state->dma[NEXTDMA_SCSI].csr &= ~DMA_COMPLETE;
         }
 
-        if (value & DMA_RESET) {
+        if (val & DMA_RESET) {
             next_state->dma[NEXTDMA_SCSI].csr &= ~(DMA_COMPLETE | DMA_SUPDATE |
                                                   DMA_ENABLE | DMA_DEV2M);
             /* DPRINTF("SCSI DMA RESET\n"); */
@@ -552,23 +556,23 @@ static void dma_writel(void *opaque, hwaddr addr, uint64_t value,
         break;
 
     case NEXTDMA_SCSI(NEXTDMA_NEXT):
-        next_state->dma[NEXTDMA_SCSI].next = value;
+        next_state->dma[NEXTDMA_SCSI].next = val;
         break;
 
     case NEXTDMA_SCSI(NEXTDMA_LIMIT):
-        next_state->dma[NEXTDMA_SCSI].limit = value;
+        next_state->dma[NEXTDMA_SCSI].limit = val;
         break;
 
     case NEXTDMA_SCSI(NEXTDMA_START):
-        next_state->dma[NEXTDMA_SCSI].start = value;
+        next_state->dma[NEXTDMA_SCSI].start = val;
         break;
 
     case NEXTDMA_SCSI(NEXTDMA_STOP):
-        next_state->dma[NEXTDMA_SCSI].stop = value;
+        next_state->dma[NEXTDMA_SCSI].stop = val;
         break;
 
     case NEXTDMA_SCSI(NEXTDMA_NEXT_INIT):
-        next_state->dma[NEXTDMA_SCSI].next_initbuf = value;
+        next_state->dma[NEXTDMA_SCSI].next_initbuf = val;
         break;
 
     default:
@@ -576,52 +580,73 @@ static void dma_writel(void *opaque, hwaddr addr, uint64_t value,
     }
 }
 
-static uint64_t dma_readl(void *opaque, hwaddr addr, unsigned int size)
+static uint64_t next_dma_read(void *opaque, hwaddr addr, unsigned int size)
 {
     NeXTState *next_state = NEXT_MACHINE(opaque);
+    uint64_t val;
 
     switch (addr) {
     case NEXTDMA_SCSI(NEXTDMA_CSR):
         DPRINTF("SCSI DMA CSR READ\n");
-        return next_state->dma[NEXTDMA_SCSI].csr;
+        val = next_state->dma[NEXTDMA_SCSI].csr;
+        break;
+
     case NEXTDMA_ENRX(NEXTDMA_CSR):
-        return next_state->dma[NEXTDMA_ENRX].csr;
+        val = next_state->dma[NEXTDMA_ENRX].csr;
+        break;
+
     case NEXTDMA_ENRX(NEXTDMA_NEXT_INIT):
-        return next_state->dma[NEXTDMA_ENRX].next_initbuf;
+        val = next_state->dma[NEXTDMA_ENRX].next_initbuf;
+        break;
+
     case NEXTDMA_ENRX(NEXTDMA_NEXT):
-        return next_state->dma[NEXTDMA_ENRX].next;
+        val = next_state->dma[NEXTDMA_ENRX].next;
+        break;
+
     case NEXTDMA_ENRX(NEXTDMA_LIMIT):
-        return next_state->dma[NEXTDMA_ENRX].limit;
+        val = next_state->dma[NEXTDMA_ENRX].limit;
+        break;
 
     case NEXTDMA_SCSI(NEXTDMA_NEXT):
-        return next_state->dma[NEXTDMA_SCSI].next;
+        val = next_state->dma[NEXTDMA_SCSI].next;
+        break;
+
     case NEXTDMA_SCSI(NEXTDMA_NEXT_INIT):
-        return next_state->dma[NEXTDMA_SCSI].next_initbuf;
+        val = next_state->dma[NEXTDMA_SCSI].next_initbuf;
+        break;
+
     case NEXTDMA_SCSI(NEXTDMA_LIMIT):
-        return next_state->dma[NEXTDMA_SCSI].limit;
+        val = next_state->dma[NEXTDMA_SCSI].limit;
+        break;
+
     case NEXTDMA_SCSI(NEXTDMA_START):
-        return next_state->dma[NEXTDMA_SCSI].start;
+        val = next_state->dma[NEXTDMA_SCSI].start;
+        break;
+
     case NEXTDMA_SCSI(NEXTDMA_STOP):
-        return next_state->dma[NEXTDMA_SCSI].stop;
+        val = next_state->dma[NEXTDMA_SCSI].stop;
+        break;
 
     default:
         DPRINTF("DMA read @ %x\n", (unsigned int)addr);
-        return 0;
+        val = 0;
     }
 
     /*
      * once the csr's are done, subtract 0x3FEC from the addr, and that will
      * normalize the upper registers
      */
+
+    return val;
 }
 
-static const MemoryRegionOps dma_ops = {
-    .read = dma_readl,
-    .write = dma_writel,
+static const MemoryRegionOps next_dma_ops = {
+    .read = next_dma_read,
+    .write = next_dma_write,
     .impl.min_access_size = 4,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void next_irq(void *opaque, int number, int level)
@@ -1017,7 +1042,8 @@ static void next_cube_init(MachineState *machine)
     next_scsi_init(pcdev, cpu);
 
     /* DMA */
-    memory_region_init_io(dmamem, NULL, &dma_ops, machine, "next.dma", 0x5000);
+    memory_region_init_io(dmamem, NULL, &next_dma_ops, machine, "next.dma",
+                          0x5000);
     memory_region_add_subregion(sysmem, 0x02000000, dmamem);
 }
 
-- 
2.39.2


