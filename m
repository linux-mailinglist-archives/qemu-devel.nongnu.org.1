Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609C81AD65
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ef-0007EZ-EE; Wed, 20 Dec 2023 22:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eX-00073j-J2
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:17 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9eV-0006le-Nl
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:17 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67ef18444ecso1889916d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128995; x=1703733795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQp9TiKTfW4pKwvJ10bzG77ZWz+yEVc510AVAe1oXAE=;
 b=uOoZLy5UnjKMQ8rx6qd5iZxiUlLWo2gIRHPZTrsdHEj7fLQ7hplHiTEf/9Xpw0bM3j
 yKJiBEOGQS0VuAWLdanCRUdRvo6WoDXA/fWdYUyXoebjbWpBikwAnBiVk2LP/p1fRXqn
 jCtkDhlW7pxDK6zOHq8aYoCN/LnsUbbBy7cLTqmhbirOEvtQLgHC7+/Pl2IngugHa6+Z
 E+vftNA4JcLFOj4eBzT3WCPI0JXc1BTT90xUDTaeXZuGJeOv+hJFP5oqJzag6uwaRsMm
 5NUq4Gk4ubbJIF2vzmWMPYvOlE1pfmxtmMjOB1a1VN2XtYEnD5nJL7LW1b6G3MuLHbMV
 PntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128995; x=1703733795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQp9TiKTfW4pKwvJ10bzG77ZWz+yEVc510AVAe1oXAE=;
 b=PY/GHIW9Qa81H+5G0mjMfvVl4V3i7v4b3cWeGxRMC7TTnKn6pxD9WZ+Cut1xqKP55s
 eKQxMhms7s0M2KOtxFdoFi2qisE1453ljvadSYTHxpTMwTe8EC38ZFtvbf6reTzLeGqF
 O0quL54pp2P2a0kuud8qwkGw50Rvnzum/n6bDO7CUJuInejuUGDMd+/8nwLU8Oyois79
 3SvEj+MIdaASzZVPR5D3NY4bJLm54+xUO5jSMVKXBs4KS6shjh9whekXc1YmZa0V2W0E
 yvInqc+xAwZP7jkfqym9vWVQIBH1UHSe5BBNVbqsbbNO0tnR3DSfif7SJmtZ8IFTiUUY
 NISA==
X-Gm-Message-State: AOJu0YznC9CdAPgR2c8e+2ShTqB7jQfU5QqvBFQeMGEvMf/8vDr/XL0o
 +QJIlWSMcJds29VjC4xidwrNIscz78paTO6EXQSnLwqQ
X-Google-Smtp-Source: AGHT+IEpz/868IrBupPseqrcbL++vUuW7a6wLmf2G65DNMKHwg0IVfVEYjgN1GB808O2JGJ1Vnn6NQ==
X-Received: by 2002:a05:6214:d0c:b0:67f:4819:30db with SMTP id
 12-20020a0562140d0c00b0067f481930dbmr7666639qvh.92.1703128994816; 
 Wed, 20 Dec 2023 19:23:14 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 46/71] hw/pci-host: Constify VMState
Date: Thu, 21 Dec 2023 14:16:27 +1100
Message-Id: <20231221031652.119827-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
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


