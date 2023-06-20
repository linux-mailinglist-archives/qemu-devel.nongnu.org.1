Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F9737543
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:47:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIc-0008M4-4J; Tue, 20 Jun 2023 15:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7X-0004Fj-G4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:24 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7T-0006bW-6L
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:23 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5704ddda6dfso56333047b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281975; x=1689873975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5oficzjs5xcBYSHcpYrMTcfh+AwyMWQx/k5j2kJ4DGo=;
 b=O2gmxwgPbbW0ycNLE6VtVZ2j4XzYDPo99Wh8EBMogWPXV+Kpoo9l2hXiGgJTL+3UWy
 AV3HvB2nSQNIdHMZ3w/fcuOS3koy85JWsyMEA7Yff+X+tkkHnwQAUrI+P7vHfcJew7Ug
 Xm/I3seDw2cBPzJ85DqXi1QSKXudjAHLntTZvTgkwyQs8QodwBBGFOhFsBa9wdc+0HRV
 HC+t05bwvGK34OqN7tNbN9nZ4fHb12xARVgPdXFx+ua4ql/xGu5zg7kk2qyn2rHk3n0l
 9IaX5IlOAWeqfzqzljQHBqfCYEO5CzgHpqTA/ZiuAQed4J4/mx+PjRPgfZHTOe0RL5mE
 DujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281975; x=1689873975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5oficzjs5xcBYSHcpYrMTcfh+AwyMWQx/k5j2kJ4DGo=;
 b=iXDz3MYxXIGDWJrxPosLs7EwFup8qSqyrYZmNorqEywdAVcJdPwh+2a51WHJt5U8v/
 zv5I6TAP7U1K3kZw9UndldgekSfrKoCgK1djh3X0acIOdTY/zbgVQ+k/FVeVIyrwOraN
 LviZma5NGtdDv6kqlBWXPes/ClXQgMiVXpEHCm3ru8utjR6/oC1wqO3Z5upE/0P+YRzt
 cgCNV2/oICQF3xT8hM5yRMNUeoMFjyR9yDWol74/VLbwQutFrKl7GJGiAYU/rYMZbyld
 0zm18+pdiJd5ORlzduxlnFtJa7Roxb4zJ95kccn++oiijQYwmLp/O/hB32ajBvVIQdFv
 qJyw==
X-Gm-Message-State: AC+VfDwZWlS92ejjozTjrjkwd+3s4a0X5aUQxuplTNGw3Xk1JIsxv5Yb
 TsQhJbrmssqnNAznnTPyBokhua4vDn1bXQ==
X-Google-Smtp-Source: ACHHUZ6XnSFKFEmZ4JRuuQ8RG5O/zfoeupAWUrMFLcGCPcnHuHkd+hGqCOhfxRag80J/Ukwvt5V6wQ==
X-Received: by 2002:a81:6ac6:0:b0:56d:ccf:19a9 with SMTP id
 f189-20020a816ac6000000b0056d0ccf19a9mr16316679ywc.34.1687281975343; 
 Tue, 20 Jun 2023 10:26:15 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:15 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 10/23] xen/pt: add support for PCIe Extended Capabilities
 and larger config space
Date: Tue, 20 Jun 2023 13:24:44 -0400
Message-Id: <775c2acb6ac819990e28d881167fcdfcd58b9886.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:55 -0400
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

This patch provides basic facilities for PCIe Extended Capabilities and
support for controlled (via s->pcie_enabled_dev flag) access to PCIe
config space (>256).

PCIe Extended Capabilities make use of 16-bit capability ID. Also,
a capability size might exceed 8-bit width. So as the very first step
we need to increase type size for grp_id, grp_size, etc -- they were
limited to 8-bit.

The only troublesome issue with PCIe Extended Capability IDs is that their
value range is actually same as for basic PCI capabilities.
Eg. capability ID 3 means VPD Capability for PCI and at the same time
Device Serial Number Capability for PCIe Extended caps. This adds a bit of
inconvenience.

In order to distinguish between two sets of same capability IDs, the patch
introduces a set of macros to mark a capability ID as PCIe Extended one
(or check if it is basic/extended + get a raw ID value):
- PCIE_EXT_CAP_ID(cap_id)
- IS_PCIE_EXT_CAP_ID(grp_id)
- GET_PCIE_EXT_CAP_ID(grp_id)

Here is how it's used:
    /* Intel IGD Opregion group */
    {
        .grp_id      = XEN_PCI_INTEL_OPREGION,  /* no change */
        .grp_type    = XEN_PT_GRP_TYPE_EMU,
        .grp_size    = 0x4,
        .size_init   = xen_pt_reg_grp_size_init,
        .emu_regs    = xen_pt_emu_reg_igd_opregion,
    },
    /* Vendor-specific Extended Capability reg group */
    {
        .grp_id      = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_VNDR),
        .grp_type    = XEN_PT_GRP_TYPE_EMU,
        .grp_size    = 0xFF,
        .size_init   = xen_pt_ext_cap_vendor_size_init,
        .emu_regs    = xen_pt_ext_cap_emu_reg_vendor,
    },
