Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72098929FE4
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jul 2024 12:09:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQlIH-0000k2-7H; Mon, 08 Jul 2024 06:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pykfirst@gmail.com>)
 id 1sQlIE-0000iV-VQ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 06:08:22 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pykfirst@gmail.com>)
 id 1sQlID-0004wi-3U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 06:08:22 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fb1ff21748so16803795ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720433299; x=1721038099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oqXgCm7imyK9wZeIvi0UU+/FYjei8lJ2zlL7ikKt+nE=;
 b=C4jKXcnYYk3TnEzKN8uX+Z/8corUlFvmgQ07n6CRiPhMjnxNK+mgWN1pRWPgYDMok9
 qdXebeFQow8N4Vl6HvWpNXhK1Otjr0rYcQjAGnjiwytJdwJYhTfldCyeG0KJ6MU3PU0n
 b6D/YcTbJANHtmL81o1t7ybWUPRyspj+aF1iqV4/GDi5KNFfUqsStUvDDHKvSPBt6My+
 e9buI3v+DIKK2GIgxu1PV28Zg18rcsaAoA3YYPMLDaedd8PkOqshv0u54OhV1kKAC/O7
 Qe3AbRRyYyU0mdJkajxHOAGX/TVfKyZ0WVegO/kRyN/uiLcFXM5ardipaTW8tLJmJirX
 N1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720433299; x=1721038099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oqXgCm7imyK9wZeIvi0UU+/FYjei8lJ2zlL7ikKt+nE=;
 b=kYrZSiifZ7rJ3A1Wej0DPqo+5JiuP33F24gzoKw9HqSdCns02dOGZP4NqtZIA4uphL
 ZbxuDl4rpmP1KOSO6ajSIVV1sPyEPVAwm9CxMEfcvsViZ2xD0I6xCL3HHVWtxAcyRtfb
 TuEnvZHAQAQu0eH7dqjdGfLFTb08Py+PfH+H9lJFjnkO/5BbiHOmOQU+zfgySx2NCsGT
 +Qu/TYRGUt6XHVH6hWfbKjOX9DeiHmZjucV7Iz6aILXnNyXZWHFJji4V02XzJak5yx1w
 QyrOIAyHKVI2q0itHNPWPMzz7UkgJksQ/ECG78+KdYFcrfVZUE3Pvwv/70I0B0c5v2Ws
 jGKw==
X-Gm-Message-State: AOJu0YzpheHcMOOfQ8U0gfF7qsSYC4YnMxIToicYjOvWh012uFCGD99c
 9xmBhXmLFZByz8NuZOvMp0NNtlub4vBOqADXuUICDO6ZpM8umXMy5L0dpJbIxAymWQ==
X-Google-Smtp-Source: AGHT+IF2jEDi/BIwkzLkhAyQ0lLKoCiDTZKMup4h43Of9c6PvD0qJnV1wIWytXq4k2nguysFzfjjpA==
X-Received: by 2002:a17:902:ef45:b0:1fb:5574:7560 with SMTP id
 d9443c01a7336-1fb55747a7fmr38432765ad.65.1720433298996; 
 Mon, 08 Jul 2024 03:08:18 -0700 (PDT)
Received: from localhost ([116.6.234.149]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb9a83529bsm13031655ad.245.2024.07.08.03.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 03:08:18 -0700 (PDT)
From: Yuke Peng <pykfirst@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2] hw/i386/intel_iommu: Block CFI when necessary
Date: Mon,  8 Jul 2024 18:08:16 +0800
Message-Id: <20240708100816.1916346-1-pykfirst@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pykfirst@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

According to Intel VT-d specification 5.1.4, CFI must be blocked when
Extended Interrupt Mode is enabled or Compatibility format interrupts
are disabled.

Signed-off-by: Yuke Peng <pykfirst@gmail.com>
---
Changes in v2:
- Use subsections for the cfi_enabled field.
- Link to v1: https://lore.kernel.org/qemu-devel/20240625112819.862282-1-pykfirst@gmail.com/

