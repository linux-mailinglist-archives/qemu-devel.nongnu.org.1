Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF187C6DE1
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqufL-0003NA-IH; Thu, 12 Oct 2023 08:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqufG-0003Mh-On
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:43 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqufE-0001rS-Si
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:42 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so182405066b.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697113179; x=1697717979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YRr81WGc0jZpkwI738+aZ2Qnn+FlQH2u0zMxI+6iKE=;
 b=NlTVkg3M3GloTpmwFOjkDsXaLybBvajTFNjwiZD4DONPGoXn2JkqeZgpYFmYe3UtZH
 t7YQOEBpcRIW4Iy3rtUl8PVIRLq3eJhlAHgqlNS2J8DG2X5OYcpwMs+/cEtMv+oR6c9u
 PvGcKgDgyEtCVezQTiXMsDDayK5yY8AFLDLGIraSb8E7aSVXFUy+uKQHQ+8sC+xcbeEq
 nZrSL1aUWka8zzawWkPFYdz949i5JlZ7VL3FAk/5d57ZKHNgh+M8PighQ1XN4jLVRT1F
 ueyuuJvdQFiClobFeqy1cQUcmdCNMGktC/X9kfHrLimwa1WRRrnL4uDahKRIk8pi3DaZ
 bAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113179; x=1697717979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YRr81WGc0jZpkwI738+aZ2Qnn+FlQH2u0zMxI+6iKE=;
 b=kav/yydstTuZH+01UQ/LKirJyBjPejxw7IlWnWnkcx4ogNyoLym10zfDVmPcZ/EEvA
 zVwLOs/LXOtuS2+BKbYj7RvsfFYzjOQmqJXbuRSAsrsBIX6dZz5N6ozp9A5uINk6/wt1
 V3KrBl6o4raOl4oife0xu7SyxnfrvhC8Wm2xJ0ru6bVo1fh310aMhcpC9W8Qm/HgrOjI
 lpMGEZzrOaF2aQffzGJfUy1JM+x7GJlYnZCqXTnpQ5ldodOEWEubVT9O6u2ZT+8F90DK
 xymTvp+wseBSdtLsvJlr1gYQtL3ZoxF+ONbcK2IW19QhEn+iDbJAheATCz6NGTmKnXAS
 hurg==
X-Gm-Message-State: AOJu0YzMByEmqQSpHJxv2P1lJovzv7kOxQlbdMJBJ6WMy2P8T5csIq8P
 VM1FtGnqycfvIytqQNgsPLDIIWwC/AMs93YS1J4WRw==
X-Google-Smtp-Source: AGHT+IGJGc+4EQWfaQL9qmpVIedGcbWZL4J3ku6So8X+uM+RzQqGGbtw2/SjfeoG7NRogKs/g5RQuw==
X-Received: by 2002:a17:907:7b84:b0:9a5:dc2b:6a5 with SMTP id
 ne4-20020a1709077b8400b009a5dc2b06a5mr15849000ejc.35.1697113179303; 
 Thu, 12 Oct 2023 05:19:39 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-232.abo.bbox.fr. [176.131.211.232])
 by smtp.gmail.com with ESMTPSA id
 gh18-20020a170906e09200b009786c8249d6sm11146880ejb.175.2023.10.12.05.19.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Oct 2023 05:19:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] hw/pci-host/designware: Move viewports from root func to
 host bridge
Date: Thu, 12 Oct 2023 14:18:54 +0200
Message-ID: <20231012121857.31873-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012121857.31873-1-philmd@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

As mentioned in previous commit, the PCI root function is
irrelevant for the ViewPorts. Move the fields to the host
bridge state.

