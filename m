Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9997CE238
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8y5-0003xi-Po; Wed, 18 Oct 2023 12:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xz-0003q1-NP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xx-00080v-9A
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7yLJhsKzBOqiWUrJA7Var67GrcuSuwHsIVThsjTdeY=;
 b=i7SAuFwiiOvyv+QllL/iDQBNg+6K8FQAKbS18c6nGgd+2F/Y2B0fdI1X2co4vX+GqTQkGA
 P56Nogcutn+qsvslwVEWw9M/1wTyCdtphfgP8Crb9+NvnJCuVs1wXeHIlx4EztYLEm8rs5
 rrYhi44McjOBiO5HHCrglB0gwScoFHA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-7dRrFcUdMBOKYaf1FGMCSQ-1; Wed, 18 Oct 2023 12:00:09 -0400
X-MC-Unique: 7dRrFcUdMBOKYaf1FGMCSQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5079a66711eso5460405e87.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644808; x=1698249608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7yLJhsKzBOqiWUrJA7Var67GrcuSuwHsIVThsjTdeY=;
 b=DkO6yJ3jDiEFmyo9QRgQHOoHkgfdeOV1byCyXEs54hoETlFYMnFL+Ipzq50zFzcWMI
 CmPSOOI9xZc5xRoipVXJ6neK9Ocj1sByzbHCMBZTKYc3mGc7wFcHtHzcrrt3qHvgSzoW
 mSaoNUeRivnat+ec/uLR/aeEXUV3ipQaic8un+hl8LGT7dFPCkwJBLYJy19QTADLS/zl
 ebpaNyxzZyA2v2izURejOQdd830mK/EpwS6sPafdg+jrffSVEaH0v+L54MY3pRopNn0k
 x+83JfrS7ygbJd6TfhxIL6YYyn57ZBch2DjTzl1e+5ta3W+IjJ58TKAC8MTeeiUxQ9VO
 rZZg==
X-Gm-Message-State: AOJu0Yw0ec8Wr0OQtc14Rk4TB+JHOmCpuOJJDq5XgAFLADIOhJp8tdkD
 thNN3AX8zbycYmxM/lsxJgBvzogybAq/q/uozrfHrkVxAn4c63330qoulcXExnFnbYhM4UBcYjB
 wjy4eXlcM6+QghiC7OptrHhbKEXjTyoOvQc40hbiFuSHrxBxiLBYVi52D1DrQZkCQrI/ZuOE=
X-Received: by 2002:a05:6512:3b85:b0:507:a04c:76eb with SMTP id
 g5-20020a0565123b8500b00507a04c76ebmr5105562lfv.35.1697644807725; 
 Wed, 18 Oct 2023 09:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzGlgSNuyIsyGGTc6yrhddf5JtmkCyMk5Lp3qrRbxEUxjW5nG2Crh4vIB1ZXVmv1Fau+U7lg==
X-Received: by 2002:a05:6512:3b85:b0:507:a04c:76eb with SMTP id
 g5-20020a0565123b8500b00507a04c76ebmr5105528lfv.35.1697644807234; 
 Wed, 18 Oct 2023 09:00:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a5d614f000000b003142e438e8csm2396965wrt.26.2023.10.18.09.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:00:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:59:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 83/83] intel-iommu: Report interrupt remapping faults, fix
 return value
Message-ID: <49ca8f122f3e84d7d879f3b4d54a5294b39764d1.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

A generic X86IOMMUClass->int_remap function should not return VT-d
specific values; fix it to return 0 if the interrupt was successfully
translated or -EINVAL if not.

The VTD_FR_IR_xxx values are supposed to be used to actually raise
faults through the fault reporting mechanism, so do that instead for
the case where the IRQ is actually being injected.

