Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE2A761019
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOErX-00030D-3y; Tue, 25 Jul 2023 06:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b7341d96be85b1396a27+7275+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qOErU-000300-7j
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:01:48 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+b7341d96be85b1396a27+7275+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qOErQ-0002k1-TC
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:To:From:
 Subject:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Q1ulUnhDOYrxOIPX3fxqGu5hiA3sjbNsgvgs5paKRQQ=; b=cmfqgH4oqr+HCu6p2TMyYD+zLb
 dbs3Z5e9rS81cqu6WB74sDZk5RYTj+MD7iX/JiEfLngLHWOyAcdwlVxuOkR7WuqibhJizTZRaB2ix
 DAbBTLlFvSMLr3ib6D2yydTR4xAMG1/RHzlzjZ5FzOR/ghhfDXcXu1K0T3LHqumk/IP855E5aYLPC
 9l4Q5JlJRXzRZJr5cu6nH2euoE70Q6luvDwF3GJcABAvhBV7ghPvQm6cNL07qfiNzQ+V5O20RcpU1
 Zc1gfqsJmUNxi4tAlTObi4RhCPfG1D1vkIcoMetqL5xLjVDNr5k6aqui4j3244TPuBjvtX9uOSMbM
 l9aFYVFA==;
Received: from [2001:8b0:10b:1:7f07:4fc6:8b21:3b6b]
 (helo=u3832b3a9db3152.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qOEr0-005M0D-Uv; Tue, 25 Jul 2023 10:01:19 +0000
Message-ID: <d6e586699117542f9aeb3018cd5985834d727b44.camel@infradead.org>
Subject: intel-iommu: Report interrupt remapping faults, fix return value
From: David Woodhouse <dwmw2@infradead.org>
To: Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  qemu-devel
 <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 25 Jul 2023 11:01:16 +0100
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-Ls/W2zPC2lD49AzMfvzS"
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+b7341d96be85b1396a27+7275+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


--=-Ls/W2zPC2lD49AzMfvzS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
---
 hw/i386/intel_iommu.c          | 148 ++++++++++++++++++++++-----------
 hw/i386/intel_iommu_internal.h |   1 +
 2 files changed, 102 insertions(+), 47 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dcc334060c..a65a94a4ce 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -469,21 +469,12 @@ static void vtd_set_frcd_and_update_ppf(IntelIOMMUSta=
te *s, uint16_t index)
=20
 /* Must not update F field now, should be done later */
 static void vtd_record_frcd(IntelIOMMUState *s, uint16_t index,
-                            uint16_t source_id, hwaddr addr,
-                            VTDFaultReason fault, bool is_write,
-                            bool is_pasid, uint32_t pasid)
+                            uint64_t hi, uint64_t lo)
 {
-    uint64_t hi =3D 0, lo;
     hwaddr frcd_reg_addr =3D DMAR_FRCD_REG_OFFSET + (((uint64_t)index) << =
4);
=20
     assert(index < DMAR_FRCD_REG_NR);
=20
-    lo =3D VTD_FRCD_FI(addr);
-    hi =3D VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault) |
-         VTD_FRCD_PV(pasid) | VTD_FRCD_PP(is_pasid);
-    if (!is_write) {
-        hi |=3D VTD_FRCD_T;
-    }
     vtd_set_quad_raw(s, frcd_reg_addr, lo);
     vtd_set_quad_raw(s, frcd_reg_addr + 8, hi);
=20
@@ -509,17 +500,11 @@ static bool vtd_try_collapse_fault(IntelIOMMUState *s=
, uint16_t source_id)
 }
=20
 /* Log and report an DMAR (address translation) fault to software */
