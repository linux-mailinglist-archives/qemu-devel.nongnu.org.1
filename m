Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12023932E5C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jul 2024 18:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2W-0003mg-W0; Tue, 16 Jul 2024 12:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1f-0007RW-Np; Tue, 16 Jul 2024 12:27:40 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1b-0006eY-CI; Tue, 16 Jul 2024 12:27:38 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-75c3acf90f0so3940938a12.2; 
 Tue, 16 Jul 2024 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147252; x=1721752052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5TYVL1+Yc8WK0n0GdjxRRRAt3lrb2JlCgvlJVpBsBY=;
 b=U/rewGvIOEhlfKwKcCgwqkRsEAJGFWCKX+Wk3VpLs9CQ5vxg+L/wuDipI7a2ze+wXH
 GUENzLdrfUdTg26AJ/cAIrypJfV6+0UONxXUk8fcbOxy2uWkUUm/EBsNCHE94/BzUDD2
 oq3Y3GOTjV2Bw6isZBuZV1RZfdpqE7NjFvJwbB6MESqGAjea/6uUOtyOawquZcKpsu01
 avQfvoSSzWgEq5+jUUFSZF2jaCbuCbDRlYmGTCa2MUfVc51eFjKm0GGyx73UyZIXp03O
 Re2JLBe4bfRuj1KY3KNSh5e1h8HFEzAnyq4nKzem4PL79t4ZPCLtwhBKKpyHyxcoPxk/
 bHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147252; x=1721752052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5TYVL1+Yc8WK0n0GdjxRRRAt3lrb2JlCgvlJVpBsBY=;
 b=Dhk9vLuoBRvVShi91Lzu3QRdEtzIrXHaeqGaDgNh1GOVrEk6yMAZZNsxjMaTiYVR3P
 qMWBPDbN0hYn0z1NUDClvXIl+1DkjUMzT1woER5gNAMsPtsbwTTgdQIsBZAMaySV+nJk
 VVYE4P7sQXdWxv71/Ff4W4l37fr5ogMdA1hKNwPvFyrTFT+nqq7iz5bjkquZOXEvm/vn
 ya6knwkvzDhuIg/L5+9yB50GILppNIJbp3HmwJv7xDihf0oeLB7YQeNEtf2EIi1Mxoqe
 8RMVQfLfrz9Ifp0CDRXTYoeGeeYvFCE4mkCj8N393gurdtWP8Cvb7OnocSA5HGgH7gdR
 O7Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPVzj4Zco5zVTiMEEddWO8RpUE3WPs1d1bLAGQINyVPI1x2KwrODZOtgT54FQqENgkTtW1bxhYECDUrmqQfvCMu+SN/SU=
X-Gm-Message-State: AOJu0YxILT8Q2Z/mcWY+VvnLbBqfis8HUcp8D6JK5K5DwxrOlPpfy8Ov
 ha3bIH/atdBHnwGLeT0Gez7Snqb1R8OZGT9pNESmzjvQbOAEqev+S9yNMQ==
X-Google-Smtp-Source: AGHT+IEkZ9iFMbJ5PJ8j5nwresaxAmpwusHF6DXjVs1/uFzea2fWFOoGmx/SZG0oN8soxJDHUQmi8g==
X-Received: by 2002:a05:6a21:3947:b0:1c0:e9dd:11b8 with SMTP id
 adf61e73a8af0-1c3f12399e1mr2999752637.28.1721147252358; 
 Tue, 16 Jul 2024 09:27:32 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 18/19] ppc/pnv: Implement POWER10 PC xscom registers for
 direct controls
Date: Wed, 17 Jul 2024 02:26:14 +1000
Message-ID: <20240716162617.32161-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The PC unit in the processor core contains xscom registers that provide
low level status and control of the CPU.

This implements "direct controls", sufficient for skiboot firmware,
which uses it to send NMI IPIs between CPUs.

