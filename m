Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0054273755B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIo-0000B5-67; Tue, 20 Jun 2023 15:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7e-0004LD-Rw
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:30 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7a-0006ex-Qd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:28 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5707b429540so62318677b3.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281985; x=1689873985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZtR49Wj+BsujqlKtwlIvLXrUvLyGZ/7NrGzguEb9A0=;
 b=rxOo0tXcKfS1IYKEXuRJnHwkAChp/cBkhBvjJfVCWGOzcsHGlCZ6l3tNOl0XO8izkf
 9Ua5For1WY8+nDPZPjKubfsBDBU/BzDNa6nmgGSAIshSBmPHoYrQPtjQl0y1Xheg+pE8
 mM18gyjsk2UTfcWTS2tbtC/0QL/fxAXqEYd0vMsCcXesrSzdEw4xpnL1uHCir3pVNz7k
 fO0iYsRcdwiWniF2hmpqKPZiwJcE4Ct8XbLtn4XH9Vidk+E4PIB7BHmUoGSLo1GRK+Pl
 BVW1BZbGXKhPuDybfQm9FQoZV3aTssCTg85XrL/1IVvdxnV3aGq8D/bcziQJXFRksMgz
 9cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281985; x=1689873985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ZtR49Wj+BsujqlKtwlIvLXrUvLyGZ/7NrGzguEb9A0=;
 b=MlU21hZ/PWijusFAETE24uB6f86+SulslnvRTMspUAzJkv7yMcpz9rG56oqLo3WKb7
 ygfNyf6KMH/XwR9ZJd+P7WIB0U6nNMX0/HftQvrZQQMPOmTewP8e58kgK1lFx3sTOYoQ
 J3fYj2Swpa6zK5SdAMfkENS+Tgvgv+eOL5Ezj8ElQhTbyYwy3/VWxBTHiP979xUFr/9G
 5yGSoguukxcpdr0UEW9QQvRzDFAbuCPwlJXJdtNh4N85v5CS+cM3qSfutLoxJx3no03v
 Q75mp4KrnN+cZEhknida+cH6X5kHsWwmO2yyZ+/qMzKch+YoZ3NASG2ER+zmHjjMWQSU
 8GTA==
X-Gm-Message-State: AC+VfDyA7JdHzsFUS+VbEYQM5XDEQ5kbRCQPaNq8n5yXnPsvSsAbIj6B
 7jUJ6T/hV6L3wTb3p1Cywjw7I2u157upKA==
X-Google-Smtp-Source: ACHHUZ7vnof2FXuOFDNyhaBtlcGPG7xrWzUFudElGDOK5WYidGkK2Dmf/59suWaFDE/d1Yxi9aEXng==
X-Received: by 2002:a0d:cbcb:0:b0:56c:e5a3:3e09 with SMTP id
 n194-20020a0dcbcb000000b0056ce5a33e09mr21057302ywd.15.1687281985609; 
 Tue, 20 Jun 2023 10:26:25 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:25 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 15/23] xen/pt: add AER PCIe Extended Capability descriptor
 and sizing
Date: Tue, 20 Jun 2023 13:24:49 -0400
Message-Id: <adf11b407bbb7c8fd2815559329b7a3d4e5b0f1e.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:54 -0400
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

The patch provides Advanced Error Reporting PCIe Extended Capability
description structure and corresponding capability sizing function.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 69d8857c66..9fd0531bc4 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1861,6 +1861,70 @@ static int xen_pt_msix_size_init(XenPCIPassthroughState *s,
 }
 
 
+/* get Advanced Error Reporting Extended Capability register group size */
+#define PCI_ERR_CAP_TLP_PREFIX_LOG      (1U << 11)
+#define PCI_DEVCAP2_END_END_TLP_PREFIX  (1U << 21)
+static int xen_pt_ext_cap_aer_size_init(XenPCIPassthroughState *s,
+                                        const XenPTRegGroupInfo *grp_reg,
+                                        uint32_t base_offset,
+                                        uint32_t *size)
+{
+    uint8_t dev_type = get_pcie_device_type(s);
+    uint32_t aer_caps = 0;
+    uint32_t sz = 0;
+    int pcie_cap_pos;
+    uint32_t devcaps2;
+    int ret = 0;
+
+    pcie_cap_pos = xen_host_pci_find_next_cap(&s->real_device, 0,
+                                              PCI_CAP_ID_EXP);
+    if (!pcie_cap_pos) {
+        XEN_PT_ERR(&s->dev,
+                   "Cannot find a required PCI Express Capability\n");
+        return -1;
+    }
+
+    if (get_pcie_capability_version(s) > 1) {
+        ret = xen_host_pci_get_long(&s->real_device,
+                                    pcie_cap_pos + PCI_EXP_DEVCAP2,
+                                    &devcaps2);
+        if (ret) {
+            XEN_PT_ERR(&s->dev, "Error while reading Device "
+                       "Capabilities 2 Register \n");
+            return -1;
+        }
+    }
+
+    if (devcaps2 & PCI_DEVCAP2_END_END_TLP_PREFIX) {
+        ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + PCI_ERR_CAP,
+                                    &aer_caps);
+        if (ret) {
+            XEN_PT_ERR(&s->dev,
+                       "Error while reading AER Extended Capability\n");
+            return -1;
+        }
+
+        if (aer_caps & PCI_ERR_CAP_TLP_PREFIX_LOG) {
+            sz = 0x48;
+        }
+    }
+
+    if (!sz) {
+        if (dev_type == PCI_EXP_TYPE_ROOT_PORT ||
+            dev_type == PCI_EXP_TYPE_RC_EC) {
+            sz = 0x38;
+        } else {
+            sz = 0x2C;
+        }
+    }
+
+    *size = sz;
+
+    log_pcie_extended_cap(s, "AER", base_offset, *size);
+    return ret;
+}
+
 static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
     /* Header Type0 reg group */
     {
@@ -2128,6 +2192,14 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init  = xen_pt_reg_grp_size_init,
         .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
     },
+    /* Advanced Error Reporting Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_ERR),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_aer_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
     {
         .grp_size = 0,
     },
-- 
2.34.1


