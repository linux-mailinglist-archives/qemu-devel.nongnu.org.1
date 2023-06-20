Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A01F1737551
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIg-0008PL-4m; Tue, 20 Jun 2023 15:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7e-0004LE-SQ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:30 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7a-0006ed-9a
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:29 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-570114e1feaso57478897b3.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281983; x=1689873983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUH0LrDNCluOY2g7IZF9uazabmu57c7aIkRqhWuUoW4=;
 b=iwRwRTaFQJfYCfdFgHs5hBrVVJyyLJCQKXLzDjc2uw1+9/aIo5cnUv+/xiPHbxjuh2
 XFwA15wc+YNcwlq8WwcGhVyB1lz9VsRgzw4+XvIpPjE8ExRcuEvjNOBNE0RQ57VEEDNJ
 64EPpQNaQEYzxkQ3c/wV95dN8zfhpngMP2nU9OZ/liVkq+4MPfn3nPH+QPU4ginQEKvn
 U8V7lDKGEZ9gP08J4zgUGhm2JE9iozhSVNTDMielRBCFN0rxFigIZOc94CQIhyYeuQPR
 hxGZm6uHroeQ+mGmjc3xBa9l0n2oo9PXJfgI65Ux8poxJl/JDEtJvcHnMCpECNXdCZx2
 LiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281983; x=1689873983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUH0LrDNCluOY2g7IZF9uazabmu57c7aIkRqhWuUoW4=;
 b=ZcA1o5+VQ8Fbb4A6HxKprIPZI6gDc3lntVICV8NMDUsHPUGnHivLXqfvRO32Qhqd7G
 gDKpzvodYnTJD4WXWoKOEEBRuGkxMOlpEm6/4VXAP1nN7uUujkb8+XnRHhe7pjAwKj9H
 PBN+Ehk+aeGFbTaak4UBkZgIg8ZqCZW2o4Q6/3ziZaxN2ArdxdG9Akzrn6FF8p1YyxVi
 ny+vyEMWmp6dintmH3EbJbvZIw2JFdExqAuyjkNjFVJ+7ndy/FZHPRUzsffgLF9W+JSb
 z/K7AvfNe2bKtYW66IuXkhXR6Q4PGPsFrOIIOuNj1DkBQ5BipKjgK6jHaks74bCw/bUR
 zMZQ==
X-Gm-Message-State: AC+VfDwzsI0kWarnvg647Dbp+y6fUClNKKvcOiFTYzSmNnkiTh8XmwV6
 Uua9m0farDxXQQb9oTPvrv43ilPd1rp/yA==
X-Google-Smtp-Source: ACHHUZ7H14tCE3HKsTlD/gtaiOjoMH3zAfVEsd3ThHpqpefM/jk8OkdgqNWhx9f/7UfbiTzox58o8A==
X-Received: by 2002:a81:5215:0:b0:56c:e2c1:6695 with SMTP id
 g21-20020a815215000000b0056ce2c16695mr12352572ywb.50.1687281983595; 
 Tue, 20 Jun 2023 10:26:23 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:23 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 14/23] xen/pt: add fixed-size PCIe Extended Capabilities
 descriptors
Date: Tue, 20 Jun 2023 13:24:48 -0400
Message-Id: <ddd201fc1ee529a90861aabdf0479e8b1d382bf3.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x1133.google.com
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

This adds description structures for all fixed-size PCIe Extended
Capabilities.

For every capability register group, only 2 registers are emulated
currently: Capability ID (16 bit) and Next Capability Offset/Version (16
bit). Both needed to implement selective capability hiding. All other
registers are passed through at the moment (unless they belong to
a "hardwired" capability which is hidden)

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 183 ++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 20b5561d25..69d8857c66 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1669,6 +1669,37 @@ static XenPTRegInfo xen_pt_ext_cap_emu_reg_vendor[] = {
         .size = 0,
     },
 };
+
+/* Common reg static information table for all passthru-type
+ * PCIe Extended Capabilities. Only Extended Cap ID and
+ * Next pointer are handled (to support capability hiding).
+ */
+static XenPTRegInfo xen_pt_ext_cap_emu_reg_dummy[] = {
+    {
+        .offset     = XEN_PCIE_CAP_ID,
+        .size       = 2,
+        .init_val   = 0x0000,
+        .ro_mask    = 0xFFFF,
+        .emu_mask   = 0xFFFF,
+        .init       = xen_pt_ext_cap_capid_reg_init,
+        .u.w.read   = xen_pt_word_reg_read,
+        .u.w.write  = xen_pt_word_reg_write,
+    },
+    {
+        .offset     = XEN_PCIE_CAP_LIST_NEXT,
+        .size       = 2,
+        .init_val   = 0x0000,
+        .ro_mask    = 0xFFFF,
+        .emu_mask   = 0xFFFF,
+        .init       = xen_pt_ext_cap_ptr_reg_init,
+        .u.w.read   = xen_pt_word_reg_read,
+        .u.w.write  = xen_pt_word_reg_write,
+    },
+    {
+        .size = 0,
+    },
+};
+
 /****************************
  * Capabilities
  */
@@ -1945,6 +1976,158 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init   = xen_pt_ext_cap_vendor_size_init,
         .emu_regs    = xen_pt_ext_cap_emu_reg_vendor,
     },
+    /* Device Serial Number Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_DSN),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_DSN_SIZEOF,       /*0x0C*/
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Power Budgeting Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PWR),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_PWR_SIZEOF,       /*0x10*/
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Root Complex Internal Link Control Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_RCILC),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x0C,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Root Complex Event Collector Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_RCEC),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x08,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Root Complex Register Block Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_RCRB),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x14,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Configuration Access Correlation Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_CAC),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x08,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Alternate Routing ID Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_ARI),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_ARI_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Address Translation Services Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_ATS),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_ATS_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Single Root I/O Virtualization Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_SRIOV),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_SRIOV_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Page Request Interface Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PRI),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_PRI_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Latency Tolerance Reporting Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_LTR),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_LTR_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Secondary PCIe Capability Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_SECPCI),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x10,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Process Address Space ID Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PASID),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_PASID_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* L1 PM Substates Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_L1SS),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x10,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Precision Time Measurement Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PTM),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x0C,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* M-PCIe Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(0x20),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x1C,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* LN Requester (LNR) Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(0x1C),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x08,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Function Readiness Status (FRS) Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(0x21),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x10,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Readiness Time Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(0x22),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x0C,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
     {
         .grp_size = 0,
     },
-- 
2.34.1