There is more work to be done here, as pretranslations for the KVM IRQ
routing table can't fault; an untranslatable IRQ should be handled in
userspace and the fault raised only when the IRQ actually happens (if
indeed the IRTE is still not valid at that time). But we can work on
that later; we can at least raise faults for the direct case.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <31bbfc9041690449d3ac891f4431ec82174ee1b4.camel@infradead.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |   1 +
 hw/i386/intel_iommu.c          | 150 ++++++++++++++++++++++-----------
 2 files changed, 103 insertions(+), 48 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e1450c5cfe..f8cf99bddf 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -268,6 +268,7 @@
 #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
 #define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
+#define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
 
 /* DMA Remapping Fault Conditions */
 typedef enum VTDFaultReason {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2c832ab68b..30a108a42b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -469,21 +469,12 @@ static void vtd_set_frcd_and_update_ppf(IntelIOMMUState *s, uint16_t index)
 
 /* Must not update F field now, should be done later */
 static void vtd_record_frcd(IntelIOMMUState *s, uint16_t index,
-                            uint16_t source_id, hwaddr addr,
-                            VTDFaultReason fault, bool is_write,
-                            bool is_pasid, uint32_t pasid)
+                            uint64_t hi, uint64_t lo)
 {
-    uint64_t hi = 0, lo;
     hwaddr frcd_reg_addr = DMAR_FRCD_REG_OFFSET + (((uint64_t)index) << 4);
 
     assert(index < DMAR_FRCD_REG_NR);
 
-    lo = VTD_FRCD_FI(addr);
-    hi = VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault) |
-         VTD_FRCD_PV(pasid) | VTD_FRCD_PP(is_pasid);
-    if (!is_write) {
-        hi |= VTD_FRCD_T;
-    }
     vtd_set_quad_raw(s, frcd_reg_addr, lo);
     vtd_set_quad_raw(s, frcd_reg_addr + 8, hi);
 
@@ -509,17 +500,11 @@ static bool vtd_try_collapse_fault(IntelIOMMUState *s, uint16_t source_id)
 }
 
 /* Log and report an DMAR (address translation) fault to software */
-static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
-                                  hwaddr addr, VTDFaultReason fault,
-                                  bool is_write, bool is_pasid,
-                                  uint32_t pasid)
+static void vtd_report_frcd_fault(IntelIOMMUState *s, uint64_t source_id,
+                                  uint64_t hi, uint64_t lo)
 {
     uint32_t fsts_reg = vtd_get_long_raw(s, DMAR_FSTS_REG);
 
-    assert(fault < VTD_FR_MAX);
-
-    trace_vtd_dmar_fault(source_id, fault, addr, is_write);
-
     if (fsts_reg & VTD_FSTS_PFO) {
         error_report_once("New fault is not recorded due to "
                           "Primary Fault Overflow");
@@ -539,8 +524,7 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
         return;
     }
 
-    vtd_record_frcd(s, s->next_frcd_reg, source_id, addr, fault,
-                    is_write, is_pasid, pasid);
+    vtd_record_frcd(s, s->next_frcd_reg, hi, lo);
 
     if (fsts_reg & VTD_FSTS_PPF) {
         error_report_once("There are pending faults already, "
@@ -565,6 +549,40 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
     }
 }
 
+/* Log and report an DMAR (address translation) fault to software */
+static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
+                                  hwaddr addr, VTDFaultReason fault,
+                                  bool is_write, bool is_pasid,
+                                  uint32_t pasid)
+{
+    uint64_t hi, lo;
+
+    assert(fault < VTD_FR_MAX);
+
+    trace_vtd_dmar_fault(source_id, fault, addr, is_write);
+
+    lo = VTD_FRCD_FI(addr);
+    hi = VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault) |
+         VTD_FRCD_PV(pasid) | VTD_FRCD_PP(is_pasid);
+    if (!is_write) {
+        hi |= VTD_FRCD_T;
+    }
+
+    vtd_report_frcd_fault(s, source_id, hi, lo);
+}
+
+
+static void vtd_report_ir_fault(IntelIOMMUState *s, uint64_t source_id,
+                                VTDFaultReason fault, uint16_t index)
+{
+    uint64_t hi, lo;
+
+    lo = VTD_FRCD_IR_IDX(index);
+    hi = VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault);
+
+    vtd_report_frcd_fault(s, source_id, hi, lo);
+}
+
 /* Handle Invalidation Queue Errors of queued invalidation interface error
  * conditions.
  */
