Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA358201E3
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPZ-0005tU-Ax; Fri, 29 Dec 2023 16:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPR-0005Mz-RL
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:49 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPP-0000Kh-Sq
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:49 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-594ce2083easo1616256eaf.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885323; x=1704490123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVMipdkCvfQWbibmbHXql300byrzbMe7iB+XTgpUb/Q=;
 b=ElRh0MHQtOFF2nqR/8kmJxl2AUNh01lv9STkeuZJzT8RohUqMKK4oaslsRnMDM0/nF
 F6hWjzTeSGnIu8Q/vGr2mjVZykkks2Rt+xibXlZJkcYTxY1OC21gxNcyWcyxzfN4110l
 jBpvqSS5eN8ShjauZHNljX0EsbSjTWUR1yHR5id3zo3DElWQ73CY+5Os0kKJwkx6PqU5
 KaMOYRgMbCCpGMEdDenNkHc90aa2lE9XhvKt0x3m+f2YFvSreQeOy0hB2Tsr7SUAimEX
 kSNWNsappmNhCnLGIyM1WI3h13WT+ZNhTz1qXPoHX9KDrKqDbIUYqPlUPlNG5WBmj8z0
 0zuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885323; x=1704490123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVMipdkCvfQWbibmbHXql300byrzbMe7iB+XTgpUb/Q=;
 b=meG9MWRV9JCq9yQRGwaXMjX8hfuAAp5eciFWQclT94qIJktkDeaBpEGlK/oQIWiWHg
 GQjUhbMygdRR20jzPd7GlUoKagjXxLbUPe1SCyjcWTClib+VWeizzbIw9rYQdNFGJyCb
 /FniDVK8hU0UZUFGr9TphzlQeFDTAYQH3CDx20SaqbHQAwnPo9eOLbm7n0KoVjBVmLRC
 pvIY0BYQzUEpjVGKG5N/Ni50/Fv0kyVw+IRdiezbGLhmgvkdYJUUbdaSrKTHGMUiVztO
 8tFqHL3Hl6VCcDm91JVXvBQrdw6WAIrSmGj9jkVqrAiJV9gwUYyGuXXn9mwVjDnJmt8v
 JSpA==
X-Gm-Message-State: AOJu0Yw/3jQujI0yaCJ2jS77s4vN9DwIxGHXlyPTI3QalCboXI3GRHGy
 1zGM8K2D3ex7bHYldCeWA9T+xUdxbMHgQmfPiybI0lAo6u5otg==
X-Google-Smtp-Source: AGHT+IHXFQ+hRc10WM0lbuSEaIdQWMqcAC76ak0i9mIbi3qA4M3uiegjeRyXkC2wS1XTcNKnjS30SA==
X-Received: by 2002:a05:6358:103:b0:174:dc14:2dea with SMTP id
 f3-20020a056358010300b00174dc142deamr12316424rwa.47.1703885323257; 
 Fri, 29 Dec 2023 13:28:43 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/71] hw/pci-host: Constify VMState