By using the PCIE_EXT_CAP_ID() macro it is possible to reuse existing
header files with already defined PCIe Extended Capability ID values.

find_cap_offset() receive capabily ID and checks if it's an Extended one
by using IS_PCIE_EXT_CAP_ID(cap) macro, passing the real capabiliy
ID value to either xen_host_pci_find_next_ext_cap
or xen_host_pci_find_next_cap.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/xen/xen_pt.c             | 10 ++++-
 hw/xen/xen_pt.h             | 13 ++++--
 hw/xen/xen_pt_config_init.c | 90 ++++++++++++++++++++++++++-----------
 3 files changed, 83 insertions(+), 30 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 65c5516ef4..f757978800 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -96,8 +96,16 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...)
 
 static int xen_pt_pci_config_access_check(PCIDevice *d, uint32_t addr, int len)
 {
+    XenPCIPassthroughState *s = XEN_PT_DEVICE(d);
     /* check offset range */
-    if (addr > 0xFF) {
+    if (s->pcie_enabled_dev) {
+        if (addr >= PCIE_CONFIG_SPACE_SIZE) {
+            XEN_PT_ERR(d, "Failed to access register with offset "
+                          "exceeding 0xFFF. (addr: 0x%02x, len: %d)\n",
+                          addr, len);
+            return -1;
+        }
+    } else if (addr >= PCI_CONFIG_SPACE_SIZE) {
         XEN_PT_ERR(d, "Failed to access register with offset exceeding 0xFF. "
                    "(addr: 0x%02x, len: %d)\n", addr, len);
         return -1;
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 1c9cd6b615..eb062be3f4 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -33,6 +33,11 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...) G_GNUC_PRINTF(2, 3);
 /* Helper */
 #define XEN_PFN(x) ((x) >> XC_PAGE_SHIFT)
 
+/* Macro's for PCIe Extended Capabilities */
+#define PCIE_EXT_CAP_ID(cap_id)     ((cap_id) | (1U << 16))
+#define IS_PCIE_EXT_CAP_ID(grp_id)  ((grp_id) & (1U << 16))
+#define GET_PCIE_EXT_CAP_ID(grp_id) ((grp_id) & 0xFFFF)
+
 typedef const struct XenPTRegInfo XenPTRegInfo;
 typedef struct XenPTReg XenPTReg;
 
@@ -174,13 +179,13 @@ typedef const struct XenPTRegGroupInfo XenPTRegGroupInfo;
 /* emul reg group size initialize method */
 typedef int (*xen_pt_reg_size_init_fn)
     (XenPCIPassthroughState *, XenPTRegGroupInfo *,
-     uint32_t base_offset, uint8_t *size);
+     uint32_t base_offset, uint32_t *size);
 
 /* emulated register group information */
 struct XenPTRegGroupInfo {
-    uint8_t grp_id;
+    uint32_t grp_id;
     XenPTRegisterGroupType grp_type;
-    uint8_t grp_size;
+    uint32_t grp_size;
     xen_pt_reg_size_init_fn size_init;
     XenPTRegInfo *emu_regs;
 };
@@ -190,7 +195,7 @@ typedef struct XenPTRegGroup {
     QLIST_ENTRY(XenPTRegGroup) entries;
     XenPTRegGroupInfo *reg_grp;
     uint32_t base_offset;
-    uint8_t size;
+    uint32_t size;
     QLIST_HEAD(, XenPTReg) reg_tbl_list;
 } XenPTRegGroup;
 
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 757a035aad..34ed9c25c5 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -32,28 +32,40 @@ static int xen_pt_ptr_reg_init(XenPCIPassthroughState *s, XenPTRegInfo *reg,
 /* helper */
 
 /* A return value of 1 means the capability should NOT be exposed to guest. */
-static int xen_pt_hide_dev_cap(const XenHostPCIDevice *d, uint8_t grp_id)
+static int xen_pt_hide_dev_cap(const XenHostPCIDevice *d, uint32_t grp_id)
 {
-    switch (grp_id) {
-    case PCI_CAP_ID_EXP:
-        /* The PCI Express Capability Structure of the VF of Intel 82599 10GbE
-         * Controller looks trivial, e.g., the PCI Express Capabilities
-         * Register is 0. We should not try to expose it to guest.
-         *
-         * The datasheet is available at
-         * http://download.intel.com/design/network/datashts/82599_datasheet.pdf
-         *
-         * See 'Table 9.7. VF PCIe Configuration Space' of the datasheet, the
-         * PCI Express Capability Structure of the VF of Intel 82599 10GbE
-         * Controller looks trivial, e.g., the PCI Express Capabilities
-         * Register is 0, so the Capability Version is 0 and
-         * xen_pt_pcie_size_init() would fail.
-         */
-        if (d->vendor_id == PCI_VENDOR_ID_INTEL &&
-            d->device_id == PCI_DEVICE_ID_INTEL_82599_SFP_VF) {
-            return 1;
+    if (IS_PCIE_EXT_CAP_ID(grp_id)) {
+        switch (GET_PCIE_EXT_CAP_ID(grp_id)) {
+            /* Here can be added device-specific filtering
+             * for PCIe Extended capabilities (those with offset >= 0x100).
+             * This is simply a placeholder as no filtering needed for now.
+             */
+        default:
+            break;
+        }
+    } else {
+        /* basic PCI capability */
+        switch (grp_id) {
+        case PCI_CAP_ID_EXP:
+            /* The PCI Express Capability Structure of the VF of Intel 82599 10GbE
+             * Controller looks trivial, e.g., the PCI Express Capabilities
+             * Register is 0. We should not try to expose it to guest.
+             *
+             * The datasheet is available at
+             * http://download.intel.com/design/network/datashts/82599_datasheet.pdf
+             *
+             * See 'Table 9.7. VF PCIe Configuration Space' of the datasheet, the
+             * PCI Express Capability Structure of the VF of Intel 82599 10GbE
+             * Controller looks trivial, e.g., the PCI Express Capabilities
+             * Register is 0, so the Capability Version is 0 and
+             * xen_pt_pcie_size_init() would fail.
+             */
+            if (d->vendor_id == PCI_VENDOR_ID_INTEL &&
+                d->device_id == PCI_DEVICE_ID_INTEL_82599_SFP_VF) {
+                return 1;
+            }
+            break;
         }
-        break;
     }
     return 0;
 }
@@ -1615,7 +1627,7 @@ static XenPTRegInfo xen_pt_emu_reg_igd_opregion[] = {
 
 static int xen_pt_reg_grp_size_init(XenPCIPassthroughState *s,
                                     const XenPTRegGroupInfo *grp_reg,
-                                    uint32_t base_offset, uint8_t *size)
+                                    uint32_t base_offset, uint32_t *size)
 {
     *size = grp_reg->grp_size;
     return 0;
@@ -1623,14 +1635,22 @@ static int xen_pt_reg_grp_size_init(XenPCIPassthroughState *s,
 /* get Vendor Specific Capability Structure register group size */
 static int xen_pt_vendor_size_init(XenPCIPassthroughState *s,
                                    const XenPTRegGroupInfo *grp_reg,
-                                   uint32_t base_offset, uint8_t *size)
+                                   uint32_t base_offset, uint32_t *size)
+{
+    uint8_t sz = 0;
+    int ret = xen_host_pci_get_byte(&s->real_device, base_offset + 0x02, &sz);
+
+    *size = sz;
+    return ret;
+}
+
 {
     return xen_host_pci_get_byte(&s->real_device, base_offset + 0x02, size);
 }
 /* get PCI Express Capability Structure register group size */
 static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
                                  const XenPTRegGroupInfo *grp_reg,
-                                 uint32_t base_offset, uint8_t *size)
+                                 uint32_t base_offset, uint32_t *size)
 {
     PCIDevice *d = PCI_DEVICE(s);
     uint8_t version = get_pcie_capability_version(s);
@@ -1702,7 +1722,7 @@ static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
 /* get MSI Capability Structure register group size */
 static int xen_pt_msi_size_init(XenPCIPassthroughState *s,
                                 const XenPTRegGroupInfo *grp_reg,
-                                uint32_t base_offset, uint8_t *size)
+                                uint32_t base_offset, uint32_t *size)
 {
     uint16_t msg_ctrl = 0;
     uint8_t msi_size = 0xa;
@@ -1730,7 +1750,7 @@ static int xen_pt_msi_size_init(XenPCIPassthroughState *s,
 /* get MSI-X Capability Structure register group size */
 static int xen_pt_msix_size_init(XenPCIPassthroughState *s,
                                  const XenPTRegGroupInfo *grp_reg,
-                                 uint32_t base_offset, uint8_t *size)
+                                 uint32_t base_offset, uint32_t *size)
 {
     int rc = 0;
 
@@ -1953,6 +1973,26 @@ static uint8_t find_cap_offset(XenPCIPassthroughState *s, uint8_t cap)
     return 0;
 }
 
+/*************
+ * Main
+ */
+
+static uint32_t find_cap_offset(XenPCIPassthroughState *s, uint32_t cap)
+{
+    uint32_t retval = 0;
+
+    if (IS_PCIE_EXT_CAP_ID(cap)) {
+        if (s->pcie_enabled_dev) {
+            retval = xen_host_pci_find_next_ext_cap(&s->real_device, 0,
+                                                    GET_PCIE_EXT_CAP_ID(cap));
+        }
+
+    } else {
+        retval = xen_host_pci_find_next_cap(&s->real_device, 0, cap);
+    }
+    return retval;
+}
+
 static void xen_pt_config_reg_init(XenPCIPassthroughState *s,
                                    XenPTRegGroup *reg_grp, XenPTRegInfo *reg,
                                    Error **errp)
-- 
2.34.1