@@ -3305,8 +3323,9 @@ static Property vtd_properties[] = {
 };
 
 /* Read IRTE entry with specific index */
-static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
-                        VTD_IR_TableEntry *entry, uint16_t sid)
+static bool vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
+                         VTD_IR_TableEntry *entry, uint16_t sid,
+                         bool do_fault)
 {
     static const uint16_t vtd_svt_mask[VTD_SQ_MAX] = \
         {0xffff, 0xfffb, 0xfff9, 0xfff8};
@@ -3317,7 +3336,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
     if (index >= iommu->intr_size) {
         error_report_once("%s: index too large: ind=0x%x",
                           __func__, index);
-        return -VTD_FR_IR_INDEX_OVER;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_INDEX_OVER, index);
+        }
+        return false;
     }
 
     addr = iommu->intr_root + index * sizeof(*entry);
@@ -3325,7 +3347,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
                         entry, sizeof(*entry), MEMTXATTRS_UNSPECIFIED)) {
         error_report_once("%s: read failed: ind=0x%x addr=0x%" PRIx64,
                           __func__, index, addr);
-        return -VTD_FR_IR_ROOT_INVAL;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_ROOT_INVAL, index);
+        }
+        return false;
     }
 
     entry->data[0] = le64_to_cpu(entry->data[0]);
@@ -3333,11 +3358,24 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
 
     trace_vtd_ir_irte_get(index, entry->data[1], entry->data[0]);
 
+    /*
+     * The remaining potential fault conditions are "qualified" by the
+     * Fault Processing Disable bit in the IRTE. Even "not present".
+     * So just clear the do_fault flag if PFD is set, which will
+     * prevent faults being raised.
+     */
+    if (entry->irte.fault_disable) {
+        do_fault = false;
+    }
+
     if (!entry->irte.present) {
         error_report_once("%s: detected non-present IRTE "
                           "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
                           __func__, index, entry->data[1], entry->data[0]);
-        return -VTD_FR_IR_ENTRY_P;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_ENTRY_P, index);
+        }
+        return false;
     }
 
     if (entry->irte.__reserved_0 || entry->irte.__reserved_1 ||
@@ -3345,7 +3383,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
         error_report_once("%s: detected non-zero reserved IRTE "
                           "(index=%u, high=0x%" PRIx64 ", low=0x%" PRIx64 ")",
                           __func__, index, entry->data[1], entry->data[0]);
-        return -VTD_FR_IR_IRTE_RSVD;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_IRTE_RSVD, index);
+        }
+        return false;
     }
 
     if (sid != X86_IOMMU_SID_INVALID) {
@@ -3361,7 +3402,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
                 error_report_once("%s: invalid IRTE SID "
                                   "(index=%u, sid=%u, source_id=%u)",
                                   __func__, index, sid, source_id);
-                return -VTD_FR_IR_SID_ERR;
+                if (do_fault) {
+                    vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, index);
+                }
+                return false;
             }
             break;
 
@@ -3373,7 +3417,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
                 error_report_once("%s: invalid SVT_BUS "
                                   "(index=%u, bus=%u, min=%u, max=%u)",
                                   __func__, index, bus, bus_min, bus_max);
-                return -VTD_FR_IR_SID_ERR;
+                if (do_fault) {
+                    vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, index);
+                }
+                return false;
             }
             break;
 
@@ -3382,23 +3429,24 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
                               "(index=%u, type=%d)", __func__,
                               index, entry->irte.sid_vtype);
             /* Take this as verification failure. */
