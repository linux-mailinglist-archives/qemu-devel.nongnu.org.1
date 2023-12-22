Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA4781CAE0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:47:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfr2-0008F1-HE; Fri, 22 Dec 2023 08:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqe-0007YX-23
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:46:02 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqa-0004JM-Bo
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:54 -0500
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-40d22d3e751so17785785e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252750; x=1703857550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKCCvFa0vt2bP91cxXGy4Jwucv10C/kDWcWCnPxujjE=;
 b=QDjvT0k1KzWQoLgIuhoZumhWuztUsx6vHdH1pMX67f3YGtWIIu4jBcJwr7t7upHQzm
 eQQJtpV80eEHswWWmmnyWZ4+KTyIpEQy/ZJx3SAaMPtxU/H9l3fVEGZlXUUM6AAXhekr
 PFMw3N0ZZooZ+wBHSgcneUIzY1XaTkIoAtXIAB0rzXN3cvQOxFGnchiQiP4aiLUMs6Rw
 rPS7/ubC6/mHHmzvc6esUHWmQWtARX/yhsf8D1xsXOvX7Gq6RS0swvsCeX5jXummPHMe
 S9b6Hnor6YphSNy7yyuJpc2gf/WdJRJ/6kS+1DN5vUaAYUju0QSYTUmEGkQl7y50Mh1D
 CveA==
X-Gm-Message-State: AOJu0YxGiJChhqQLd94Hd8GQ1P6lRXCP4thGZjCPuopIDxHea9KphMB0
 RKMrEruDVmZhl9yk00MHMXn4CiMZdYA=
X-Google-Smtp-Source: AGHT+IFmWUuwUa/Kb9otDsd7d0ZVRSqJVLWv5kpf4Yfx2mYT1AbU4mj8PB0pU5pehNtAzTbbqgzhSw==
X-Received: by 2002:a7b:ca50:0:b0:40c:6e2a:6d3 with SMTP id
 m16-20020a7bca50000000b0040c6e2a06d3mr697043wml.167.1703252750486; 
 Fri, 22 Dec 2023 05:45:50 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:49 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 05/11] next-cube.c: update and improve dma_ops
Date: Fri, 22 Dec 2023 14:45:21 +0100
Message-ID: <20231222134527.15705-6-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.128.48; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f48.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Rename dma_ops to next_dma_ops and the read/write functions to next_dma_read()
and next_dma_write() respectively, mark next_dma_ops as DEVICE_BIG_ENDIAN and
also improve the consistency of the val variable in next_dma_read() and
next_dma_write().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
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
2.43.0


