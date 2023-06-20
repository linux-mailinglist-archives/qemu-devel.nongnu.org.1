Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C299A737556
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhJK-00016y-O5; Tue, 20 Jun 2023 15:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7Y-0004GZ-K2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:28 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7W-0006dZ-Sn
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:24 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b469507e4bso2424654a34.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281981; x=1689873981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K61wLAMvxduhXajLJmXKkCD2KgQmA24lyEh8ZOauW3g=;
 b=IX6OWGyMDuquswGxYoFJvDL0Ts6f749+YDHQGq/VK7v6MzucLGn3mJLNRgyBXD73nh
 I/uap9v+a/tpM5eiSkd2OkS0iQARyHW6tg8ULcTLPED98ouQUyuWH2UQR8ZlORK0Cr6B
 BDgLegkcEOk635hmIGl+Bwtfz5e1hT96JE/JDmGP0Bqw0e7cIkLr/RU266DuT5tbGceb
 zRUNYzhZb93MyWsSOjfGJeeGl5aBmP4hUNJ3PbRSOE6eRw3nAOQED29dYWIme6OHtNXm
 5ulmEwaOXRsnulp5JjUk1Y9/q/G60rjQqvx5duoVQR4CjtOtUdcENi3WHS3YKVj8zhvS
 WFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281981; x=1689873981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K61wLAMvxduhXajLJmXKkCD2KgQmA24lyEh8ZOauW3g=;
 b=VCv7PM82td01UqwRyH3VolCKukzA1edvQa1l2lz+5rZa86qCcoMVaVBuA2jkPV0W97
 gj6uJxLI2MrsmyDt0zFIv2v47y61+bVGOEFHkB5hQT/Acxzk+LvBXlq4A3nUF3SACOe/
 3AA0CRssTdaDynTX2HOZoqC4gh7OpGq7T6y68lZbd95cFVAcCBJu4jheRC5oScegYp1w
 kwibOeS62E4w6ENmfgxyk3j2QkmW8GhKoImrA/DktDkzm+KT4bLjtZg/QxJPtp+R9PMz
 y+1UdOP+nv2Lm/qmujmV2QPKrMoRr/16NiHIIgu0eOaqeQzU2v/Z9/WgZr/SZ9LgIwMw
 X8qA==
X-Gm-Message-State: AC+VfDwUoxZTALuVEdNuk05Ws/SC5xcE/5bOvBeg3USbqHpNQGA7kwoM
 896CA6fOLViwhV4TdEQZUBKSTPpgrf3R4Q==
X-Google-Smtp-Source: ACHHUZ5spqw7iFHqYn8GRj32Nl0UI37k62ovrhkdOFMHxlCYXYMjF7pxPN/co2hG4xEewZ4G5pFXTg==
X-Received: by 2002:a05:6358:1a84:b0:130:e675:3e8c with SMTP id
 gm4-20020a0563581a8400b00130e6753e8cmr4571923rwb.28.1687281981240; 
 Tue, 20 Jun 2023 10:26:21 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:20 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v1 13/23] xen/pt: add Vendor-specific PCIe Extended Capability
 descriptor and sizing
Date: Tue, 20 Jun 2023 13:24:47 -0400
Message-Id: <ead3c0639b91d0d0c12f91f3f1b4024547a9a0b4.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=jupham125@gmail.com; helo=mail-ot1-x335.google.com
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

The patch provides Vendor-specific PCIe Extended Capability description
structure and corresponding sizing function. In this particular case the
size of the Vendor capability is available in the VSEC Length field.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 71 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index ed36edbc4a..20b5561d25 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -124,6 +124,17 @@ static uint32_t get_throughable_mask(const XenPCIPassthroughState *s,
     return throughable_mask & valid_mask;
 }
 
+static void log_pcie_extended_cap(XenPCIPassthroughState *s,
+                                  const char *cap_name,
+                                  uint32_t base_offset, uint32_t size)
+{
+    if (size) {
+        XEN_PT_LOG(&s->dev, "Found PCIe Extended Capability: %s at 0x%04x, "
+                            "size 0x%x bytes\n", cap_name,
+                            (uint16_t) base_offset, size);
+    }
+}
+
 /****************
  * general register functions
  */
@@ -1622,6 +1633,42 @@ static XenPTRegInfo xen_pt_emu_reg_igd_opregion[] = {
     },
 };
 
+/* Vendor-specific Ext Capability Structure reg static information table */
+static XenPTRegInfo xen_pt_ext_cap_emu_reg_vendor[] = {
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
+        .offset     = PCI_VNDR_HEADER,
+        .size       = 4,
+        .init_val   = 0x00000000,
+        .ro_mask    = 0xFFFFFFFF,
+        .emu_mask   = 0x00000000,
+        .init       = xen_pt_common_reg_init,
+        .u.dw.read  = xen_pt_long_reg_read,
+        .u.dw.write = xen_pt_long_reg_write,
+    },
+    {
+        .size = 0,
+    },
+};
 /****************************
  * Capabilities
  */
@@ -1647,9 +1694,23 @@ static int xen_pt_vendor_size_init(XenPCIPassthroughState *s,
     return ret;
 }
 
+static int xen_pt_ext_cap_vendor_size_init(XenPCIPassthroughState *s,
+                                           const XenPTRegGroupInfo *grp_reg,
+                                           uint32_t base_offset,
+                                           uint32_t *size)
 {
-    return xen_host_pci_get_byte(&s->real_device, base_offset + 0x02, size);
+    uint32_t vsec_hdr = 0;
+    int ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + PCI_VNDR_HEADER,
+                                    &vsec_hdr);
+
+    *size = PCI_VNDR_HEADER_LEN(vsec_hdr);
+
+    log_pcie_extended_cap(s, "Vendor-specific", base_offset, *size);
+
+    return ret;
 }
+
 /* get PCI Express Capability Structure register group size */
 static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
                                  const XenPTRegGroupInfo *grp_reg,
@@ -1876,6 +1937,14 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init   = xen_pt_reg_grp_size_init,
         .emu_regs    = xen_pt_emu_reg_igd_opregion,
     },
+    /* Vendor-specific Extended Capability reg group */
+    {
+        .grp_id      = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_VNDR),
+        .grp_type    = XEN_PT_GRP_TYPE_EMU,
+        .grp_size    = 0xFF,
+        .size_init   = xen_pt_ext_cap_vendor_size_init,
+        .emu_regs    = xen_pt_ext_cap_emu_reg_vendor,
+    },
     {
         .grp_size = 0,
     },
-- 
2.34.1


