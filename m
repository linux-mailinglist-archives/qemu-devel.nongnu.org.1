Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 513387C6DE5
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 14:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqufC-0003Lj-NW; Thu, 12 Oct 2023 08:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqufA-0003JR-DT
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:36 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qquf8-0001qf-PL
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 08:19:36 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b98a699f45so140132066b.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 05:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697113173; x=1697717973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+a0EyKEUxgm0lXUaYS7q8xxVvw9rO8rB+Ai3q4Lewo=;
 b=HRYzUdjuIzzshSApbyr6p80clJeH0G2TR9aLDH244d7GvCcTIH+nk1AKjkmuo7BXXT
 d/koBRIC3dMcx1KT6P0ECDXYd5S4aL1qcumb82bilXZj/QDhs454npNQKSeG2N/GYm8T
 aRm3AswaN2pYN2LFzUM2+vYOdYC7Hb1+BQO6oz9FjS9Mjfa3j0tEEIYw69r3FJx/zQwm
 j+XIUTzKGSEdrpx14brh9WYymhdCPcT6rg37hG4/LWPSvouzX2VfPMfkeyRSbiihJizg
 Gj6vTP1F3fW8ku7QB4s1aiOuGeyaUOG1F8I1C5sMA1xDvLnb7yklt5eWr5+gDRnLtbrF
 itGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697113173; x=1697717973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+a0EyKEUxgm0lXUaYS7q8xxVvw9rO8rB+Ai3q4Lewo=;
 b=iXaATBjjco0W7Qt9f3SJZgoOBn7eSCDaTUadfY0kFw2yrlC7XcdffZYKZskUbT25GW
 PZK69UuaLoKsON5xUsxOR+OKZT+F0hbSMtKnef+PuRCfuIC2K2+z5cw/h4dbR8gUw/B+
 uTQbRzrMyUZ4cAjmXD0anJYVCfRtMKK3LRGvBCZ1ccnVYWPQEqQ3lf+aIjSB6twR1IbQ
 HS1wS3Umfe8mEKq5W3aqs72+/DHZ1zeE+oOFJ23vIO9niLp54JBxPkbLir27mTo0131h
 Utz29T1vR/EkioPuBCbouIVE4fc63Q5vF8F66jZhfLRbWS0tvIXZzIEbfS7FL318oJey
 ShDQ==
X-Gm-Message-State: AOJu0YxvsEtx3j/0btN+/5R26hOt2x3iHTpytljjFbY+MNhxcb7WFq94
 yM+oNhaaoMzmVRpGhF1ezR8iVZZAOyWqbs0YPX0qHA==
X-Google-Smtp-Source: AGHT+IF8Ty1Ofc3y4oS4MyLfM3KP0DdcxO3I6XSWDaHoOKSIH9fmBD+D3NCO5YaX3Y19CVr9n65SyQ==
X-Received: by 2002:a17:906:ef90:b0:9ae:673a:88b9 with SMTP id
 ze16-20020a170906ef9000b009ae673a88b9mr20120482ejb.22.1697113172897; 
 Thu, 12 Oct 2023 05:19:32 -0700 (PDT)
Received: from m1x-phil.lan (176-131-211-232.abo.bbox.fr. [176.131.211.232])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170906190600b009ad89697c86sm11081226eje.144.2023.10.12.05.19.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Oct 2023 05:19:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] hw/pci-host/designware: Keep host reference in
 DesignwarePCIEViewport
Date: Thu, 12 Oct 2023 14:18:53 +0200
Message-ID: <20231012121857.31873-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012121857.31873-1-philmd@linaro.org>
References: <20231012121857.31873-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

The PCI root function is irrelevant for the ViewPort; only
a reference to the host bridge is required. Since we can
directly access the PCI bus, remove the pci_get_bus() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci-host/designware.h | 2 +-
 hw/pci-host/designware.c         | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index 9e2caa04e9..e1952ad324 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -32,7 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIEHost, DESIGNWARE_PCIE_HOST)
 OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIERoot, DESIGNWARE_PCIE_ROOT)
 
 typedef struct DesignwarePCIEViewport {
-    DesignwarePCIERoot *root;
+    DesignwarePCIEHost *host;
 
     MemoryRegion cfg;
     MemoryRegion mem;
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index fb46493a05..d12a36b628 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -211,12 +211,11 @@ static uint64_t designware_pcie_root_data_access(void *opaque, hwaddr addr,
                                                  uint64_t *val, unsigned len)
 {
     DesignwarePCIEViewport *viewport = opaque;
-    DesignwarePCIERoot *root = viewport->root;
+    PCIHostState *pci = PCI_HOST_BRIDGE(viewport->host);
 
     const uint8_t busnum = DESIGNWARE_PCIE_ATU_BUS(viewport->target);
     const uint8_t devfn  = DESIGNWARE_PCIE_ATU_DEVFN(viewport->target);
-    PCIBus    *pcibus    = pci_get_bus(PCI_DEVICE(root));
-    PCIDevice *pcidev    = pci_find_device(pcibus, busnum, devfn);
+    PCIDevice *pcidev    = pci_find_device(pci->bus, busnum, devfn);
 
     if (pcidev) {
         addr &= pci_config_size(pcidev) - 1;
@@ -445,7 +444,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         g_free(name);
 
         viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
-        viewport->root    = root;
+        viewport->host    = host;
         viewport->inbound = false;
         viewport->base    = 0x0000000000000000ULL;
         viewport->target  = 0x0000000000000000ULL;
-- 
2.41.0