This is a migration compatibility break for the machines
using the i.MX7 SoC (currently the mcimx7d-sabre machine).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci-host/designware.h | 13 ++++-----
 hw/pci-host/designware.c         | 47 ++++++++++++++++----------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index e1952ad324..702777ab17 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -63,13 +63,6 @@ typedef struct DesignwarePCIEMSI {
 struct DesignwarePCIERoot {
     PCIBridge parent_obj;
 
-    uint32_t atu_viewport;
-
-#define DESIGNWARE_PCIE_VIEWPORT_OUTBOUND    0
-#define DESIGNWARE_PCIE_VIEWPORT_INBOUND     1
-#define DESIGNWARE_PCIE_NUM_VIEWPORTS        4
-
-    DesignwarePCIEViewport viewports[2][DESIGNWARE_PCIE_NUM_VIEWPORTS];
     DesignwarePCIEMSI msi;
     DesignwarePCIEHost *host;
 };
@@ -79,6 +72,12 @@ struct DesignwarePCIEHost {
 
     DesignwarePCIERoot root;
 
+    uint32_t atu_viewport;
+#define DESIGNWARE_PCIE_VIEWPORT_OUTBOUND    0
+#define DESIGNWARE_PCIE_VIEWPORT_INBOUND     1
+#define DESIGNWARE_PCIE_NUM_VIEWPORTS        4
+    DesignwarePCIEViewport viewports[2][DESIGNWARE_PCIE_NUM_VIEWPORTS];
+
     struct {
         AddressSpace address_space;
         MemoryRegion address_space_root;
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index d12a36b628..2ef17137e2 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -109,20 +109,21 @@ static void designware_pcie_root_update_msi_mapping(DesignwarePCIERoot *root)
 }
 
 static DesignwarePCIEViewport *
-designware_pcie_root_get_current_viewport(DesignwarePCIERoot *root)
+designware_pcie_host_get_current_viewport(DesignwarePCIEHost *host)
 {
-    const unsigned int idx = root->atu_viewport & 0xF;
+    const unsigned int idx = host->atu_viewport & 0xF;
     const unsigned int dir =
-        !!(root->atu_viewport & DESIGNWARE_PCIE_ATU_REGION_INBOUND);
-    return &root->viewports[dir][idx];
+        !!(host->atu_viewport & DESIGNWARE_PCIE_ATU_REGION_INBOUND);
+    return &host->viewports[dir][idx];
 }
 
 static uint32_t
 designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(d);
+    DesignwarePCIEHost *host = root->host;
     DesignwarePCIEViewport *viewport =
-        designware_pcie_root_get_current_viewport(root);
+        designware_pcie_host_get_current_viewport(host);
 
     uint32_t val;
 
@@ -170,7 +171,7 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
         break;
 
     case DESIGNWARE_PCIE_ATU_VIEWPORT:
-        val = root->atu_viewport;
+        val = host->atu_viewport;
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_BASE:
@@ -294,7 +295,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(d);
     DesignwarePCIEHost *host = root->host;
     DesignwarePCIEViewport *viewport =
-        designware_pcie_root_get_current_viewport(root);
+        designware_pcie_host_get_current_viewport(host);
 
     switch (address) {
     case DESIGNWARE_PCIE_PORT_LINK_CONTROL:
@@ -332,7 +333,7 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         break;
 
     case DESIGNWARE_PCIE_ATU_VIEWPORT:
-        root->atu_viewport = val;
+        host->atu_viewport = val;
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_BASE:
@@ -420,7 +421,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         const char *direction;
         char *name;
 
-        viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
+        viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
         viewport->inbound = true;
         viewport->base    = 0x0000000000000000ULL;
         viewport->target  = 0x0000000000000000ULL;
@@ -443,7 +444,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         memory_region_set_enabled(mem, false);
         g_free(name);
 
-        viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
+        viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
         viewport->host    = host;
         viewport->inbound = false;
         viewport->base    = 0x0000000000000000ULL;
@@ -490,7 +491,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
      * NOTE: This will not work correctly for the case when first
      * configured inbound window is window 0
      */
-    viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
+    viewport = &host->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
     viewport->cr[1] = DESIGNWARE_PCIE_ATU_ENABLE;
     designware_pcie_update_viewport(root, viewport);
 
@@ -563,18 +564,10 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
 
 static const VMStateDescription vmstate_designware_pcie_root = {
     .name = "designware-pcie-root",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
-        VMSTATE_UINT32(atu_viewport, DesignwarePCIERoot),
-        VMSTATE_STRUCT_2DARRAY(viewports,
-                               DesignwarePCIERoot,
-                               2,
-                               DESIGNWARE_PCIE_NUM_VIEWPORTS,
-                               1,
-                               vmstate_designware_pcie_viewport,
-                               DesignwarePCIEViewport),
         VMSTATE_STRUCT(msi,
                        DesignwarePCIERoot,
                        1,
@@ -711,14 +704,22 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_designware_pcie_host = {
     .name = "designware-pcie-host",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_STRUCT(root,
                        DesignwarePCIEHost,
                        1,
                        vmstate_designware_pcie_root,
                        DesignwarePCIERoot),
+        VMSTATE_UINT32(atu_viewport, DesignwarePCIEHost),
+        VMSTATE_STRUCT_2DARRAY(viewports,
+                               DesignwarePCIEHost,
+                               2,
+                               DESIGNWARE_PCIE_NUM_VIEWPORTS,
+                               1,
+                               vmstate_designware_pcie_viewport,
+                               DesignwarePCIEViewport),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.41.0