-static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
-                                  hwaddr addr, VTDFaultReason fault,
-                                  bool is_write, bool is_pasid,
-                                  uint32_t pasid)
+static void vtd_report_frcd_fault(IntelIOMMUState *s, uint64_t source_id,
+                                  uint64_t hi, uint64_t lo)
 {
     uint32_t fsts_reg =3D vtd_get_long_raw(s, DMAR_FSTS_REG);
=20
-    assert(fault < VTD_FR_MAX);
-
-    trace_vtd_dmar_fault(source_id, fault, addr, is_write);
-
     if (fsts_reg & VTD_FSTS_PFO) {
         error_report_once("New fault is not recorded due to "
                           "Primary Fault Overflow");
@@ -539,8 +524,7 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, u=
int16_t source_id,
         return;
     }
=20
-    vtd_record_frcd(s, s->next_frcd_reg, source_id, addr, fault,
-                    is_write, is_pasid, pasid);
+    vtd_record_frcd(s, s->next_frcd_reg, hi, lo);
=20
     if (fsts_reg & VTD_FSTS_PPF) {
         error_report_once("There are pending faults already, "
@@ -565,6 +549,40 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, =
uint16_t source_id,
     }
 }
=20
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
+    lo =3D VTD_FRCD_FI(addr);
+    hi =3D VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault) |
+         VTD_FRCD_PV(pasid) | VTD_FRCD_PP(is_pasid);
+    if (!is_write) {
+        hi |=3D VTD_FRCD_T;
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
+    lo =3D VTD_FRCD_IR_IDX(index);
+    hi =3D VTD_FRCD_SID(source_id) | VTD_FRCD_FR(fault);
+
+    vtd_report_frcd_fault(s, source_id, hi, lo);
+}
+
 /* Handle Invalidation Queue Errors of queued invalidation interface error
  * conditions.
  */
@@ -3300,8 +3318,9 @@ static Property vtd_properties[] =3D {
 };
=20
 /* Read IRTE entry with specific index */
-static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
-                        VTD_IR_TableEntry *entry, uint16_t sid)
+static bool vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
+                         VTD_IR_TableEntry *entry, uint16_t sid,
+                         bool do_fault)
 {
     static const uint16_t vtd_svt_mask[VTD_SQ_MAX] =3D \
         {0xffff, 0xfffb, 0xfff9, 0xfff8};
@@ -3312,7 +3331,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint=
16_t index,
     if (index >=3D iommu->intr_size) {
         error_report_once("%s: index too large: ind=3D0x%x",
                           __func__, index);
-        return -VTD_FR_IR_INDEX_OVER;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_INDEX_OVER, index);
+        }
+        return false;
     }
=20
     addr =3D iommu->intr_root + index * sizeof(*entry);
@@ -3320,17 +3342,33 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uin=
t16_t index,
                         entry, sizeof(*entry), MEMTXATTRS_UNSPECIFIED)) {
         error_report_once("%s: read failed: ind=3D0x%x addr=3D0x%" PRIx64,
                           __func__, index, addr);
-        return -VTD_FR_IR_ROOT_INVAL;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_ROOT_INVAL, index);
+        }
+        return false;
     }
=20
     trace_vtd_ir_irte_get(index, le64_to_cpu(entry->data[1]),
                           le64_to_cpu(entry->data[0]));
=20
+	/*
+	 * The remaining potential fault conditions are "qualified" by the
+	 * Fault Processing Disable bit in the IRTE. Even "not present".
+	 * So just clear the do_fault flag if PFD is set, which will
+	 * prevent faults being raised.
+	 */
+	if (entry->irte.fault_disable) {
+		do_fault =3D false;
+    }
+
     if (!entry->irte.present) {
         error_report_once("%s: detected non-present IRTE "
                           "(index=3D%u, high=3D0x%" PRIx64 ", low=3D0x%" P=
RIx64 ")",
                           __func__, index, le64_to_cpu(entry->data[1]),
                           le64_to_cpu(entry->data[0]));
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_ENTRY_P, index);
+        }
         return -VTD_FR_IR_ENTRY_P;
     }
=20
@@ -3340,7 +3378,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint=
16_t index,
                           "(index=3D%u, high=3D0x%" PRIx64 ", low=3D0x%" P=