POWER10 is sufficiently different from POWER9 (particularly with respect
to QME and special wakeup) that it is not trivial to implement POWER9
support by reusing the code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_core.h |  3 ++
 hw/ppc/pnv_core.c         | 89 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index c8784777a4..1de79a818e 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -109,6 +109,9 @@ OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
 struct PnvQuad {
     DeviceState parent_obj;
 
+    bool special_wakeup_done;
+    bool special_wakeup[4];
+
     uint32_t quad_id;
     MemoryRegion xscom_regs;
     MemoryRegion xscom_qme_regs;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 1783795b23..8ed1cfe8a2 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -185,16 +185,40 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
  */
 
 #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
+#define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
+#define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
+#define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
 
 static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
 {
+    PnvCore *pc = PNV_CORE(opaque);
+    int nr_threads = CPU_CORE(pc)->nr_threads;
+    int i;
     uint32_t offset = addr >> 3;
     uint64_t val = 0;
 
     switch (offset) {
     case PNV10_XSCOM_EC_CORE_THREAD_STATE:
-        val = 0;
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+
+            if (cs->halted) {
+                val |= PPC_BIT(56 + i);
+            }
+        }
+        break;
+    case PNV10_XSCOM_EC_CORE_THREAD_INFO:
+        break;
+    case PNV10_XSCOM_EC_CORE_RAS_STATUS:
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+            if (cs->stopped) {
+                val |= PPC_BIT(0 + 8 * i) | PPC_BIT(1 + 8 * i);
+            }
+        }
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
@@ -207,9 +231,46 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
 static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
                                          uint64_t val, unsigned int width)
 {
+    PnvCore *pc = PNV_CORE(opaque);
+    int nr_threads = CPU_CORE(pc)->nr_threads;
+    int i;
     uint32_t offset = addr >> 3;
 
     switch (offset) {
+    case PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS:
+        for (i = 0; i < nr_threads; i++) {
+            PowerPCCPU *cpu = pc->threads[i];
+            CPUState *cs = CPU(cpu);
+
+            if (val & PPC_BIT(7 + 8 * i)) { /* stop */
+                val &= ~PPC_BIT(7 + 8 * i);
+                cpu_pause(cs);
+            }
+            if (val & PPC_BIT(6 + 8 * i)) { /* start */
+                val &= ~PPC_BIT(6 + 8 * i);
+                cpu_resume(cs);
+            }
+            if (val & PPC_BIT(4 + 8 * i)) { /* sreset */
+                val &= ~PPC_BIT(4 + 8 * i);
+                pnv_cpu_do_nmi_resume(cs);
+            }
+            if (val & PPC_BIT(3 + 8 * i)) { /* clear maint */
+                /*
+                 * Hardware has very particular cases for where clear maint
+                 * must be used and where start must be used to resume a
+                 * thread. These are not modelled exactly, just treat
+                 * this and start the same.
+                 */
+                val &= ~PPC_BIT(3 + 8 * i);
+                cpu_resume(cs);
+            }
+        }
+        if (val) {
+            qemu_log_mask(LOG_UNIMP, "%s: unimp bits in DIRECT_CONTROLS "
+                                     "0x%016lx\n", __func__, val);
+        }
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
@@ -526,6 +587,7 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
 static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
 {
+    PnvQuad *eq = PNV_QUAD(opaque);
     uint32_t offset = addr >> 3;
     uint64_t val = -1;
 
@@ -533,10 +595,14 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
      * Forth nibble selects the core within a quad, mask it to process read
      * for any core.
      */
-    switch (offset & ~0xf000) {
-    case P10_QME_SPWU_HYP:
+    switch (offset & ~PPC_BITMASK32(16, 19)) {
     case P10_QME_SSH_HYP:
-        return 0;
+        val = 0;
+        if (eq->special_wakeup_done) {
+            val |= PPC_BIT(1); /* SPWU DONE */
+            val |= PPC_BIT(4); /* SSH SPWU DONE */
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
                       offset);
@@ -548,9 +614,22 @@ static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
 static void pnv_qme_power10_xscom_write(void *opaque, hwaddr addr,
                                          uint64_t val, unsigned int width)
 {
+    PnvQuad *eq = PNV_QUAD(opaque);
     uint32_t offset = addr >> 3;
+    bool set;
+    int i;
 
-    switch (offset) {
+    switch (offset & ~PPC_BITMASK32(16, 19)) {
+    case P10_QME_SPWU_HYP:
+        set = !!(val & PPC_BIT(0));
+        eq->special_wakeup_done = set;
+        for (i = 0; i < 4; i++) {
+            /* These bits select cores in the quad */
+            if (offset & PPC_BIT32(16 + i)) {
+                eq->special_wakeup[i] = set;
+            }
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
                       offset);
-- 
2.45.1