Date: Sat, 30 Dec 2023 08:23:21 +1100
Message-Id: <20231229212346.147149-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-47-richard.henderson@linaro.org>
---
 hw/pci-host/astro.c      |  4 ++--
 hw/pci-host/bonito.c     |  2 +-
 hw/pci-host/designware.c | 10 +++++-----
 hw/pci-host/dino.c       |  2 +-
 hw/pci-host/gpex.c       |  2 +-
 hw/pci-host/gt64120.c    |  2 +-
 hw/pci-host/i440fx.c     |  2 +-
 hw/pci-host/ppce500.c    |  6 +++---
 hw/pci-host/q35.c        |  2 +-
 hw/pci-host/raven.c      |  2 +-
 hw/pci-host/versatile.c  |  2 +-
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 7d68ccee7e..f4de70475c 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -459,7 +459,7 @@ static const VMStateDescription vmstate_elroy = {
     .name = "Elroy",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(hpa, ElroyState),
         VMSTATE_UINT32(pci_bus_num, ElroyState),
         VMSTATE_UINT64(config_address, ElroyState),
@@ -691,7 +691,7 @@ static const VMStateDescription vmstate_astro = {
     .name = "Astro",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ioc_ctrl, AstroState),
         VMSTATE_UINT64(ioc_status_ctrl, AstroState),
         VMSTATE_UINT64_ARRAY(ioc_ranges, AstroState, (0x03d8 - 0x300) / 8),
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index bab661f3ce..1f0c435348 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -619,7 +619,7 @@ static const VMStateDescription vmstate_bonito = {
     .name = "Bonito",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIBonitoState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index f477f97847..dd9e389c07 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -529,7 +529,7 @@ static const VMStateDescription vmstate_designware_pcie_msi_bank = {
     .name = "designware-pcie-msi-bank",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(enable, DesignwarePCIEMSIBank),
         VMSTATE_UINT32(mask, DesignwarePCIEMSIBank),
         VMSTATE_UINT32(status, DesignwarePCIEMSIBank),
@@ -541,7 +541,7 @@ static const VMStateDescription vmstate_designware_pcie_msi = {
     .name = "designware-pcie-msi",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(base, DesignwarePCIEMSI),
         VMSTATE_STRUCT_ARRAY(intr,
                              DesignwarePCIEMSI,
@@ -557,7 +557,7 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
     .name = "designware-pcie-viewport",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(base, DesignwarePCIEViewport),
         VMSTATE_UINT64(target, DesignwarePCIEViewport),
         VMSTATE_UINT32(limit, DesignwarePCIEViewport),
@@ -570,7 +570,7 @@ static const VMStateDescription vmstate_designware_pcie_root = {
     .name = "designware-pcie-root",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
         VMSTATE_UINT32(atu_viewport, DesignwarePCIERoot),
         VMSTATE_STRUCT_2DARRAY(viewports,
@@ -718,7 +718,7 @@ static const VMStateDescription vmstate_designware_pcie_host = {
     .name = "designware-pcie-host",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(root,
                        DesignwarePCIEHost,
                        1,
diff --git a/hw/pci-host/dino.c b/hw/pci-host/dino.c
index 5b0947a16c..d992c4bb69 100644
--- a/hw/pci-host/dino.c
+++ b/hw/pci-host/dino.c
@@ -287,7 +287,7 @@ static const VMStateDescription vmstate_dino = {
     .name = "Dino",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(iar0, DinoState),
         VMSTATE_UINT32(iar1, DinoState),
         VMSTATE_UINT32(imr, DinoState),
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index a6752fac5e..e117e47fa7 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -195,7 +195,7 @@ static const VMStateDescription vmstate_gpex_root = {
     .name = "gpex_root",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, GPEXRootState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 143bf053d7..e02efc9e2e 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -431,7 +431,7 @@ static const VMStateDescription vmstate_gt64120 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = gt64120_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, GT64120State, GT_REGS),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 653cc3f149..4f0a0438d7 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -125,7 +125,7 @@ static const VMStateDescription vmstate_i440fx = {
     .version_id = 3,
     .minimum_version_id = 3,
     .post_load = i440fx_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState),
         /* Used to be smm_enabled, which was basically always zero because
          * SeaBIOS hardly uses SMM.  SMRAM is now handled by CPU code.
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 453a4e6ed3..fa0d67b342 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -379,7 +379,7 @@ static const VMStateDescription vmstate_pci_outbound = {
     .name = "pci_outbound",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(potar, struct pci_outbound),
         VMSTATE_UINT32(potear, struct pci_outbound),
         VMSTATE_UINT32(powbar, struct pci_outbound),
@@ -392,7 +392,7 @@ static const VMStateDescription vmstate_pci_inbound = {
     .name = "pci_inbound",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(pitar, struct pci_inbound),
         VMSTATE_UINT32(piwbar, struct pci_inbound),
         VMSTATE_UINT32(piwbear, struct pci_inbound),
@@ -405,7 +405,7 @@ static const VMStateDescription vmstate_ppce500_pci = {
     .name = "ppce500_pci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(pob, PPCE500PCIState, PPCE500_PCI_NR_POBS, 1,
                              vmstate_pci_outbound, struct pci_outbound),
         VMSTATE_STRUCT_ARRAY(pib, PPCE500PCIState, PPCE500_PCI_NR_PIBS, 1,
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 08534bc7cc..0d7d4e3f08 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -520,7 +520,7 @@ static const VMStateDescription vmstate_mch = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = mch_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, MCHPCIState),
         /* Used to be smm_enabled, which was basically always zero because
          * SeaBIOS hardly uses SMM.  SMRAM is now handled by CPU code.
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 86c3a49087..f71d4872c8 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -383,7 +383,7 @@ static const VMStateDescription vmstate_raven = {
     .name = "raven",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, RavenPCIState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 60d4e7cd92..0e65deb3f9 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -147,7 +147,7 @@ static const VMStateDescription pci_vpb_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = pci_vpb_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(imap, PCIVPBState, 3),
         VMSTATE_UINT32_ARRAY(smap, PCIVPBState, 3),
         VMSTATE_UINT32(selfid, PCIVPBState),
-- 
2.34.1