RIx64 ")",
                           __func__, index, le64_to_cpu(entry->data[1]),
                           le64_to_cpu(entry->data[0]));
-        return -VTD_FR_IR_IRTE_RSVD;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_IRTE_RSVD, index);
+        }
+        return false;
     }
=20
     if (sid !=3D X86_IOMMU_SID_INVALID) {
@@ -3356,7 +3397,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint=
16_t index,
                 error_report_once("%s: invalid IRTE SID "
                                   "(index=3D%u, sid=3D%u, source_id=3D%u)"=
,
                                   __func__, index, sid, source_id);
-                return -VTD_FR_IR_SID_ERR;
+                if (do_fault) {
+                    vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, ind=
ex);
+                }
+                return false;
             }
             break;
=20
@@ -3368,7 +3412,10 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint=
16_t index,
                 error_report_once("%s: invalid SVT_BUS "
                                   "(index=3D%u, bus=3D%u, min=3D%u, max=3D=
%u)",
                                   __func__, index, bus, bus_min, bus_max);
-                return -VTD_FR_IR_SID_ERR;
+                if (do_fault) {
+                    vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, ind=
ex);
+                }
+                return false;
             }
             break;
=20
@@ -3377,23 +3424,24 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uin=
t16_t index,
                               "(index=3D%u, type=3D%d)", __func__,
                               index, entry->irte.sid_vtype);
             /* Take this as verification failure. */
-            return -VTD_FR_IR_SID_ERR;
+            if (do_fault) {
+                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_SID_ERR, index);
+            }
+            return false;
         }
     }
=20
-    return 0;
+    return true;
 }
=20
 /* Fetch IRQ information of specific IR index */
-static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
-                             X86IOMMUIrq *irq, uint16_t sid)
+static bool vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
+                              X86IOMMUIrq *irq, uint16_t sid, bool do_faul=
t)
 {
     VTD_IR_TableEntry irte =3D {};
-    int ret =3D 0;
=20
-    ret =3D vtd_irte_get(iommu, index, &irte, sid);
-    if (ret) {
-        return ret;
+    if (!vtd_irte_get(iommu, index, &irte, sid, do_fault)) {
+        return false;
     }
=20
     irq->trigger_mode =3D irte.irte.trigger_mode;
@@ -3412,16 +3460,15 @@ static int vtd_remap_irq_get(IntelIOMMUState *iommu=
, uint16_t index,
     trace_vtd_ir_remap(index, irq->trigger_mode, irq->vector,
                        irq->delivery_mode, irq->dest, irq->dest_mode);
=20
-    return 0;
+    return true;
 }
=20
 /* Interrupt remapping for MSI/MSI-X entry */
 static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
                                    MSIMessage *origin,
                                    MSIMessage *translated,
-                                   uint16_t sid)
+                                   uint16_t sid, bool do_fault)
 {
-    int ret =3D 0;
     VTD_IR_MSIAddress addr;
     uint16_t index;
     X86IOMMUIrq irq =3D {};
@@ -3438,14 +3485,20 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState =
*iommu,
     if (origin->address & VTD_MSI_ADDR_HI_MASK) {
         error_report_once("%s: MSI address high 32 bits non-zero detected:=
 "
                           "address=3D0x%" PRIx64, __func__, origin->addres=
s);
-        return -VTD_FR_IR_REQ_RSVD;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
+        }
+        return -EINVAL;
     }
=20
     addr.data =3D origin->address & VTD_MSI_ADDR_LO_MASK;
     if (addr.addr.__head !=3D 0xfee) {
         error_report_once("%s: MSI address low 32 bit invalid: 0x%" PRIx32=
,
                           __func__, addr.data);
-        return -VTD_FR_IR_REQ_RSVD;
+        if (do_fault) {
+            vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
+        }
+        return -EINVAL;
     }
=20
     /* This is compatible mode. */
@@ -3464,9 +3517,8 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *i=
ommu,
         index +=3D origin->data & VTD_IR_MSI_DATA_SUBHANDLE;
     }
