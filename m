Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 196817D0195
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXiO-0002td-Q0; Thu, 19 Oct 2023 14:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhR-0000nN-I7
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhP-0003QI-0U
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q7yLJhsKzBOqiWUrJA7Var67GrcuSuwHsIVThsjTdeY=;
 b=CPvXF5kYyaDctpmvDrXGwCPpJ/cLizg5SdVEAcBzaP12r85to0j85cTp9yku83TMG4pZxq
 qrHK2HXTxzhQiFitFXZsEFSFEWe78JXADYjK36cp4BVbdtdzHzTsHzkpbj7PKmPyMCWgVt
 UPmsmFFHwV9ENIw6zPc1Nsrap8J7HBo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-cy24Se2xPMmOuK3FlwJ6GA-1; Thu, 19 Oct 2023 14:24:44 -0400
X-MC-Unique: cy24Se2xPMmOuK3FlwJ6GA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5079fd97838so6257163e87.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739883; x=1698344683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7yLJhsKzBOqiWUrJA7Var67GrcuSuwHsIVThsjTdeY=;
 b=MO+DLxAsAZk+FXZU51j1eaLccExYF2mx3zfKepdWiFajMckpBfKi3Ji1SxE3mh1ND5
 o8DcXHLLjWCNwm0if2YU3b+OxePZWv+2S5BAZIhixYUc62MJrh5aKSqoznZXVHk13ueU
 ClMm887USqRu2tyosRINzRCTkiBpi1kJgrHcrrxP/9B24lIM0DesKPSaeP8fM13bol0x
 zTNiCKPOWUPHoYdWgn2Ig6fBCfJiCGSPS0oX6HcnEM+eEBEEa8tsZHdLbM2Pe7DlomNx
 1w31NFyr4CePor5TMdmEqjhBHt5aCX2wBlc7AkRDDLmuIZKPIlF0Q3FnWbxSSFpdYRiy
 XWPQ==
X-Gm-Message-State: AOJu0YzRAYywhOu5AUnhGu7NbXYHMS7bar/g/o1ero/IKhZLgBh+hq9D
 Tk3H1VxcIYicKNXmC1hY1ABQz4eksTuQghqNQFiySu7l/Wv8v1UnVEAr9Lue/zM+DZWCXwzsxh9
 711W3Y3H2guj5nXKFs5u/OyTOKvJ53dz6NCFiV69nrTN7ptTjLrLDRQqDe1Ly1EuD/3C1
X-Received: by 2002:a05:6512:147:b0:503:3816:c42c with SMTP id
 m7-20020a056512014700b005033816c42cmr1879573lfo.41.1697739882855; 
 Thu, 19 Oct 2023 11:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4n2iVyZR7hQkTy7jVlIcCTCnf9Ijvfnz1+J+y01Hfm4V/mJ3YmLzRF7/+/1Et+43hFiTwpA==
X-Received: by 2002:a05:6512:147:b0:503:3816:c42c with SMTP id
 m7-20020a056512014700b005033816c42cmr1879552lfo.41.1697739882413; 
 Thu, 19 Oct 2023 11:24:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b003fee6e170f9sm189579wms.45.2023.10.19.11.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:41 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 78/78] intel-iommu: Report interrupt remapping faults, fix
 return value
Message-ID: <16ef005ba922d5af498e9f0f2ee6b29a318821a8.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