---
 hw/i386/intel_iommu.c         | 53 +++++++++++++++++++++++++++++++++--
 hw/i386/trace-events          |  1 +
 include/hw/i386/intel_iommu.h |  1 +
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5085a6fee3..af9c864bde 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2410,6 +2410,22 @@ static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
     }
 }
 
+/* Handle Compatibility Format Interrupts Enable/Disable */
+static void vtd_handle_gcmd_cfi(IntelIOMMUState *s, bool en)
+{
+    trace_vtd_cfi_enable(en);
+
+    if (en) {
+        s->cfi_enabled = true;
+        /* Ok - report back to driver */
+        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_CFIS);
+    } else {
+        s->cfi_enabled = false;
+        /* Ok - report back to driver */
+        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_CFIS, 0);
+    }
+}
+
 /* Handle write to Global Command Register */
 static void vtd_handle_gcmd_write(IntelIOMMUState *s)
 {
@@ -2440,6 +2456,10 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
         /* Interrupt remap enable/disable */
         vtd_handle_gcmd_ire(s, val & VTD_GCMD_IRE);
     }
+    if (changed & VTD_GCMD_CFI) {
+        /* Compatibility format interrupts enable/disable */
+        vtd_handle_gcmd_cfi(s, val & VTD_GCMD_CFI);
+    }
 }
 
 /* Handle write to Context Command Register */
@@ -3283,7 +3303,25 @@ static int vtd_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vtd_vmstate = {
+static bool vtd_cfi_needed(void *opaque)
+{
+    IntelIOMMUState *iommu = opaque;
+
+    return iommu->intr_enabled && !iommu->intr_eime;
+}
+
+static const VMStateDescription vmstate_vtd_cfi = {
+    .name = "iommu-intel/cfi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vtd_cfi_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(cfi_enabled, IntelIOMMUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_vtd = {
     .name = "iommu-intel",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -3306,6 +3344,10 @@ static const VMStateDescription vtd_vmstate = {
         VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
         VMSTATE_BOOL(intr_eime, IntelIOMMUState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_vtd_cfi,
+        NULL
     }
 };
 
@@ -3525,6 +3567,12 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
 
     /* This is compatible mode. */
     if (addr.addr.int_mode != VTD_IR_INT_FORMAT_REMAP) {
+        if (iommu->intr_eime || !iommu->cfi_enabled) {
+            if (do_fault) {
+                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_COMPAT, 0);
+            }
+            return -EINVAL;
+        }
         memcpy(translated, origin, sizeof(*origin));
         goto out;
     }
@@ -3950,6 +3998,7 @@ static void vtd_init(IntelIOMMUState *s)
     s->root_scalable = false;
     s->dmar_enabled = false;
     s->intr_enabled = false;
+    s->cfi_enabled = false;
     s->iq_head = 0;
     s->iq_tail = 0;
     s->iq = 0;
@@ -4243,7 +4292,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
 
     dc->reset = vtd_reset;
-    dc->vmsd = &vtd_vmstate;
+    dc->vmsd = &vmstate_vtd;
     device_class_set_props(dc, vtd_properties);
     dc->hotpluggable = false;
     x86_class->realize = vtd_realize;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 53c02d7ac8..ffd87db65f 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -57,6 +57,7 @@ vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova, uint6
 vtd_dmar_enable(bool en) "enable %d"
 vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_write) "sid 0x%"PRIx16" fault %d addr 0x%"PRIx64" write %d"
 vtd_ir_enable(bool en) "enable %d"
+vtd_cfi_enable(bool en) "enable %d"
 vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
 vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t dest, int dest_mode) "index %d trigger %d vector %d deliver %d dest 0x%"PRIx32" mode %d"
 vtd_ir_remap_type(const char *type) "%s"
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 7fa0a695c8..38e20d0f2c 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -294,6 +294,7 @@ struct IntelIOMMUState {
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
+    bool cfi_enabled;               /* Whether CFI is enabled */
     dma_addr_t intr_root;           /* Interrupt remapping table pointer */
     uint32_t intr_size;             /* Number of IR table entries */
     bool intr_eime;                 /* Extended interrupt mode enabled */
-- 
2.34.1