-            return -VTD_FR_IR_SID_ERR;
+            if (do_fault) {
+                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, index);
+            }
+            return false;
         }
     }
 
-    return 0;
+    return true;
 }
 
 /* Fetch IRQ information of specific IR index */
-static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
-                             X86IOMMUIrq *irq, uint16_t sid)
+static bool vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
+                              X86IOMMUIrq *irq, uint16_t sid, bool do_fault)
 {
     VTD_IR_TableEntry irte = {};
-    int ret = 0;
 
-    ret = vtd_irte_get(iommu, index, &irte, sid);
-    if (ret) {
-        return ret;
+    if (!vtd_irte_get(iommu, index, &irte, sid, do_fault)) {
+        return false;
     }
 
     irq->trigger_mode = irte.irte.trigger_mode;
@@ -3417,16 +3465,15 @@ static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
     trace_vtd_ir_remap(index, irq->trigger_mode, irq->vector,
                        irq->delivery_mode, irq->dest, irq->dest_mode);
 
-    return 0;
+    return true;
 }
 
 /* Interrupt remapping for MSI/MSI-X entry */
 static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
                                    MSIMessage *origin,
                                    MSIMessage *translated,
-                                   uint16_t sid)
+                                   uint16_t sid, bool do_fault)
 {
-    int ret = 0;
     VTD_IR_MSIAddress addr;
     uint16_t index;
     X86IOMMUIrq irq = {};
@@ -3443,14 +3490,20 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
     if (origin->address & VTD_MSI_ADDR_HI_MASK) {
         error_report_once("%s: MSI address high 32 bits non-zero detected: "
                           "address=0x%" PRIx64, __func__, origin->address);
-        return -VTD_FR_IR_REQ_RSVD;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
+        }
+        return -EINVAL;
     }
 
     addr.data = origin->address & VTD_MSI_ADDR_LO_MASK;
     if (addr.addr.__head != 0xfee) {
         error_report_once("%s: MSI address low 32 bit invalid: 0x%" PRIx32,
                           __func__, addr.data);
-        return -VTD_FR_IR_REQ_RSVD;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
+        }
+        return -EINVAL;
     }
 
     /* This is compatible mode. */
@@ -3469,9 +3522,8 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
         index += origin->data & VTD_IR_MSI_DATA_SUBHANDLE;
     }
 
-    ret = vtd_remap_irq_get(iommu, index, &irq, sid);
-    if (ret) {
-        return ret;
+    if (!vtd_remap_irq_get(iommu, index, &irq, sid, do_fault)) {
+        return -EINVAL;
     }
 
     if (addr.addr.sub_valid) {
@@ -3481,7 +3533,10 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
                               "(sid=%u, address=0x%" PRIx64
                               ", data=0x%" PRIx32 ")",
                               __func__, sid, origin->address, origin->data);
-            return -VTD_FR_IR_REQ_RSVD;
+            if (do_fault) {
+                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
+            }
+            return -EINVAL;
         }
     } else {
         uint8_t vector = origin->data & 0xff;
@@ -3521,7 +3576,7 @@ static int vtd_int_remap(X86IOMMUState *iommu, MSIMessage *src,
                          MSIMessage *dst, uint16_t sid)
 {
     return vtd_interrupt_remap_msi(INTEL_IOMMU_DEVICE(iommu),
-                                   src, dst, sid);
+                                   src, dst, sid, false);
 }
 
 static MemTxResult vtd_mem_ir_read(void *opaque, hwaddr addr,
@@ -3547,9 +3602,8 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
         sid = attrs.requester_id;
     }
 
-    ret = vtd_interrupt_remap_msi(opaque, &from, &to, sid);
+    ret = vtd_interrupt_remap_msi(opaque, &from, &to, sid, true);
     if (ret) {
-        /* TODO: report error */
         /* Drop this interrupt */
         return MEMTX_ERROR;
     }
-- 
MST