=20
-    ret =3D vtd_remap_irq_get(iommu, index, &irq, sid);
-    if (ret) {
-        return ret;
+    if (!vtd_remap_irq_get(iommu, index, &irq, sid, do_fault)) {
+        return -EINVAL;
     }
=20
     if (addr.addr.sub_valid) {
@@ -3476,7 +3528,10 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *=
iommu,
                               "(sid=3D%u, address=3D0x%" PRIx64
                               ", data=3D0x%" PRIx32 ")",
                               __func__, sid, origin->address, origin->data=
);
-            return -VTD_FR_IR_REQ_RSVD;
+            if (do_fault) {
+                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_RSVD, 0);
+            }
+            return -EINVAL;
         }
     } else {
         uint8_t vector =3D origin->data & 0xff;
@@ -3516,7 +3571,7 @@ static int vtd_int_remap(X86IOMMUState *iommu, MSIMes=
sage *src,
                          MSIMessage *dst, uint16_t sid)
 {
     return vtd_interrupt_remap_msi(INTEL_IOMMU_DEVICE(iommu),
-                                   src, dst, sid);
+                                   src, dst, sid, false);
 }
=20
 static MemTxResult vtd_mem_ir_read(void *opaque, hwaddr addr,
@@ -3542,9 +3597,8 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwa=
ddr addr,
         sid =3D attrs.requester_id;
     }
=20
-    ret =3D vtd_interrupt_remap_msi(opaque, &from, &to, sid);
+    ret =3D vtd_interrupt_remap_msi(opaque, &from, &to, sid, true);
     if (ret) {
-        /* TODO: report error */
         /* Drop this interrupt */
         return MEMTX_ERROR;
     }
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 2e61eec2f5..eb8087a2cf 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -268,6 +268,7 @@
 #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
 #define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
+#define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
=20
 /* DMA Remapping Fault Conditions */
 typedef enum VTDFaultReason {
--=20
2.34.1



--=-Ls/W2zPC2lD49AzMfvzS
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwNzI1MTAwMTE2WjAvBgkqhkiG9w0BCQQxIgQg8+Lz4qWo
NKKLxhgi0qq2P/8PRku+WaIxhuX9HSJKRvEwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCofDRMY1nwcCtMOv9DOh+bHCXSulXHNYA+
t82OlY9EKF+AQGfrziBjR6Y1AP/GrD/nh4tYZzR9UvM7eNE36JAMw4XQa/IaFLT7F8Giaxj82s60
hua71oQqYOM/vRdWQrCP4DJ9VxlyfQAUiXhKUeKd7gG2ykVmbMK0YIndEprgzAXBxWPR77sV9FGR
lqIdCSvqyaIFMSjYJLRvy3g+5mLuutismj0U7Yl9hajkaeHmdb7z8njshPqYJzDl/00pO1qcmVG/
wH8pBKV8Upn1c7YvjnSSEqy02dxGM7TfuJcMwV5rzvP/9ZZuatCNiyqcxZ/yCgnmtSW/nlUPsHoU
qemzRblLxBhjnKGIDh4fHyjL/kgSqcHBlQmL10rbaM6fsocRkewGa8q24HO5jA/qqlXyjBUrZkb1
1oIjEv47LYTcATBPsJTTVaObhc25llYlzzB5gfCmYN9zqDvBpEpJ1TopA1h5efHKVTMc3ZsnOWcq
eovR4EK8kQyaxgNWdugXbQGatXGCjhTHgT7uk+dSMCHfOILG4cbAnDQa9iU+0mIvcfppoX4kQuk1
oKaJoERJtOrq7twJQZ9I1hProdvUwOKw0fsw5zawT27wc+wCa3NVkzP6NF8aN61vFa3HoR9gaanA
Nvy3RMYn1n1eR6fG0vPaVMRxXZ4Cc+tCp4wlyCLAMAAAAAAAAA==


--=-Ls/W2zPC2lD49AzMfvzS--

